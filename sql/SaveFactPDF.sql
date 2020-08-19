--
-- Añadir una nueva factura a la base de datos de documentos
--
CREATE OR REPLACE FUNCTION SaveFactPDF(fichero IN bytea, xid_issued in integer
) returns void
AS
$body$
DECLARE

      nombrePDF varchar(250);

BEGIN

    nombrePDF:='fact_id-'||xid_issued ||'.pdf';


    INSERT INTO doc_supporting (id_issued,tipo_mime,filename,hash_algo,fileblob)
    VALUES (xid_issued,'application/pdf',nombrePDF,
                encode(digest(fichero, 'sha512'), 'hex'),fichero);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
