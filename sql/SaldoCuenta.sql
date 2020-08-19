--
-- Resultado del saldo de una cuenta
--
CREATE OR REPLACE FUNCTION SaldoCuenta(xCuenta in varchar, xYear in varchar) returns numeric
AS
$body$
DECLARE
    xSumDebe numeric(8,2):=0;
    xSumHaber numeric(8,2):=0;
BEGIN


    SELECT sum(importe) as debe INTO xSumDebe FROM Diario where cuenta=xCuenta and debe_haber='D' and
    id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal=xYear);

    if xSumDebe is null then
        xSumDebe:=0;
    end if;


    SELECT sum(importe) as haber INTO xSumHaber FROM Diario where cuenta=xCuenta and debe_haber='H' and
    id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal=xYear);
    
if xSumHaber is null then
    xSumHaber:=0;
end if;

return xSumDebe - xSumHaber ;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ******************************************
-- Resultado del saldo de un grupo de cuentas
-- ******************************************
CREATE OR REPLACE FUNCTION SaldoGrupoCuenta(
        xCuenta in varchar, 
        xYear in varchar,
        xSumDebe out  numeric,
        xSumHaber out numeric,
	xSaldo out numeric        
) returns RECORD
AS
$body$
DECLARE
    
BEGIN

    xSumDebe :=0;
    xSumHaber :=0;

    if xCuenta = '' then
        xSaldo:=0;
        return;
    end if;

    xCuenta:=xCuenta||'%';

    SELECT sum(importe) as debe INTO xSumDebe FROM Diario where cuenta Like xCuenta and debe_haber='D' and
    id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal=xYear);

    if xSumDebe is null then
        xSumDebe:=0;
    end if;


    SELECT sum(importe) as haber INTO xSumHaber FROM Diario where cuenta Like xCuenta and debe_haber='H' and
    id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal=xYear);
    
    if xSumHaber is null then
        xSumHaber:=0;
    end if;

    xSaldo:= xSumDebe - xSumHaber;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

