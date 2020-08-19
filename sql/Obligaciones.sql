/*
DROP TABLE leg_detalle;
DROP TABLE leg_obligaciones;
DROP TABLE obligaciones;
*/
--
-- Las obligaciones de una empresa con las administraciones
--
CREATE TABLE obligaciones
(
    id          serial NOT NULL,
    cuenta      varchar(10),
    naturaleza  varchar(50),
    periodo     varchar(2),
    plazos      varchar(90),
    primary key (naturaleza)
);



-- NRC modelo, ejercicio, periodo, NIF declarante, apellido e importe exacto del ingreso
--
-- peridos de las obligaciones 
--
-- url de verificación del NRC
-- https://www2.agenciatributaria.gob.es/L/inwinvoc/es.aeat.dit.adu.eeca.catalogo.vis.VisualizaSc?COMPLETA=NO&ORIGEN=J
--
CREATE TABLE leg_obligaciones
(
    id          serial NOT NULL,
    concepto    varchar(120),
    naturaleza  varchar(50) references obligaciones(naturaleza),
    year_fiscal varchar(4),
    periodo     varchar(2),
    estado      varchar(10) default 'PENDIENTE', -- PENDIENTE, PAGADO, CERRADO
    NRC         varchar(50), -- Codigo NRC obtenido del banco al ingresar un tributo
    fecha_pago  date,
    id_apunte   integer references Apuntes(id),
    primary key (id)
);

CREATE INDEX leg_obligaciones_apuntes on leg_obligaciones(id_apunte);
CREATE INDEX leg_obligaciones_naturaleza on leg_obligaciones(naturaleza);
CREATE INDEX leg_obligaciones_year_fiscal on leg_obligaciones(year_fiscal);


--
-- Detalles de un perido de obligaciones ejemplo: IRPF 3T 2013
-- se divide en: retenciones, especie, profesionales y alquileres
--

CREATE TABLE leg_detalle
(
    id          serial NOT NULL,
    id_leg      integer references leg_obligaciones(id),
    cuenta      varchar(10),
    importe     numeric(8,2),
    primary key (id)
);

CREATE INDEX leg_detalle_id_leg on leg_detalle(id_leg);



/*
-presentar el modelo 300 del iva cada trimestre.
-En enero presentar los modelos anuales 390 (resumen de iva)
-En marzo presentar el 347 (operaciones con terceros por valor de +3000€)
-En julio presentar el modelo 201 (impuesto de sociedades del ejercicio del año anterior). 
    Si este impuesto diera positivo, en octubre, diciembre y abril deberéis presentar también el modelo 202 
    (pagos fraccionados a cuenta del ISS).
-presentar los libros en el RR. MM. de vuestra provincia y en julio las cuentas anuales
*/


-- de caracter interno para las nóminas
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('NOMINAS','12',
    '{"periodo":"mes"}','4650000000');

--
-- IRPF
--
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 111-IRPF empleados y prof.','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000111');

INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 216-IRPF no residentes','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000216');

INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 115-IRPF alquileres','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000115');




-- ingresado a día 1
INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('Modelo 202-Acuenta Sociedades','3',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]','6300000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('Modelo 303-IVA','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4770000000');

-- Impuesto de Sociedades
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) 
    VALUES ('Modelo 200-SOCIEDADES','1','{"mes":"julio"}', '4752000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos) 
VALUES ('Modelo 123-Reparto de dividendos','1','{"mes":"julio"}');


INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('SEGURIDAD-SOCIAL','12','{"mensual":12}','4760000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 347-MAYORES-3000','1','{"mes":"marzo"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 349-OPERACIONES-INTRA','4','{depende del volumen de facturación}');


INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('IAE','1','{depende del volumen de facturación}');

-- una vez al año Los Resumenes
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 190: resumen 111','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 180: resumen 115','1','{"mes":"enero"}'); 
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 193: resumen 123','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 296: resumen 216','1','{"mes":"enero"}'); 
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 390: resumen 303','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Registro Mercantil-Libros y Cuentas anuales','1','{"mes":"julio"}');

