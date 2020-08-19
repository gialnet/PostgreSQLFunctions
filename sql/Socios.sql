
--
-- Añadir la aportación de un socio
--

CREATE OR REPLACE FUNCTION AddSocio(
    xNif in varchar,
    xNombre in varchar,
    xAportacion in numeric,
    xFecha in varchar,
    xBanco in varchar
)
returns void
AS
$body$
DECLARE

xCuenta varchar(10);
xSocio varchar(10);
xIDSocio integer;
xID integer;

BEGIN

WITH capital_ins AS (

INSERT INTO capital (nif, nombre, aportacion,fecha) 
    VALUES (xNif,xNombre,xAportacion, to_date(xFecha, 'YYYY-MM-DD'))
    RETURNING ID
    )
select id into xIDSocio from capital_ins;

    -- pasamos de integer a string
    xSocio := '' || xIDSocio;

    xSocio := '1000' || lpad(xSocio,6,'0');

-- Comprobamos si la cuenta existe
Select cuenta into xCuenta from cuentas where cuenta = xSocio;

if xCuenta is null then
    -- Añadir la cuenta del Capital Social
    INSERT INTO cuentas (concepto, cuenta) VALUES ('Capital Social', xSocio);
end if;


-- Añadimos asiento 

--
-- Apunte contable
--
WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo, reglas) 
    VALUES ('Desembolso Capital Social '|| xNombre, to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(MONTH FROM to_date(xFecha, 'YYYY-MM-DD')),
            '{"vista":"DatosPer.jsp"}'
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

-- movimientos del diario
-- Cantidad depositada en el banco
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'D',xAportacion);

-- capital social es cuenta de pasivo y se carga a su haber
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xSocio,'H',xAportacion);

-- anotamos el apunte en la tabla de capital socios

UPDATE Capital Set id_apunte = xId Where id = xIDSocio;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- **********************************************************
-- Actualizar los datos de un apunte de desembolso de capital
-- **********************************************************
CREATE OR REPLACE FUNCTION UpdateSocio(
    xIDSocio in integer,
    xNif in varchar,
    xNombre in varchar,
    xAportacion in numeric,
    xFecha in varchar,
    xBanco in varchar
)
returns void
AS
$body$
DECLARE

xCuenta varchar(10);
xSocio varchar(20);
xIDApunte integer;

BEGIN

WITH capital_ins AS (

UPDATE capital SET nif = xNif, nombre = xNombre , aportacion = xAportacion
    WHERE id = xIDSocio
    RETURNING id_apunte
    )
select id_apunte into xIDApunte from capital_ins;

    -- pasamos de integer a string
    xSocio := '' || xIDSocio;

    xSocio := '1000'||lpad(xSocio,6,'0');

-- Comprobamos si la cuenta existe
Select cuenta into xCuenta from cuentas where cuenta = xSocio;

if xCuenta is null then
    -- Añadir la cuenta del Capital Social
    INSERT INTO cuentas (concepto, cuenta) VALUES ('Capital Social', xSocio);
end if;

--
-- Apunte contable
--
    UPDATE Apuntes SET concepto = 'Desembolso Capital Social '|| xNombre,
        fecha = to_date(xFecha, 'YYYY-MM-DD'),
        year_fiscal = EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
        periodo = EXTRACT(MONTH FROM to_date(xFecha, 'YYYY-MM-DD')), 
        reglas = '{"vista":"DatosPer.jsp"}'
    WHERE id = xIDApunte;

-- borrar el detalle anterior
 DELETE FROM Diario WHERE id_apunte = xIDApunte;

-- poner los nuevos datos
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,xBanco,'D',xAportacion);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,xSocio,'H',xAportacion);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Devuelve el importe total del capital social
--

CREATE OR REPLACE FUNCTION CapitalSocial()
returns numeric
AS
$body$
DECLARE

xaportacion numeric(12,2);

BEGIN

SELECT sum(aportacion) into xaportacion FROM Capital;

return xaportacion;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
