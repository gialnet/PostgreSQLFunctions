
--
-- Los distintos tipos de cleintes en función de su residencia y consideraciones
-- especiales tributarias
--
CREATE TABLE customers_type
(
    id              serial      NOT NULL,
    descripcion     varchar(50),
    cuenta          varchar(4),
    gasto           varchar(4),
    primary key (id)
);

INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PENINSULA Y BALEARES','4300','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES RECARGO EQUIVALENCIA PENINSULA Y BALEARES','4301','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES CANARIAS','4302','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES CEUTA Y MELILLA','4303','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PAIS MIEMBRO DE LA UE','4303','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PAIS FUERA UE','4304','7000');
/


--
-- Clientes
--

CREATE TABLE customers
(
   id                      serial      NOT NULL,
   id_customers_type       integer,
   IBAN                    varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
   nif                     char(10),
   nombre                  varchar(60),
   direccion               varchar(90), -- Avenida Europa, 21
   objeto                  varchar(40), -- bloque A 2ºD
   poblacion               varchar(90), -- 18690 Almuñécar Granada
   movil                   char(10),
   mail                    varchar(60),
   saldo                   numeric(5),
   passwd                  varchar(40),
   clase                   char(2)        DEFAULT 'SL'::bpchar,
   pertenece_a             integer        DEFAULT 0,
   sip                     varchar(40),
   perfil                  varchar(50),
   digitos                 varchar(16),
   rol                     integer,
   carpeta_digitalizacion  varchar(90),
   tipo                    varchar(40)    DEFAULT 'US'::character varying,
   id_delegacion           integer,
   id_departamento         integer,
   envio_sms               char(1)        DEFAULT 'N'::bpchar,
   databasename            varchar(20),
   passdatabase            varchar(10),
   primary key (id)
);

create index customers_nombre on customers(nombre);

Alter Table customers Add Column objeto varchar(40)
Alter Table customers Add Column poblacion varchar(90)
Alter Table customers Add Column id_customers_type       integer

INSERT INTO customers (nif,nombre,direccion,movil,mail) 
VALUES ('P1800400B','Excmo. Ayuntamiento de Albolote','Plaza de España, 1, 18220 Albolote (Granada)','666123456','aporcel@gmail.com');


--
-- TIPOS DE PROVEEDORES
--
/*
62. SERVICIOS EXTERIORES
620. Gastos en investigación y desarrollo del ejercicio.
621. Arrendamientos y cánones.
622. Reparaciones y conservación.
623. Servicios de profesionales independientes.
624. Transportes.
625. Primas de seguros.
626. Servicios bancarios y similares.
627. Publicidad, propaganda y relaciones públicas.
628. Suministros.
629. Otros servicios.
*/
CREATE TABLE suppliers_type
(
    id              serial      NOT NULL,
    descripcion     varchar(50),
    cuenta          varchar(4),
    gasto           varchar(4),
    primary key (id)
);

INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES',                      '4000','6000');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES UNIÓN EUROPEA',        '4001','6000');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES INTERNACIONALES NO UE','4004','6000'); --4004 PROVEEDOR EXTRACOMUNITARIO
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('BANCOS','5720','6260');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('ARRENDAMIENTOS','4100','6210');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('REPARACIONES','4100','6220');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROFESIONALES','4100','6230');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('TRANSPORTE','4100','6240');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('SEGUROS','4100','6250');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PUBLICIDAD','4100','6270');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('SUMINISTROS','4100','6280');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('OTROS','4100','6290');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('I+D','4100','6200');
/
--
-- Proveedores
--

CREATE TABLE suppliers
(
   id                      serial      NOT NULL,
   id_suppliers_type       integer,
   IBAN                    varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
   nif                     char(10),
   nombre                  varchar(60),
   direccion               varchar(90), -- Avenida Europa, 21
   objeto                  varchar(40), -- bloque A 2ºD
   poblacion               varchar(90), -- 18690 Almuñécar Granada
   movil                   char(10),
   mail                    varchar(60),
   saldo                   numeric(5),
   passwd                  varchar(40),
   clase                   char(2)        DEFAULT 'SL'::bpchar,
   pertenece_a             integer        DEFAULT 0,
   sip                     varchar(40),
   perfil                  varchar(50),
   digitos                 varchar(16),
   rol                     integer,
   carpeta_digitalizacion  varchar(90),
   tipo                    varchar(40)    DEFAULT 'US'::character varying,
   id_delegacion           integer,
   id_departamento         integer,
   envio_sms               char(1)        DEFAULT 'N'::bpchar,
   databasename            varchar(20),
   passdatabase            varchar(10),
   primary key (id)
);

create index suppliers_nombre on suppliers(nombre);

Alter Table suppliers Add Column objeto varchar(40)
Alter Table suppliers Add Column poblacion varchar(90)
Alter Table suppliers Add Column id_suppliers_type integer



-- crear los contadores
CREATE SEQUENCE cont_facturas;
CREATE SEQUENCE cont_albaranes;

-- aumentar los contadores
SELECT nextval('cont_facturas');
SELECT nextval('cont_albaranes');




--
-- Facturas
--

CREATE TABLE head_bill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    id_apunte           integer,
    id_apcobro          integer,
    fiscal_year         char(4),
    trimestre           char(2),
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    global_dto          numeric(4,2) default 0, -- para un posible descuento a nivel global de la factura al margen del dto. a cada linea de producto
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    fecha_cobro         date,
    primary key (id)
);

create unique index number_bill on head_bill(numero);
create index head_bill_fiscal_year on head_bill(fiscal_year);
create index head_bill_fecha on head_bill(fecha);

ALTER TABLE head_bill ADD COLUMN estado varchar(10) DEFAULT 'PENDIENTE'::character varying
ALTER TABLE head_bill ADD COLUMN id_apunte integer
ALTER TABLE head_bill ADD COLUMN fecha_cobro date
ALTER TABLE head_bill ADD COLUMN id_apcobro integer
ALTER TABLE head_bill ADD COLUMN fiscal_year         char(4)
ALTER TABLE head_bill ADD COLUMN trimestre           char(1)
insert into head_bill (id_cliente,fecha,numero) 
values 
(1, '2003/07/09', '2013/30103');



-- Lineas de detalle de la factura

CREATE TABLE row_bill
(
    id                  serial NOT NULL,
    id_bill             integer references head_bill(id), -- bill, invoice
    id_item             integer, -- references productos/items(id), para futuras versiones de clientes con control de almacén
    id_store            integer, -- references almacenes/stores(id), para futuras versiones de clientes con control de almacén
    concepto            varchar(90),
    unidades            numeric(4,2) default 1,
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 21,
    por_req             numeric(4,2) default 0,
    por_dto             numeric(4,2) default 0,
    primary key (id)
);

CREATE INDEX row_bill_id_bill on row_bill (id_bill);

--ALTER TABLE row_bill alter COLUMN unidades set default 1
--ALTER TABLE row_bill alter COLUMN importe set default 0
--ALTER TABLE row_bill alter COLUMN por_vat set default 21
--ALTER TABLE row_bill alter COLUMN por_dto set default 0
--ALTER TABLE row_bill add COLUMN por_req numeric(4,2) 
--ALTER TABLE row_bill alter COLUMN por_req set default 0
-- Tipos de IVA 2013 -> 21,10,4

insert into row_bill 
(id_bill,concepto,unidades,importe,por_vat) 
values 
(1,'Desarrollo portal Web Radio Albolote',1,1800,21);

insert into row_bill 
(id_bill,concepto,unidades,importe,por_vat) 
values 
(1,'Formación personal Radio Albolote',1,250,21);


-- Vista con los totales agrupados por tipo de IVA

create or replace view total_bill (base,iva, id_bill) 
as select sum((importe-((importe*por_dto)/100))*unidades), por_vat, id_bill from row_bill
group by por_vat,id_bill;


-- Total a pagar
create or replace view total_a_pagar (total, id_bill) as 
select sum(((importe - getdto(importe,por_dto)) * unidades) + getiva(importe-getdto(importe,por_dto), por_vat)) as total,id_bill from row_bill
group by id_bill;


create or replace view vwhead_bill (id,id_cliente,fecha,numero,global_dto,nif,nombre,direccion,movil,mail,
    income_account,estado,total,id_customers_type,fiscal_year,trimestre) 
as select h.id,h.id_cliente,h.fecha,h.numero,h.global_dto,c.nif,c.nombre,c.direccion,c.movil,c.mail,
    d.income_account,h.estado,t.total,c.id_customers_type,h.fiscal_year,h.trimestre
from head_bill h, customers c, datosper d, total_a_pagar t where h.id_cliente=c.id and d.id=1 and t.id_bill=h.id
order by h.id;

-- para depurar
select importe,importe - getdto(importe,por_dto) as neto,por_dto, por_vat, getiva(importe-getdto(importe,por_dto), por_vat),
getiva(importe, por_vat) as sindto, id_bill from row_bill where id_bill=1;

--
-- para el listado de facturas emitidas Ventas e Ingresos
--
select T.base*T.iva/100 as impIVA,T.id_bill,T.iva,B.fecha,B.numero,B.nif,B.nombre,T.base,T.base+(T.base*T.iva/100) as total from total_bill T, vwhead_bill B 
where B.id=T.id_bill and B.fiscal_year='2013' and B.trimestre='3'
order by T.id_bill

-- Vista con los datos de la factura mas las lineas !!! no tiene sentido
/*
create or replace view one_bill (id,cliente,cif,fecha,numero,concepto,unidades,importe,total) 
as select h.id,h.cliente,h.cif,h.fecha,h.numero,r.concepto,r.unidades,r.importe,
(r.importe*r.unidades)
from head_bill h, row_bill r where h.id=r.id_bill;
*/

--
-- Albaranes
--

CREATE TABLE head_waybill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    primary key (id)
);

CREATE TABLE row_waybill
(
    id                  serial NOT NULL,
    id_head_waybill     integer references head_waybill(id), -- bill, invoice
    id_item             integer, -- references prodcutos/items(id), para futuras versiones de clientes con control de almacen
    id_store            integer, -- references almacenes/stores(id), para futuras versiones de clientes con control de almacen
    concepto            varchar(90),
    unidades            numeric(4,2),
    importe             numeric(8,2),
    por_vat             numeric(4,2),
    por_dto             numeric(4,2),
    primary key (id)
);

--
-- facturas proforma/presupuestos
--

CREATE TABLE head_budgetbill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    primary key (id)
);

CREATE TABLE row_budgetbill
(
    id                  serial NOT NULL,
    id_head_budgetbill  integer references head_budgetbill(id), -- bill, invoice
    concepto            varchar(90),
    unidades            numeric(4,2),
    importe             numeric(8,2),
    por_vat             numeric(4,2),
    por_dto             numeric(4,2),
    primary key (id)
);


--
-- Libro de facturas recibidas/invoices received
--

CREATE TABLE invoices_received
(
    id                  serial NOT NULL,
    id_proveedor        integer references suppliers(id),
    id_banco            integer, -- banco en el que se paga
    id_apunte           integer,
    id_appago           integer,
    forma_pago          char(1) NOT NULL CHECK (forma_pago IN ('E','B')),
    fecha_emision       date, -- fecha de la factura
    fecha_vencimiento   date, -- fecha de vencimiento o limite de pago
    fecha_pago          date, -- fecha en la que se hace efectiva
    fiscal_year         char(4),
    concepto            varchar(90),
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 21,
    total               numeric(8,2) default 0,
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    trimestre           char(2), -- 1,2,3,4 en el que se ha declarado
    primary key (id)
);

-- Vista con los datos de la facturas facuras recibidas
ALTER TABLE invoices_received alter COLUMN forma_pago set DEFAULT 'B'
ALTER TABLE invoices_received ADD COLUMN id_apunte integer
ALTER TABLE invoices_received ADD COLUMN id_appago integer

create or replace view vw_recibidas (id,id_proveedor,id_banco,forma_pago,fecha_emision,fecha_vencimiento,fecha_pago,
    fiscal_year,concepto,importe,por_vat,total,estado,trimestre,nombre,nif)
as select i.id,i.id_proveedor,i.id_banco,i.forma_pago,i.fecha_emision,i.fecha_vencimiento,i.fecha_pago,
    i.fiscal_year,i.concepto,i.importe,i.por_vat,i.total,i.estado,i.trimestre,s.nombre,s.nif
from invoices_received i, suppliers s where i.id_proveedor=s.id;

-- Justificantes de facturas/supporting invoices
-- digest(data bytea, 'sha1') returns bytea
CREATE TABLE doc_supporting
(
   id           serial   NOT NULL,
   id_issued    integer,
   id_received  integer,
   id_user      integer,
   lote         integer,
   tipo_mime    varchar(40) DEFAULT 'application/pdf'::character varying,
   filename     varchar(250),
   filesize     integer,
   fecha        timestamp DEFAULT LOCALTIMESTAMP,
   hash_algo    varchar(128), -- almacenar la representación del algoritmo en hexadecimal sha1 sha224/256/384/512
   fileblob     bytea,
   url_nube     text,
    primary key (id)
);

create index doc_supporting_id_issued on doc_supporting(id_issued);
create index doc_supporting_id_received on doc_supporting(id_received);

-- ALTER TABLE doc_supporting alter COLUMN tipo_mime set DEFAULT 'application/pdf'
-- ALTER TABLE doc_supporting ADD COLUMN hash_algo    varchar(128)
-- ALTER TABLE head_bill alter COLUMN global_dto set default 0
-- SELECT encode(digest(plantilla_factura, 'sha512'), 'hex') FROM DATOSPER

--
-- Configuración de la cuenta de correo de salida
--
CREATE TABLE OUTGOING_MAIL_CONFIGURATION (
	ID serial   NOT NULL, 
	NAME VARCHAR(250), 
	USER_NAME VARCHAR(250), 
	PASSWD VARCHAR(250), 
	HOST VARCHAR(250), 
	PORT VARCHAR(10), 
	SERVER_SECURITY VARCHAR(10), 
	EMAIL VARCHAR(250),
    primary key (id)
);

Insert into OUTGOING_MAIL_CONFIGURATION (NAME,USER_NAME,PASSWD,HOST,PORT,SERVER_SECURITY,EMAIL) 
values ('Redmoon Gmail STARTTLS','redmoon.granada@gmail.com','cajagranada2012','smtp.gmail.com','587','starttls','redmoon.granada@gmail.com');

Insert into OUTGOING_MAIL_CONFIGURATION (NAME,USER_NAME,PASSWD,HOST,PORT,SERVER_SECURITY,EMAIL) 
values ('Redmoon Gmail SSL','redmoon.granada@gmail.com','cajagranada2012','smtp.gmail.com','465','ssl/tls','redmoon.granada@gmail.com');

