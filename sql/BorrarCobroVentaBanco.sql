--
-- borrar el cobro de una venta
--
CREATE OR REPLACE FUNCTION BorrarCobroVentaBanco( xIDFact in integer ) 
returns void
AS
$body$
DECLARE

    xid_apcobro integer;

BEGIN
    
    -- actualizar la factura a pendiente
    WITH factura_update AS (
        UPDATE head_bill SET estado='PENDIENTE', fecha_cobro=null
        WHERE id=xIDFact
        RETURNING id_apcobro
    )
    select id_apcobro into xid_apcobro from factura_update;

    -- Borrar el diario
    DELETE FROM Diario WHERE id_apunte=xid_apcobro;

    -- Borrar el apunte y el diario
    DELETE FROM Apuntes WHERE id=xid_apcobro;



UPDATE head_bill SET id_apcobro=0 WHERE id=xIDFact;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
