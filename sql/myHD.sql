
--
-- Add table "doc_custodia"    
--

CREATE TABLE doc_custodia (
    id serial  NOT NULL,
    id_user Integer,
    tipo    varchar(15) default 'clientes',--clientes | terceros | personal
    filename varchar(250),
    fecha TIMESTAMP default now(),
    hash_algo varchar(128), -- almacenar la representación del algoritmo en hexadecimal sha1 sha224/256/384/512
    fichero bytea,
    PRIMARY KEY (id)
);

COMMENT ON TABLE doc_custodia IS 'Tabla que almacena los documentos, sus firmas y demas metadatos';
create index doc_custodia_FILENAME on doc_custodia(FILENAME);
create index doc_custodia_hash_algo on doc_custodia(hash_algo);


--
-- Add table "doc_compartir"                                               */
--

CREATE TABLE doc_compartir (
    id serial  NOT NULL,
    id_doc INTEGER references doc_custodia(id),
    id_personal_rrhh INTEGER,
    id_share        Integer, -- id del usuario al que se le comparte un docuemnto, hace referencia a un customer o a personal
    tipo_share    varchar(15) default 'clientes',--clientes | terceros | personal que indica el tiepo de usaurio de id_share
    n_lecturas INTEGER DEFAULT 0,
    PRIMARY KEY (id)
);

COMMENT ON TABLE doc_compartir IS 'Tabla que almacena los apuntes de quien puede ver los docuementos';

-- 
-- Add table "CARPETA"                                                     */
--


CREATE TABLE CARPETA (
    ID SERIAL,
    ID_USUARIO INTEGER,
    tipo_usuario varchar(15) default 'clientes',--clientes | terceros | personal que indica el tiepo de usaurio de id_share
    NOMBRE varchar(100),
    FECHA TIMESTAMP default now(),
    primary key(id)
);

--
-- Add table "CARPETA_DOC"                                                
--

CREATE TABLE CARPETA_DOC (
    ID_CARPETA integer references CARPETA(id),
    ID_DOC INTEGER references doc_custodia(id)
   
);


--
-- Add table "CUENTAS_EMPLEADO_CLIENTE"    
-- En esta tabla solo estarán los clientes que atiende directamente el administrador                                            
--

CREATE TABLE CUENTAS_EMPLEADO_CLIENTE (
    ID_EMPLEADO integer references PersonalRRHH(id),
    ID_CLIENTE INTEGER references customers(id)
   
);
