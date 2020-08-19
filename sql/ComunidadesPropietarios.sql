
--
-- Gestión de presupuestos
--
-- Se trata de crear un presupuesto para crear recibos de una comunidad de 
-- propietarios en función de los coeficientes de participación de los comuneros
--

--
-- Estas tablas se van a cargar desde hojas de cálculo Excel
-- también se exportan a Excel

-- A partir de un presupuesto se emiten las cuotas a los comuneros en función de
-- su coeficiente de participación

-- Existe la casualidad y por lo tanto se contempla el control de gastos
-- extraordinarios o derramas mediante confección del presupuesto y generación
-- de los recibos sin IVA


--
-- Datos generales de un presupuesto
--

CREATE TABLE Presupuestos
(
    id              serial NOT NULL,
    fecha           date default now(),
    estado          varchar(10) default 'pendiente', -- aprobado
    Descripcion     text,
    primary key (id)
);

INSERT INTO Presupuestos (Descripcion) VALUES ('Presupuesto año 2014');



--
-- Grupo de gasto, capitulos del presupuesto
--
CREATE TABLE grupo_gasto
(
    id              serial NOT NULL,
    Descripcion     text,
    primary key (id)
);

INSERT INTO grupo_gasto (Descripcion) VALUES ('ADMINISTRACIÓN');
INSERT INTO grupo_gasto (Descripcion) VALUES ('JARDIN-LIMPIEZA');
INSERT INTO grupo_gasto (Descripcion) VALUES ('AGUA');
INSERT INTO grupo_gasto (Descripcion) VALUES ('ALUMBRADO PÚBLICO');
INSERT INTO grupo_gasto (Descripcion) VALUES ('MANTENIMIENTO GENERAL');
INSERT INTO grupo_gasto (Descripcion) VALUES ('OTROS GASTOS');
INSERT INTO grupo_gasto (Descripcion) VALUES ('SANEAMIENTO');
INSERT INTO grupo_gasto (Descripcion) VALUES ('DERRAMAS');
INSERT INTO grupo_gasto (Descripcion) VALUES ('ASCENSORES');
INSERT INTO grupo_gasto (Descripcion) VALUES ('CALEFACCIÓN');


--
-- Detalle del presupuesto
--

CREATE TABLE Presupuestos_row
(
    id                  serial NOT NULL,
    id_presupuestos     integer references Presupuestos(id),
    grupo_gasto         integer references grupo_gasto(id),
    suppliers_type      integer references suppliers_type(id),
    Partida             text,
    Importe             numeric(12,2) default 0,
    primary key (id)
);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,1,'Gastos administración',2600);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,1,'Material de oficina',300);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,5,'Hacienda IRPF',165);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,5,'IBI',70);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,4,'Gastos Bancarios',400);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,9,'Seguro de Responsabilidad Civil',860);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,1,'Gastos de Correos',600);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,1,1,'Protección de datos',250);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,2,6,'Mano de obra limpieza',4500);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,2,6,'Ajardinamiento',500);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,11,'Gastos energía electrica agua',2500);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,6,'Reparaciones agua',1000);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,6,'Control cloro agua',1500);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,6,'Análisis del agua',500);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,6,'Control del caudal agua',500);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,3,6,'Sistemas automáticos agua',300);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,4,11,'Energía electríca alumbrado',2000);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,4,6,'Reparación alumbrado',1000);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,5,12,'Desrratización',450);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,5,6,'Mantenimiento general',2000);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,5,6,'Parque juegos',300);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,6,12,'Fianza canalización zona E',821.31);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,6,6,'Reparación y limpieza deposito agua',11000);

INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,7,11,'Energía fosa aseptica',300);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,7,12,'Limpieza de darros',360);
INSERT INTO Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe) VALUES (1,7,6,'Reparaciones',1040);


                                                            -- tipo de gasto -- grupo
create or replace view VistaPresupuesto (id, id_presupuesto, TipoGasto, gasto, Capitulo, Partida, Importe) as 
select p.id,p.id_presupuestos, s.descripcion,s.gasto, g.descripcion, p.Partida, p.importe
    from Presupuestos_row p, grupo_gasto g, suppliers_type s
    where g.id = p.grupo_gasto
    and s.id = p.suppliers_type
    order by p.id;




--
-- Tabla temporal con los resultados del presupuesto
--

CREATE TABLE tmp_ResultPresupuesto
(
    id              serial NOT NULL,
    usuario         varchar(90),
    year_fiscal     varchar(4),
    tipo_registro   varchar(15) DEFAULT 'DETALLE',  -- PAGINA TITULO SUMA TITULO_SEC SECCION DETALLE TOTAL
    id_presupuesto  integer DEFAULT 0, -- contine uno asignado para cada apartado del presupuesto
    TipoGasto       text,
    grupo_contable  varchar(4), -- grupo contable del gasto 62 622, 623, ..
    Capitulo        text,
    Partida         text,
    Importe         numeric(12,2) default 0,
    Importe_prev    numeric(12,2) default 0,
    primary key (id)
);



--
-- Tabla de reparto de un presupuesto
--

CREATE TABLE RepartoPresupuesto
(
    id                  serial NOT NULL,
    id_presupuesto      integer references Presupuestos(id),
    id_customer         integer references customers(id),
    comunero            varchar(60),
    Importe             numeric(15,10) default 0,
    cuota               numeric(8,2) default 0,
    primary key (id)
);



create or replace view vwRepartoPresupuesto (id,id_presupuesto,id_customer,comunero,importe,cuota,domiciliado)
as select r.id,r.id_presupuesto,r.id_customer,r.comunero,r.importe,r.cuota,c.domiciliado
    from RepartoPresupuesto r, Customers c
    where c.id=r.id_customer;


--
-- Estado de ejecución de un presupuesto
--

CREATE TABLE EstadoEjePresupuesto
(
    id                  serial NOT NULL,
    id_presupuesto      integer references Presupuestos(id),
    grupo_cuenta        varchar(4),
    presupuestado       numeric(8,2) default 0,
    ejecutado           numeric(8,2) default 0,
    primary key (id)
);



--
-- Tabla de cuadernos bancarios formato SEPA
--
CREATE TABLE CuadernosSEPA
(
    id                  serial NOT NULL,
    fecha               timestamp default now(),
    detalle_remesa      text,
    Importe             numeric(15,10) default 0,
    primary key (id)
);


--
-- Detalle de un cuaderno bancario
--
CREATE TABLE CuadernosSEPA_row
(
    id                  serial NOT NULL,
    id_CuadernosSEPA   integer references CuadernosSEPA(id),
    registro            text,
    primary key (id)
);


--
-- Soporte de devoluciones de errores
--
CREATE TABLE CuadernosSEPA_Devo
(
    id                  serial NOT NULL,
    fecha               timestamp default now(),
    detalle_remesa      text,
    Importe             numeric(15,10) default 0,
    primary key (id)
);



--
-- Detalle de un cuaderno bancario de devoluciones
--
CREATE TABLE CuadernosSEPA_row_Devo
(
    id                  serial NOT NULL,
    id_CuadernosSEPA    integer references CuadernosSEPA(id),
    registro            text,
    primary key (id)
);




--
-- Vista del total del presupuesto
--

create or replace view total_presupuesto (id, importe, fecha, descripcion) 
    as select p.id,(select sum(importe) from Presupuestos_row where Presupuestos_row.id_presupuestos=p.id) as importe, 
    p.fecha, p.descripcion
    from Presupuestos p order by id desc;


--
-- Un presupuesto una vez aprobado por la asamblea de propietarios se divide en
-- cuotas en función del porcentaje de participación de cada comunero
-- Estas cuotas se pueden dividir en recibos con una periodicidad determinada

--
-- Reparto del presupuesto en cuotas
--

CREATE OR REPLACE FUNCTION RepartoPresupuesto(xIdPresu in integer) 
returns void
AS
$body$
DECLARE

    xPorParticiapacion varchar(10);
    NumberPorPar numeric(12,2);
    xPresupuesto numeric(12,2);
    xCuota numeric(15,10);
    xImporte numeric(15,10);
    xNumRec integer;
    xVar text;

    CursorClientes CURSOR IS SELECT * FROM customers ORDER BY ID;

    cCursor RECORD;

BEGIN

select periodicidad_er into xNumRec from DatosPer where id=1;

select importe into xPresupuesto from total_presupuesto where id = xIdPresu;

if xPresupuesto is null or xPresupuesto <=0 then
    RAISE NOTICE 'Importe del presupuesto %', xPresupuesto;
    return;
end if;

-- Leer el número total de comuneros y su porcentaje de participación

FOR cCursor IN CursorClientes LOOP


    xVar := cCursor.otros_datos;
    xPorParticiapacion := xVar::json->>'porcentaje_participacion';
    NumberPorPar := to_number(xPorParticiapacion,'99D9999999999');

    if NumberPorPar is null then
        RAISE NOTICE 'Cliente sin porcentaje de participación %',cCursor.id;
    end if;
    -- Insertar el reparto
    
    xImporte := xPresupuesto * NumberPorPar / 100;
    xCuota := xImporte / xNumRec;
    INSERT INTO RepartoPresupuesto (id_presupuesto, id_customer, comunero, importe, cuota) 
    VALUES (xIdPresu, cCursor.id, cCursor.nombre, xImporte, xCuota);

END LOOP;



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- *************************************************
-- Generar una remesa de recibos para el cuaderno 19
-- *************************************************
-- select GenerarRemesaComunidades('Remesa de la Inocentada','2013-01-01','5720000001')
--
CREATE OR REPLACE FUNCTION GenerarRemesaComunidades(
    xConcepto in varchar,
    xFecha in varchar,
    xCuentaBanco in varchar
    )
returns void
AS
$body$
DECLARE

    xID integer;
    ImporteRecibo numeric(12,2);
    xLDetalle text;
    xValor VARCHAR(13);
    xPeriodicidad integer;

    CursorReparto CURSOR IS SELECT * FROM RepartoPresupuesto ORDER BY ID;

    cCursor RECORD;

BEGIN


-- IDENTIFICADOR DE REMESA se realizar sobre un Trigger de la tabla REMESAS

 WITH Remesas_ins AS (
    INSERT INTO Remesas (descripcion,fecha_cobro, cuenta_banco) 
        VALUES (xConcepto, to_date(xfecha,'YYYY-MM-DD'), xCuentaBanco)
    RETURNING ID
    )
    select id into xID from Remesas_ins;


-- saber la periodicidad de los recibos a lo largo del ejercicio

Select periodicidad_er into xPeriodicidad from DatosPer where id=1;

-- Crear los recibos a partir de las cuotas
FOR cCursor IN CursorReparto LOOP


    -- generar una factura a partir del importe del RepartoPresupuesto
    -- 
    ImporteRecibo := cCursor.Importe/xPeriodicidad;

    xLDetalle:='[{"concepto": "'||xConcepto||'","unidades": "1","importe": "'||ImporteRecibo||'","por_vat": "0"}]';

    Perform newFacturaRemesa(cCursor.id_customer, xFecha, xLDetalle, xID);

END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ***************************************
-- Añadir consumos y conceptos a un recibo
-- ***************************************

CREATE OR REPLACE FUNCTION AddConsumosRemesaComunidades(
    xLDetalle in varchar,
    xNif in varchar,
    xIDRemesa in integer
    )
returns void
AS
$body$
DECLARE

    xID integer;

    CursorRecibo CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

    xVar json;

BEGIN


    FOR cCursor IN CursorRecibo LOOP

        xVar := cCursor.value;

        SELECT id INTO xID FROM head_bill where id_remesa=xIDRemesa AND nif=xNif;

        --INSERT INTO ROW_BILL (id_bill,concepto,unidades,importe,por_vat) 
        --    VALUES (xID, xConcepto, 
        --    to_number(xUnidades,'99D99'), 
        --    to_number(ximporte,'99999999D99'), 
        --    to_number(xpor_vat,'99D99'));

    END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Formato de vista de impresion de un presupuesto
--

CREATE OR REPLACE FUNCTION  Presupuesto(
    xIDPresupuesto in integer, 
    xYear in varchar, 
    xUser in varchar) 
returns void
AS
$body$
DECLARE

    xSumaCapitulo numeric(12,2) :=0;
    xTotal numeric(12,2) :=0;
    xCapitulo text;

    curs4 CURSOR IS SELECT id, id_presupuesto, TipoGasto, gasto, Capitulo, Partida, Importe
    FROM VistaPresupuesto
    WHERE id_presupuesto=xIDPresupuesto
    order by id;

    cCursor RECORD;
    
BEGIN

-- Borrar el balance anterior, para limpiar los datos del listado
DELETE FROM tmp_ResultPresupuesto WHERE year_fiscal=xYear AND usuario=xUser;


xCapitulo:='';

-- Los capitulos se compone de partidas
FOR cCursor IN curs4 LOOP

    

    -- El presupuesto se divide en capítulos
    if xCapitulo <> cCursor.capitulo then

        -- Suma total de un capitulo
        if xSumaCapitulo > 0 then
            INSERT INTO tmp_ResultPresupuesto (usuario,year_fiscal,tipo_registro,importe,capitulo)
            VALUES (xUser,xYear, 'SUMA',xSumaCapitulo,xCapitulo);
        end if;

        INSERT INTO tmp_ResultPresupuesto (usuario,year_fiscal,tipo_registro,capitulo)
                            VALUES (xUser, xYear, 'CAPITULO', cCursor.capitulo);

        xSumaCapitulo := 0;
        xCapitulo := cCursor.capitulo;
    end if;

    INSERT INTO tmp_ResultPresupuesto (usuario,year_fiscal,tipo_registro,
            TipoGasto,grupo_contable,capitulo,partida,importe)
    VALUES (xUser,xYear, 'DETALLE',cCursor.TipoGasto,cCursor.gasto, cCursor.capitulo,
            cCursor.partida,cCursor.importe);

    xSumaCapitulo:=xSumaCapitulo+cCursor.importe;

END LOOP;


-- último total
INSERT INTO tmp_ResultPresupuesto (usuario,year_fiscal,tipo_registro,importe, Capitulo)
            VALUES (xUser,xYear, 'SUMA',xSumaCapitulo, xCapitulo);

-- Suma total presupuesto

select sum(importe) into xTotal from Presupuestos_row 
    where id_presupuestos = xIDPresupuesto;

INSERT INTO tmp_ResultPresupuesto (usuario,year_fiscal,tipo_registro,importe)
                            VALUES (xUser,xYear, 'TOTAL',xTotal);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




--
-- Estado de ejecución del presupuesto
--

CREATE OR REPLACE FUNCTION  Estado_Ejecucion_Presupuesto(xIDPresupuesto in integer) 
returns void
AS
$body$
DECLARE

    xejecutado numeric(12,2) :=0;
    xfiscal_year varchar(4);
    xBusca text;
    xIDApunte integer;

    -- El presupuesto agrupado por cuenta de gasto
    CurVistaPresupuesto CURSOR IS SELECT gasto, sum(Importe) as presupuestado
    FROM VistaPresupuesto
    WHERE id_presupuesto=xIDPresupuesto
    group by gasto;

    -- Recorrer el diario de asientos sumando el gasto más sus impuestos
    CurDiario CURSOR IS select a.id from apuntes a, diario d
        where a.id=d.id_apunte
            and d.cuenta like xBusca
            and d.debe_haber = 'D'
            and a.year_fiscal = xfiscal_year;

    cCursor RECORD;
    iCursor RECORD;
    
BEGIN

delete from EstadoEjePresupuesto where id_presupuesto=xIDPresupuesto;

select fiscal_year into xfiscal_year from DatosPer where id=1;

-- Leer las partidas del presupuesto

FOR cCursor IN CurVistaPresupuesto LOOP

    xBusca := cCursor.gasto || '%';

    FOR iCursor IN CurDiario LOOP

        -- sumar el gasto más impuestos
        select sum(importe) into xejecutado from diario where id_apunte=iCursor.id and debe_haber = 'D';

    end loop;

    insert into EstadoEjePresupuesto (id_presupuesto, grupo_cuenta, presupuestado, ejecutado) 
        values (xIDPresupuesto, cCursor.gasto, cCursor.presupuestado, xejecutado);

    xejecutado:=0;

END LOOP;



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- -- Crear un nuevo presupuesto
--
CREATE OR REPLACE FUNCTION NuevoPresupuesto(descrip in text)
returns integer
AS
$body$
DECLARE

  id_pre integer;

BEGIN

WITH presu_ins AS (
Insert into Presupuestos (descripcion) values (descrip)
RETURNING ID
   )
   select id into id_pre from presu_ins;

return id_pre;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Nuevo capitulo de gasto
--
CREATE OR REPLACE FUNCTION NuevoCapitulo(descrip in text)
returns integer
AS
$body$
DECLARE

  id_pre integer;

BEGIN

WITH presu_ins AS (
Insert into grupo_gasto (descripcion) values (descrip)
RETURNING ID
   )
   select id into id_pre from presu_ins;

return id_pre;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Insertar una partida
--

CREATE OR REPLACE FUNCTION NuevaPartida(
    xid_presupuestos in integer,
    xgrupo_gasto in integer,
    xsuppliers_type in integer, 
    xdescripcion in varchar, 
    ximporte in varchar)
returns integer
AS
$body$
DECLARE

  id_pre integer;

BEGIN

ximporte:=replace(ximporte, '.', ',');

WITH partida_ins AS (
Insert into Presupuestos_row (id_presupuestos,grupo_gasto,suppliers_type, Partida, importe)
    values (xid_presupuestos,xgrupo_gasto,xsuppliers_type, xdescripcion, to_number(ximporte,'99999999D99'))
    RETURNING ID
   )
   select id into id_pre from partida_ins;

return id_pre;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Borrar una partida
--
CREATE OR REPLACE FUNCTION DeletePartida(xID in integer)
returns void
AS
$body$
DECLARE
  

BEGIN

    delete from Presupuestos_row where id=xID;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
