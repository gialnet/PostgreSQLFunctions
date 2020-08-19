

--
-- Datos del Panel de Control de Facturas
--

CREATE OR REPLACE FUNCTION  PanelFactura(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar,
    irpf out numeric,
    ventas out numeric,
    compras out numeric,
    iva out numeric,
    sociedades out numeric,
    nominas out numeric,
    seguridad_s out numeric
) 
returns RECORD
AS
$body$
DECLARE

    
BEGIN

    
    SELECT SumaVentasPeriodo(xYear, xPeri, xTipoPeri) INTO ventas;
    SELECT SumaComprasPeriodo(xYear, xPeri, xTipoPeri) INTO compras;
    SELECT SumaIVACobradoPeriodo(xYear, xPeri, xTipoPeri) - SumaIVAPagadoPeriodo(xYear, xPeri, xTipoPeri) INTO iva;
    SELECT PeriodoSociedades(xYear, xPeri, xTipoPeri) INTO sociedades;
    SELECT SumaIRPFPeriodo(xYear, xPeri, xTipoPeri) INTO irpf;
    SELECT SumaNominasPeriodo(xYear, xPeri, xTipoPeri) INTO nominas;
    SELECT SumaSSPeriodo(xYear, xPeri, xTipoPeri) INTO seguridad_s;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- **********************************************************************
-- Para vistas de totales y gráficos, con tipoPeriodo (mes,trimestre,año)
-- **********************************************************************
CREATE OR REPLACE FUNCTION  SumaIRPFPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIRPF numeric(8,2) :=0;
    
BEGIN

    IF xTipoPeri = 'MES' THEN 
        
            SELECT sum(importe) INTO xSumaIRPF FROM Diario D, Apuntes A 
                WHERE A.id=D.id_apunte
                and cuenta like '4751%'
                and debe_haber='H'
                and year_fiscal=xYear
                and to_char(fecha,'MM')=xPeri;
        
     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            SELECT sum(importe) INTO xSumaIRPF FROM Diario D, Apuntes A 
                WHERE A.id=D.id_apunte
                and cuenta like '4751%'
                and debe_haber='H'
                and year_fiscal=xYear
                and periodo=xPeri;
        

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            SELECT sum(importe) INTO xSumaIRPF FROM Diario D, Apuntes A 
                WHERE A.id=D.id_apunte
                and cuenta like '4751%'
                and debe_haber='H'
                and year_fiscal=xYear;
        
     ELSE 
        
            xSumaIRPF := -1;
        
    END IF;


    if xSumaIRPF is null then
        xSumaIRPF:=0;
    end if;

    return xSumaIRPF;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;





-- *************************************************************************
-- Sumar las ventas del periodo, segun el tipo de periodo(mes,trimestre,año)
-- *************************************************************************
CREATE OR REPLACE FUNCTION  SumaVentasPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN



    IF xTipoPeri = 'MES' THEN 
        
            select sum(importe) INTO xSumaBases 
            from row_bill T, head_bill B
            where B.id=T.id_bill and B.fiscal_year=xYear and to_char(B.fecha,'MM')=xPeri;
        
     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            select sum(importe) INTO xSumaBases 
            from row_bill T, head_bill B
            where B.id=T.id_bill and B.fiscal_year=xYear and B.trimestre=xPeri;
        

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            select sum(importe) INTO xSumaBases 
            from row_bill T, head_bill B
            where B.id=T.id_bill and B.fiscal_year=xYear;
        
     ELSE 
        
            xSumaBases := -1;
        
    END IF;



if xSumaBases is null then
    xSumaBases:=0;
end if;

return xSumaBases;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ************************************************************************************************
-- Sumar las compras y gastos deducibles de un periodo, segun el tipo de periodo(mes,trimestre,año)
-- ************************************************************************************************

CREATE OR REPLACE FUNCTION  SumaComprasPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN



    IF xTipoPeri = 'MES' THEN 

            select sum(r.importe) INTO xSumaBases 
            from row_invoices_received r, invoices_received i
            where i.id = r.id_inre
                and fiscal_year=xYear 
                and to_char(fecha,'MM')=xPeri;
        
     ELSEIF xTipoPeri = 'TRIM' THEN 
             
            select sum(r.importe) INTO xSumaBases 
            from row_invoices_received r, invoices_received i
            where i.id = r.id_inre 
                and fiscal_year=xYear 
                and trimestre=xPeri;

     ELSEIF xTipoPeri = 'AÑO' THEN 

            select sum(r.importe) INTO xSumaBases 
            from row_invoices_received r, invoices_received i
            where i.id = r.id_inre  and fiscal_year=xYear;
        
     ELSE 
        
            xSumaBases := -1;
        
    END IF;


if xSumaBases is null then
    xSumaBases:=0;
end if;

return xSumaBases;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ***************************************************************************
--                      Impuesto de Sociedades
-- ***************************************************************************

CREATE OR REPLACE FUNCTION  PeriodoSociedades
    (xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar) returns numeric
AS
$body$
DECLARE

    xBaseImponible numeric(8,2) :=0;
    xSumaCompras numeric(8,2) :=0;
    xSumaVentas numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2) :=0;

BEGIN

    SELECT carga_impositiva INTO xCarga_impositiva FROM DatosPer WHERE id=1;

    IF xTipoPeri = 'MES' THEN 

            SELECT SumaVentasPeriodo(xYear, xPeri, 'MES') INTO xSumaVentas;
            SELECT SumaComprasPeriodo(xYear, xPeri, 'MES') INTO xSumaCompras;

            if (xSumaVentas - xSumaCompras) > 0 then

                -- beneficios a tributar
                xBaseImponible = xSumaVentas - xSumaCompras;
                xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
            else
                -- perdidas saldrán los valores en negativo
                xBaseImponible:=0;

            end if;
        
    ELSEIF xTipoPeri = 'TRIM' THEN 

            SELECT SumaVentasPeriodo(xYear, xPeri, 'TRIM') INTO xSumaVentas;
            SELECT SumaComprasPeriodo(xYear, xPeri, 'TRIM') INTO xSumaCompras;

            if (xSumaVentas - xSumaCompras) > 0 then

                -- beneficios a tributar
                xBaseImponible = xSumaVentas - xSumaCompras;
                xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
            else
                -- perdidas saldrán los valores en negativo
                xBaseImponible:=0;

            end if;

    ELSEIF xTipoPeri = 'AÑO' THEN 

            SELECT SumaVentasPeriodo(xYear, xPeri, 'AÑO') INTO xSumaVentas;
            SELECT SumaComprasPeriodo(xYear, xPeri, 'AÑO') INTO xSumaCompras;

            if (xSumaVentas - xSumaCompras) > 0 then

                -- beneficios a tributar
                xBaseImponible = xSumaVentas - xSumaCompras;
                xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
            else
                -- perdidas saldrán los valores en negativo
                xBaseImponible:=0;

            end if;
        
    ELSE 
        
            xBaseImponible := -1;
        
    END IF;



return xBaseImponible;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ************************************************************
-- Sumar el IVA del periodo, segun tipo de periodo MES,TRIM,AÑO
-- ************************************************************
CREATE OR REPLACE FUNCTION  SumaIVACobradoPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIVA numeric(8,2) :=0;
    
BEGIN

    IF xTipoPeri = 'MES' THEN 
        
            select sum(T.base*T.iva/100) INTO xSumaIVA
            from total_bill T, vwhead_bill B
            where B.id=T.id_bill 
            and B.fiscal_year=xYear
            and to_char(B.fecha,'MM')=xPeri;
        
     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            select sum(T.base*T.iva/100) INTO xSumaIVA
            from total_bill T, vwhead_bill B
            where B.id=T.id_bill 
            and B.fiscal_year=xYear 
            and B.trimestre=xPeri;

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            select sum(T.base*T.iva/100) INTO xSumaIVA
            from total_bill T, vwhead_bill B
            where B.id=T.id_bill 
            and B.fiscal_year=xYear;
        
     ELSE 
        
            xSumaIVA := -1;
        
    END IF;


    if xSumaIVA is null then
        xSumaIVA:=0;
    end if;

    return xSumaIVA;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- *********************************************************************
-- Suma del IVA Pagado en el periodo, segun tipo de periodo MES,TRIM,AÑO
-- *********************************************************************
CREATE OR REPLACE FUNCTION  SumaIVAPagadoPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaIVA numeric(8,2) :=0;
    
BEGIN


    IF xTipoPeri = 'MES' THEN 

            select sum(importe*por_vat/100) INTO xSumaIVA 
            from row_invoices_received r, invoices_received i 
            where i.id = r.id_inre 
            and fiscal_year=xYear 
            and to_char(fecha_emision,'MM')=xPeri;

     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            select sum(importe*por_vat/100) INTO xSumaIVA 
            from row_invoices_received r, invoices_received i
            where i.id = r.id_inre
            and fiscal_year=xYear and trimestre=xPeri;

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            select sum(importe*por_vat/100) INTO xSumaIVA 
            from row_invoices_received r, invoices_received i
            where i.id = r.id_inre 
            and fiscal_year=xYear;
        
     ELSE 
        
            xSumaIVA := -1;
        
    END IF;


    if xSumaIVA is null then
        xSumaIVA:=0;
    end if;

    return xSumaIVA;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- *********************************************************************
--                      Suma de las Nóminas
-- *********************************************************************
CREATE OR REPLACE FUNCTION  SumaNominasPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaNominas numeric(8,2) :=0;
    
BEGIN


     IF xTipoPeri = 'MES' THEN 

            xSumaNominas := SumaNominasMes(xYear, xPeri);

     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            xSumaNominas := SumaNominasTrimestre(xYear, xPeri);

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            xSumaNominas := SumaNominasYear(xYear);
        
     ELSE 
        
            xSumaNominas := -1;
        
    END IF;


    if xSumaNominas is null then
        xSumaNominas:=0;
    end if;

    return xSumaNominas;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- *********************************************************************
--                      Suma de los Seguros Sociales
-- *********************************************************************
CREATE OR REPLACE FUNCTION  SumaSSPeriodo(
    xYear in varchar,
    xPeri in varchar,
    xTipoPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaSS numeric(8,2) :=0;
    
BEGIN


     IF xTipoPeri = 'MES' THEN 

            xSumaSS := SumaSSMes(xYear, xPeri);

     ELSEIF xTipoPeri = 'TRIM' THEN 
        
            xSumaSS := SumaSSTrimestre(xYear, xPeri);

     ELSEIF xTipoPeri = 'AÑO' THEN 
        
            xSumaSS := SumaSSYear(xYear);
        
     ELSE 
        
            xSumaSS := -1;
        
    END IF;


    if xSumaSS is null then
        xSumaSS := 0;
    end if;

    return xSumaSS;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
