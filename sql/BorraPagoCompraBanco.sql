--
-- Borrar apunte de pago de una compra
--
CREATE OR REPLACE FUNCTION BorraPagoCompraBanco( xIDGasto in integer ) returns void
AS
$body$
DECLARE

    xid_appago integer;

BEGIN

-- dejamos la factura pendiente
 WITH factura_update AS (
    UPDATE invoices_received SET 
        fecha_pago=null,
        estado='PENDIENTE'
        where id=xIDGasto
        RETURNING id_appago
    )
    select id_appago into xid_appago from factura_update;

-- borramos el diario
DELETE FROM Diario WHERE id_apunte = xid_appago;

-- borramos el apunte
DELETE FROM Apuntes WHERE id = xid_appago;

UPDATE invoices_received SET id_appago=0
        where id=xIDGasto;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

