
--
-- Balance al cierre del ejercicio
--
/*
A) ACTIVO NO CORRIENTE 
B) ACTIVO CORRIENTE 
A) PATRIMONIO NETO
B) PASIVO NO CORRIENTE
C) PASIVO CORRIENTE
*/

CREATE OR REPLACE FUNCTION  BalanceNormal(xYear in varchar, xUser in varchar) 
returns void
AS
$body$
DECLARE

    xSumasCorriente numeric(12,2) :=0;
    xSumasNoCorriente numeric(12,2) :=0;
    xTotalActivo numeric(12,2) :=0;
    xTotalPatrimonio numeric(12,2) :=0;

    xSumasPasivoCorriente numeric(12,2) :=0;
    xSumasPasivoNoCorriente numeric(12,2) :=0;
    xSumasPatrimonio numeric(12,2) :=0;

BEGIN

-- Borrar el balance anterior, para limpiar los datos del listado
DELETE FROM tmp_ResultBalance WHERE year_fiscal=xYear AND usuario=xUser;

-- pagina 1
-- Activo
-- A) ACTIVO NO CORRIENTE 
INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
VALUES (xUser,xYear, 'ACTIVO','PAGINA-1',10001);


INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'A) ACTIVO NO CORRIENTE ','TITULO',10002);

SELECT CalcularACTIVO_NO_CORRIENTE(xUser, xYear) INTO xSumasNoCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'ACTIVO NO CORRIENTE',xSumasNoCorriente,'SUMA',10003);

--
-- B) ACTIVO CORRIENTE
--
INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'B) ACTIVO CORRIENTE','TITULO',10004);

SELECT CalcularACTIVO_CORRIENTE(xUser, xYear) INTO xSumasCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'ACTIVO CORRIENTE',xSumasCorriente,'SUMA',10005);

-- TOTAL ACTIVO A + B
xTotalActivo:=xSumasCorriente + xSumasNoCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'TOTAL ACTIVO A + B',xTotalActivo,'TOTAL',10006);

-- ************************************************************
--                              Página 2
-- PATRIMONIO NETO
-- A-1) Fondos propios.

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
VALUES (xUser,xYear, 'PATRIMONIO NETO Y PASIVO','PAGINA-2',10007);

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,seccion,tipo_registro,id_balance)
    VALUES (xUser,xYear, 'A-1) Fondos propios.','TITULO',10008);

-- PATRIMONIO NETO
INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'A) PATRIMONIO NETO','TITULO',10009);

SELECT CalcularPATRIMONIO_NETO (xUser, xYear) INTO xSumasPatrimonio;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'PATRIMONIO NETO',xSumasPatrimonio,'SUMA',10010);

-- PASIVO CORRIENTE 
INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'B) PASIVO NO CORRIENTE','TITULO',10011);
SELECT CalcularPASIVO_NO_CORRIENTE (xUser, xYear) INTO xSumasPasivoNoCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'PASIVO NO CORRIENTE',xSumasPasivoNoCorriente,'SUMA',10012);

-- B) PASIVO NO CORRIENTE
INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'C) PASIVO CORRIENTE','TITULO',10013);

SELECT CalcularPASIVO_CORRIENTE (xUser, xYear) INTO xSumasPasivoCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'PASIVO CORRIENTE',xSumasPasivoCorriente,'SUMA',10014);

--TOTAL PATRIMONIO NETO Y PASIVO
xTotalPatrimonio := xSumasPatrimonio + xSumasPasivoNoCorriente + xSumasPasivoCorriente;

INSERT INTO tmp_ResultBalance (usuario,year_fiscal,Balance,Importe,tipo_registro,id_balance) 
    VALUES (xUser,xYear, 'TOTAL PATRIMONIO NETO Y PASIVO A+B+C',xTotalPatrimonio,'TOTAL',10015);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;





-- ***************************************************************************
--                      Leer todos los apartados de una sección
-- ***************************************************************************

CREATE OR REPLACE FUNCTION LeeSeccion(xUser in varchar, xYear in varchar, xBalance in varchar, xSeccion in varchar)
returns numeric
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
    
    curs4 CURSOR IS SELECT A.grupo_cuentas,A.apartado, A.id
    FROM Balance B, SeccionBalance S, ApartadoSeccionBalance A
    WHERE B.id=S.id_balance AND S.id=A.id_SeccionBalance AND S.seccion=xSeccion;

    cCursor RECORD;
BEGIN

--
-- Lista de cuentas de los apartados
--
FOR cCursor IN curs4 LOOP

    FOREACH xCuenta IN ARRAY cCursor.grupo_cuentas
    LOOP

        if xCuenta is null or xCuenta ='' then
            continue;
        end if;

        --RAISE NOTICE 'cuenta %', xCuenta;

        xSigno:=substr(xCuenta,1,1);
        xCuenta:=substr(xCuenta,2);

        --RAISE NOTICE 'xSigno %', xSigno;
        -- Leer los saldos del grupo de cuentas
        SELECT xSumDebe, xSumHaber, xSaldo INTO xDebe, xHaber, xSaldo2 from SaldoGrupoCuenta(xCuenta, xYear);

        --RAISE NOTICE 'xDebe %', xDebe;
        --RAISE NOTICE 'xHaber %', xHaber;

        -- - Debe  + Haber
        if xSigno = '-' then
            xSumaSaldo := xSumaSaldo + xDebe;
        else
            xSumaSaldo := xSumaSaldo + xHaber;
        end if;

        --RAISE NOTICE 'xSumaSaldo %', xSumaSaldo;

    END LOOP;

    -- Insertamos el campo si tiene algún valor
    if xSumaSaldo !=0 then

      INSERT INTO tmp_ResultBalance (usuario,year_fiscal,id_balance,Balance,Seccion,Apartado,Importe) 
                    VALUES (xUser,xYear,cCursor.id,xBalance,xSeccion, cCursor.Apartado,xSumaSaldo);

      xSumaSaldoSeccion := xSumaSaldoSeccion + xSumaSaldo;
      
      --RAISE NOTICE 'xSumaSaldoSeccion %', xSumaSaldoSeccion;

    end if;

    
    xSaldo2:=0;
    xSumaSaldo :=0;

END LOOP;



return xSumaSaldoSeccion;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




--
-- Paso de valores de actual a historico
--
CREATE OR REPLACE FUNCTION CierreBalance()
returns void
AS
$body$
DECLARE

BEGIN



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- COPIAR DE tmp a Historico
--
CREATE OR REPLACE FUNCTION CopyTmpToHistoBalance(xUser in varchar, xYear in varchar)
returns void
AS
$body$
DECLARE
    
    curs4 CURSOR IS SELECT id_balance,tipo_registro, year_fiscal, Balance, Seccion, Apartado, Importe
    FROM tmp_ResultBalance
    WHERE year_fiscal=xYear and usuario = xUser order by id;

    cCursor RECORD;

    xID INTEGER;

BEGIN

-- Borrar datos anteriores

DELETE FROM HistoricoBalances WHERE year_fiscal=xYear;


FOR cCursor IN curs4 LOOP

    INSERT INTO HistoricoBalances (id_balance,tipo_registro, year_fiscal, Balance, Seccion, Apartado, Importe) 
        VALUES (cCursor.id, cCursor.tipo_registro, cCursor.year_fiscal, cCursor.Balance, cCursor.Seccion, 
                cCursor.Apartado, cCursor.Importe);

END LOOP;



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- *************************
-- COPIAR DE Historico a tmp
-- *************************
CREATE OR REPLACE FUNCTION CopyHistoBalanceTotmp(xUser in varchar, xYear in varchar)
returns void
AS
$body$
DECLARE
    
    curs4 CURSOR IS SELECT id_balance, Importe
    FROM HistoricoBalances
    WHERE year_fiscal=xYear 
    order by id_balance;

    cCursor RECORD;
BEGIN

FOR cCursor IN curs4 LOOP

    UPDATE tmp_ResultBalance SET importe_prev= cCursor.Importe 
        WHERE id_balance=cCursor.id_balance
        and year_fiscal=xYear 
        and usuario=xUser;

END LOOP;



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

