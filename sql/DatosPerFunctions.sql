
--
-- Actualizar los datos de la empresa
--

CREATE OR REPLACE FUNCTION UpdateDatosPer(
    xIBAN in varchar,
    xBIC in varchar,
    xnif in varchar,
    xnombre in varchar,
    xdireccion in varchar,
    xobjeto in varchar,
    xpoblacion in varchar,
    xmovil in varchar,
    xfax in varchar,
    xmail in varchar,
    xurl in varchar
)
returns varchar
AS
$body$
DECLARE

    xLetra varchar(1);
    xFormaJuridica text;
    xtipo_de_cuenta integer := 1;
    DatosperJSON json;
    cuantos integer;

BEGIN

-- G30107072 comunidad de regantes mas normal G pero pueden ser Q
-- COMUNIDAD DE REGANTES DEL SECTOR "XI" DEL CANAL DEL FLUMEN
-- C.I.F. Nº Q2267010C.
-- Cl. LORETO, 1-20 12Q. (SARIÑENA - HUESCA )

xLetra:=Substr(Upper(xnif),1,1);

CASE
WHEN xLetra='A' THEN xFormaJuridica:='SA'; xtipo_de_cuenta:=3;
WHEN xLetra='B' THEN xFormaJuridica:='SL'; xtipo_de_cuenta:=2;
WHEN xLetra='C' THEN xFormaJuridica:='Sociedades colectivas'; xtipo_de_cuenta:=2;
WHEN xLetra='D' THEN xFormaJuridica:='Sociedades comanditarias'; xtipo_de_cuenta:=2;
WHEN xLetra='E' THEN xFormaJuridica:='COMUNIDAD-BIENES'; xtipo_de_cuenta:=2;
WHEN xLetra='F' THEN xFormaJuridica:='COOPERATIVA'; xtipo_de_cuenta:=3;
WHEN xLetra='G' THEN xFormaJuridica:='Asociaciones'; xtipo_de_cuenta:=3;
WHEN xLetra='H' THEN xFormaJuridica:='Comunidades de propietarios'; xtipo_de_cuenta:=3;
WHEN xLetra='J' THEN xFormaJuridica:='Sociedades civiles'; xtipo_de_cuenta:=3;
WHEN xLetra='P' THEN xFormaJuridica:='Corporaciones Locales'; xtipo_de_cuenta:=3;
WHEN xLetra='Q' THEN xFormaJuridica:='Organismos públicos'; xtipo_de_cuenta:=3;
WHEN xLetra='R' THEN xFormaJuridica:='Congregaciones e instituciones religiosas'; xtipo_de_cuenta:=3;
WHEN xLetra='S' THEN xFormaJuridica:='Órganos Administración del Estado y Comunidades Autónomas'; xtipo_de_cuenta:=3;
WHEN xLetra='U' THEN xFormaJuridica:='UTE'; xtipo_de_cuenta:=3;
WHEN xLetra='V' THEN xFormaJuridica:='Otros tipos no definidos'; xtipo_de_cuenta:=3;
WHEN xLetra='N' THEN xFormaJuridica:='Entidades extranjeras'; xtipo_de_cuenta:=3;
WHEN xLetra='W' THEN xFormaJuridica:='Empresas Extranjeras no residentes en España'; xtipo_de_cuenta:=3;
WHEN xLetra='X' THEN xFormaJuridica:='NIE extrangeros no residentes'; xtipo_de_cuenta:=2;
WHEN xLetra='M' THEN xFormaJuridica:='NIF Extranjeros que no tienen NIE'; xtipo_de_cuenta:=2;
WHEN xLetra='L' THEN xFormaJuridica:='Españoles residentes en el extranjero sin DNI'; xtipo_de_cuenta:=1;
WHEN xLetra='K' THEN xFormaJuridica:='Españoles menores de 14 años'; xtipo_de_cuenta:=1;
WHEN xLetra='Y' THEN xFormaJuridica:='Extranjeros Orden INT/2058/2008'; xtipo_de_cuenta:=1;
ELSE xFormaJuridica:='RETA'; xtipo_de_cuenta:=1;
END CASE;

xIBAN:=trim(xIBAN);

if length(xIBAN) > 32 and trim(xbic)='' then
    select bic into xbic from EntidadesBIC where codigo=substr(xIBAN,5,4);
end if;


--
-- actualizar la forma jurídica
-- Y EL TIPO DE CUENTA siempre y cuando el tipo sea 1 Free
--
UPDATE DatosPer 
    SET nif=Upper(xnif),forma_juridica=xFormaJuridica,iban=upper(xiban),bic=upper(xbic),tipo_de_cuenta=xtipo_de_cuenta,
    nombre=xnombre,direccion=xdireccion,objeto=xobjeto,poblacion=xpoblacion,movil=xmovil,
    fax=xfax,mail=xmail, url_web = xURL
    where id=1;

select row_to_json(datosper) into DatosperJSON from datosper where id=1;

-- xiban
-- Crear la cuenta bancaria como proveedor
-- 4 es el tipo de proveedor BANCO
--

select count(*) into cuantos from suppliers where iban = xiban;

if cuantos is null or cuantos = 0 then
    -- Crear la cuenta bancaria en proveedores y contabilidad
    perform SaveNewProveedor('','Asiento apertura','','','','','',4,xiban,xbic);
end if;


-- Informar al sistema
return DatosperJSON;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;

--
-- DatosComplementarios
--
CREATE OR REPLACE FUNCTION UpdateDatosPerCNAE(
    xCNAE in varchar,
    xfecha_creacion in varchar,
    xIRPFprof in varchar,
    xIRPFalqui in varchar,
    xYear in varchar,
    xTrimestre in varchar
)
returns VOID
AS
$body$
DECLARE

    cuantos integer;

BEGIN

--
-- pasar de varchar a numeric
--
UPDATE DatosPer 
    SET CNAE = xCNAE, fecha_constitucion  = to_date(xfecha_creacion,'YYYY-MM-DD'),
        irpf_profesionales = cast(xIRPFprof as numeric), irpf_alquileres = cast(xIRPFalqui as numeric),
        fiscal_year = xYear, periodo = xTrimestre
    where id=1;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Datos SEPA
--
-- select DatosPerSEPA('0182','0019','000','12')
--
CREATE OR REPLACE FUNCTION DatosPerSEPA(
    xEntidad in varchar,
    xOficina in varchar,
    xSufijo in varchar,
    xNuRecibos in varchar,
    xEmiteRemesa in varchar
)
returns VOID
AS
$body$
DECLARE


BEGIN

--
-- pasar de varchar a numeric
--
UPDATE DatosPer 
    SET EntidadPresenta = xEntidad, OficinaPresenta = xOficina,
        sufijo=xSufijo, periodicidad_er = cast(xNuRecibos as numeric), EmiteRemesas=xEmiteRemesa
    where id=1;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Datos SEPA
--
CREATE OR REPLACE FUNCTION DatosPerYear(
    xYear in varchar,
    xPeriodo in varchar
)
returns VOID
AS
$body$
DECLARE


BEGIN

--
-- pasar de varchar a numeric
--
UPDATE DatosPer 
    SET fiscal_year = xYear, periodo = xPeriodo
    where id=1;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Datos de la carga impositiva
--
CREATE OR REPLACE FUNCTION DatosPerCargaImpostiva(
    xCriterio in varchar,
    xFechaCons in varchar,
    xCNAE in varchar,
    xIRPFprof in varchar,
    xIRPFalqui in varchar,
    xIVA in varchar,
    x036 in bytea,
    xEscrituras in bytea
)
returns void
AS
$body$
DECLARE


BEGIN

-- esta variable entra con valores null o caja
-- tiene que tener SI o NO
if xCriterio is null then
    xCriterio:='NO';
else
    xCriterio:='SI';
end if;
--
-- pasar de varchar a numeric
--
UPDATE DatosPer 
    SET criterio_de_caja=xCriterio, fecha_constitucion= to_date(xFechaCons, 'YYYY-MM-DD'),
        cnae=xCNAE, irpf_profesionales=cast(xIRPFprof as numeric), irpf_alquileres=cast(xIRPFalqui as numeric), 
        iva=cast(xIVA as numeric),
        cero36=x036, escrituras_consti=xEscrituras
    where id=1;


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;




--
-- Alta de un nuevo cliente desde Google+
-- select newusergoogleplus('antonio.gialnet@gmail.com', 'antonio perez caballero', 'male', 'es')

CREATE OR REPLACE FUNCTION NewUserGooglePlus(
    xmail in varchar,
    xnombre in varchar,
    xgenero in varchar,
    xpais in varchar
)
returns void
AS
$body$
DECLARE

    cuantos integer;
    -- jdbc/myEmpresa1
    --xCert varchar(20);

BEGIN

        -- comprobar que no existe el usuario
    select count(*) into cuantos from PersonalRRHH where email = xMail;

    if cuantos > 0 then
        
        return;
    else

        -- insertar el nuevo usuario proporcionado por Google
        UPDATE PersonalRRHH set nombre = xNombre, 
        email = xMail, 
        genero = xGenero, 
        locale = xPais
        WHERE TIPO = 'administrador';

    end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;


--
-- Version para enviar el certificado vía servlet
--
-- select newusergoogleplus('antonio.gialnet@gmail.com', 'antonio perez caballero', 'male', 'es','jdbc/myEmpresa1')
--
CREATE OR REPLACE FUNCTION NewUserGooglePlus(
    xmail in varchar,
    xnombre in varchar,
    xgenero in varchar,
    xpais in varchar,
    xCert in bytea
)
returns void
AS
$body$
DECLARE

    cuantos integer;

BEGIN

    -- comprobar que no existe el usuario
    select count(*) into cuantos from PersonalRRHH where email = xMail;

    if cuantos > 0 then
        
        return;
    else

        -- insertar el nuevo usuario proporcionado por Google
        INSERT INTO PersonalRRHH (nombre, tipo, email, genero, locale, certificado) 
        VALUES (xNombre,'administrador',xMail, xGenero, xPais, xCert);

    end if;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
