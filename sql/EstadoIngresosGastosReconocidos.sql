
-- ****************************************************************************
--  Estado de ingresos y gastos reconocidos
-- ****************************************************************************
CREATE OR REPLACE FUNCTION  EstadoIGR(xYear in varchar, xUser in varchar) 
returns void
AS
$body$
DECLARE

    ResultadoPyG numeric(12,2) :=0;
    DirectoPatrimonioNeto  numeric(12,2) :=0;
    TransferenciasPyG numeric(12,2) :=0;
    TotalIngresosGasto numeric(12,2) :=0;

BEGIN

-- Borrar el balance anterior, para limpiar los datos del listado
DELETE FROM tmp_ResultIGR WHERE year_fiscal=xYear AND usuario=xUser;

-- Las reglas de calculo de las secciones

PERFORM AplicaReglasEIGR(xUser, xYear, 1); -- 1 normal 2 abreviada


--
-- Realizar las operaciones
--

-- A) resultado de la cuenta de P Y G
SELECT importe INTO ResultadoPyG FROM tmp_resultpyg 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='PROFIT';

UPDATE tmp_ResultIGR SET importe = ResultadoPyG 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro = 'PROFIT';


-- B) Total ingresos y gastos imputados directamente en el patrimonio neto

SELECT SUM(IMPORTE) INTO DirectoPatrimonioNeto FROM tmp_ResultIGR 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionIGR BETWEEN 3 and 11;

UPDATE tmp_ResultIGR SET importe = DirectoPatrimonioNeto
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='TIGIDPN';


-- C) Total transferencias a la cuenta de pérdidas y ganancias(VIII+IX+X+XI+XII+XIII)
SELECT SUM(IMPORTE) INTO TransferenciasPyG FROM tmp_ResultIGR 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND id_SeccionIGR BETWEEN 14 and 21;

UPDATE tmp_ResultIGR SET importe = TransferenciasPyG
        WHERE USUARIO=xUser 
        AND YEAR_FISCAL=xYear 
        AND tipo_registro='TTCPYG';


-- TOTAL DE INGRESOS Y GASTOS RECONOCIDOS (A + B + C)

TotalIngresosGasto := ResultadoPyG + DirectoPatrimonioNeto + TransferenciasPyG;

UPDATE tmp_ResultIGR SET importe = TotalIngresosGasto 
    WHERE USUARIO=xUser 
    AND YEAR_FISCAL=xYear 
    AND tipo_registro='TIGR';


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




--
-- Aplicar las reglas de calculo del documento
--
CREATE OR REPLACE FUNCTION AplicaReglasEIGR(xUser in varchar, xYear in varchar, xTipo in integer)
returns void
AS
$body$
DECLARE

    xCuenta varchar(10);
    xSigno varchar(1);

    xSaldo2 numeric(12,2) :=0;
    xSumaSaldo numeric(12,2) :=0;
    xSumaSaldoSeccion numeric(12,2) :=0;
    xDebe numeric(12,2) :=0;
    xHaber numeric(12,2) :=0;
    
    curs4 CURSOR IS SELECT id,grupo_cuentas,Seccion,tipo_registro
    FROM SeccionIGR
    WHERE id_IGR = xTipo -- 1 Normal 2 Abreviado
    ORDER BY ID;

    cCursor RECORD;
BEGIN

--
-- Lista de cuentas de las SeccionPyG
--
FOR cCursor IN curs4 LOOP


    FOREACH xCuenta IN ARRAY cCursor.grupo_cuentas
    LOOP

        if xCuenta is null or xCuenta ='' then

            continue;

        end if;

        xSigno:=substr(xCuenta,1,1);
        xCuenta:=substr(xCuenta,2);

        -- Leer los saldos del grupo de cuentas
        SELECT xSumDebe, xSumHaber, xSaldo INTO xDebe, xHaber, xSaldo2 from SaldoGrupoCuenta(xCuenta, xYear);

        if xDebe is not null and xHaber is not null and  xSaldo2 is not null then

            -- - Debe  + Haber
            if xSigno='-' then
                xSumaSaldo := xSumaSaldo + xDebe;
            else
                xSumaSaldo := xSumaSaldo + xHaber;
            end if;
        end if;

    END LOOP;

    -- Insertamos el campo

    INSERT INTO tmp_ResultIGR (usuario, year_fiscal, tipo_registro, id_SeccionIGR, Seccion, Importe) 
        VALUES (xUser, xYear, cCursor.tipo_registro, cCursor.ID, cCursor.Seccion, xSumaSaldo);


    xSumaSaldo :=0;

END LOOP;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


