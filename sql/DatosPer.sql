--
-- Naturaleza jurídica
--
CREATE TABLE datosper_legal
(
    id                  serial NOT NULL,
    forma_juridica      varchar(50),
    primary key (forma_juridica)
);

INSERT INTO datosper_legal (forma_juridica) VALUES ('SA');
INSERT INTO datosper_legal (forma_juridica) VALUES ('SL');
INSERT INTO datosper_legal (forma_juridica) VALUES ('RETA'); -- AUTONOMOS
INSERT INTO datosper_legal (forma_juridica) VALUES ('COOPERATIVA');
INSERT INTO datosper_legal (forma_juridica) VALUES ('COMUNIDAD-BIENES');
INSERT INTO datosper_legal (forma_juridica) VALUES ('UTE');
/


CREATE TABLE datosper
(
    id                  serial NOT NULL,
    forma_juridica      varchar(50) references datosper_legal(forma_juridica),
    fecha_constitucion  date,                                               -- fecha de constitución de la sociedad
    carga_impositiva    numeric(4,2) default 20,
    sociedades          varchar(2) default 'NO',
    capital_social      numeric(10,2) default 0,
    income_account      varchar(40), -- income account cuenta de ingresos
    fiscal_year         char(4),
    periodo             char(2),
    irpf_profesionales  numeric(4,2) default 21,
    nif                 char(10),
    nombre              varchar(60),
    direccion           varchar(90), -- Avenida Europa, 21
    objeto              varchar(40), -- bloque A 2ºD
    poblacion           varchar(90), -- 18690 Almuñécar Granada
    movil               char(10),
    mail                varchar(60),
    plantilla_factura   bytea,
    plantilla_albaran   bytea,
    plantilla_proforma  bytea,
    escrituras_consti   bytea,
    cero36              bytea
);

ALTER TABLE datosper ADD COLUMN irpf_profesionales numeric(4,2)  default 21;
ALTER TABLE datosper ADD COLUMN periodo char(1);
ALTER TABLE datosper ADD COLUMN fiscal_year char(4);
ALTER TABLE datosper ADD COLUMN nif char(10);
ALTER TABLE datosper ADD COLUMN nombre varchar(60);
ALTER TABLE datosper ADD COLUMN direccion varchar(90);
ALTER TABLE datosper ADD COLUMN objeto varchar(40);
ALTER TABLE datosper ADD COLUMN poblacion varchar(90);
ALTER TABLE datosper ADD COLUMN movil char(10);
ALTER TABLE datosper ADD COLUMN mail varchar(60);
ALTER TABLE datosper ADD COLUMN carga_impositiva numeric(4,2)
ALTER TABLE datosper
  ADD CONSTRAINT datosper_forma_juridica_fkey FOREIGN KEY (forma_juridica)
  REFERENCES datosper_legal (forma_juridica);

ALTER TABLE datosper drop column periodo
ALTER TABLE datosper add column periodo char(2)
ALTER TABLE datosper add column sociedades          varchar(2)

ALTER TABLE datosper add column fecha_constitucion  date
ALTER TABLE datosper add column escrituras_consti   bytea
ALTER TABLE datosper add column cero36              bytea



insert into datosper (income_account, forma_juridica, fiscal_year, periodo, nif, nombre) 
values ('2031-0023-95-1234567890','SL','2013','3','B18456962','Empresa Demo');

update datosper set plantilla_factura= lo_import('/home/antonio/plantillas_pdf/plantilla_factura10-2011.pdf');

-- el fichero tiene que estar en la carpeta de datos de postgres
insert into datosper (income_account,plantilla_factura) 
values ('2031-0023-95-1234567890',pg_read_binary_file('plantilla_factura10-2011.pdf'));

UPDATE datosper
   SET plantilla_factura = {$blobfile='/home/antonio/plantillas_pdf/plantilla_factura10-2011.pdf'}
WHERE id = 2;


--
-- Capital, socios
--
CREATE TABLE capital
(
    id                  serial NOT NULL,
    nif                 varchar(10),
    nombre              varchar(90),
    aportacion          numeric(8,2),
    fecha               date,
    id_apunte           integer,
    primary key (id)
);
/


-- Select AddSocio('23781553J','Antonio Pérez Caballero',1000,'2013-01-01','5720000003')
    

INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781553J','Antonio Pérez Caballero',1000);
INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781554J','Sara Pérez Fajardo',1000);
INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781555J','María del Mar Pérez Fajardo',1000);
/
--
-- Cambios en el capital de la sociedad
--
CREATE TABLE capital_cambios
(
    id                  serial NOT NULL,
    fecha               date,
    nif                 varchar(10),
    nombre              varchar(90),
    aportacion          numeric(8,2),
    escritura_publica   bytea,
    primary key (id)
);
/


--
-- Administradores
--
CREATE TABLE administradores
(
    id                  serial NOT NULL,
    nif                 varchar(10),
    nombre              varchar(90),
    capacidad           varchar(50), -- Unico, solidario, mancomunado
    fecha_desde         date,
    primary key (id)
);
/

INSERT INTO administradores (nif, nombre, capacidad) VALUES ('23781555J','María del Mar Pérez Fajardo','Solidaria');
/

--
-- Administradores cambios
--
CREATE TABLE administradores_cambios
(
    id                  serial NOT NULL,
    fecha               date,
    nif                 varchar(10),
    nombre              varchar(90),
    capacidad           varchar(50), -- Unico, solidario, mancomunado
    escritura_publica   bytea,
    primary key (id)
);
/

--
-- Personal Recursos Humanos, además de Recursos humanos externos y colaboradores
-- También representa la tabla de usuarios de la aplicación
--
CREATE TABLE PersonalRRHH       -- Usuarios de la aplicación
(
    id                  serial NOT NULL,
    tipo                varchar(50),    -- tipo de relación con la empresa empleado, freelance, socio, administrador
    Empleado            varchar(25),
    LinkedIn            varchar(90),
    email               varchar(90),
    cargo               varchar(50), -- cargo responsabilidad en la empresa
    estudios            varchar(50), -- nivel de estudios
    categoria           varchar(50), -- categoría profesional
    tipo_contrato       varchar(50), -- tipo de contrato
    SalarioBruto        numeric(8,2), -- salario bruto anual
    nif                 varchar(10),
    Nombre              varchar(90),
    fecha_nacimiento    date,
    estado_civil        varchar(25),
    fecha_alta          date,
    fecha_baja          date,
    hijos               integer,
    asucargo            integer,
    contrato            bytea,
    primary key (id)
);
/

INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
    VALUES ('23781553J','Antonio Pérez Caballero','Responsable de producto', 'socio','antonio@redmoon.es');

INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
    VALUES ('23781554J','Sara Pérez Fajardo','Administración, publicidad y diseño', 'socio','sara@redmoon.es');

INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
    VALUES ('23781555J','María del Mar Pérez Fajardo','Desarrollo de negocio', 'administrador','maria@redmoon.es');

INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
    VALUES ('23781555J','Ángel Luis García Sánchez','Desarrollo Java', 'empleado','angel@redmoon.es');
/

--
-- Crear una vista con la lista de socios más los administradores y los trabajadores
--


