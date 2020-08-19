
--
-- Leer el descuento
--
CREATE OR REPLACE FUNCTION getdto(base numeric, dto numeric) returns numeric
AS
$body$
BEGIN

if (dto > 0) then
    return base * dto / 100;
else
    return 0;
end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- Calcular el IVA
--
CREATE OR REPLACE FUNCTION getiva(base numeric, por_vat numeric) returns numeric
AS
$body$
BEGIN

if (por_vat > 0) then
    return base * por_vat / 100;
else
    return 0;
end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Base imponible de una línea de factura
--
CREATE OR REPLACE FUNCTION get_BaseImponible(base numeric, por_dto numeric, unidades numeric) returns numeric
AS
$body$
BEGIN

-- el importe menos el % de descuento * el número de unidades
return ((base - getdto(base,por_dto)) * unidades);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Importe del IVA de una línea de factura
--
CREATE OR REPLACE FUNCTION get_IVAImporte(base numeric, por_dto numeric, unidades numeric, por_vat numeric) returns numeric
AS
$body$
DECLARE
    xBaseImponible numeric(12,2);
BEGIN

xBaseImponible := get_BaseImponible(base, por_dto, unidades);

return getiva( xBaseImponible, por_vat);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
