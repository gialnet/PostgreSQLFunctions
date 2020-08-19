

--
-- Añadir un asesor
--

CREATE OR REPLACE FUNCTION AddAsesor(
    xNif in varchar,
    xNombre in varchar,
    xPoderes in varchar,
    xFecha in varchar
)
returns integer
AS
$body$
DECLARE

xIDAdmin integer;

BEGIN

WITH Asesores_ins AS (

INSERT INTO Asesores (nif, nombre, capacidad, fecha_desde) 
    VALUES (xNif,xNombre,xPoderes, to_date(xFecha, 'YYYY-MM-DD'))
    RETURNING ID
    )
select id into xIDAdmin from Asesores_ins;

return xIDAdmin;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- **********************************************************
-- Actualizar los datos de un asesor
-- **********************************************************
CREATE OR REPLACE FUNCTION UpdateAsesor(
    xIDAdmin in integer,
    xNif in varchar,
    xNombre in varchar,
    xPoderes in varchar,
    xFecha in varchar
)
returns integer
AS
$body$
DECLARE


xIDApunte integer;

BEGIN

WITH Asesores_ins AS (

UPDATE Asesores SET nif = xNif, nombre = xNombre , capacidad = xPoderes
    WHERE id = xIDAdmin
    RETURNING id
    )
select id into xIDApunte from Asesores_ins;

return xIDApunte;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
