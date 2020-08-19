CREATE OR REPLACE FUNCTION getCuentaDebe(xCuenta in varchar) returns numeric
AS
$body$
DECLARE 

    xSumDebe numeric(8,2);

BEGIN


SELECT SUM(importe) INTO xSumDebe FROM Diario WHERE cuenta = xCuenta and debe_haber='D';

if xSumDebe is null then
    xSumDebe:=0;
end if;

RETURN xSumDebe;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



CREATE OR REPLACE FUNCTION getCuentaHaber(xCuenta in varchar) returns numeric
AS
$body$
DECLARE

    xSumaHaber numeric(8,2);

BEGIN


SELECT SUM(importe) INTO xSumaHaber FROM Diario WHERE cuenta = xCuenta and debe_haber='H';

if xSumaHaber is null then
    xSumaHaber:=0;
end if;

RETURN xSumaHaber;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


