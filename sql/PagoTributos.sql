-- ****************************************************
-- Hacer efectivo el ingreso del IRPF, IVA y Sociedades
-- ****************************************************

CREATE OR REPLACE FUNCTION IngresoTributos(
    xIDleg_obligaciones in integer,
    xFecha in varchar,
    xBanco in varchar,
    xNRC in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xImporte numeric(8,2):=0;
    xNaturaleza varchar(50);
    xCuenta varchar(10);
    xEstado varchar(10);
    
BEGIN

-- comprobar si está pagado o cerrado el trimestre
SELECT L.estado, L.naturaleza, D.importe, D.cuenta 
    INTO xEstado, xNaturaleza, xImporte, xCuenta 
        FROM leg_obligaciones L, leg_detalle D
        WHERE id=xIDleg_obligaciones AND D.id_leg=ID.L;

IF xEstado != 'PENDIENTE' THEN
    RAISE NOTICE 'Estado %', xEstado;
    RETURN;
END IF;


-- Realizar el apunte contable del pago
WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
    VALUES (xNaturaleza,
            to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
            '{"vista":"BrowseIRPF.jsp"}'
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

    -- Al pago de las retenciones de IRPF, se pagan trimestralmente antes del día 20 de final de trimestre.

    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xCuenta,'D',xImporte);

     -- El cargo total del banco
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);

    -- Actualizar la tabla de obligaciones 
    UPDATE leg_obligaciones SET id_apunte=xId, 
        estado='PAGADO', 
        NRC=xNRC, 
        fecha_pago=to_date(xFecha, 'YYYY-MM-DD')
        WHERE id=xIDleg_obligaciones;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- **********************************************
-- Deshacer el ingreso del IRPF, IVA y Sociedades
-- **********************************************

CREATE OR REPLACE FUNCTION DeshacerIngresoTributos(xIDleg_obligaciones in integer) 
returns void
AS
$body$
DECLARE

    xID integer;
    xID_Apunte integer;
    xImporte numeric(8,2):=0;
    xNaturaleza varchar(50);
    xCuenta varchar(10);
    xEstado varchar(10);
    
BEGIN

-- comprobar si está pagado o cerrado el trimestre
SELECT L.estado, L.naturaleza, L.id_apunte, D.importe, D.cuenta 
    INTO xEstado, xNaturaleza, xID_Apunte, xImporte, xCuenta 
        FROM leg_obligaciones L, leg_detalle D
        WHERE id=xIDleg_obligaciones AND D.id_leg=ID.L;

IF xEstado = 'CERRADO' THEN
    RAISE NOTICE 'Estado %', xEstado;
    RETURN;
END IF;

-- Borrar el apunte contable
delete from Diario where id_apunte=xID_Apunte;

delete from Apuntes where id=xID_Apunte;

    -- Actualizar la tabla de obligaciones 
    UPDATE leg_obligaciones SET id_apunte=NULL, 
        estado='PENDIENTE', 
        NRC=NULL, 
        fecha_pago=NULL
        WHERE id=xIDleg_obligaciones;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
