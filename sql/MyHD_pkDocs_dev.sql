--
-- Maria del Mar Perez
-- Marzo 2013
--
--
--

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------


--
-- Cliente: puede subir un docuemento, pdf, excel, word.
-- eliminar
-- Los documentos subidos por un cluinete unicamento los podrá ver
--  el administrador del sistema y este será el que decida la visibilidad de
-- los docuementos dentro de su organización

--
-- Empleados: 
-- - Subir sus propios documentos
-- - Compartir: 
-- Segun los pormisos que otorgue el administrador permitirá compartir docuemntos con clientes
-- Según una tabla de permisos organizada por grupos y permisos
-- Entre personal está permitido compartir docuementos

-- Administrador:
-- Tiene sus propios docuemntos
-- Puede ver todos los documentos de la organización
-- Podrá otorgar permisos a el personal sobre la visibilidad de los docuemntos de los clientes.


---
--- Subir documento cliente
--- 


CREATE OR REPLACE FUNCTION uploadDocCliente(
	xIDUsuario  integer,
        xFileName varchar,
        xFichero bytea
        
	)  returns void
	
AS
$$
DECLARE
       
        xNombre varchar(60);
        
	begin	

                
		insert into doc_custodia (id_user,tipo,FILENAME,hash_algo,fichero) 
                values(xIDUsuario,'clientes',trim(xFileName),encode(digest(xFichero, 'sha512'), 'hex'),xFichero);

                Select nombre into xNombre from customers where id=xIDUsuario;
                
                INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('El cliente '||trim(xNombre)||' ha subido el documento '||trim(xFileName), 1);
   	

       end;
$$ LANGUAGE plpgsql;

/


--
-- Mover un documento a una carpeta
--

CREATE OR REPLACE FUNCTION moveDocCarpeta(
	xIDDoc  integer,
        xIDCarpeta integer
        
	)  returns void
	
AS
$$
DECLARE
       
        
        xNum integer := 0;
	begin	
                select count(*) into xNum from carpeta_doc where id_doc=xIDDoc;
                
                if xNum=0 then
                    insert into carpeta_doc (id_carpeta,id_doc) values(xIDCarpeta,xIDDoc);
                else
                    delete from carpeta_doc where id_doc=xIDDoc;
                    insert into carpeta_doc (id_carpeta,id_doc) values(xIDCarpeta,xIDDoc);
                end if;
                
		
   	

       end;
$$ LANGUAGE plpgsql;

/


---
--- Subir documento empleado
--- 


CREATE OR REPLACE FUNCTION uploadDocEmployee(
	xIDUsuario  integer,
        xFileName varchar,
        xFichero bytea
        
	)  returns void
	
AS
$$
DECLARE
       
        xNombre varchar(60);
        
	begin	

                
		insert into doc_custodia (id_user,tipo,FILENAME,hash_algo,fichero) 
                values(xIDUsuario,'employee',trim(xFileName),encode(digest(xFichero, 'sha512'), 'hex'),xFichero);

                

       end;
$$ LANGUAGE plpgsql;
/

---
--- Eliminar un documento
--- 

CREATE OR REPLACE FUNCTION deleteDocAdministrator(	
        xIDDoc  Integer
	)  returns void
	
AS
$body$
DECLARE
       
       
        
	begin	

                
                --eliminamos el doc de el apuntador
                delete from doc_compartir where id_doc=xIDDoc;
		
                --eliminamos el domunto fisico
                delete from doc_custodia where id=xIDDoc;
		 
  		 

       end;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

/



--
-- Empleado comparte con un cliente
--



CREATE OR REPLACE FUNCTION employeeShareDocClient(
	xIDPersonal  integer,        
        xIDDoc Integer,
        xIDCliente Integer
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		insert into doc_compartir (id_personal_rrhh,tipo_share,id_share,id_doc) 
                values(xIDPersonal,'clientes',xIDCliente,xIDDoc);
   	

       end;
$$ LANGUAGE plpgsql;
/


--
-- Empleado comparte con un empleado
--



CREATE OR REPLACE FUNCTION employeeShareDocEmployee(
	xIDPersonal  integer,        
        xIDDoc Integer,
        xIDShare Integer
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		insert into doc_compartir (id_personal_rrhh,tipo_share,id_share,id_doc) 
                values(xIDPersonal,'employee',xIDShare,xIDDoc);
   	

       end;
$$ LANGUAGE plpgsql;
/

---
--- Cancelar el compartir un docuemento
--- 

CREATE OR REPLACE FUNCTION unshareDoc(	
        xIDDoc  Integer,
        xIDShare Integer
	)  returns void
	
AS
$body$
DECLARE
       
       
        
	begin	

                --eliminamos el doc de el apuntador
                delete from doc_compartir where id_doc=xIDDoc and id_share=xIDShare;
		
                
       end;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/


---
--- Crear carpeta
--- 
--select newCarpeta(1,'docuemntacion');
CREATE OR REPLACE FUNCTION newCarpetaCliente(
	xIdUsuario  integer,
        xNombre     varchar
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		
		

                insert into carpeta(nombre,id_usuario,tipo_usuario) values (xNombre,xIdUsuario,'clientes');
   	

       end;
$$ LANGUAGE plpgsql;
/

---
--- Eliminar carpeta
--- 
CREATE OR REPLACE FUNCTION dropCarpeta(
	xIDCarpeta  integer
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		
		

                delete from carpeta where id = xIDCarpeta;
   	

       end;
$$ LANGUAGE plpgsql;
/


---
--- Crear carpeta
--- 
CREATE OR REPLACE FUNCTION newCarpetaEmployee(
	xIdUsuario  integer,
        xNombre     varchar
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		
		

                insert into carpeta(nombre,id_usuario,tipo_usuario) values (xNombre,xIdUsuario,'employee');
   	

       end;
$$ LANGUAGE plpgsql;
/

---
--- Renombrar carpeta
--- 
CREATE OR REPLACE FUNCTION renameCarpeta(
	xIDCarpeta  integer,
        xNombre     varchar
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
		
		

                update carpeta set nombre=xNombre where id = xIDCarpeta;
   	

       end;
$$ LANGUAGE plpgsql;
/



--
-- Leer documento
-- Para saber si al usuario al que le has compratido el documento ya lo ha leido
CREATE OR REPLACE FUNCTION leerDoc(
	xIDShare  integer,        
        xIDDoc   integer
           
        
	)  returns void
	
AS
$$
DECLARE
       
        
        
	begin	
			
                
               update doc_compartir set n_lecturas=n_lecturas+1 where id_share=xIDShare and id_doc=xIDDoc;
   	

       end;
$$ LANGUAGE plpgsql;

/



