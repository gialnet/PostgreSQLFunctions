-- ***********************************************************************
--                      Balances
-- ***********************************************************************

/*

Cada línea del balance tiene una clave o firma, una Unique ID que representa a
una línea en el documento PDF.

Estas líneas son de un determinado tipo Titulo, Suma, Detalle, Sección,etc. y estan
escritas en orden de impresión por su ID, es decir, se crean en un orden predeterminado.
Se marcan con un código de balance id_balance que a su vez pertenece a dos tipos de tuplas
las que corresponden con un apartado concreto de la tabla ApartadoSeccionBalance, su clave
corresponde con el ID de esta tabla, que es la que implementa las reglas del balance.

Por otro lado quedan los valores de Página, Titulo, Sección, etc, vía procedimiento SQL
se les asigna un valor entre 10.001 y 10.103

*/

/*
DROP TABLE Balance CASCADE;
DROP TABLE SeccionBalance CASCADE;
DROP TABLE ApartadoSeccionBalance CASCADE;
DROP TABLE tmp_ResultBalance;
DROP TABLE HistoricoBalances;
/
*/

/*
A) ACTIVO NO CORRIENTE 
B) ACTIVO CORRIENTE 
A) PATRIMONIO NETO
B) PASIVO NO CORRIENTE
C) PASIVO CORRIENTE
*/
CREATE TABLE Balance
(
    id              serial NOT NULL,
    Norma           text,
    primary key (id)
);



/*
Ejemplo INSERT INTO ReglasBalance (SECCION,id_balance) VALUES ('Inmovilizado intangible',1);
*/

CREATE TABLE SeccionBalance
(
    id              serial NOT NULL,
    id_balance      integer references Balance(id),
    Seccion         varchar(150),
    primary key (id)
);

create index SeccionBalance_Seccion on SeccionBalance(Seccion);

-- TOTAL PATRIMONIO NETO Y PASIVO (A + B + C)



/*
Ejemplo INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Desarrollo','{201,2801,2901}');
*/

CREATE TABLE ApartadoSeccionBalance
(
    id                      serial NOT NULL,
    id_SeccionBalance       integer references SeccionBalance(id),
    Apartado                varchar(150),
    grupo_cuentas           text[],
    primary key (id)
);
create index ApartadoSeccionBalance_Apartado on ApartadoSeccionBalance(Apartado);


--
-- Vista vwApartadoSeccionBalance
--
create or replace view vwApartadoSeccionBalance (IDApartado,Norma,Seccion,Apartado,grupo_cuentas) AS
SELECT A.id, B.Norma, S.Seccion, A.Apartado, A.grupo_cuentas 
    FROM Balance B, SeccionBalance S, ApartadoSeccionBalance A
    WHERE B.id = S.id_balance AND S.id = A.id_SeccionBalance;





--
-- Tabla temporal con los resultados del balance
--
CREATE TABLE tmp_ResultBalance
(
    id              serial NOT NULL,
    usuario         varchar(90),
    year_fiscal     varchar(4),
    tipo_registro   varchar(15) DEFAULT 'DETALLE',  -- PAGINA TITULO SUMA TITULO_SEC SECCION DETALLE TOTAL
    id_balance      integer DEFAULT 0, -- contine uno asignado para cada apartado del balance por código SQL en Balance.sql
    Balance         text,
    Seccion         varchar(150),
    Apartado        varchar(150),
    Importe         numeric(12,2) default 0,
    Importe_prev    numeric(12,2) default 0,
    primary key (id)
);


--
-- Tabla historica de balances consolidados años cerrados.
--
CREATE TABLE HistoricoBalances
(
    id              serial NOT NULL,
    tipo_registro   varchar(15) DEFAULT 'DETALLE',  -- PAGINA TITULO SUMA TITULO_SEC SECCION DETALLE TOTAL
    id_balance      integer DEFAULT 0, -- contine uno asignado para cada apartado del balance por código SQL en Balance.sql
    year_fiscal     varchar(4),
    Balance         text,
    Seccion         varchar(150),
    Apartado        varchar(150),
    Importe         numeric(12,2) default 0,
    Importe_prev    numeric(12,2) default 0,
    primary key (id)
);



/* ****************************************************************************
        Carga de Datos
**************************************************************************** */

INSERT INTO Balance (Norma) VALUES ('ACTIVO NO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('ACTIVO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('PATRIMONIO NETO');
INSERT INTO Balance (Norma) VALUES ('PASIVO NO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('PASIVO CORRIENTE');


-- ****************************************************************************
--                      Seccion
-- ****************************************************************************

-- ACTIVO NO CORRIENTE
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'I. Inmovilizado intangible.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'II. Inmovilizado material.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'III. Inversiones inmobiliarias.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'IV. Inversiones en empresas del grupo y asociadas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'V. Inversiones financieras a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'VI. Activos por impuesto diferido.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'VII. Deudores comerciales no corrientes.');

-- ACTIVO CORRIENTE
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'I. Activos no corrientes mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'II. Existencias.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'III. Deudores comerciales y otras cuentas a cobrar.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'IV. Inversiones en empresas del grupo y asociadas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'V. Inversiones financieras a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'VI. Periodificaciones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'VII. Efectivo y otros activos líquidos equivalentes.');

-- PATRIMONIO NETO
-- A-1) Fondos propios.

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'I. Capital.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'II. Prima de emisión.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'III. Reservas.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IV. (Acciones y participaciones en patrimonio propias).');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'V. Resultados de ejercicios anteriores.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VI. Otras aportaciones de socios.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VII. Resultado del ejercicio.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VIII. (Dividendo a cuenta).');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IX. Otros instrumentos de patrimonio neto.');


-- A-2) Ajustes por cambios de valor.
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'I. Activos financieros disponibles para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'II. Operaciones de cobertura.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IV. Diferencia de conversión.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'V. Otros');


-- A-3) Subvenciones, donaciones y legados recibidos.
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'A-3) Subvenciones, donaciones y legados recibidos.');

-- B) PASIVO NO CORRIENTE

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'I. Provisiones a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'II Deudas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'III. Deudas con empresas del grupo y asociadas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'IV. Pasivos por impuesto diferido.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'V. Periodificaciones a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'VI. Acreedores comerciales no corrientes.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'VII. Deuda con características especiales a largo plazo.');

-- C) PASIVO CORRIENTE

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'II. Provisiones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'III. Deudas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'IV. Deudas con empresas del grupo y asociadas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'V. Acreedores comerciales y otras cuentas a pagar.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'VI. Periodificaciones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'VII. Deuda con características especiales a corto plazo.');


-- ****************************************************************************
--                      Apartado y cuentas Reglas del Balance
-- ****************************************************************************
-- ********************
-- ACTIVO NO CORRIENTE
-- ********************

-- I. Inmovilizado intangible.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Desarrollo.','{+201, -2801, -2901}'); -- 1
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Concesiones.','{+202, -2802, -2902}'); -- 2
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Patentes, licencias, marcas y similares.','{+203, -2803, -2903}'); -- 3
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Fondo de comercio.','{+204}'); -- 4
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Aplicaciones informáticas.','{+206, -2806, -2906}'); -- 5
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Investigación.','{+200, -2800, -2900}'); -- 6
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Otro inmovilizado intangible.','{+205, +209, -2805, -2905, +207, -2807, -2907}'); -- 7

-- II. Inmovilizado material.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Terrenos y construcciones.','{+210, +211, -2811, -2910, -2911}'); -- 8
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Instalaciones técnicas, y otro inmovilizado material.',
'{+212, +213, +214, +215, +216, +217, +218, +219, -2812, -2813, -2814, -2815, -2816, -2817, -2818, -2819, -2912, -2913, -2914, -2915, -2916, -2917, -2918, -2919}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Inmovilizado en curso y anticipos.','{+23}');

-- III. Inversiones inmobiliarias.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (3, 'Terrenos.','{+220, -2920}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (3, 'Construcciones.','{+221, 282, -2921}');

-- IV. Inversiones en empresas del grupo y asociadas a largo plazo.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Instrumentos de patrimonio.','{+2403, +2404, -2493, -2494, -2933, -2934}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Créditos a empresas','{+2423, +2424, -2953, -2954}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Valores representativos de deuda','{+2413, +2414, -2943, -2944}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Derivados','{+255}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Otros activos financieros','{+258, +26}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Otras inversiones','{+257}');

-- V. Inversiones financieras a largo plazo.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Instrumentos de patrimonio','{+2405, -2495, -2935, +250, -259}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Créditos a terceros','{+2425, +252, +253, +254, -2955, -298}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Valores representativos de deuda','{+2415, +251, -2945, -297}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Derivados','{+255}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Otros activos financieros','{+257, +258, +26}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Otras inversiones','{}');

-- VI. Activos por impuesto diferido.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (6, 'Activos por impuesto diferido','{+474}');

-- VII. Deudores comerciales no corrientes. 
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (7, 'Deudores comerciales no corrientes','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (7, 'Deudores comerciales no corrientes, empresas del grupo y asociadas','{}');


-- ********************
-- ACTIVO CORRIENTE
-- ********************

-- 'I. Activos no corrientes mantenidos para la venta.'

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (8, 'I. Activos no corrientes mantenidos para la venta.','{+580,+581,+582,+583,+584,-599}');

--'II. Existencias.' 499, 529
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Comerciales.','{+30, -390}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Materias primas y otros aprovisionamientos.','{+31, +32, -391, -392}');

--'Productos en curso.'     ******************************************************************************************************
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo largo de producción.','{+3301,+3311,+3401,+3411,-3931,-3941}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo corto de producción.','{+3300,+3310,+3400,+3410,-3930,-3940}');

-- 4. Productos terminados.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo largo de producción.','{+3501,+3511,-3951}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo corto de producción.','{+3500,+3510,-3950}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Subproductos, residuos y materiales recuperados.','{+36,-396}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Anticipos a proveedores.','{+4070,+4073,+4074,+4077}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Anticipos a proveedores, empresas del grupo y asociadas.','{+4071,+4072,+4075,+4076}');


--'III. Deudores comerciales y otras cuentas a cobrar.'
--1. Clientes por ventas y prestaciones de servicios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes por ventas y prestaciones de servicios a largo plazo.',
'{+4302,+4303,+4316,+4317,+4318,+4319,+4321,+43501,+43511,+43521,+43541,+43571,-4371 }');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes por ventas y prestaciones de servicios a corto plazo.',
'{+4300,+4304,+4309,+4310,+4311,+4312,+4315,+4320,+4350,+4351,+43520,+43540,+4356,+43570,+4359,+4360,-4370,-490,-4935}');

--2. Clientes, empresas del grupo y asociadas.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes, empresas del grupo y asociadas a largo plazo.',
        '{+43301,+43311,+43321,+43341,+43371,+43401,+43411,+43421,+43441,+43471}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes, empresas del grupo y asociadas a corto plazo.',
        '{+43300,+43310,+43320,+43340,+4336,+43370,+4339,+43400,+43410,+43420,+43440,+4346,+43470,+4349,-4933,-4934}');

--3. Deudores varios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Deudores varios.','{+440,+441,+444,+446,+449,+5531,+5533,+554}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Deudores varios, empresas del grupo y asociadas.','{+442,+443}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Personal.','{+460,+544}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Activos por impuesto corriente.','{+4703,+4709,+473}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Otros créditos con las Administraciones Públicas.','{+4700,+4701,+4702,+4707,+4708,+471,+472}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Accionistas (socios) por desembolsos exigidos ','{+5580,+5581}');



--'IV. Inversiones en empresas del grupo y asociadas a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Instrumentos de patrimonio.','{+5303,+5304,-5393,-5394,-5933,-5934}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Créditos a empresas.','{+5323,+5324,+5343,+5344,-5953,-5954}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Valores representativos de deuda.','{+5313,+5314,+5333,+5334,-5943,-5944}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Derivados.','{+5353,+5354,+5523,+5524}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Otros activos financieros.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Otras inversiones.','{}');

--'V. Inversiones financieras a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Instrumentos de patrimonio.','{+5305,+540,-5395,-549}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Créditos a empresas.',
    '{+5325,+5345,+542,+543,+547,-5955,-598,+5315,+5335,+541,+546,-5935,-5945,-597}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Valores representativos de deuda.','{+5590,+5593}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Derivados.','{+5355,+545,+548,+551,+5525,+565,+566}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Otros activos financieros.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Otras inversiones.','{}');

--'VI. Periodificaciones a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (13, 'Periodificaciones a corto plazo.','{+480,+567}');


--'VII. Efectivo y otros activos líquidos equivalentes.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (14, 'Tesorería.','{+570,+571,+572,+573,+574,+575}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (14, 'Otros activos líquidos equivalentes.','{+576}');

-- TOTAL ACTIVO (A + B)

-- ********************
-- PATRIMONIO NETO
-- ********************
-- A-1) Fondos propios.

--'I. Capital.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (15, 'Capital escriturado.','{+100,+101,+102}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (15, '(Capital no exigido)','{-1030,-1040}');

--'II. Prima de emisión.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (16, 'Prima de emisión.','{+110}');

--'III. Reservas.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (17, 'Legal y estatutarias.','{+112,+1141}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (17, 'Otras reservas.','{+113,+1140,+1142,+1143,+1144,+1145,+115,+119}');

--'IV. (Acciones y participaciones en patrimonio propias).');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (18, '(Acciones y participaciones en patrimonio propias).','{-108,-109}');

--'V. Resultados de ejercicios anteriores.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (19, 'Remanente.','{+120}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (19, '(Resultados negativos de ejercicios anteriores).','{-121}');

--'VI. Otras aportaciones de socios.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (20, 'Otras aportaciones de socios.','{+118,+550}');

--'VII. Resultado del ejercicio.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (21, 'Resultado del ejercicio.','{+129}');

--'VIII. (Dividendo a cuenta).');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (22, '(Dividendo a cuenta).','{-557}');

--'IX. Otros instrumentos de patrimonio neto.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (23, 'Otros instrumentos de patrimonio neto.','{+111}');

-- A-2) Ajustes por cambios de valor.

--'I. Activos financieros disponibles para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (24, 'Activos financieros disponibles para la venta.','{+133}');
--'II. Operaciones de cobertura.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (25, 'Operaciones de cobertura.','{+1340,+1341}');
--'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (26, 'Activos no corrientes y pasivos vinculados, mantenidos para la venta.','{+136}');
--'IV. Diferencia de conversión.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (27, 'Diferencia de conversión.','{+135}');
--'V. Otros');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (28, 'Otros','{+137}');

-- A-3) Subvenciones, donaciones y legados recibidos.

--'A-3) Subvenciones, donaciones y legados recibidos.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (29, 'Subvenciones, donaciones y legados recibidos.','{+130,+131,+132}');




-- ********************
-- B) PASIVO NO CORRIENTE
-- ********************

--'I. Provisiones a largo plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Obligaciones por prestaciones a largo plazo al personal.','{+140}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Actuaciones medioambientales.','{+145}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Provisiones por reestructuración.','{+146}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Otras provisiones.','{+141,+142,+143,+147}');

--'II Deudas a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Obligaciones y otros valores negociables.','{+177,+178,+179}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Deudas con entidades de crédito.','{+1605,+170}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Acreedores por arrendamiento financiero.','{+1625,+174}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Derivados.','{+176}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Otros pasivos financieros.',
       '{+1615,+1635,+171,+172,+173,+175,+180,+185,+189,+1645,+1655,+1665,+1675,+1685,+16905,+16915,+16955,+16995}');

--'III. Deudas con empresas del grupo y asociadas a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (32, 'Deudas con empresas del grupo y asociadas a largo plazo.',
'{+1603,+1604,+1613,+1614,+1623,+1624,+1633,+1634,+1643,+1644,+1653,+1654,+1663,+1664,+1673,+1674,+1683,+1684,+16903,+16904,+16913,+16914,+16953,+16954,+16993,+16994}');

--'IV. Pasivos por impuesto diferido.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (33, 'Pasivos por impuesto diferido.','{+479}');

--'V. Periodificaciones a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (34, 'Periodificaciones a largo plazo.','{+1810,+1815}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (34, 'Periodificaciones a largo plazo, empresas del grupo y asociadas.','{+1813,+1814}');

--'VI. Acreedores comerciales no corrientes.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (35, 'Acreedores comerciales no corrientes.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (35, 'Acreedores comerciales no corrientes, empresas del grupo y asociadas.','{}');
--'VII. Deuda con características especiales a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (36, 'Deuda con características especiales a largo plazo.','{-15,-5585}');

-- ********************
-- C) PASIVO CORRIENTE
-- ********************

--'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (37, 'Pasivos vinculados con activos no corrientes mantenidos para la venta.','{+585,+586,+587,+588,+589}');
--'II. Provisiones a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (38, 'Provisiones a corto plazo.','{+499,+529}');
--'III. Deudas a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Obligaciones y otros valores negociables.','{+500,+501,+505,+506}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Deudas con entidades de crédito.','{+5105,+520,+527}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Acreedores por arrendamiento financiero.','{+5125,+524}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Derivados.','{+5595,+5598}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Otros pasivos financieros.','{-1034, -1044, -190,-1920,-1925,+194,+509,+5115,+5135,+5145,+521,+522,+523,+525,+526,+528,+551,+5525,+5530,+5532,+555,+5565,+5566,+560,+561,+569}');

--'IV. Deudas con empresas del grupo y asociadas a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (40, 'Deudas con empresas del grupo y asociadas a corto plazo.',
'{-1923,-1924,+5103,+5104,+5113,+5114,+5123,+5124,+5133,+5134,+5143,+5144,+5523,+5524,+5563,+5564}');

--'V. Acreedores comerciales y otras cuentas a pagar.');
--1. Proveedores.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores a largo plazo.','{+4002,+4003,+4011,+4052,+4053,-4061}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores a corto plazo.','{+4000,+4004,+4009,+4010,+4050,+4051,+4054,+4056,+4059,-4060}');

--2. Proveedores, empresas del grupo y asociadas.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores, empresas del grupo y asociadas a largo plazo.','{+4032,+4033,+4042,+4043}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores, empresas del grupo y asociadas a corto plazo.','{+4030,+4031,+4034,+4036,+4039,+4040,+4041,+4044,+4046,+4049}');

--3. Acreedores varios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Acreedores varios.','{+410,+411,+414,+419,+554}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Acreedores varios, empresas del grupo y asociadas.','{+412,+413}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Personal (remuneraciones pendientes de pago).','{+465,+466}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Pasivos por impuesto corriente.','{+4752,+4755}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Otras deudas con las Administraciones Públicas.','{+4750,+4751,+4758,+476,+477,+4753,+4754,+4756,+4757,+4759}');

--7. Anticipos de clientes.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Anticipos de clientes.','{+4380,+4383}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Anticipos de clientes, empresas del grupo y asociadas.','{+4381,+4382}');

--'VI. Periodificaciones a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (42, 'Periodificaciones a corto plazo.','{+485,+568}');
--'VII. Deuda con características especiales a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (43, 'Deuda con características especiales a corto plazo.','{-195,-197,+199,+502,+507}');


