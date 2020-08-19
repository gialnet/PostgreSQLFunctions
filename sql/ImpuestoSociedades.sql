
--
-- Pagos fracccionados a cuenta del impuesto de sociedades en caso de que la declaración
-- anual del año anterior haya sido a pagar
--
-- pagos en octubre, diciembre, abril
--

CREATE OR REPLACE FUNCTION  PFImpuestoSociedades(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xCuantos integer;
    xId_leg integer;
    xCuenta varchar(10);
    xSociedades varchar(2);

    xSumaVentas numeric(8,2) :=0;
    xSumaCompras numeric(8,2) :=0;
    xBaseImponible numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2);

BEGIN

-- comprobar la obligación de realizarlo

-- DatosPer retiene la última declaración de Sociedades
SELECT sociedades,carga_impositiva INTO xSociedades,xCarga_impositiva FROM DatosPer WHERE id=1;

if xSociedades='NO' then
    return;
end if;

SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='Modelo 202-Acuenta Sociedades';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='Modelo 202-Acuenta Sociedades'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Pago fraccionado a cuenta del Impuesto de Sociedades','Modelo 202-Acuenta Sociedades',xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- Si hay que hacerla

SELECT SumaVentasPeriodo(xYear, xPeri) INTO xSumaVentas;
SELECT SumaComprasPeriodo(xYear, xPeri) INTO xSumaCompras;


if (xSumaVentas - xSumaCompras) > 0 then

    -- beneficios a tributar
    xBaseImponible = xSumaVentas - xSumaCompras;
    xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
else
    -- perdidas saldrán los valores en negativo
    xBaseImponible:=0;

end if;

INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xBaseImponible);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Julio una vez al año
--

CREATE OR REPLACE FUNCTION  ImpuestoSociedades(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xCuantos integer;
    xId_leg integer;
    xCuenta varchar(10);

    xSumaVentas numeric(8,2) :=0;
    xSumaCompras numeric(8,2) :=0;
    xBaseImponible numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2);

BEGIN


-- DatosPer retiene la última declaración de Sociedades
SELECT carga_impositiva INTO xCarga_impositiva FROM DatosPer WHERE id=1;

SELECT cuenta INTO xCuenta FROM Obligaciones WHERE naturaleza='Modelo 200-SOCIEDADES';

--  comprobamos si ya existe esta anotación
SELECT Id INTO xId_leg FROM leg_obligaciones WHERE naturaleza='Modelo 200-SOCIEDADES'
        AND year_fiscal=xYear
        AND periodo=xPeri;

-- si no existe la obligación la creamos
if xId_leg is null then

    WITH leg_obligaciones_ins AS (
    INSERT INTO leg_obligaciones (concepto, naturaleza, year_fiscal,periodo) 
        VALUES ('Impuesto de Sociedades','Modelo 200-SOCIEDADES',xYear, xPeri)
    RETURNING ID
    )
    select id into xId_leg from leg_obligaciones_ins;

else
    DELETE FROM leg_detalle WHERE id_leg=xId_leg;
end if;

-- Si hay que hacerla

SELECT SumaVentasYear(xYear) INTO xSumaVentas;
SELECT SumaComprasYear(xYear) INTO xSumaCompras;


if (xSumaVentas - xSumaCompras) > 0 then

    -- beneficios a tributar
    xBaseImponible = xSumaVentas - xSumaCompras;
    xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
else
    -- perdidas saldrán los valores en negativo
    xBaseImponible:=0;

end if;


INSERT INTO leg_detalle (cuenta, id_leg,importe) 
                VALUES (xCuenta, xId_leg, xBaseImponible);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ****************************
-- Sumar las ventas del periodo
-- ****************************
CREATE OR REPLACE FUNCTION  SumaVentasPeriodo(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN

select sum(T.importe) INTO xSumaBases 
from row_bill T, head_bill B
            where B.id=T.id_bill and B.fiscal_year=xYear and B.trimestre=xPeri;


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





--
-- Suma de ventas del año
--
CREATE OR REPLACE FUNCTION  SumaVentasYear( xYear in varchar) 
returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN

select sum(importe) INTO xSumaBases 
from row_bill T, head_bill B
            where B.id=T.id_bill and B.fiscal_year=xYear;


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


--
-- Sumar las compras y gastos deducibles de un periodo
--
CREATE OR REPLACE FUNCTION  SumaComprasPeriodo(
    xYear in varchar,
    xPeri in varchar
) 
returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN

select sum(importe) INTO xSumaBases 
from invoices_received where fiscal_year=xYear and trimestre=xPeri;


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


--
-- Sumar las compras y gastos deducibles del año
--
CREATE OR REPLACE FUNCTION  SumaComprasYear(xYear in varchar) returns numeric
AS
$body$
DECLARE

    xSumaBases numeric(8,2) :=0;
    
BEGIN

select sum(importe) INTO xSumaBases 
from invoices_received where fiscal_year=xYear;


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


--
--
--
CREATE OR REPLACE FUNCTION  PeriodoSociedades(xYear in varchar,
    xPeri in varchar) returns numeric
AS
$body$
DECLARE

    xBaseImponible numeric(8,2) :=0;
    xSumaCompras numeric(8,2) :=0;
    xSumaVentas numeric(8,2) :=0;
    xCarga_impositiva numeric(4,2) :=0;

BEGIN

SELECT carga_impositiva INTO xCarga_impositiva FROM DatosPer WHERE id=1;

SELECT SumaVentasPeriodo(xYear, xPeri) INTO xSumaVentas;
SELECT SumaComprasPeriodo(xYear, xPeri) INTO xSumaCompras;


if (xSumaVentas - xSumaCompras) > 0 then

    -- beneficios a tributar
    xBaseImponible = xSumaVentas - xSumaCompras;
    xBaseImponible = xBaseImponible * xCarga_impositiva / 100;
else
    -- perdidas saldrán los valores en negativo
    xBaseImponible:=0;

end if;

return xBaseImponible;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
