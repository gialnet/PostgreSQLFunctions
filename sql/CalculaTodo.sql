

--
-- Realizar los calculos de todas las opciones
--

CREATE OR REPLACE FUNCTION  CalcularTodo(
    xYear in varchar,
    xPeri in varchar
) 
returns void
AS
$body$
DECLARE

    xMes varchar(2);

BEGIN

    xMes := EXTRACT(MONTH FROM NOW());

    -- mensuales
    PERFORM CalcularNomina(xYear, xMes);
    PERFORM CalcularSS(xYear, xMes);
    
    -- Trimestrales
    PERFORM CalcularIVA(xYear, xPeri);
    PERFORM CalculoIRPF(xYear, xPeri);

    -- Anuales
    --PERFORM CalcularTrimestreSociedades(xYear, xPeri);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
