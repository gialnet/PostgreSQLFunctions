

--
-- Generar una remesa de facturas de Asesores
-- Se tiene una cuota fija por cliente más posibles cargos de servicios
-- adicionales
--
CREATE OR REPLACE FUNCTION GenerarRemesaAsesores(
    xConcepto in varchar,
    xFecha in varchar,
    xCuentaBanco in varchar
)
returns void
AS
$body$
DECLARE

    xID integer;
    ImporteRecibo numeric(12,2);
    xLDetalle text;
    xValor VARCHAR(13);
    xPorIVA numeric(4,2);
    xPeriodicidad integer;

    -- generar una remesa para todos aquellos clientes que su cuota de servicio es mayor de cero

    CursorClientes CURSOR IS SELECT * FROM Customers where cuotaservicio > 0 ORDER BY ID;

    cCursor RECORD;

BEGIN

select iva into xPorIVA from DatosPer where id=1;




-- insertar la nueva remesa


  WITH Remesas_ins AS (
    INSERT INTO Remesas (descripcion,fecha_cobro, cuenta_banco) 
        VALUES (xConcepto, to_date(xfecha,'YYYY-MM-DD'), xCuentaBanco)
    RETURNING ID
    )
    select id into xID from Remesas_ins;


-- saber la periodicidad de los recibos a lo largo del ejercicio

Select periodicidad_er into xPeriodicidad from DatosPer where id=1;

-- Crear los recibos a partir de las cuotas

FOR cCursor IN CursorClientes LOOP


    -- generar una factura a partir del importe del RepartoPresupuesto
    -- 
    ImporteRecibo := cCursor.Importe/xPeriodicidad;

    xLDetalle:='{"concepto": "'||xConcepto||'","unidades": "1","importe": "'||cCursor.CuotaServicio||'","por_vat": "'|| xPorIVA ||'"}';

    Perform newFacturaRemesa(cCursor.id_customer, xFecha, xLDetalle, xId);  

END LOOP;

-- Marcar los recibos o facturas como enviados al banco para su cobro

UPDATE head_bill SET estado='ENVBANCO', fecha_estado=now() where id_remesa=xID;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



--
-- Disparador para ajustar la variable de domiciliado en función del importe
-- de la cuota de servicio
--

CREATE OR REPLACE FUNCTION set_identifica_remesa() RETURNS TRIGGER AS $trg_set_identifica_remesa$
  BEGIN

-- insertar la nueva remesa
-- IDENTIFICADOR DE REMESA
-- PRE TO_CHAR(NOW(),'YYYYMMDDHHMMSSmmmmm' Referencia identificativa que asigne el presentador (13 caracteres)
-- PRE 20101105 2235 4212245 0159300491893
    
    NEW.IdentificaRemesa := 'PRE'|| Left(TO_CHAR(NOW(),'YYYYMMDDHHMMSSSSSS'),19) || lpad(cast(NEW.id as varchar),13,'0');


       RETURN NEW;
  END;
$trg_set_identifica_remesa$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_set_identifica_remesa
BEFORE INSERT OR UPDATE ON Remesas
    FOR EACH ROW EXECUTE PROCEDURE set_identifica_remesa();



-- ***************************************
-- Leer soporte de devoluciones de remesas
-- ***************************************

CREATE OR REPLACE FUNCTION Procesar_Devoluciones(xIDRemesa in integer, xLDetalle in varchar)
returns void
AS
$body$
DECLARE

    referencia_recibo text;
    motivo varchar(4);
    xVar text;

    CursorDevoluciones CURSOR IS SELECT * from json_array_elements(xLDetalle::json);

    cCursor RECORD;

BEGIN


-- Las entidades financieras nos informan que una transacción no se ha podido 
-- realizar por una determinada causa.

    FOR cCursor IN CursorDevoluciones LOOP

        xVar := cCursor.value;
        --RAISE NOTICE 'Línea de detalle %', xVar;
        -- descodifica una linea
        --select * from json_populate_record(xLineaFact::LineaFact, cCursor.value);
        referencia_recibo := xVar::json->>'referencia_recibo';
        motivo:=xVar::json->>'motivo';

        UPDATE head_bill SET estado='DEVUELTO', fecha_estado=now() 
            where numero=referencia_recibo;

        -- esto es candidato a Trigger
        -- INSERT INTO head_bill_history () VALUES ();

    END LOOP;



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;



-- ********************************************************************************
-- Dar por cobrados los recibos de una remesa tras haber procesado las devoluciones
-- ********************************************************************************
CREATE OR REPLACE FUNCTION Procesar_Cobros_Remsa(
    xIDRemesa in integer, 
    xCuentaBanco in varchar
)
returns void
AS
$body$
DECLARE

    CursorCobroRemesa CURSOR IS SELECT * from vwhead_bill 
                                where remesa=xIDRemesa and estado='ENVBANCO';
    cCursor RECORD;

BEGIN

    -- Realizar el apunte de cobro en bancos para todos los recibos 
    FOR cCursor IN CursorCobroRemesa LOOP

        -- realizar el apunte contable
        -- además actualiza la tabla head_bill marcandola como pagada
        perform CobroVentaBanco(cCursor.id, xCuentaBanco, cCursor.total, to_char(now(),'YYYY-MM-DD') );

    END LOOP;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;