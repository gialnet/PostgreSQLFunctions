
--
-- Cuando se añade un documento en la tabla doc_custodia lo referenciamos 
-- en doc_world
--
-- tabla de documentos subidos a myHD
--

CREATE OR REPLACE FUNCTION New_doc_world() RETURNS 
    TRIGGER AS $trg_New_doc_world$
  BEGIN

        INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,hash_algo) 
                        VALUES ('tabla', 'doc_custodia', NEW.id, NEW.hash_algo);

       RETURN NEW;
  END;
$trg_New_doc_world$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_New_doc_world
BEFORE INSERT ON doc_custodia
    FOR EACH ROW EXECUTE PROCEDURE New_doc_world();

--
-- Actualizar doc_custodia
--

CREATE OR REPLACE FUNCTION UPD_doc_world() RETURNS 
    TRIGGER AS $trg_UPD_doc_world$
  BEGIN

        UPDATE doc_world SET hash_algo = NEW.hash_algo
        WHERE tabla_proceso_name='doc_custodia' AND id_tabla_proceso = NEW.id;

       RETURN NEW;
  END;
$trg_UPD_doc_world$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_UPD_doc_world
BEFORE UPDATE ON doc_custodia
    FOR EACH ROW EXECUTE PROCEDURE UPD_doc_world();

--
-- Tabla de facturas y compras
--

CREATE OR REPLACE FUNCTION New_doc_supporting() RETURNS 
    TRIGGER AS $trg_doc_supporting_new$
  BEGIN

        INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,hash_algo) 
                        VALUES ('tabla', 'doc_supporting', NEW.id, NEW.hash_algo);

       RETURN NEW;
  END;
$trg_doc_supporting_new$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_doc_supporting_new
BEFORE INSERT ON doc_supporting
    FOR EACH ROW EXECUTE PROCEDURE New_doc_supporting();

--
-- ACTUALIZAR doc_supporting
--

CREATE OR REPLACE FUNCTION UPD_doc_supporting() RETURNS 
    TRIGGER AS $trg_doc_supporting_UPD$
  BEGIN

        UPDATE doc_world SET hash_algo = NEW.hash_algo
        WHERE tabla_proceso_name='doc_supporting' AND id_tabla_proceso = NEW.id;

       RETURN NEW;
  END;
$trg_doc_supporting_UPD$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_doc_supporting_UPD
BEFORE UPDATE ON doc_supporting
    FOR EACH ROW EXECUTE PROCEDURE UPD_doc_supporting();

--
-- Datosper
--

CREATE OR REPLACE FUNCTION datosper_upddocs() RETURNS 
    TRIGGER AS $trg_datosper_upddocs$
DECLARE
    xID integer;
  BEGIN

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='datosper' 
            AND numero_doc=1;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,numero_doc,hash_algo) 
                        VALUES ('tabla', 'datosper', 1, encode(digest(NEW.escrituras_consti, 'sha512')));
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.escrituras_consti, 'sha512'))
                    WHERE tabla_proceso_name='datosper'
                    AND numero_doc=1;
        end if;

        -- comprobar que el documento existe ya en la tabla
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='datosper' 
            AND numero_doc=2;

        if xid is null then 
                INSERT INTO doc_world (tipo,tabla_proceso_name,numero_doc,hash_algo) 
                        VALUES ('tabla', 'datosper', 2, encode(digest(NEW.cero36, 'sha512')) );
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.cero36, 'sha512'))
                    WHERE tabla_proceso_name='datosper'
                    AND numero_doc=2;
        end if;

       RETURN NEW;
  END;
$trg_datosper_upddocs$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_datosper_upddocs
BEFORE UPDATE ON datosper
    FOR EACH ROW EXECUTE PROCEDURE datosper_upddocs();


--
-- Administradores
--

CREATE OR REPLACE FUNCTION administradores_cambios_upddocs() RETURNS 
    TRIGGER AS $trg_administradores_cambios_upddocs$
DECLARE
    xID integer;
  BEGIN

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='administradores_cambios' 
            AND id=1;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,hash_algo) 
                        VALUES ('tabla', 'administradores_cambios', NEW.id, encode(digest(NEW.escritura_publica, 'sha512')) );
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.escritura_publica, 'sha512'))
                    WHERE tabla_proceso_name='administradores_cambios'
                    AND id_tabla_proceso=NEW.id;
        end if;


       RETURN NEW;
  END;
$trg_administradores_cambios_upddocs$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_administradores_cambios_upddocs
BEFORE INSERT OR UPDATE ON administradores_cambios
    FOR EACH ROW EXECUTE PROCEDURE administradores_cambios_upddocs();



--
-- PersonalRRHH
--

CREATE OR REPLACE FUNCTION PersonalRRHH_upddocs() RETURNS 
    TRIGGER AS $trg_PersonalRRHH_upddocs$
DECLARE
    xID integer;
  BEGIN

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='PersonalRRHH' 
            AND numero_doc=1;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,numero_doc,hash_algo) 
                        VALUES ('tabla', 'PersonalRRHH', NEW.id, 1, encode(digest(NEW.contrato, 'sha512'), 'hex'));
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.contrato, 'sha512') 
                    WHERE tabla_proceso_name='PersonalRRHH'
                    AND id_tabla_proceso=NEW.id AND numero_doc=1;
        end if;

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='PersonalRRHH' 
            AND numero_doc=2;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,numero_doc,hash_algo) 
                        VALUES ('tabla', 'PersonalRRHH', NEW.id, 2, encode(digest(NEW.orden_sepa, 'sha512'), 'hex'));
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.orden_sepa, 'sha512') 
                    WHERE tabla_proceso_name='PersonalRRHH'
                    AND id_tabla_proceso=NEW.id AND numero_doc=2;
        end if;

       RETURN NEW;
  END;
$trg_PersonalRRHH_upddocs$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_PersonalRRHH_upddocs
BEFORE INSERT OR UPDATE ON PersonalRRHH
    FOR EACH ROW EXECUTE PROCEDURE PersonalRRHH_upddocs();


--
-- customers
--

CREATE OR REPLACE FUNCTION customers_upddocs() RETURNS 
    TRIGGER AS $trg_customers_upddocs$
DECLARE
    xID integer;
  BEGIN

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='customers' 
            AND id=1;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,hash_algo) 
                        VALUES ('tabla', 'customers', NEW.id, encode(digest(NEW.orden_sepa, 'sha512')) );
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.orden_sepa, 'sha512'))
                    WHERE tabla_proceso_name='customers'
                    AND id_tabla_proceso=NEW.id;
        end if;


       RETURN NEW;
  END;
$trg_customers_upddocs$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_customers_upddocs
BEFORE INSERT OR UPDATE ON customers
    FOR EACH ROW EXECUTE PROCEDURE customers_upddocs();


--
-- suppliers
--

CREATE OR REPLACE FUNCTION suppliers_upddocs() RETURNS 
    TRIGGER AS $trg_suppliers_upddocs$
DECLARE
    xID integer;
  BEGIN

        -- comprobar que el documento existe ya en la tabla escrituras_consti
        SELECT id into xid FROM doc_world WHERE tabla_proceso_name='suppliers' 
            AND id=1;

        if xid is null then
                INSERT INTO doc_world (tipo,tabla_proceso_name,id_tabla_proceso,hash_algo) 
                        VALUES ('tabla', 'suppliers', NEW.id, encode(digest(NEW.orden_sepa, 'sha512')) );
        else
                UPDATE doc_world SET hash_algo=encode(digest(NEW.orden_sepa, 'sha512'))
                    WHERE tabla_proceso_name='suppliers'
                    AND id_tabla_proceso=NEW.id;
        end if;


       RETURN NEW;
  END;
$trg_suppliers_upddocs$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_suppliers_upddocs
BEFORE INSERT OR UPDATE ON suppliers
    FOR EACH ROW EXECUTE PROCEDURE suppliers_upddocs();
