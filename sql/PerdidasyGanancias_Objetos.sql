/*
DROP TABLE HistoricoPyG;
DROP TABLE tmp_ResultPyG;
DROP TABLE SeccionPyG;
DROP TABLE PerdidasGanancias;
*/
--
-- Informe de Perdidas y Ganancias
--
CREATE TABLE PerdidasGanancias
(
    id              serial NOT NULL,
    Tipo            varchar(10),
    primary key (id)
);

INSERT INTO PerdidasGanancias (Tipo) VALUES ('Normal');
INSERT INTO PerdidasGanancias (Tipo) VALUES ('Abreviada');


--
-- Secciones del informe
--
CREATE TABLE SeccionPyG
(
    id                  serial NOT NULL,
    id_pyg              integer references PerdidasGanancias(id),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',
    Seccion             varchar(150),
    grupo_cuentas       text[],
    primary key (id)
);

create index SeccionPyG_Seccion on SeccionPyG(Seccion);


--
-- Cuenta de Perdidas y Ganancias del ejercicio en curso
--

CREATE TABLE tmp_ResultPyG
(
    id                  serial NOT NULL,
    usuario             varchar(90),
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    id_SeccionPyG       integer references SeccionPyG(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)

);


--
-- Cuenta de Perdidas y Ganancias consolidados, años cerrados.
--
CREATE TABLE HistoricoPyG
(
    id                  serial NOT NULL,
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    id_SeccionPyG       integer references SeccionPyG(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)
);


-- ***************************************************************************
--                  Modelo Normal
-- ***************************************************************************

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'1. Importe neto de la cifra de negocios.',
    '{+700, +701, +702, +703, +704, +705, -706, -708, -709}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'2. Variación de existencias de productos terminados y en curso de fabricación.',
    '{-6930, 71, +7930}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'3. Trabajos realizados por la empresa para su activo.',
    '{+73}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'4. Aprovisionamientos.',
    '{-600, -601, -602, +606, -607, +608, +609, 61, -6931,-6932, -6933, +7931, +7932, +7933}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'5. Otros ingresos de explotación.',
    '{+74000, +74700, +75}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'6. Gastos de personal.',
    '{ -64, +7950, +7957}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'7. Otros gastos de explotación.',
    '{-62, -631, -634, +636, +639, -65, -694, -695, +794, +7954}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'8. Amortización del inmovilizado.',
    '{-68}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'9. Imputación de subvenciones de inmovilizado no financiero y otras.',
    '{+74600}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'10. Excesos de provisiones.',
    '{+7951, +7952, +7955, +7956 }');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'11. Deterioro y resultado por enajenaciones del inmovilizado.',
    '{-670, -671, -672, -690, -691, -692, +770, +771, +772, +790, +791, +792}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'12. Diferencia negativa de combinaciones de negocios.',
    '{+774}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'13. Otros resultados.',
    '{-678, +778}');

-- *****************************************
-- OPERATING INCOME RESULTADO DE EXPLOTACION
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) VALUES ('OPERATING INCOME',
    1,'A) RESULTADO DE EXPLOTACION (1+2+3+4+5+6+7+8+9+10+11+12+13).', '{}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'14. Ingresos financieros.', '{}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'a) Imputación de subvenciones,donaciones y legados de carácter financiero.',
    '{+74001, +74601, +74701}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'b) Otros ingresos financieros.',
    '{ +760, +761, +762, +767, +769}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'15. Gastos financieros.',
    '{-660, -661, -662, -664, -665, -669}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'16. Variación de valor razonable en instrumentos financieros.',
    '{-663, +763}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'17. Diferencias de cambio.',
    '{-668, +768}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'18. Deterioro y resultado por enajenaciones de instrumentos financieros.',
    '{-666, -667, -673, -675, -696, -697, -698, -699, +766, +773, +775, +796, +797, +798, +799}');

-- **********************
-- RESULTADOS FINANCIEROS
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('FINANCIAL RESULTS',1,'B) RESULTADO FINANCIERO (14+15+16+17+18)', '{}');

-- ****************************************
-- beneficio antes de intereses e impuestos
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('EBITDA',1,'C) RESULTADO ANTES DE IMPUESTOS (A+B)', '{}');


INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'19. Impuestos sobre beneficios.',
    '{-6300, 6301, -633, +638}');

-- ***********************
-- RESULTADO DEL EJERCICIO
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('PROFIT',1,'D) RESULTADO DEL EJERCICIO (C + 19)', '{}');






-- ***************************************************************************
--                  Modelo Abreviado
-- ***************************************************************************

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'1. Importe neto de la cifra de negocios.',
    '{+700, +701, +702, +703, +704, +705, -706, -708, -709}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'2. Variación de existencias de productos terminados y en curso de fabricación.',
    '{-6930, 71, +7930}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'3. Trabajos realizados por la empresa para su activo.',
    '{+73}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'4. Aprovisionamientos.',
    '{-600, -601, -602, +606, -607, +608, +609, 61, -6931,-6932, -6933, +7931, +7932, +7933}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'5. Otros ingresos de explotación.',
    '{+74000, +74700, +75}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'6. Gastos de personal.',
    '{ -64, +7950, +7957}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'7. Otros gastos de explotación.',
    '{-62, -631, -634, +636, +639, -65, -694, -695, +794, +7954}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'8. Amortización del inmovilizado.',
    '{-68}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'9. Imputación de subvenciones de inmovilizado no financiero y otras.',
    '{+74600}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'10. Excesos de provisiones.',
    '{+7951, +7952, +7955, +7956 }');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'11. Deterioro y resultado por enajenaciones del inmovilizado.',
    '{-670, -671, -672, -690, -691, -692, +770, +771, +772, +790, +791, +792}');


-- *****************************************
-- OPERATING INCOME RESULTADO DE EXPLOTACION
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) VALUES ('OPERATING INCOME',
    2,'A) RESULTADO DE EXPLOTACION (1+2+3+4+5+6+7+8+9+10+11).', '{}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'12. Ingresos financieros.', '{}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'13. Gastos financieros.',
    '{-660, -661, -662, -664, -665, -669}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'14. Variación de valor razonable en instrumentos financieros.',
    '{-663, +763}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'15. Diferencias de cambio.',
    '{-668, +768}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'16. Deterioro y resultado por enajenaciones de instrumentos financieros.',
    '{-666, -667, -673, -675, -696, -697, -698, -699, +766, +773, +775, +796, +797, +798, +799}');

-- **********************
-- RESULTADOS FINANCIEROS
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('FINANCIAL RESULTS',2,'B) RESULTADO FINANCIERO (12+13+14+15+16)', '{}');

-- ****************************************
-- beneficio antes de intereses e impuestos
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('EBITDA',2,'C) RESULTADO ANTES DE IMPUESTOS (A+B)', '{}');


INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'17. Impuestos sobre beneficios.',
    '{-6300, 6301, -633, +638}');

-- ***********************
-- RESULTADO DEL EJERCICIO
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('PROFIT',2,'D) RESULTADO DEL EJERCICIO (C + 17)', '{}');


