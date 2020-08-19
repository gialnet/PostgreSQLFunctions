--
-- A) ACTIVO NO CORRIENTE 
--

CREATE OR REPLACE FUNCTION  CalcularACTIVO_NO_CORRIENTE(xUser in varchar, xYear in varchar)
returns numeric
AS
$body$
DECLARE

    xSumas numeric(8,2) :=0;
    xSumasTotal numeric(8,2) :=0;
    

BEGIN

-- A) ACTIVO NO CORRIENTE id_balance
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10016,xUser,xYear, 'I. Inmovilizado intangible.','TITULO_SEC');

SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'I. Inmovilizado intangible.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10017,xUser,xYear, 'I. Inmovilizado intangible.',xSumas,'SECCION');



INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10018,xUser,xYear, 'II. Inmovilizado material.','TITULO_SEC');

SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'II. Inmovilizado material.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10019,xUser,xYear, 'II. Inmovilizado material.',xSumas,'SECCION');


INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10020,xUser,xYear, 'III. Inversiones inmobiliarias.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'III. Inversiones inmobiliarias.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro)
    VALUES (10021,xUser,xYear, 'III. Inversiones inmobiliarias.',xSumas,'SECCION');


INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10022,xUser,xYear, 'IV. Inversiones en empresas del grupo y asociadas a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'IV. Inversiones en empresas del grupo y asociadas a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro)
    VALUES (10023,xUser,xYear, 'IV. Inversiones en empresas del grupo y asociadas a largo plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10024,xUser,xYear, 'V. Inversiones financieras a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'V. Inversiones financieras a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro)
    VALUES (10025,xUser,xYear, 'V. Inversiones financieras a largo plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10026,xUser,xYear, 'VI. Activos por impuesto diferido.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'VI. Activos por impuesto diferido.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro)
    VALUES (10027,xUser,xYear, 'VI. Activos por impuesto diferido.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10028,xUser,xYear, 'VII. Deudores comerciales no corrientes.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO NO CORRIENTE', 'VII. Deudores comerciales no corrientes.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro)
    VALUES (10029,xUser,xYear, 'VII. Deudores comerciales no corrientes.',xSumas,'SECCION');

 
    return xSumasTotal;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ****************************************************************************************************
--              B) ACTIVO CORRIENTE
-- ****************************************************************************************************
CREATE OR REPLACE FUNCTION  CalcularACTIVO_CORRIENTE(xUser in varchar,xYear in varchar) 
returns numeric
AS
$body$
DECLARE

    xSumas numeric(8,2) :=0;
    xSumasTotal numeric(8,2) :=0;

BEGIN

-- ACTIVO CORRIENTE
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10030,xUser,xYear, 'I. Activos no corrientes mantenidos para la venta.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' ,'I. Activos no corrientes mantenidos para la venta.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10031,xUser,xYear, 'I. Activos no corrientes mantenidos para la venta.',xSumas,'SECCION');


INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10032,xUser,xYear, 'II. Existencias.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'II. Existencias.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10033,xUser,xYear, 'II. Existencias.',xSumas,'SECCION');


INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10034,xUser,xYear, 'III. Deudores comerciales y otras cuentas a cobrar.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'III. Deudores comerciales y otras cuentas a cobrar.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10035,xUser,xYear, 'III. Deudores comerciales y otras cuentas a cobrar.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10036,xUser,xYear, 'IV. Inversiones en empresas del grupo y asociadas a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'IV. Inversiones en empresas del grupo y asociadas a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10037,xUser,xYear, 'IV. Inversiones en empresas del grupo y asociadas a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10038,xUser,xYear, 'V. Inversiones financieras a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'V. Inversiones financieras a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10039,xUser,xYear, 'V. Inversiones financieras a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10040,xUser,xYear,'VI. Periodificaciones a corto plazo.' ,'TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'VI. Periodificaciones a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10041,xUser,xYear, 'VI. Periodificaciones a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10042,xUser,xYear, 'VII. Efectivo y otros activos líquidos equivalentes.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'ACTIVO CORRIENTE' , 'VII. Efectivo y otros activos líquidos equivalentes.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10043,xUser,xYear, 'VII. Efectivo y otros activos líquidos equivalentes.',xSumas,'SECCION');
 
    return xSumasTotal;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- ****************************************************************************************************
--              A) PATRIMONIO NETO
-- ****************************************************************************************************
CREATE OR REPLACE FUNCTION  CalcularPATRIMONIO_NETO(xUser in varchar,xYear in varchar) 
returns numeric
AS
$body$
DECLARE

    xSumas numeric(8,2) :=0;
    xSumasTotal numeric(8,2) :=0;

BEGIN



INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10044,xUser,xYear, 'I. Capital.','TITULO_SEC');

SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'I. Capital.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10045,xUser,xYear, 'I. Capital.',xSumas,'SECCION');


-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10046,xUser,xYear, 'II. Prima de emisión.','TITULO_SEC');

SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'II. Prima de emisión.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10047,xUser,xYear, 'II. Prima de emisión.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10048,xUser,xYear, 'III. Reservas.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'III. Reservas.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10049,xUser,xYear, 'III. Reservas.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10050,xUser,xYear, 'IV. (Acciones y participaciones en patrimonio propias).','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'IV. (Acciones y participaciones en patrimonio propias).') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10051,xUser,xYear, 'IV. (Acciones y participaciones en patrimonio propias).',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10052,xUser,xYear, 'V. Resultados de ejercicios anteriores.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'V. Resultados de ejercicios anteriores.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10053,xUser,xYear, 'V. Resultados de ejercicios anteriores.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10054,xUser,xYear, 'VI. Otras aportaciones de socios.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'VI. Otras aportaciones de socios.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10055,xUser,xYear, 'VI. Otras aportaciones de socios.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10056,xUser,xYear, 'VII. Resultado del ejercicio.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'VII. Resultado del ejercicio.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10057,xUser,xYear, 'VII. Resultado del ejercicio.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10058,xUser,xYear, 'VIII. (Dividendo a cuenta).','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'VIII. (Dividendo a cuenta).') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10059,xUser,xYear, 'VIII. (Dividendo a cuenta).',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10060,xUser,xYear, 'IX. Otros instrumentos de patrimonio neto.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'IX. Otros instrumentos de patrimonio neto.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10061,xUser,xYear, 'IX. Otros instrumentos de patrimonio neto.',xSumas,'SECCION');

-- A-2) Ajustes por cambios de valor.
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10062,xUser,xYear, 'A-2) Ajustes por cambios de valor.','TITULO');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10063,xUser,xYear, 'I. Activos financieros disponibles para la venta.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'I. Activos financieros disponibles para la venta.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10064,xUser,xYear, 'I. Activos financieros disponibles para la venta.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10065,xUser,xYear, 'II. Operaciones de cobertura.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'II. Operaciones de cobertura.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10066,xUser,xYear, 'II. Operaciones de cobertura.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10067,xUser,xYear, 'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10068,xUser,xYear, 'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10069,xUser,xYear, 'IV. Diferencia de conversión.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'IV. Diferencia de conversión.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10070,xUser,xYear, 'IV. Diferencia de conversión.',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10071,xUser,xYear, 'V. Otros','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'V. Otros') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10072,xUser,xYear, 'V. Otros',xSumas,'SECCION');

-- **********************************
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10073,xUser,xYear, 'A-3) Subvenciones, donaciones y legados recibidos.','TITULO_SEC');

-- A-3) Subvenciones, donaciones y legados recibidos.
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10074,xUser,xYear, 'A-3) Subvenciones, donaciones y legados recibidos.','TITULO');

SELECT LeeSeccion(xUser, xYear,'PATRIMONIO NETO', 'A-3) Subvenciones, donaciones y legados recibidos.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10075,xUser,xYear, 'A-3) Subvenciones, donaciones y legados recibidos.',xSumas,'SECCION');



return xSumasTotal;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ****************************************************************************************************
--              B) PASIVO NO CORRIENTE
-- ****************************************************************************************************
CREATE OR REPLACE FUNCTION  CalcularPASIVO_NO_CORRIENTE(xUser in varchar,xYear in varchar) 
returns numeric
AS
$body$
DECLARE

    xSumas numeric(8,2) :=0;
    xSumasTotal numeric(8,2) :=0;

BEGIN


-- B) PASIVO NO CORRIENTE

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10076,xUser,xYear, 'I. Provisiones a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'I. Provisiones a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10077,xUser,xYear, 'I. Provisiones a largo plazo.',xSumas,'SECCION');


INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10078,xUser,xYear, 'II Deudas a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'II Deudas a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10079,xUser,xYear, 'II Deudas a largo plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10080,xUser,xYear, 'III. Deudas con empresas del grupo y asociadas a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'III. Deudas con empresas del grupo y asociadas a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10081,xUser,xYear, 'III. Deudas con empresas del grupo y asociadas a largo plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10082,xUser,xYear, 'IV. Pasivos por impuesto diferido.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'IV. Pasivos por impuesto diferido.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10083,xUser,xYear, 'IV. Pasivos por impuesto diferido.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10084,xUser,xYear, 'V. Periodificaciones a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'V. Periodificaciones a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10085,xUser,xYear, 'V. Periodificaciones a largo plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10086,xUser,xYear, 'VI. Acreedores comerciales no corrientes.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'VI. Acreedores comerciales no corrientes.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10087,xUser,xYear, 'VI. Acreedores comerciales no corrientes.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10088,xUser,xYear, 'VII. Deuda con características especiales a largo plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO NO CORRIENTE', 'VII. Deuda con características especiales a largo plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10089,xUser,xYear, 'VII. Deuda con características especiales a largo plazo.',xSumas,'SECCION');

return xSumasTotal;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ****************************************************************************************************
--              C) PASIVO CORRIENTE
-- ****************************************************************************************************
CREATE OR REPLACE FUNCTION  CalcularPASIVO_CORRIENTE(xUser in varchar,xYear in varchar) 
returns numeric
AS
$body$
DECLARE

    xSumas numeric(8,2) :=0;
    xSumasTotal numeric(8,2) :=0;

    

BEGIN

-- C) PASIVO CORRIENTE
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10090,xUser,xYear, 'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10091,xUser,xYear, 'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10092,xUser,xYear, 'II. Provisiones a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'II. Provisiones a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10093,xUser,xYear, 'II. Provisiones a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10094,xUser,xYear, 'III. Deudas a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'III. Deudas a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10095,xUser,xYear, 'III. Deudas a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10096,xUser,xYear, 'IV. Deudas con empresas del grupo y asociadas a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'IV. Deudas con empresas del grupo y asociadas a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10097,xUser,xYear, 'IV. Deudas con empresas del grupo y asociadas a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10098,xUser,xYear, 'V. Acreedores comerciales y otras cuentas a pagar.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'V. Acreedores comerciales y otras cuentas a pagar.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10099,xUser,xYear, 'V. Acreedores comerciales y otras cuentas a pagar.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10100,xUser,xYear, 'VI. Periodificaciones a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'VI. Periodificaciones a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10101,xUser,xYear, 'VI. Periodificaciones a corto plazo.',xSumas,'SECCION');

INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,tipo_registro)
    VALUES (10102,xUser,xYear, 'VII. Deuda con características especiales a corto plazo.','TITULO_SEC');
SELECT LeeSeccion(xUser, xYear,'PASIVO CORRIENTE', 'VII. Deuda con características especiales a corto plazo.') INTO xSumas;
xSumasTotal := xSumasTotal + xSumas;
INSERT INTO tmp_ResultBalance (id_balance,usuario,year_fiscal,seccion,Importe,tipo_registro) 
    VALUES (10103,xUser,xYear, 'VII. Deuda con características especiales a corto plazo.',xSumas,'SECCION');

-- TOTAL PATRIMONIO NETO Y PASIVO (A + B + C)


return xSumasTotal;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


