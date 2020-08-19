

--
-- Establecer los permisos de un usuario ver 1
--

CREATE OR REPLACE FUNCTION SetPermisosUsuario(xIdUser in integer, vjsonPermisos in text) 
returns void
AS
$body$
DECLARE

BEGIN


    update PersonalRRHH set permisos=vjsonPermisos::json where id = xIdUser;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

