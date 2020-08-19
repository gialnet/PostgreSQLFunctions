--
-- Actualizar datos de una nómina
--
CREATE OR REPLACE FUNCTION UpdateCargoNomina(
    xIDApunte in integer,
    xConcepto in varchar,
    xFecha in varchar,
    xSueldo in numeric,
    xSSEmpresa in numeric,
    xSSTotal in numeric,
    xRetencion in numeric,
    xRemuneracion in numeric
) 
returns void
AS
$body$
DECLARE

    xID integer;
    xCuenta varchar(10);
    xId_leg integer;

BEGIN


    UPDATE Apuntes SET concepto=xConcepto,fecha=to_date(xFecha, 'YYYY-MM-DD'),
        year_fiscal=EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
        periodo=EXTRACT(MONTH FROM to_date(xFecha, 'YYYY-MM-DD')),
        reglas='{"vista":"CargoNominas.jsp","xSueldo":' ||xSueldo ||',"xSSEmpresa":' || xSSEmpresa ||
            ',"xSSTotal": '|| xSSTotal ||',"xRetencion":'|| xRetencion ||',"xRemuneracion":'|| xRemuneracion ||'}'
        WHERE id=xIDApunte;

 -- borramos los apuntes anteriores
 DELETE FROM Diario WHERE id_apunte=xIDApunte;

 -- añadimos los nuevos valores
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,'6400000000','D',xSueldo);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,'6420000000','D',xSSEmpresa);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,'4760000000','H',xSSTotal);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,'4751000000','H',xRetencion);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xIDApunte,'4650000000','H',xRemuneracion);


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
