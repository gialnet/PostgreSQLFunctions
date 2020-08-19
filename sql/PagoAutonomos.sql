--
-- Los autonomos debe pagarlos el interesado, pero en muchas ocasiones los paga
-- la empresa y se entienden como pagos en especie.
-- 
-- 
-- 
--
CREATE OR REPLACE FUNCTION PagoAutonomos(
    xFecha in varchar,
    xImporte in numeric,
    xBanco in varchar
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xirpf_profesionales numeric(4,2);
    xSocio numeric(8,2);

BEGIN

WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo,reglas) 
    VALUES ('Pago cuota SS Autónomos',
            to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
            '{"vista":".jsp"}'
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

-- Debe     6400000001 sueldos y salarios en especie
-- haber    4761000001 organismos SS acreedores
-- haber    4751000001 HP acreedora por retenciones en especie
-- haber    5510000000 cuenta corriente con socios y admiistradores

 select irpf_profesionales into xirpf_profesionales from DatosPer where id=1;

 xSocio:=(xImporte*xirpf_profesionales/100)+xImporte;

 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'6400000001','D',xImporte);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4761000001','H',xImporte);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4751000001','H',xImporte*xirpf_profesionales/100);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'5510000000','D',xSocio);

-- al pago por banco

-- haber 572x cuenta banco donde se paga
-- debe 4761000001 organismos SS acreedores

INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);
INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4761000001','D',xImporte);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
