--
-- Plan contable español
--


CREATE TABLE PlanGeneral
(
    id          serial NOT NULL,
    concepto    varchar(150),
    cuenta      varchar(5),
    vector      tsvector,
    primary key (id)
);
/

CREATE INDEX PlanGeneral_v ON PlanGeneral USING gist(vector);
update PlanGeneral set vector = to_tsvector('spanish',concepto);

select * from PlanGeneral where vector @@ to_tsquery('spanish','capital & social') order by id;

SELECT ts_rank_cd (vector, to_tsquery('spanish','capital')),concepto from PlanGeneral where vector @@ to_tsquery('spanish','capital')



-- alter table plangeneral add column vector tsvector

CREATE TABLE Cuentas
(
    cuenta      varchar(10) NOT NULL,
    concepto    varchar(120),
    year_fiscal varchar(4) default EXTRACT(year FROM now()),
    primary key (cuenta)
);

create index Cuentas_year_fiscal on Cuentas(year_fiscal);
/


--
-- Vista de bancos
--
create or replace view bancos (cuenta, concepto) as
        select * from cuentas where cuenta like '572%';
/


/*
    Realizar apuntes contables
*/
--*
CREATE TABLE Apuntes
(
    id          serial NOT NULL,
    concepto    varchar(120),
    fecha       date,
    year_fiscal varchar(4),
    periodo     varchar(2),
    reglas      json,
    primary key (id)
);

create index Apuntes_year_fiscal on Apuntes(year_fiscal);
--*
create index Apuntes_periodo on Apuntes(periodo);
/

-- drop index Apuntes_trimestre
/*
alter table Apuntes drop column trimestre

alter table Apuntes add column periodo varchar(2)

view seguridadsocial depends on table apuntes column trimestre
view irpf depends on table apuntes column trimestre
view iva depends on table apuntes column trimestre

update Apuntes set periodo = EXTRACT(QUARTER FROM Fecha)

*/

-- En el campo reglas vamos a guardar una relación de parejas de claves valor
-- Naturaleza de la operación, quien realiza la operación que módulo.
-- ejemplo 

-- newFactura.jsp realiza una factura 

--
-- Diario de operaciones contables
--
CREATE TABLE Diario
(
    id          serial NOT NULL,
    id_apunte   integer references Apuntes(id),
    cuenta      varchar(10) references Cuentas(cuenta),
    debe_haber  varchar(1), -- D/H
    importe     numeric(8,2),
    primary key (id)
);

create index Diario_cuenta on Diario(cuenta);
create index Diario_id_apunte on Diario(id_apunte);
/



-- Vista de saldo de cuentas
create or replace view PlanCuentaSaldos (cuenta,concepto,debe,haber,saldo,year_fiscal) AS
SELECT C.cuenta,C.concepto,getCuentaDebe(C.cuenta) as debe,getCuentaHaber(C.cuenta) as haber,
getCuentaDebe(C.cuenta)-getCuentaHaber(C.cuenta) as saldo, C.year_fiscal
FROM Cuentas C;
/


--
-- Vista de Salarios
--
create or replace view Salarios (cuenta, concepto, fecha, year_fiscal,periodo,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '640%' and d.cuenta=c.cuenta and d.id_apunte=a.id;
/


--
-- Vista de la cuenta de la Seguridad Social
--
create or replace view SeguridadSocial (cuenta, concepto, fecha, year_fiscal,periodo,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '476%' and d.cuenta=c.cuenta and d.id_apunte=a.id;
/


--
-- Vista de la cuenta de la Hacienda IRPF trabajadores y profesionales
-- 'IRPF-111+216+115'
--
create or replace view IRPF (cuenta, concepto, fecha, year_fiscal,trimestre,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '4751%' and d.cuenta=c.cuenta and d.id_apunte=a.id;

SELECT SUM(D.importe) AS Total FROM leg_detalle D, leg_obligaciones O WHERE O.naturaleza='IRPF-111+216+115' and O.year_fiscal=xYear and O.trimestre=xPeri;
/


--
-- Vista de la cuenta del IVA 
--
create or replace view IVA (cuenta, concepto, fecha, year_fiscal,trimestre,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '477%' and d.cuenta=c.cuenta and d.id_apunte=a.id;
/


--
-- Plantillas de asientos tipo
--
CREATE TABLE Template
(
    id          serial NOT NULL,
    concepto    varchar(120),
    primary key (id)
);
create index template_concepto on template(concepto);
/

--
-- movimientos a realizar por la platilla de asientos
--

CREATE TABLE Templates_detalle
(
    id              serial NOT NULL,
    id_template     integer references Template(id),
    cuenta          varchar(10),
    debe_haber      varchar(1),
    primary key (id)
);
/

--
-- Normativa
--

CREATE TABLE Normas_juridicas
(
    id              serial NOT NULL,
    Norma           text,
    primary key (id)
);

CREATE INDEX Normas_juridicas_idx ON Normas_juridicas USING gin(to_tsvector('spanish', Norma));
/


--
-- Texto desarrollo de la Nornativa
--
CREATE TABLE Normativa
(
    id                  serial NOT NULL,
    id_norma            integer references Normas_juridicas(id),
    TextoNorma          text,
    primary key (id)
);

CREATE INDEX Normativa_idx ON Normativa USING gin(to_tsvector('spanish', TextoNorma));
/



--
-- Vista vwApartadoSeccionBalance
--
create or replace view vwApartadoSeccionBalance (IDApartado,Norma,Seccion,Apartado,grupo_cuentas) AS
SELECT A.id, B.Norma, S.Seccion, A.Apartado, A.grupo_cuentas 
    FROM Balance B, SeccionBalance S, ApartadoSeccionBalance A
    WHERE B.id = S.id_balance AND S.id = A.id_SeccionBalance;
/




/*
Información que se debe presentar en el Registro Mercantil
Deberá presentarse en el Registro Mercantil de la provincia en la que radique su domicilio social:
a) Instancia de presentación de las cuentas.
b) Hoja de datos generales de identificación.
c) Declaración medioambiental.d) Modelo de autocartera.
e) Las cuentas anuales:
– Balance.
– Cuenta de pérdidas y ganancias.
– Estado de cambios en el patrimonio neto.
– Estado de flujos de efectivo (solo para empresas que cumplimentan el modelo normal de balance).
– Memoria.
f)
Certificación de la aprobación de las cuentas anuales, conteniendo la aplicación de resultados.
g) Informe de gestión (solo para empresas que cumplimentan el modelo normal de balance).
h) Informe de auditoría, cuando la sociedad esté obligada a auditarse o si la minoría lo solicitase.
i) Certificación acreditativa de que las cuentas depositadas se corresponden con las auditadas.
*/

--
-- Amortizaciones
--
CREATE TABLE Amortizaciones
(
    id                  serial NOT NULL,
    id_compra           integer,        -- para los casos de compras, inmaterial material
    year_fiscal         varchar(4),
    tipo                varchar(25), -- inmaterial material financiero
    plazo_years         integer,
    importe             numeric(8,2),
    valor_residual      numeric(8,2),
    inicio_year         integer, -- primer año de aplicación
    descripcion         text,
    primary key (id)
);
/


--
-- Tabla de amortización
--
CREATE TABLE DetalleAmortizaciones
(
    id                  serial NOT NULL,
    id_Amortizaciones   integer references Amortizaciones(id),
    year_fiscal         varchar(4),
    mes                 integer, -- para las amortizaciones financieras, sea más fácil recuperar un determinado plazo
    plazo_numero        integer,
    importe             numeric(8,2),
    intereses           numeric(8,2),
    principal           numeric(8,2),
    primary key (id)
);
/


