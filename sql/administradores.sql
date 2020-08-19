
--
-- Añadir un administrador de la sociedad
--

CREATE OR REPLACE FUNCTION AddAdministrador(
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

WITH administradores_ins AS (

INSERT INTO administradores (nif, nombre, capacidad, fecha_desde) 
    VALUES (xNif,xNombre,xPoderes, to_date(xFecha, 'YYYY-MM-DD'))
    RETURNING ID
    )
select id into xIDAdmin from administradores_ins;

return xIDAdmin;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


-- **********************************************************
-- Actualizar los datos de un administrador
-- **********************************************************
CREATE OR REPLACE FUNCTION UpdateAdministrador(
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

WITH administradores_ins AS (

UPDATE administradores SET nif = xNif, nombre = xNombre , capacidad = xPoderes
    WHERE id = xIDAdmin
    RETURNING id
    )
select id into xIDApunte from administradores_ins;

return xIDApunte;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

