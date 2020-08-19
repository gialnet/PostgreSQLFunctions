
--
-- Actualizar la lista de cuentas de un apartado del balance
--
CREATE OR REPLACE FUNCTION UpdateApartado(xIDApartado in integer, xCuentas in varchar) 
returns void
AS
$body$
DECLARE

BEGIN

    UPDATE ApartadoSeccionBalance SET grupo_cuentas = xCuentas WHERE ID = xIDApartado;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
