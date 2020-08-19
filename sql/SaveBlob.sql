
/* PROBAR EL PROCEDIMIENTO 
SELECT lo_export(fileblob, '/home/antonio/bin/fact.pdf') FROM doc_supporting
WHERE id=18;

*/
--
-- Grabar un campo blob en postgres 9.2
--
CREATE OR REPLACE FUNCTION SaveBlob(fichero IN bytea, nombre in varchar) returns void
AS
$body$
DECLARE
   
      loid oid;
      lfd integer;
      lsize integer;
   
BEGIN

    if(fichero is null) then
      return;
    end if;

    with datos_insertados as (
       		INSERT INTO doc_supporting (filename,fileblob) VALUES (nombre,lo_creat(-1)) returning fileblob
    )
    select fileblob into loid from datos_insertados;
				
   lfd := lo_open(loid,131072); -- el numero significa atributo de escritura INV_WRITE
   lsize := lowrite(lfd,fichero);
   perform lo_close(lfd);        

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/