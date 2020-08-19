
/*


[{"cuenta":"5720000035","debe_haber":"D","importe":"50"},{"cuenta":"4720000002","debe_haber":"H","importe":"50"}]

*/

--
-- Añadir un apunte contable desde contabilidad
--

CREATE OR REPLACE FUNCTION AddAsientoDiario(
    xConcepto in varchar,
    xFecha in varchar,
    xLineasAsiento in varchar
)
returns int
AS
$body$
DECLARE

    xID int;

    CurLineasAsiento CURSOR IS SELECT * from json_array_elements(xLineasAsiento::json);

    cCursor RECORD;

    xVar json;

    xcuenta varchar(10);
    xdebe_haber varchar(1);
    ximporte text;

    xVarRegla varchar(150);

BEGIN

    -- extaer el trimestre
    -- SELECT EXTRACT(QUARTER FROM now());

    xVarRegla:='{"vista":"conta-NewAsiento.jsp"}';

    -- Insertar las líneas de detalle del asiento
    WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,periodo, reglas) 
    VALUES (xConcepto,
            to_date(xFecha, 'YYYY-MM-DD'),
            EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
            EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')),
            xVarRegla::json
    )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

    FOR cCursor IN CurLineasAsiento LOOP

        xVar := cCursor.value;
        --RAISE NOTICE 'Línea de detalle %', xVar;
        -- descodifica una linea
        --select * from json_populate_record(xLineaFact::LineaFact, cCursor.value);
        xcuenta := xVar::json->>'cuenta';
        xdebe_haber:=xVar::json->>'debe_haber';

        ximporte:=xVar::json->>'importe';
        ximporte:=replace(ximporte, '.', ',');

        INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) 
        VALUES ( xId, xcuenta, xdebe_haber, to_number(ximporte,'99999999D99') );

    END LOOP;

    return xID;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- **************************************************************************
--                  Actualizar un asiento contable
-- **************************************************************************

CREATE OR REPLACE FUNCTION UpdateAsientoDiario(
    xIDAsiento in integer,
    xConcepto in varchar,
    xFecha in varchar,
    xLineasAsiento in varchar
)
returns void
AS
$body$
DECLARE


    curs4 CURSOR IS SELECT * from json_array_elements(xLineasAsiento::json);

    cCursor RECORD;

    xVar json;

    xcuenta varchar(10);
    xdebe_haber varchar(1);
    ximporte text;

    xVarRegla varchar(150);

BEGIN

    -- La única regla es la vista que lo genera

    xVarRegla:='{"vista":"conta-NewAsiento.jsp"}';

    -- Actualizar los datos del asiento

    UPDATE Apuntes  SET concepto = xConcepto,
                        fecha = to_date(xFecha, 'YYYY-MM-DD'),
                        year_fiscal = EXTRACT(year FROM to_date(xFecha, 'YYYY-MM-DD')),
                        periodo = EXTRACT(QUARTER FROM to_date(xFecha, 'YYYY-MM-DD')), 
                        reglas = xVarRegla::json 
               WHERE id = xIDAsiento;

    -- Borrar los movimientos del diario 

    DELETE FROM Diario WHERE id_apunte = xIDAsiento;

    -- Insertar los nuevos movimientos del diario

    FOR cCursor IN curs4 LOOP

        xVar := cCursor.value;
        RAISE NOTICE 'Línea de detalle %', xVar;
        -- descodifica una linea
        --select * from json_populate_record(xLineaFact::LineaFact, cCursor.value);
        xcuenta := xVar::json->>'cuenta';
        xdebe_haber:=xVar::json->>'debe_haber';

        ximporte:=xVar::json->>'importe';
        ximporte:=replace(ximporte, '.', ',');

        INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) 
        VALUES (xIDAsiento, xcuenta, xdebe_haber, to_number(ximporte,'99999999D99'));

    END LOOP;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
