--
-- Tetbury Software Services LTD
--
-- SIC 62012 Business and domestic software development

--

--
-- Crear una base datos para Demo
--

CREATE TABLE EntidadesBIC
(
    codigo          varchar(4) not null,
    entidad         text,
    bic             varchar(11),
    primary key (codigo)
);

--
-- Entidas según banco España (Relación publicada en el BOE de fecha 25/10/2013)
--
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ABNAESMMXXX' , 'THE ROYAL BANK OF SCOTLAND PLC, SUCURSAL EN ESPAÑA' , '0156');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('AHCFESMMXXX' , 'AHORRO CORPORACION FINANCIERA, S.A., SOCIEDAD DE VALORES' , '3524');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ALCLESMMXXX' , 'BANCO ALCALA, S.A.' , '0188');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('AREBESMMXXX' , 'ARESBANK, S.A.' , '0136');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BAPUES22XXX' , 'BANCA PUEYO, S.A.' , '0078'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BARCESMMXXX' , 'BARCLAYS BANK, S.A.' , '0065');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BASKES2BXXX' , 'KUTXABANK, S.A.' , '2095');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BBPIESMMXXX' , 'BANCO BPI, S.A., SUCURSAL EN ESPAÑA' , '0190');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BBRUESMXXXX' , 'ING BELGIUM, S.A., SUCURSAL EN ESPAÑA' , '0168');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BBVAESMMXXX' , 'BANCO BILBAO VIZCAYA ARGENTARIA, S.A.' , '0182');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BCOEESMM081' , 'CAJA RURAL DE CASTILLA-LA MANCHA, S.C.C.' , '3081'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BCOEESMMXXX' , 'BANCO COOPERATIVO ESPAÑOL, S.A.' , '0198');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BESMESMMXXX' , 'BANCO ESPIRITO SANTO, S.A., SUCURSAL EN ESPAÑA' , '0131');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BFASESMMXXX' , 'BANCO FINANCIERO Y DE AHORROS, S.A.' , '0488');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BFIVESBBXXX' , 'BANCO MEDIOLANUM, S.A.' , '0186');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BKBKESMMXXX' , 'BANKINTER, S.A.' , '0128');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BKOAES22XXX' , 'BANKOA, S.A.' , '0138');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BMARES2MXXX' , 'BANCA MARCH, S.A.' , '0061');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BMCEESMMXXX' , 'BANQUE MAROCAINE COMMERCE EXTERIEUR INTERNATIONAL, S.A.' , '0219');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BNPAESMHXXX' , 'BNP PARIBAS, SUCURSAL EN ESPAÑA' , '0149');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BPLCESMMXXX' , 'BNP PARIBAS ESPAÑA, S.A.' , '0058');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BOTKESMXXXX' , 'THE BANK OF TOKYO-MITSUBISHI UFJ, LTD, SUCURSAL EN ESPAÑA' , '0160');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BPLCESMMXXX' , 'BARCLAYS BANK PLC, SUCURSAL EN ESPAÑA' , '0152');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BRASESMMXXX' , 'BANCO DO BRASIL, S.A., SUCURSAL EN ESPAÑA' , '0155');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BSABESBBXXX' , 'BANCO DE SABADELL, S.A.' , '0081');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BSCHESMMXXX' , 'BANCO SANTANDER, S.A.' , '0049');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CAGLESMMVIG' , 'NCG BANCO, S.A.' , '2080');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BSUIESMMXXX' , 'CREDIT AGRICOLE CORPORATE AND INVESTMENT BANK, SUCURSAL EN ESPAÑA' , '0154');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('BVALESMMXXX' , 'RBC INVESTOR SERVICES ESPAÑA, S.A.' , '0094');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CAHMESMMXXX' , 'BANKIA, S.A.' , '2038');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CAIXESBBXXX' , 'CAIXABANK, S.A.' , '2100'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CAPIESMMXXX' , 'CM CAPITAL MARKETS BOLSA, SOCIEDAD DE VALORES, S.A.' , '3604');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CASDESBBXXX' , 'CAJA DE ARQUITECTOS S.C.C.' , '3183');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CAZRES2ZXXX' , 'IBERCAJA BANCO, S.A.' , '2085');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CCOCESMMXXX' , 'BANCO CAMINOS, S.A.' , '0234');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMM045' , 'CAJAS RURALES UNIDAS, S.C.C.' , '3058');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMM048' , 'LIBERBANK, S.A.' , '2048');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CDENESBBXXX' , 'CAIXA DE CREDIT DELS ENGINYERS - CAJA DE CREDITO DE LOS INGENIEROS, S.C.C.' , '3025');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMM045' , 'CAJA DE AHORROS Y M.P. DE ONTINYENT' , '2045');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMM056' , 'COLONYA - CAIXA D ESTALVIS DE POLLENSA' , '2056');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMM086' , 'BANCO GRUPO CAJATRES, S.A.' , '2086');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CECAESMMXXX' , 'CECABANK, S.A.' , '2000');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CESCESBBXXX' , 'CATALUNYA BANC, S.A.' , '2013');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CGDIESMMXXX' , 'BANCO CAIXA GERAL, S.A.' , '0130'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CITIES2XXXX' , 'CITIBANK ESPAÑA, S.A.' , '0122');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CITIESMXSEC' , 'CITIBANK INTERNATIONAL PLC, SUCURSAL EN ESPAÑA' , '1474');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CLPEES2MXXX' , 'CAJA LABORAL POPULAR, C.C.' , '3035');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('COBAESMXTMA' , 'COMMERZBANK AKTIENGESELLSCHAFT, SUCURSAL EN ESPAÑA' , '0159');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CRESESMMXXX' , 'CREDIT SUISSE AG, SUCURSAL EN ESPAÑA' , '1460');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CSPAES2L108' , 'BANCO DE CAJA ESPAÑA DE INVERSIONES, SALAMANCA Y SORIA, S.A.' , '2108');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CSSOES2SFIN' , 'FINANDUERO, SOCIEDAD DE VALORES, S.A.' , '3656');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('CSURES2CXXX' , 'CAJASUR BANCO, S.A' , '0237');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('DEUTESBBASS' , 'DEUTSCHE BANK, S.A.E.' , '0019');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('DSBLESMMXXX' , 'DEXIA SABADELL, S.A.' , '0231');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('EHYPESMXXXX' , 'HYPOTHEKENBANK FRANKFURT AG. SUCURSAL EN ESPAÑA' , '1467');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ESPBESMMXXX' , 'BANCO DE ESPAÑA' , '9000');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ESSIESMMXXX' , 'BANCO ESPIRITO SANTO DE INVESTIMENTO, S.A., SUCURSAL EN ESPAÑA' , '1497');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ETCHES2GXXX' , 'BANCO ETCHEVERRIA, S.A.' , '0031');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('GALEES2GXXX' , 'BANCO GALLEGO, S.A.' , '0046');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('GBMNESMMXXX' , 'BANCO MARE NOSTRUM, S.A.' , '0487');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('GEBAESMMBIL' , 'BNP PARIBAS FORTIS, S.A., N.V., SUCURSAL EN ESPAÑA' , '0167');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ICROESMMXXX' , 'GVC GAESCO VALORES, SOCIEDAD DE VALORES, S.A.' , '3682');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('INGDESMMXXX' , 'ING DIRECT, N.V., SUCURSAL EN ESPAÑA' , '1465');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('IBRCESMMXXX' , 'SOCIEDAD DE GESTION DE LOS SISTEMAS DE REGISTRO, COMPENSACIÓN Y LIQUIDACION DE VALORES, S.A.U.' , '9096');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('ICROESMMXXX' , 'INSTITUTO DE CREDITO OFICIAL' , '1000');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('INSGESMMXXX' , 'INVERSEGUROS, SOCIEDAD DE VALORES, S.A.' , '3575');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('INVLESMMXXX' , 'BANCO INVERSIS, S.A.' , '0232');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('IPAYESMMXXX' , 'SOCIEDAD ESPAÑOLA DE SISTEMAS DE PAGO, S.A.' , '9020');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('IVALESMMXXX' , 'INTERMONEY VALORES, SOCIEDAD DE VALORES, S.A.' , '3669'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('LISEESMMXXX' , 'LINK SECURITIES, SOCIEDAD DE VALORES, S.A.' , '3641');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('LOYIESMMXXX' , 'LLOYDS BANK INTERNATIONAL, S.A.U.' , '0236');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('MADRESMMXXX' , 'BANCO DE MADRID, S.A.' , '0059');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('MEFFESBBXXX' , 'MEFF SOCIEDAD RECTORA DE PRODUCTOS DERIVADOS S.A.U.' , '9094');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('MIDLESMXXXX' , 'HSBC BANK PLC, SUCURSAL EN ESPAÑA' , '0162');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('MISVESMMXXX' , 'MAPFRE INVERSION, SOCIEDAD DE VALORES, S.A.' , '3563');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('NATXESMMXXX' , 'NATIXIS, S.A., SUCURSAL EN ESPAÑA' , '1479');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('MLCEESMMXXX' , 'MERRILL LYNCH CAPITAL MARKETS ESPAÑA, S.A., SOCIEDAD DE VALORES' , '3661');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('NACNESMMXXX' , 'BANCO DE LA NACION ARGENTINA, SUCURSAL EN ESPAÑA' , '0169');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('PARBESMHXXX' , 'BNP PARIBAS SECURITIES SERVICES, SUCURSAL EN ESPAÑA' , '0144');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('POHIESMMXXX' , 'TARGOBANK, S.A.' , '0216');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('POPIESMMXXX' , 'POPULAR BANCA PRIVADA, S.A.' , '0233');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('POPLESMMXXX' , 'BANCOPOPULAR-E, S.A.' , '0229');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('POPUESMMXXX' , 'BANCO POPULAR ESPAÑOL, S.A.' , '0075');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('PRABESMMXXX' , 'COOPERATIEVE CENTRALE RAIFFEISEN- BOERENLEENBANK B.A. (RABOBANK NEDERLAND), SUCURSAL EN ESPAÑA' , '1459');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('PROAESMMXXX' , 'EBN BANCO DE NEGOCIOS, S.A.' , '0211');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('RENBESMMXXX' , 'RENTA 4 BANCO, S.A.' , '0083');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('RENTESMMXXX' , 'RENTA 4 SOCIEDAD DE VALORES, S.A.' , '3501');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('SOGEESMMAGM' , 'SOCIETE GENERALE, SUCURSAL EN ESPAÑA' , '0108');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('UBIBESMMXXX' , 'UBI BANCA INTERNATIONAL, S.A., SUCURSAL EN ESPAÑA' , '1524');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('UBSWESMMNPB' , 'UBS BANK, S.A.' , '0226');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('UCJAES2MXXX' , 'UNICAJA BANCO, S.A.' , '2103');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('WELAESMMFUN' , 'PORTIGON AG, SUCURSAL EN ESPAÑA' , '0196');
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('XBCNESBBXXX' , 'SOCIEDAD RECTORA BOLSA VALORES DE BARCELONA, S.A., S.R.B.V.' , '9091'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('XRBVES2BXXX' , 'SOCIEDAD RECTORA BOLSA DE VALORES DE BILBAO, S.A., S.R.B.V.' , '9092'); 
INSERT INTO EntidadesBIC (BIC,entidad,codigo) VALUES ('XRVVESVVXXX' , 'SOCIEDAD RECTORA BOLSA VALORES DE VALENCIA, S.A., S.R.B.V.' , '9093');

--
-- Codigos de devolución de remesas formato SEPA
--

CREATE TABLE CodigosDevolucion
(
    codigo          varchar(4) not null,
    nombre          text,
    definicion      text,
    primary key (codigo)
);

INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AC01','IncorrectAccountNumber','Número de cuenta incorrecto (IBAN no válido).');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AC04','ClosedAccountNumber ','Cuenta cancelada.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AC06','BlockedAccount','Cuenta bloqueada y/o cuenta bloqueada por el deudor para adeudos directos.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AG01','TransactionForbidden','Cuenta no admite adeudos directos.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AG02','InvalidBankOperationCode','Código de operación incorrecto.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AM04','InsufficientFunds','Saldo insuficiente');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('AM05','Duplication','Operación duplicada.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('BE01','InconsistentWithEndCustomer','Titular de la cuenta de cargo no coincide con el deudor');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('BE05','UnrecognisedInitiatingParty','Identificador del acreedor incorrecto');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('FF01','InvalidFileFormat','Formato no válido');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('FF05','InvalidLocalinstrumentcode','Tipo de adeudo incorrecto');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MD01','NoMandate','Mandato no válido o inexistente.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MD02','MissingMandatoryInformationInMandate','Faltan datos del mandato o son incorrectos');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MD06','RefundRequestByEndCustomer','Operación autorizada no conforme');

INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MD07','EndCustomerDeceased','Deudor fallecido.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MS02','NotSpecifiedReasonCustomerGenerated','Razón no especificada por el cliente (orden del deudor).');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('MS03','NotSpecifiedReasonAgentGenerated','Razón no especificada por la entidad del deudor.');

INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('RC01','BankIdentifierIncorrect','Identificador de la entidad incorrecto (BIC no válido).');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('RR01','MissingDebtorAccountOrIdentification ','Falta identificación o cuenta del deudor. Razones regulatorias.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('RR02','MissingDebtorNameOrAddress','Falta nombre o dirección del deudor. Razones regulatorias.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('RR03','MissingCreditorNameOrAddress','Falta nombre o dirección del acreedor. Razones regulatorias.');
INSERT INTO CodigosDevolucion (codigo, nombre, definicion) VALUES ('RR04','DueToSpecificServiceOfferedByDebtorAgent','Servicios específicos ofrecidos por la entidad del deudor.');




--
-- Avisos del sistema a la cuenta
-- 9 mayor gravedad

CREATE TABLE AvisosSistema
(
    id              serial      NOT NULL,
    texto           text,
    fecha           date default now(),
    estado          varchar(15) default 'open',
    nivel           integer default 1, -- nivel de gravedad del asunto
    otros           json,
    primary key (id)
);

INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('NIF/CIF de nuestra actividad', 9);
INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('CNAE código que identifica nuestra actividad empresarial o profesional', 1);
INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('Digitalizar el modelo 036 de Hacienda y subirlo a la documentación', 1);
INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('Digitalizar las escrituras públicas en los casos de las sociedades', 1);
INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('Definir el Capital Social, ¿cuanto hemos invertido? y los socios', 9);
INSERT INTO AvisosSistema (TEXTO, NIVEL) VALUES ('Probar el modelo de factura', 9);

--
-- Lista de anuncios
--
-- Desde Servlets de secure.Tetbury se cargará la publicidad adecuada a cada
-- cuenta, en esta tabla.
--
CREATE TABLE Publicidad
(
    id              serial      NOT NULL,
    texto           text, -- puede ser texto plano o html5
    fecha           date default now(),
    estado          varchar(15) default 'open',
    otros           json,
    primary key (id)
);

INSERT INTO Publicidad (TEXTO) VALUES ('Bienvenido al sistema myEmpresa, le deseamos una feliz jornada');

--
-- Tipos de cuentas
--
CREATE TABLE PoliticaCuentas
(
    id              serial      NOT NULL,
    nombre          varchar(90),
    precio          numeric(8,2),
    duracion        varchar(10), -- mensual, anual, trimestral
    servicios        json,
    primary key (id)
);

--
-- Tipos de cuentas y funciones disponibles
--

INSERT INTO PoliticaCuentas ( id, nombre, precio, duracion, servicios) VALUES ( 1, 'Chanquete Free', 0, 'año',
'{   "Contabilidad": "no", 
    "Impuestos": "yes",
    "Nominas": "yes",
    "NominasApp": "no",
    "Firma": "yes",
    "Burofax":  "no",
    "Almacenamiento": "no",
    "Indexacion":  "no",
    "myHD": "yes",
    "LimiteUsuarios": "1"
}'::json
);

INSERT INTO PoliticaCuentas ( id, nombre, precio, duracion, servicios) VALUES ( 2, 'Boqueron Premiun', 60, 'año',
'{   "Contabilidad": "yes", 
    "Impuestos": "yes",
    "Nominas": "yes",
    "NominasApp": "no",
    "Firma": "yes",
    "Burofax":  "no",
    "Almacenamiento": "no",
    "Indexacion":  "no",
    "myHD": "yes",
    "LimiteUsuarios": "5"
}'::json
);

INSERT INTO PoliticaCuentas ( id, nombre, precio, duracion, servicios) VALUES ( 3, 'Pargo Enterprise', 32, 'mes',
'{   "Contabilidad": "yes", 
    "Impuestos": "yes",
    "Nominas": "yes",
    "NominasApp": "no",
    "Firma": "yes",
    "Burofax":  "yes",
    "Almacenamiento": "yes",
    "Indexacion":  "yes",
    "myHD": "yes",
    "LimiteUsuarios": "no"
}'::json
);

INSERT INTO PoliticaCuentas ( id, nombre, precio, duracion, servicios) VALUES ( 4, 'Atún Adviser', 35, 'mes',
'{   "Contabilidad": "yes", 
    "Impuestos": "yes",
    "Nominas": "yes",
    "NominasApp": "yes",
    "Firma": "yes",
    "Burofax":  "no",
    "Almacenamiento": "no",
    "Indexacion":  "no",
    "myHD": "yes",
    "LimiteUsuarios": "no"
}'::json
);

--
-- Naturaleza jurídica
--
CREATE TABLE datosper_legal
(
    id                  serial NOT NULL,
    forma_juridica      varchar(60),
    primary key (forma_juridica)
);


INSERT INTO datosper_legal (forma_juridica) VALUES ('SA');
INSERT INTO datosper_legal (forma_juridica) VALUES ('SL');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Sociedades Colectivas');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Sociedades Comanditarias');
INSERT INTO datosper_legal (forma_juridica) VALUES ('COMUNIDAD-BIENES');
INSERT INTO datosper_legal (forma_juridica) VALUES ('COOPERATIVA');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Asociaciones');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Comunidades de propietarios');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Sociedades civiles');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Corporaciones Locales');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Organismos públicos');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Congregaciones e instituciones religiosas');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Órganos Administración Estado y Comunidades Autónomas');
INSERT INTO datosper_legal (forma_juridica) VALUES ('UTE');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Otros tipos no definidos');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Entidades extranjeras');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Empresas Extranjeras no residentes en España');
INSERT INTO datosper_legal (forma_juridica) VALUES ('NIE Extrangeros no residentes');
INSERT INTO datosper_legal (forma_juridica) VALUES ('NIF Extranjeros que no tienen NIE');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Españoles residentes en el extranjero sin DNI');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Españoles menores de 14 años');
INSERT INTO datosper_legal (forma_juridica) VALUES ('Extranjeros Orden INT/2058/2008');
INSERT INTO datosper_legal (forma_juridica) VALUES ('RETA'); -- AUTONOMOS



CREATE TABLE datosper
(
    id                  serial NOT NULL,
    tipo_de_cuenta      integer default 1,
    forma_juridica      varchar(60) references datosper_legal(forma_juridica),
    IBAN                varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
    BIC                 varchar(11), -- puede ser de 8 o de 11 posiciones
    CNAE                varchar(25), -- ejemplo: CNAE J6311: Proceso de datos, hosting y actividades relacionadas o SIC que es el código internacional
    fecha_constitucion  date, -- fecha de constitución de la sociedad
    tipo_actividad      varchar(25) default 'empresarial', -- empresarial o profesional
    carga_impositiva    numeric(4,2) default 20,
    sociedades          varchar(2) default 'NO',
    criterio_de_caja    varchar(2) default 'NO', -- para los autonomos y empresas acogidas al criterio de caja no paga IVA hasta el ingreso
    presupuestos        varchar(2) default 'NO',
    fiscal_year         char(4) default EXTRACT(year FROM now()),
    periodo             char(2) default EXTRACT(QUARTER FROM now()),
    irpf_profesionales  numeric(4,2) default 21,
    irpf_alquileres     numeric(4,2) default 21,
    iva                 numeric(4,2) default 21,
    otras_reglas        json,
    EntidadPresenta     varchar(4), -- para las domiciliaciones
    OficinaPresenta     varchar(4), -- para las domiciliaciones
    Sufijo              varchar(3)  default '000', -- para las domiciliaciones
    periodicidad_er     integer default 12, -- periodicidad de la emisión de recibos 12 uno por mes,6 cada 2 meses,4 cade tres meses, 2 cada semestre
    EmiteRemesas        varchar(2) default 'NO',
    nif                 char(20),
    nombre              varchar(60),
    direccion           varchar(90), -- Avenida Europa, 21
    objeto              varchar(40), -- bloque A 2ºD
    poblacion           varchar(90), -- 18690 Almuñécar Granada
    Pais_ISO3166        varchar(2) default 'ES',
    movil               varchar(10),
    fax                 varchar(10),
    mail                varchar(90),
    url_web             varchar(250),
    url_tsa             text,
    escrituras_consti   bytea,
    cero36              bytea
);


insert into datosper (forma_juridica, fiscal_year, periodo, nombre) 
values ('RETA','2016','1','Su nombre comercial');


--
-- VAT
--
CREATE TABLE Tipos_VAT
(
    id                  serial NOT NULL,
    descripcion         varchar(50),
    tipo                numeric(4,2),
    recargo_eq          numeric(4,2),
    primary key (id)
);


INSERT INTO Tipos_VAT (descripcion,tipo,recargo_eq) VALUES ('IVA SUPER REDUCIDO',4, 0.5);
INSERT INTO Tipos_VAT (descripcion,tipo,recargo_eq) VALUES ('IVA REDUCIDO',10, 1.4);
INSERT INTO Tipos_VAT (descripcion,tipo,recargo_eq) VALUES ('IVA NORMAL',21, 5.2);

--
-- Capital, socios
--
CREATE TABLE capital
(
    id                  serial NOT NULL,
    nif                 varchar(20),
    nombre              varchar(90),
    aportacion          numeric(8,2),
    fecha               date,
    id_apunte           integer,
    primary key (id)
);


--INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781553J','Antonio Pérez Caballero',1000);
--INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781554J','Sara Pérez Fajardo',1000);
--INSERT INTO capital (nif, nombre, aportacion) VALUES ('23781555J','María del Mar Pérez Fajardo',1000);

--
-- Cambios en el capital de la sociedad
--
CREATE TABLE capital_cambios
(
    id                  serial NOT NULL,
    fecha               date,
    nif                 varchar(20),
    nombre              varchar(90),
    aportacion          numeric(8,2),
    escritura_publica   bytea,
    primary key (id)
);



--
-- Administradores
--
CREATE TABLE administradores
(
    id                  serial NOT NULL,
    nif                 varchar(20),
    nombre              varchar(90),
    capacidad           varchar(50), -- Unico, solidario, mancomunado
    fecha_desde         date,
    primary key (id)
);


--INSERT INTO administradores (nif, nombre, capacidad) VALUES ('23781555J','María del Mar Pérez Fajardo','Solidaria');


--
-- Administradores cambios
--
CREATE TABLE administradores_cambios
(
    id                  serial NOT NULL,
    fecha               date,
    nif                 varchar(20),
    nombre              varchar(90),
    capacidad           varchar(50), -- Unico, solidario, mancomunado
    escritura_publica   bytea,
    primary key (id)
);


--
-- Asesores
--
CREATE TABLE Asesores
(
    id                  serial NOT NULL,
    nif                 varchar(10),
    nombre              varchar(90),
    capacidad           varchar(50), -- Fiscal, Laboral, Jurídico
    fecha_desde         date,
    primary key (id)
);


--
-- Personal Recursos Humanos, además de Recursos humanos externos y colaboradores
-- También representa la tabla de usuarios de la aplicación
--
CREATE TABLE PersonalRRHH       -- Usuarios de la aplicación
(
    id                  serial NOT NULL,
    tipo                varchar(50),    -- tipo de relación con la empresa empleado, freelance, socio, administrador
    IBAN                varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
    BIC                 varchar(11),
    RedSocial           text,   -- URL del usuario de la red social
    email               varchar(90),
    cargo               varchar(50), -- cargo responsabilidad en la empresa
    estudios            varchar(50), -- nivel de estudios
    categoria           varchar(50), -- categoría profesional
    tipo_contrato       varchar(50), -- tipo de contrato
    SalarioBruto        numeric(8,2), -- salario bruto anual
    NumeroPagas         integer default 14,
    nif                 varchar(20),
    Nombre              varchar(90),
    genero              varchar(10), -- hombre mujer male female
    locale              varchar(2), -- es, uk, etc.
    otros_datos         json,
    servicios           json,
    permisos            json default '{"panel":"yes","clientes":"yes","ventas":"yes","proveedores":"yes","compras":"yes","nominas":"no","bancos":"no","contabilidad":"no"}'::json,
    fecha_nacimiento    date,
    estado_civil        varchar(25),
    fecha_alta          date,
    fecha_baja          date,
    hijos               integer,
    asucargo            integer,
    contrato            bytea,
    certificado         bytea,
    fecha_orden_sepa        date,
    referencia_mandato      varchar(35),
    orden_sepa              bytea, -- orden de domiciliación en formato SEPA
    primary key (id)
);


--INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
--    VALUES ('23781553J','Antonio Pérez Caballero','Responsable de producto', 'socio','antonio@redmoon.es');

--INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
--    VALUES ('23781554J','Sara Pérez Fajardo','Administración, publicidad y diseño', 'socio','sara@redmoon.es');

INSERT INTO PersonalRRHH (tipo) 
    VALUES ('administrador');

--INSERT INTO PersonalRRHH (nif, nombre, cargo, tipo, email) 
--    VALUES ('23781555J','Ángel Luis García Sánchez','Desarrollo Java', 'empleado','angel@redmoon.es');



--
-- Los distintos tipos de clientes en función de su residencia y consideraciones
-- especiales tributarias
--
CREATE TABLE customers_type
(
    id              serial      NOT NULL,
    descripcion     varchar(50),
    cuenta          varchar(4),
    gasto           varchar(4),
    primary key (id)
);

INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PENINSULA Y BALEARES','4300','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES RECARGO EQUIVALENCIA PENINSULA Y BALEARES','4301','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES CANARIAS','4302','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES CEUTA Y MELILLA','4303','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PAIS MIEMBRO DE LA UE','4303','7000');
INSERT INTO customers_type (DESCRIPCION,cuenta,gasto) VALUES ('CLIENTES PAIS FUERA UE','4304','7000');



--
-- Clientes
--

CREATE TABLE customers
(
   id                      serial      NOT NULL,
   id_customers_type       integer references customers_type(id),
   IBAN                    varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
   BIC                     varchar(11),
   Domiciliado             varchar(15) default 'domiciliado', -- por defecto domiciliado
   nif                     varchar(20),
   nombre                  varchar(60),
   direccion               varchar(90), -- Avenida Europa, 21
   objeto                  varchar(40), -- bloque A 2ºD
   poblacion               varchar(90), -- 18690 Almuñécar Granada
   Pais_ISO3166            varchar(2) default 'ES',
   movil                   varchar(10),
   mail                    varchar(90),
   saldo                   numeric(5),
   passwd                  varchar(40),
   clase                   varchar(2)  DEFAULT 'SL',
   pertenece_a             integer        DEFAULT 0,
   sip                     varchar(40),
   perfil                  varchar(50),
   digitos                 varchar(16),
   rol                     integer,
   carpeta_digitalizacion  varchar(90),
   tipo                    varchar(40)    DEFAULT 'US'::character varying,
   id_delegacion           integer,
   id_departamento         integer,
   envio_sms               char(1)        DEFAULT 'N'::bpchar,
   databasename            varchar(20),
   passdatabase            varchar(10),
   otros_datos             json,
   CuotaServicio           numeric(8,2) default 0,
   fecha_orden_sepa        date, -- FechaFirmaMandato
   referencia_mandato      varchar(35),
   orden_sepa              bytea, -- orden de domiciliación en formato SEPA
   certificado             bytea,
   primary key (id)
);

create index customers_nombre on customers(nombre);
create index customers_nif on customers(nif);


--
-- TIPOS DE PROVEEDORES
--
/*
62. SERVICIOS EXTERIORES
620. Gastos en investigación y desarrollo del ejercicio.
621. Arrendamientos y cánones.
622. Reparaciones y conservación.
623. Servicios de profesionales independientes.
624. Transportes.
625. Primas de seguros.
626. Servicios bancarios y similares.
627. Publicidad, propaganda y relaciones públicas.
628. Suministros.
629. Otros servicios.
*/
CREATE TABLE suppliers_type
(
    id              serial      NOT NULL,
    descripcion     varchar(50),
    cuenta          varchar(4),
    gasto           varchar(4),
    primary key (id)
);

INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES',                      '4000','6000');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES UNIÓN EUROPEA',        '4001','6000');
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROVEEDORES INTERNACIONALES NO UE','4004','6000'); --4004 PROVEEDOR EXTRACOMUNITARIO
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('BANCOS','5720','6260');              --4
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('ARRENDAMIENTOS','4100','6210');      --5
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('REPARACIONES','4100','6220');        --6
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PROFESIONALES','4100','6230');       --7
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('TRANSPORTE','4100','6240');          --8
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('SEGUROS','4100','6250');             --9
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('PUBLICIDAD','4100','6270');          --10
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('SUMINISTROS','4100','6280');         --11
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('OTROS','4100','6290');               --12
INSERT INTO suppliers_type (DESCRIPCION,cuenta,gasto) VALUES ('I+D','4100','6200');                 --13

--
-- Proveedores
--

CREATE TABLE suppliers
(
   id                      serial      NOT NULL,
   id_suppliers_type       integer references suppliers_type(id),
   IBAN                    varchar(34), -- los dos primeros digitos indican el país ES codigo para españa
   BIC                     varchar(11),
   nif                     varchar(20),
   nombre                  varchar(60),
   direccion               varchar(90), -- Avenida Europa, 21
   objeto                  varchar(40), -- bloque A 2ºD
   poblacion               varchar(90), -- 18690 Almuñécar Granada
   Pais_ISO3166            varchar(2) default 'ES',
   movil                   varchar(10),
   mail                    varchar(90),
   saldo                   numeric(5),
   passwd                  varchar(40),
   clase                   varchar(2)     DEFAULT 'SL',
   pertenece_a             integer        DEFAULT 0,
   sip                     varchar(40),
   perfil                  varchar(50),
   digitos                 varchar(16),
   rol                     integer,
   carpeta_digitalizacion  varchar(90),
   tipo                    varchar(40)    DEFAULT 'US',
   id_delegacion           integer,
   id_departamento         integer,
   envio_sms               char(1)        DEFAULT 'N',
   databasename            varchar(20),
   passdatabase            varchar(10),
   otros_datos             json,
   fecha_orden_sepa        date,
   referencia_mandato      varchar(35),
   orden_sepa              bytea, -- orden de domiciliación en formato SEPA
   certificado             bytea,
   primary key (id)
);

create index suppliers_nombre on suppliers(nombre);
create index suppliers_iban on suppliers(iban);
create index suppliers_nif on suppliers(nif);


-- crear los contadores
CREATE SEQUENCE cont_facturas;
CREATE SEQUENCE cont_facturas_proforma;
CREATE SEQUENCE cont_recibidas;
CREATE SEQUENCE cont_albaranes;


--
-- Remesas de facturas, cuotas o igualas
--
CREATE TABLE Remesas
(
    id                  serial NOT NULL,
    cuenta_banco        varchar(10), -- cuenta contable del banco a la que le enviamos la remesa
    descripcion         text,
    fecha               timestamp default now(), 
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    fecha_cobro         date,
    IdentificaRemesa    varchar(35), -- identifica el fichero de remesa de cuaderno19-14 SEPA
    primary key (id)
);


--
-- Facturas
--

CREATE TABLE head_bill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    id_apunte           integer,
    id_apcobro          integer,
    fiscal_year         char(4),
    trimestre           char(2),
    fecha               date, -- emisión
    fecha_vencimiento   date, -- fecha de pago obligatoria
    fecha_apremio       date, -- para formas jurídicas Sociedades civiles y públicas como comunidades de regantes
    numero              varchar(20), -- 2013/10025
    global_dto          numeric(4,2) default 0, -- para un posible descuento a nivel global de la factura al margen del dto. a cada linea de producto
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    fecha_estado        date,
    fecha_cobro         date,
    id_remesa           integer default 0,
    otros_datos         json, -- cajón de sastre para necesidades futuras
    primary key (id)
);

create unique index number_bill on head_bill(numero);
create index head_bill_fiscal_year on head_bill(fiscal_year);
create index head_bill_fecha on head_bill(fecha);
create index head_bill_IdentificaRemesa on head_bill(id_remesa);

--
-- Copia de la tabla de facturas para guardar todos los estados por los que
-- va pasando
--
CREATE TABLE head_bill_history
(
    id_bill             integer references head_bill(id),
    id_cliente          integer,
    id_apunte           integer,
    id_apcobro          integer,
    fiscal_year         char(4),
    trimestre           char(2),
    fecha               date, -- emisión
    fecha_vencimiento   date, -- fecha de pago obligatoria
    fecha_apremio       date, -- para formas jurídicas Sociedades civiles y públicas como comunidades de regantes
    numero              varchar(20), -- 2013/10025
    global_dto          numeric(4,2) default 0, -- para un posible descuento a nivel global de la factura al margen del dto. a cada linea de producto
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    fecha_estado        date
);

--
-- Plantilla de un recibo para cuotas
--

CREATE TABLE template_row_bill
(
    concepto            varchar(90),
    origen              varchar(20) default 'PRESUPUESTO', -- PRESUPUESTO O LECTURA
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 0,
    fijo_variable       varchar(2) default 'FI' -- FI/VA importe fijo o variable
);


--
-- Consumos 
--

CREATE TABLE Consumos
(
    id                  serial NOT NULL,
    id_cliente          integer,
    id_remesa           integer,
    fecha               date,
    concepto            varchar(90),
    unidades            numeric(6,2) default 1,
    importe             numeric(8,2) default 0,
    primary key (id)
);


--
-- Lineas de detalle de la factura
--
CREATE TABLE row_bill
(
    id                  serial NOT NULL,
    id_bill             integer references head_bill(id), -- bill, invoice
    id_item             integer, -- references productos/items(id), para futuras versiones de clientes con control de almacén
    id_store            integer, -- references almacenes/stores(id), para futuras versiones de clientes con control de almacén
    concepto            varchar(90),
    unidades            numeric(4,2) default 1,
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 21,
    por_req             numeric(4,2) default 0,
    por_dto             numeric(4,2) default 0,
    primary key (id)
);

CREATE INDEX row_bill_id_bill on row_bill (id_bill);



--
-- Albaranes
--

CREATE TABLE head_waybill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    primary key (id)
);


CREATE TABLE row_waybill
(
    id                  serial NOT NULL,
    id_head_waybill     integer references head_waybill(id), -- bill, invoice
    id_item             integer, -- references prodcutos/items(id), para futuras versiones de clientes con control de almacen
    id_store            integer, -- references almacenes/stores(id), para futuras versiones de clientes con control de almacen
    concepto            varchar(90),
    unidades            numeric(4,2),
    importe             numeric(8,2),
    por_vat             numeric(4,2),
    por_dto             numeric(4,2),
    primary key (id)
);


--
-- facturas proforma/presupuestos
--

CREATE TABLE head_budgetbill
(
    id                  serial NOT NULL,
    id_cliente          integer,
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    primary key (id)
);


CREATE TABLE row_budgetbill
(
    id                  serial NOT NULL,
    id_head_budgetbill  integer references head_budgetbill(id), -- proforma
    concepto            varchar(90),
    unidades            numeric(4,2) default 1,
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 21,
    por_req             numeric(4,2) default 0,
    por_dto             numeric(4,2) default 0,
    primary key (id)
);


--
-- Libro de facturas recibidas/invoices received
--

CREATE TABLE invoices_received
(
    id                  serial NOT NULL,
    id_proveedor        integer REFERENCES suppliers (id),
    id_apunte           integer,
    id_appago           integer,
    fiscal_year         char(4),
    trimestre           char(2),
    fecha               date, -- 2013/07/10
    numero              varchar(20), -- 2013/10025
    global_dto          numeric(4,2) default 0, -- para un posible descuento a nivel global de la factura al margen del dto. a cada linea de producto
    estado              varchar(10) DEFAULT 'PENDIENTE'::character varying,
    fecha_vencimiento   date,
    fecha_pago          date,
    forma_pago         char(1)         DEFAULT 'B'::bpchar NOT NULL,
    CONSTRAINT invoices_received_forma_pago_check CHECK (forma_pago = ANY (ARRAY['E'::bpchar, 'B'::bpchar])),
    primary key (id)
);

create index invoices_received_fiscal_year on invoices_received(fiscal_year);
create index invoices_received_fecha on invoices_received(fecha);


-- Lineas de detalle de la factura recivida

CREATE TABLE row_invoices_received
(
    id                  serial NOT NULL,
    id_inre             integer references invoices_received(id),
    id_item             integer, -- references productos/items(id), para futuras versiones de clientes con control de almacén
    id_store            integer, -- references almacenes/stores(id), para futuras versiones de clientes con control de almacén
    concepto            varchar(90),
    unidades            numeric(4,2) default 1,
    importe             numeric(8,2) default 0,
    por_vat             numeric(4,2) default 21,
    por_req             numeric(4,2) default 0,
    por_dto             numeric(4,2) default 0,
    primary key (id)
);

CREATE INDEX row_invoices_received_id_inre on row_invoices_received (id_inre);


-- Justificantes de facturas/supporting invoices
-- digest(data bytea, 'sha1') returns bytea
CREATE TABLE doc_supporting
(
   id           serial   NOT NULL,
   id_issued    integer,
   id_received  integer,
   id_user      integer,
   lote         integer,
   tipo_mime    varchar(40) DEFAULT 'application/pdf'::character varying,
   filename     varchar(250),
   filesize     integer,
   fecha        timestamp DEFAULT LOCALTIMESTAMP,
   hash_algo    varchar(128), -- almacenar la representación del algoritmo en hexadecimal sha1 sha224/256/384/512
   fileblob     bytea,
   url_nube     text,
   primary key (id)
);

create index doc_supporting_id_issued on doc_supporting(id_issued);
create index doc_supporting_id_received on doc_supporting(id_received);

--
-- Fichero temporal para carga masiva de datos
--
CREATE TABLE tmp_carga_bulk
(
    usuario      varchar(90),
    fecha        timestamp DEFAULT LOCALTIMESTAMP,
    fileblob     bytea
);


--
-- Configuración de la cuenta de correo de salida
--
CREATE TABLE OUTGOING_MAIL_CONFIGURATION (
	ID serial   NOT NULL, 
	NAME VARCHAR(250), 
	USER_NAME VARCHAR(250), 
	PASSWD VARCHAR(250), 
	HOST VARCHAR(250), 
	PORT VARCHAR(10), 
	SERVER_SECURITY VARCHAR(10), 
	EMAIL VARCHAR(250),
    primary key (id)
);


Insert into OUTGOING_MAIL_CONFIGURATION (NAME,USER_NAME,PASSWD,HOST,PORT,SERVER_SECURITY,EMAIL) 
values ('Redmoon Gmail STARTTLS','redmoon.granada@gmail.com','cajagranada2012','smtp.gmail.com','587','starttls','redmoon.granada@gmail.com');

Insert into OUTGOING_MAIL_CONFIGURATION (NAME,USER_NAME,PASSWD,HOST,PORT,SERVER_SECURITY,EMAIL) 
values ('Redmoon Gmail SSL','redmoon.granada@gmail.com','cajagranada2012','smtp.gmail.com','465','ssl/tls','redmoon.granada@gmail.com');


-- ****************************************************************************
--                                   Contabilidad
-- ****************************************************************************

--
-- Plan contable español
--

CREATE TABLE PlanGeneral
(
    id          serial NOT NULL,
    concepto    varchar(150),
    cuenta      varchar(5),
    vector      tsvector,
    primary key (id)
);

CREATE INDEX PlanGeneral_v ON PlanGeneral USING gin(to_tsvector('spanish', concepto));


CREATE TABLE Cuentas
(
    cuenta      varchar(10) NOT NULL,
    concepto    varchar(120),
    year_fiscal varchar(4) default EXTRACT(year FROM now()),
    primary key (cuenta)
);

create index Cuentas_year_fiscal on Cuentas(year_fiscal);


-- *****************************************
-- Cuentas que deben de existir inicialmente
-- *****************************************

INSERT INTO Cuentas (cuenta,concepto) VALUES ('7000000000','Ventas.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6000000000','Compras de mercaderías.');

-- IRPF
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4751000111','Hacienda Pública, acreedora por retenciones nominas y profesionales.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4751000001','Hacienda Pública, rendimientos en especie.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4751000216','Hacienda Pública, no residentes.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4751000115','Hacienda Pública, acreedora por alquileres.');

-- Seguridad Social
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4761000000','Organismos de la Seguridad Social, acreedores.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4761000001','Autonomos, Organismos de la Seguridad Social, acreedores.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4760000000','Organismos de la Seguridad Social, acreedores');

-- Salarios
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4100000000','Acreedores por prestaciones de servicios');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4650000000','Remuneraciones pendientes de pago');

-- 472. Hacienda Pública, IVA soportado 
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4720000000','Hacienda Pública, IVA soportado');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4720000001','Hacienda Pública, IVA soportado UE');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4720000002','Hacienda Pública, IVA soportado paises NO UE');

-- Impuesto de Sociedades
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4752000000', 'Hacienda Pública, acreedora por impuesto sobre sociedades');

--477. Hacienda Pública, IVA repercutido
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000000','Hacienda Pública, IVA repercutido');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000001','Hacienda Pública, IVA repercutido UE');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000002','Hacienda Pública, IVA repercutido paises NO UE');


INSERT INTO Cuentas (cuenta,concepto) VALUES ('5510000000','Cuenta corriente con socios y administradores.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('5700000000','Caja.');

INSERT INTO Cuentas (cuenta,concepto) VALUES ('6200000000','Gastos en investigación y desarrollo del ejercicio.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6210000000','Arrendamientos y cánones.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6220000000','Reparaciones y conservación.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6230000000','Servicios de profesionales independientes.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6240000000','Transportes.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6250000000','Primas de seguros.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6260000000','Servicios bancarios y similares.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6270000000','Publicidad, propaganda y relaciones públicas.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6280000000','Suministros.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6290000000','Otros servicios.');

INSERT INTO Cuentas (cuenta,concepto) VALUES ('6300000000', 'Impuesto sobre beneficios');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6301000000', 'Impuesto diferido');

INSERT INTO Cuentas (cuenta,concepto) VALUES ('6420000000','Seguridad Social a cargo de la empresa.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6400000000','Sueldos y salarios.');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('6400000001','Sueldos y salarios pagos en especie.');
 


--
-- Vista de bancos
--
create or replace view bancos (cuenta, concepto) as
        select * from cuentas where cuenta like '572%';



/*
    Realizar apuntes contables
*/

CREATE TABLE Apuntes
(
    id          serial NOT NULL,
    concepto    varchar(120),
    fecha       date,
    year_fiscal varchar(4),
    periodo   varchar(2),
    reglas      json,
    primary key (id)
);

create index Apuntes_year_fiscal on Apuntes(year_fiscal);
create index Apuntes_periodo on Apuntes(periodo);




-- En el campo reglas vamos a guardar una relación de parejas de claves valor
-- Naturaleza de la operación, quien realiza la operación que módulo.
-- ejemplo 
-- newFactura.jsp realiza una factura 

--
-- Diario de operaciones contables
--
CREATE TABLE Diario
(
    id          serial NOT NULL,
    id_apunte   integer references Apuntes(id),
    cuenta      varchar(10) references Cuentas(cuenta),
    debe_haber  varchar(1), -- D/H
    importe     numeric(8,2),
    primary key (id)
);

create index Diario_cuenta on Diario(cuenta);
create index Diario_id_apunte on Diario(id_apunte);




--
-- Plantillas de asientos tipo
--
CREATE TABLE Template
(
    id          serial NOT NULL,
    concepto    varchar(120),
    primary key (id)
);
create index template_concepto on template(concepto);


--
-- movimientos a realizar por la platilla de asientos
--

CREATE TABLE Templates_detalle
(
    id              serial NOT NULL,
    id_template     integer references Template(id),
    cuenta          varchar(10),
    debe_haber      varchar(1),
    primary key (id)
);


--
-- Normativa
--

CREATE TABLE Normas_juridicas
(
    id              serial NOT NULL,
    Norma           text,
    primary key (id)
);

CREATE INDEX Normas_juridicas_idx ON Normas_juridicas USING gin(to_tsvector('spanish', Norma));



--
-- Texto desarrollo de la Nornativa
--
CREATE TABLE Normativa
(
    id                  serial NOT NULL,
    id_norma            integer references Normas_juridicas(id),
    TextoNorma          text,
    primary key (id)
);

CREATE INDEX Normativa_idx ON Normativa USING gin(to_tsvector('spanish', TextoNorma));



--
-- Amortizaciones
--
CREATE TABLE Amortizaciones
(
    id                  serial NOT NULL,
    id_compra           integer,        -- para los casos de compras, inmaterial material
    year_fiscal         varchar(4),
    tipo                varchar(25), -- inmaterial material financiero
    plazo_years         integer,
    importe             numeric(8,2),
    valor_residual      numeric(8,2),
    inicio_year         integer, -- primer año de aplicación
    descripcion         text,
    primary key (id)
);



--
-- Tabla de amortización
--
CREATE TABLE DetalleAmortizaciones
(
    id                  serial NOT NULL,
    id_Amortizaciones   integer references Amortizaciones(id),
    year_fiscal         varchar(4),
    mes                 integer, -- para las amortizaciones financieras, sea más fácil recuperar un determinado plazo
    plazo_numero        integer,
    importe             numeric(8,2),
    intereses           numeric(8,2),
    principal           numeric(8,2),
    primary key (id)
);


-- *****************************************************************************
--                  Obligaciones
-- *****************************************************************************

--
-- Las obligaciones de una empresa con las administraciones
--
CREATE TABLE obligaciones
(
    id          serial NOT NULL,
    cuenta      varchar(10),
    naturaleza  varchar(50),
    periodo     varchar(2),
    plazos      varchar(90),
    primary key (naturaleza)
);




-- NRC modelo, ejercicio, periodo, NIF declarante, apellido e importe exacto del ingreso
--
-- peridos de las obligaciones 
--
-- url de verificación del NRC
-- https://www2.agenciatributaria.gob.es/L/inwinvoc/es.aeat.dit.adu.eeca.catalogo.vis.VisualizaSc?COMPLETA=NO&ORIGEN=J
--
CREATE TABLE leg_obligaciones
(
    id          serial NOT NULL,
    concepto    varchar(120),
    naturaleza  varchar(50) references obligaciones(naturaleza),
    year_fiscal varchar(4),
    periodo     varchar(2),
    estado      varchar(10) default 'PENDIENTE', -- PENDIENTE, PAGADO, CERRADO
    NRC         varchar(50), -- Codigo NRC obtenido del banco al ingresar un tributo
    fecha_pago  date,
    id_apunte   integer references Apuntes(id),
    primary key (id)
);

CREATE INDEX leg_obligaciones_apuntes on leg_obligaciones(id_apunte);
CREATE INDEX leg_obligaciones_naturaleza on leg_obligaciones(naturaleza);
CREATE INDEX leg_obligaciones_year_fiscal on leg_obligaciones(year_fiscal);


--
-- Detalles de un perido de obligaciones ejemplo: IRPF 3T 2013
-- se divide en: retenciones, especie, profesionales y alquileres
--

CREATE TABLE leg_detalle
(
    id          serial NOT NULL,
    id_leg      integer references leg_obligaciones(id),
    cuenta      varchar(10),
    importe     numeric(8,2),
    primary key (id)
);

CREATE INDEX leg_detalle_id_leg on leg_detalle(id_leg);


-- de caracter interno para las nóminas
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('NOMINAS','12',
    '{"periodo":"mes"}','4650000000');

--
-- IRPF
--
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 111-IRPF empleados y prof.','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000111');

INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 216-IRPF no residentes','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000216');

INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) VALUES ('Modelo 115-IRPF alquileres','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4751000115');

-- ingresado a día 1
INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('Modelo 202-Acuenta Sociedades','3',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]','6300000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('Modelo 303-IVA','4',
    '{"trimestral":[{"mes":"abril","mes":"julio","mes":"octubre","mes":"diciembre"}]', '4770000000');

-- Impuesto de Sociedades
INSERT INTO obligaciones (naturaleza,periodo,plazos, cuenta) 
    VALUES ('Modelo 200-SOCIEDADES','1','{"mes":"julio"}', '4752000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos) 
VALUES ('Modelo 123-Reparto de dividendos','1','{"mes":"julio"}');


INSERT INTO obligaciones (naturaleza,periodo,plazos,cuenta) VALUES ('SEGURIDAD-SOCIAL','12','{"mensual":12}','4760000000');

INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 347-MAYORES-3000','1','{"mes":"marzo"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 349-OPERACIONES-INTRA','4','{depende del volumen de facturación}');


INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('IAE','1','{depende del volumen de facturación}');

-- una vez al año Los Resumenes
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 190: resumen 111','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 180: resumen 115','1','{"mes":"enero"}'); 
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 193: resumen 123','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 296: resumen 216','1','{"mes":"enero"}'); 
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Modelo 390: resumen 303','1','{"mes":"enero"}');
INSERT INTO obligaciones (naturaleza,periodo,plazos) VALUES ('Registro Mercantil-Libros y Cuentas anuales','1','{"mes":"julio"}');


-- *****************************************************************************
--                              Balances
-- *****************************************************************************

CREATE TABLE Balance
(
    id              serial NOT NULL,
    Norma           text,
    primary key (id)
);



/*
Ejemplo INSERT INTO ReglasBalance (SECCION,id_balance) VALUES ('Inmovilizado intangible',1);
*/

CREATE TABLE SeccionBalance
(
    id              serial NOT NULL,
    id_balance      integer references Balance(id),
    Seccion         varchar(150),
    primary key (id)
);

create index SeccionBalance_Seccion on SeccionBalance(Seccion);


/*
Ejemplo INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Desarrollo','{201,2801,2901}');
*/

CREATE TABLE ApartadoSeccionBalance
(
    id                      serial NOT NULL,
    id_SeccionBalance       integer references SeccionBalance(id),
    Apartado                varchar(150),
    grupo_cuentas           text[],
    primary key (id)
);

create index ApartadoSeccionBalance_Apartado on ApartadoSeccionBalance(Apartado);


--
-- Tabla temporal con los resultados del balance
--
CREATE TABLE tmp_ResultBalance
(
    id              serial NOT NULL,
    usuario         varchar(90),
    year_fiscal     varchar(4),
    tipo_registro   varchar(15) DEFAULT 'DETALLE',  -- PAGINA TITULO SUMA TITULO_SEC SECCION DETALLE TOTAL
    id_balance      integer DEFAULT 0, -- contine uno asignado para cada apartado del balance por código SQL en Balance.sql
    Balance         text,
    Seccion         varchar(150),
    Apartado        varchar(150),
    Importe         numeric(12,2) default 0,
    Importe_prev    numeric(12,2) default 0,
    primary key (id)
);


--
-- Tabla historica de balances consolidados años cerrados.
--
CREATE TABLE HistoricoBalances
(
    id              serial NOT NULL,
    tipo_registro   varchar(15) DEFAULT 'DETALLE',  -- PAGINA TITULO SUMA TITULO_SEC SECCION DETALLE TOTAL
    id_balance      integer DEFAULT 0, -- contine uno asignado para cada apartado del balance por código SQL en Balance.sql
    year_fiscal     varchar(4),
    Balance         text,
    Seccion         varchar(150),
    Apartado        varchar(150),
    Importe         numeric(12,2) default 0,
    Importe_prev    numeric(12,2) default 0,
    primary key (id)
);



/* ****************************************************************************
        Carga de Datos
**************************************************************************** */

INSERT INTO Balance (Norma) VALUES ('ACTIVO NO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('ACTIVO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('PATRIMONIO NETO');
INSERT INTO Balance (Norma) VALUES ('PASIVO NO CORRIENTE');
INSERT INTO Balance (Norma) VALUES ('PASIVO CORRIENTE');


-- ****************************************************************************
--                      Seccion
-- ****************************************************************************

-- ACTIVO NO CORRIENTE
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'I. Inmovilizado intangible.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'II. Inmovilizado material.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'III. Inversiones inmobiliarias.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'IV. Inversiones en empresas del grupo y asociadas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'V. Inversiones financieras a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'VI. Activos por impuesto diferido.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (1,'VII. Deudores comerciales no corrientes.');

-- ACTIVO CORRIENTE
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'I. Activos no corrientes mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'II. Existencias.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'III. Deudores comerciales y otras cuentas a cobrar.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'IV. Inversiones en empresas del grupo y asociadas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'V. Inversiones financieras a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'VI. Periodificaciones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (2,'VII. Efectivo y otros activos líquidos equivalentes.');

-- PATRIMONIO NETO
-- A-1) Fondos propios.

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'I. Capital.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'II. Prima de emisión.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'III. Reservas.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IV. (Acciones y participaciones en patrimonio propias).');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'V. Resultados de ejercicios anteriores.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VI. Otras aportaciones de socios.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VII. Resultado del ejercicio.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'VIII. (Dividendo a cuenta).');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IX. Otros instrumentos de patrimonio neto.');


-- A-2) Ajustes por cambios de valor.
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'I. Activos financieros disponibles para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'II. Operaciones de cobertura.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'IV. Diferencia de conversión.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'V. Otros');


-- A-3) Subvenciones, donaciones y legados recibidos.
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (3,'A-3) Subvenciones, donaciones y legados recibidos.');

-- B) PASIVO NO CORRIENTE

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'I. Provisiones a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'II Deudas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'III. Deudas con empresas del grupo y asociadas a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'IV. Pasivos por impuesto diferido.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'V. Periodificaciones a largo plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'VI. Acreedores comerciales no corrientes.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (4,'VII. Deuda con características especiales a largo plazo.');

-- C) PASIVO CORRIENTE

INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'II. Provisiones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'III. Deudas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'IV. Deudas con empresas del grupo y asociadas a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'V. Acreedores comerciales y otras cuentas a pagar.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'VI. Periodificaciones a corto plazo.');
INSERT INTO SeccionBalance (id_balance,SECCION) 
    VALUES (5,'VII. Deuda con características especiales a corto plazo.');


-- ****************************************************************************
--                      Apartado y cuentas Reglas del Balance
-- ****************************************************************************
-- ********************
-- ACTIVO NO CORRIENTE
-- ********************

-- I. Inmovilizado intangible.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Desarrollo.','{+201, -2801, -2901}'); -- 1
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Concesiones.','{+202, -2802, -2902}'); -- 2
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Patentes, licencias, marcas y similares.','{+203, -2803, -2903}'); -- 3
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Fondo de comercio.','{+204}'); -- 4
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Aplicaciones informáticas.','{+206, -2806, -2906}'); -- 5
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Investigación.','{+200, -2800, -2900}'); -- 6
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (1, 'Otro inmovilizado intangible.','{+205, +209, -2805, -2905, +207, -2807, -2907}'); -- 7

-- II. Inmovilizado material.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Terrenos y construcciones.','{+210, +211, -2811, -2910, -2911}'); -- 8
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Instalaciones técnicas, y otro inmovilizado material.',
'{+212, +213, +214, +215, +216, +217, +218, +219, -2812, -2813, -2814, -2815, -2816, -2817, -2818, -2819, -2912, -2913, -2914, -2915, -2916, -2917, -2918, -2919}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (2, 'Inmovilizado en curso y anticipos.','{+23}');

-- III. Inversiones inmobiliarias.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (3, 'Terrenos.','{+220, -2920}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (3, 'Construcciones.','{+221, 282, -2921}');

-- IV. Inversiones en empresas del grupo y asociadas a largo plazo.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Instrumentos de patrimonio.','{+2403, +2404, -2493, -2494, -2933, -2934}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Créditos a empresas','{+2423, +2424, -2953, -2954}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Valores representativos de deuda','{+2413, +2414, -2943, -2944}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Derivados','{+255}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Otros activos financieros','{+258, +26}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (4, 'Otras inversiones','{+257}');

-- V. Inversiones financieras a largo plazo.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Instrumentos de patrimonio','{+2405, -2495, -2935, +250, -259}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Créditos a terceros','{+2425, +252, +253, +254, -2955, -298}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Valores representativos de deuda','{+2415, +251, -2945, -297}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Derivados','{+255}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Otros activos financieros','{+257, +258, +26}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (5, 'Otras inversiones','{}');

-- VI. Activos por impuesto diferido.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (6, 'Activos por impuesto diferido','{+474}');

-- VII. Deudores comerciales no corrientes. 
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (7, 'Deudores comerciales no corrientes','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (7, 'Deudores comerciales no corrientes, empresas del grupo y asociadas','{}');


-- ********************
-- ACTIVO CORRIENTE
-- ********************

-- 'I. Activos no corrientes mantenidos para la venta.'

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (8, 'I. Activos no corrientes mantenidos para la venta.','{+580,+581,+582,+583,+584,-599}');

--'II. Existencias.' 499, 529
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Comerciales.','{+30, -390}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Materias primas y otros aprovisionamientos.','{+31, +32, -391, -392}');

--'Productos en curso.'     ******************************************************************************************************
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo largo de producción.','{+3301,+3311,+3401,+3411,-3931,-3941}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo corto de producción.','{+3300,+3310,+3400,+3410,-3930,-3940}');

-- 4. Productos terminados.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo largo de producción.','{+3501,+3511,-3951}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'De ciclo corto de producción.','{+3500,+3510,-3950}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Subproductos, residuos y materiales recuperados.','{+36,-396}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Anticipos a proveedores.','{+4070,+4073,+4074,+4077}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (9, 'Anticipos a proveedores, empresas del grupo y asociadas.','{+4071,+4072,+4075,+4076}');


--'III. Deudores comerciales y otras cuentas a cobrar.'
--1. Clientes por ventas y prestaciones de servicios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes por ventas y prestaciones de servicios a largo plazo.',
'{+4302,+4303,+4316,+4317,+4318,+4319,+4321,+43501,+43511,+43521,+43541,+43571,-4371 }');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes por ventas y prestaciones de servicios a corto plazo.',
'{+4300,+4304,+4309,+4310,+4311,+4312,+4315,+4320,+4350,+4351,+43520,+43540,+4356,+43570,+4359,+4360,-4370,-490,-4935}');

--2. Clientes, empresas del grupo y asociadas.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes, empresas del grupo y asociadas a largo plazo.',
        '{+43301,+43311,+43321,+43341,+43371,+43401,+43411,+43421,+43441,+43471}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Clientes, empresas del grupo y asociadas a corto plazo.',
        '{+43300,+43310,+43320,+43340,+4336,+43370,+4339,+43400,+43410,+43420,+43440,+4346,+43470,+4349,-4933,-4934}');

--3. Deudores varios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Deudores varios.','{+440,+441,+444,+446,+449,+5531,+5533,+554}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Deudores varios, empresas del grupo y asociadas.','{+442,+443}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Personal.','{+460,+544}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Activos por impuesto corriente.','{+4703,+4709,+473}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Otros créditos con las Administraciones Públicas.','{+4700,+4701,+4702,+4707,+4708,+471,+472}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (10, 'Accionistas (socios) por desembolsos exigidos ','{+5580,+5581}');



--'IV. Inversiones en empresas del grupo y asociadas a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Instrumentos de patrimonio.','{+5303,+5304,-5393,-5394,-5933,-5934}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Créditos a empresas.','{+5323,+5324,+5343,+5344,-5953,-5954}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Valores representativos de deuda.','{+5313,+5314,+5333,+5334,-5943,-5944}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Derivados.','{+5353,+5354,+5523,+5524}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Otros activos financieros.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (11, 'Otras inversiones.','{}');

--'V. Inversiones financieras a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Instrumentos de patrimonio.','{+5305,+540,-5395,-549}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Créditos a empresas.',
    '{+5325,+5345,+542,+543,+547,-5955,-598,+5315,+5335,+541,+546,-5935,-5945,-597}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Valores representativos de deuda.','{+5590,+5593}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Derivados.','{+5355,+545,+548,+551,+5525,+565,+566}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Otros activos financieros.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (12, 'Otras inversiones.','{}');

--'VI. Periodificaciones a corto plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (13, 'Periodificaciones a corto plazo.','{+480,+567}');


--'VII. Efectivo y otros activos líquidos equivalentes.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (14, 'Tesorería.','{+570,+571,+572,+573,+574,+575}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (14, 'Otros activos líquidos equivalentes.','{+576}');

-- TOTAL ACTIVO (A + B)

-- ********************
-- PATRIMONIO NETO
-- ********************
-- A-1) Fondos propios.

--'I. Capital.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (15, 'Capital escriturado.','{+100,+101,+102}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (15, '(Capital no exigido)','{-1030,-1040}');

--'II. Prima de emisión.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (16, 'Prima de emisión.','{+110}');

--'III. Reservas.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (17, 'Legal y estatutarias.','{+112,+1141}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (17, 'Otras reservas.','{+113,+1140,+1142,+1143,+1144,+1145,+115,+119}');

--'IV. (Acciones y participaciones en patrimonio propias).');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (18, '(Acciones y participaciones en patrimonio propias).','{-108,-109}');

--'V. Resultados de ejercicios anteriores.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (19, 'Remanente.','{+120}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (19, '(Resultados negativos de ejercicios anteriores).','{-121}');

--'VI. Otras aportaciones de socios.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (20, 'Otras aportaciones de socios.','{+118,+550}');

--'VII. Resultado del ejercicio.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (21, 'Resultado del ejercicio.','{+129}');

--'VIII. (Dividendo a cuenta).');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (22, '(Dividendo a cuenta).','{-557}');

--'IX. Otros instrumentos de patrimonio neto.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (23, 'Otros instrumentos de patrimonio neto.','{+111}');

-- A-2) Ajustes por cambios de valor.

--'I. Activos financieros disponibles para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (24, 'Activos financieros disponibles para la venta.','{+133}');
--'II. Operaciones de cobertura.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (25, 'Operaciones de cobertura.','{+1340,+1341}');
--'III. Activos no corrientes y pasivos vinculados, mantenidos para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (26, 'Activos no corrientes y pasivos vinculados, mantenidos para la venta.','{+136}');
--'IV. Diferencia de conversión.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (27, 'Diferencia de conversión.','{+135}');
--'V. Otros');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (28, 'Otros','{+137}');

-- A-3) Subvenciones, donaciones y legados recibidos.

--'A-3) Subvenciones, donaciones y legados recibidos.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (29, 'Subvenciones, donaciones y legados recibidos.','{+130,+131,+132}');




-- ********************
-- B) PASIVO NO CORRIENTE
-- ********************

--'I. Provisiones a largo plazo.'
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Obligaciones por prestaciones a largo plazo al personal.','{+140}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Actuaciones medioambientales.','{+145}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Provisiones por reestructuración.','{+146}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (30, 'Otras provisiones.','{+141,+142,+143,+147}');

--'II Deudas a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Obligaciones y otros valores negociables.','{+177,+178,+179}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Deudas con entidades de crédito.','{+1605,+170}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Acreedores por arrendamiento financiero.','{+1625,+174}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Derivados.','{+176}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (31, 'Otros pasivos financieros.',
       '{+1615,+1635,+171,+172,+173,+175,+180,+185,+189,+1645,+1655,+1665,+1675,+1685,+16905,+16915,+16955,+16995}');

--'III. Deudas con empresas del grupo y asociadas a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (32, 'Deudas con empresas del grupo y asociadas a largo plazo.',
'{+1603,+1604,+1613,+1614,+1623,+1624,+1633,+1634,+1643,+1644,+1653,+1654,+1663,+1664,+1673,+1674,+1683,+1684,+16903,+16904,+16913,+16914,+16953,+16954,+16993,+16994}');

--'IV. Pasivos por impuesto diferido.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (33, 'Pasivos por impuesto diferido.','{+479}');

--'V. Periodificaciones a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (34, 'Periodificaciones a largo plazo.','{+1810,+1815}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (34, 'Periodificaciones a largo plazo, empresas del grupo y asociadas.','{+1813,+1814}');

--'VI. Acreedores comerciales no corrientes.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (35, 'Acreedores comerciales no corrientes.','{}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (35, 'Acreedores comerciales no corrientes, empresas del grupo y asociadas.','{}');
--'VII. Deuda con características especiales a largo plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (36, 'Deuda con características especiales a largo plazo.','{-15,-5585}');

-- ********************
-- C) PASIVO CORRIENTE
-- ********************

--'I. Pasivos vinculados con activos no corrientes mantenidos para la venta.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (37, 'Pasivos vinculados con activos no corrientes mantenidos para la venta.','{+585,+586,+587,+588,+589}');
--'II. Provisiones a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (38, 'Provisiones a corto plazo.','{+499,+529}');
--'III. Deudas a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Obligaciones y otros valores negociables.','{+500,+501,+505,+506}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Deudas con entidades de crédito.','{+5105,+520,+527}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Acreedores por arrendamiento financiero.','{+5125,+524}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Derivados.','{+5595,+5598}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (39, 'Otros pasivos financieros.','{-1034, -1044, -190,-1920,-1925,+194,+509,+5115,+5135,+5145,+521,+522,+523,+525,+526,+528,+551,+5525,+5530,+5532,+555,+5565,+5566,+560,+561,+569}');

--'IV. Deudas con empresas del grupo y asociadas a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (40, 'Deudas con empresas del grupo y asociadas a corto plazo.',
'{-1923,-1924,+5103,+5104,+5113,+5114,+5123,+5124,+5133,+5134,+5143,+5144,+5523,+5524,+5563,+5564}');

--'V. Acreedores comerciales y otras cuentas a pagar.');
--1. Proveedores.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores a largo plazo.','{+4002,+4003,+4011,+4052,+4053,-4061}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores a corto plazo.','{+4000,+4004,+4009,+4010,+4050,+4051,+4054,+4056,+4059,-4060}');

--2. Proveedores, empresas del grupo y asociadas.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores, empresas del grupo y asociadas a largo plazo.','{+4032,+4033,+4042,+4043}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Proveedores, empresas del grupo y asociadas a corto plazo.','{+4030,+4031,+4034,+4036,+4039,+4040,+4041,+4044,+4046,+4049}');

--3. Acreedores varios.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Acreedores varios.','{+410,+411,+414,+419,+554}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Acreedores varios, empresas del grupo y asociadas.','{+412,+413}');

INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Personal (remuneraciones pendientes de pago).','{+465,+466}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Pasivos por impuesto corriente.','{+4752,+4755}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Otras deudas con las Administraciones Públicas.','{+4750,+4751,+4758,+476,+477,+4753,+4754,+4756,+4757,+4759}');

--7. Anticipos de clientes.
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Anticipos de clientes.','{+4380,+4383}');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (41, 'Anticipos de clientes, empresas del grupo y asociadas.','{+4381,+4382}');

--'VI. Periodificaciones a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (42, 'Periodificaciones a corto plazo.','{+485,+568}');
--'VII. Deuda con características especiales a corto plazo.');
INSERT INTO ApartadoSeccionBalance (id_SeccionBalance,Apartado,grupo_cuentas) 
    VALUES (43, 'Deuda con características especiales a corto plazo.','{-195,-197,+199,+502,+507}');



-- *****************************************************************************
--                      Informe de Perdidas y Ganancias
-- *****************************************************************************

CREATE TABLE PerdidasGanancias
(
    id              serial NOT NULL,
    Tipo            varchar(10),
    primary key (id)
);

INSERT INTO PerdidasGanancias (Tipo) VALUES ('Normal');
INSERT INTO PerdidasGanancias (Tipo) VALUES ('Abreviada');


--
-- Secciones del informe
--
CREATE TABLE SeccionPyG
(
    id                  serial NOT NULL,
    id_pyg              integer references PerdidasGanancias(id),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',
    Seccion             varchar(150),
    grupo_cuentas       text[],
    primary key (id)
);

create index SeccionPyG_Seccion on SeccionPyG(Seccion);



--
-- Cuenta de Perdidas y Ganancias del ejercicio en curso
--

CREATE TABLE tmp_ResultPyG
(
    id                  serial NOT NULL,
    usuario             varchar(90),
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    id_SeccionPyG       integer references SeccionPyG(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)

);


--
-- Cuenta de Perdidas y Ganancias consolidados, años cerrados.
--
CREATE TABLE HistoricoPyG
(
    id                  serial NOT NULL,
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    id_SeccionPyG       integer references SeccionPyG(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)
);


-- ***************************************************************************
--                  Modelo Normal
-- ***************************************************************************

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'1. Importe neto de la cifra de negocios.',
    '{+700, +701, +702, +703, +704, +705, -706, -708, -709}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'2. Variación de existencias de productos terminados y en curso de fabricación.',
    '{-6930, 71, +7930}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'3. Trabajos realizados por la empresa para su activo.',
    '{+73}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'4. Aprovisionamientos.',
    '{-600, -601, -602, +606, -607, +608, +609, 61, -6931,-6932, -6933, +7931, +7932, +7933}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'5. Otros ingresos de explotación.',
    '{+74000, +74700, +75}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'6. Gastos de personal.',
    '{ -64, +7950, +7957}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'7. Otros gastos de explotación.',
    '{-62, -631, -634, +636, +639, -65, -694, -695, +794, +7954}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'8. Amortización del inmovilizado.',
    '{-68}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'9. Imputación de subvenciones de inmovilizado no financiero y otras.',
    '{+74600}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'10. Excesos de provisiones.',
    '{+7951, +7952, +7955, +7956 }');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'11. Deterioro y resultado por enajenaciones del inmovilizado.',
    '{-670, -671, -672, -690, -691, -692, +770, +771, +772, +790, +791, +792}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'12. Diferencia negativa de combinaciones de negocios.',
    '{+774}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'13. Otros resultados.',
    '{-678, +778}');

-- *****************************************
-- OPERATING INCOME RESULTADO DE EXPLOTACION
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) VALUES ('OPERATING INCOME',
    1,'A) RESULTADO DE EXPLOTACION (1+2+3+4+5+6+7+8+9+10+11+12+13).', '{}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'14. Ingresos financieros.', '{}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'a) Imputación de subvenciones,donaciones y legados de carácter financiero.',
    '{+74001, +74601, +74701}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'b) Otros ingresos financieros.',
    '{ +760, +761, +762, +767, +769}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'15. Gastos financieros.',
    '{-660, -661, -662, -664, -665, -669}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'16. Variación de valor razonable en instrumentos financieros.',
    '{-663, +763}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'17. Diferencias de cambio.',
    '{-668, +768}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'18. Deterioro y resultado por enajenaciones de instrumentos financieros.',
    '{-666, -667, -673, -675, -696, -697, -698, -699, +766, +773, +775, +796, +797, +798, +799}');

-- **********************
-- RESULTADOS FINANCIEROS
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('FINANCIAL RESULTS',1,'B) RESULTADO FINANCIERO (14+15+16+17+18)', '{}');

-- ****************************************
-- beneficio antes de intereses e impuestos
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('EBITDA',1,'C) RESULTADO ANTES DE IMPUESTOS (A+B)', '{}');


INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (1,'19. Impuestos sobre beneficios.',
    '{-6300, 6301, -633, +638}');

-- ***********************
-- RESULTADO DEL EJERCICIO
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('PROFIT',1,'D) RESULTADO DEL EJERCICIO (C + 19)', '{}');






-- ***************************************************************************
--                  Modelo Abreviado
-- ***************************************************************************

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'1. Importe neto de la cifra de negocios.',
    '{+700, +701, +702, +703, +704, +705, -706, -708, -709}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'2. Variación de existencias de productos terminados y en curso de fabricación.',
    '{-6930, 71, +7930}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'3. Trabajos realizados por la empresa para su activo.',
    '{+73}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'4. Aprovisionamientos.',
    '{-600, -601, -602, +606, -607, +608, +609, 61, -6931,-6932, -6933, +7931, +7932, +7933}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'5. Otros ingresos de explotación.',
    '{+74000, +74700, +75}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'6. Gastos de personal.',
    '{ -64, +7950, +7957}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'7. Otros gastos de explotación.',
    '{-62, -631, -634, +636, +639, -65, -694, -695, +794, +7954}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'8. Amortización del inmovilizado.',
    '{-68}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'9. Imputación de subvenciones de inmovilizado no financiero y otras.',
    '{+74600}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'10. Excesos de provisiones.',
    '{+7951, +7952, +7955, +7956 }');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'11. Deterioro y resultado por enajenaciones del inmovilizado.',
    '{-670, -671, -672, -690, -691, -692, +770, +771, +772, +790, +791, +792}');


-- *****************************************
-- OPERATING INCOME RESULTADO DE EXPLOTACION
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) VALUES ('OPERATING INCOME',
    2,'A) RESULTADO DE EXPLOTACION (1+2+3+4+5+6+7+8+9+10+11).', '{}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'12. Ingresos financieros.', '{}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'13. Gastos financieros.',
    '{-660, -661, -662, -664, -665, -669}');

INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'14. Variación de valor razonable en instrumentos financieros.',
    '{-663, +763}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'15. Diferencias de cambio.',
    '{-668, +768}');
INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'16. Deterioro y resultado por enajenaciones de instrumentos financieros.',
    '{-666, -667, -673, -675, -696, -697, -698, -699, +766, +773, +775, +796, +797, +798, +799}');

-- **********************
-- RESULTADOS FINANCIEROS
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('FINANCIAL RESULTS',2,'B) RESULTADO FINANCIERO (12+13+14+15+16)', '{}');

-- ****************************************
-- beneficio antes de intereses e impuestos
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('EBITDA',2,'C) RESULTADO ANTES DE IMPUESTOS (A+B)', '{}');


INSERT INTO SeccionPyG (id_pyg,Seccion,grupo_cuentas) VALUES (2,'17. Impuestos sobre beneficios.',
    '{-6300, 6301, -633, +638}');

-- ***********************
-- RESULTADO DEL EJERCICIO
INSERT INTO SeccionPyG (tipo_registro,id_pyg,Seccion,grupo_cuentas) 
    VALUES ('PROFIT',2,'D) RESULTADO DEL EJERCICIO (C + 17)', '{}');



-- *****************************************************************************
-- Informe de INGRESOS Y GASTOS RECONOCIDOS
-- *****************************************************************************

CREATE TABLE IGR
(
    id              serial NOT NULL,
    Tipo            varchar(10),
    primary key (id)
);

INSERT INTO IGR (Tipo) VALUES ('Normal');
INSERT INTO IGR (Tipo) VALUES ('Abreviada');


--
-- Secciones del informe
--
CREATE TABLE SeccionIGR
(
    id                  serial NOT NULL,
    id_IGR              integer references IGR(id),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',
    Seccion             varchar(150),
    grupo_cuentas       text[],
    primary key (id)
);

create index SeccionIGR_Seccion on SeccionIGR(Seccion);



--
-- Cuenta de Perdidas y Ganancias del ejercicio en curso
--

CREATE TABLE tmp_ResultIGR
(
    id                  serial NOT NULL,
    usuario             varchar(90),
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    id_SeccionIGR       integer references SeccionIGR(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)

);


--
-- Cuenta de Perdidas y Ganancias consolidados, años cerrados.
--
CREATE TABLE HistoricoIGR
(
    id                  serial NOT NULL,
    year_fiscal         varchar(4),
    tipo_registro       varchar(25) DEFAULT 'DETALLE',  -- DETALLE, OPERATING INCOME, EBITDA y PROFIT
    ID_SeccionIGR       integer references SeccionIGR(ID),
    Seccion             varchar(150),
    Importe             numeric(12,2) default 0,
    Importe_prev        numeric(12,2) default 0,
    primary key (id)
);


--
-- NORMAL
--

-- A) Resultado de la cuenta de pérdidas y ganancias.
INSERT INTO SeccionIGR (tipo_registro,id_IGR,Seccion,grupo_cuentas) 
    VALUES ('PROFIT',1,'A) Resultado de la cuenta de pérdidas y ganancias.',
    '{}');

--Ingresos y gastos imputados directamente al patrimonio neto
INSERT INTO SeccionIGR (tipo_registro,id_IGR,Seccion,grupo_cuentas) 
    VALUES ('IGIDPN',1,'Ingresos y gastos imputados directamente al patrimonio neto',
    '{}');

--I. Por valoración instrumentos financieros.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'I. Por valoración instrumentos financieros.',
    '{-800, -89, +900, +991, +992}');

--1. Activos financieros disponibles para la venta.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'1. Activos financieros disponibles para la venta.',
    '{}');

--2. Otros ingresos/gastos.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'2. Otros ingresos/gastos.',
    '{}');

--II. Por coberturas de flujos de efectivo.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'II. Por coberturas de flujos de efectivo.',
    '{-810, -910}');

--III. Subvenciones, donaciones y legados recibidos.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'III. Subvenciones, donaciones y legados recibidos.',
    '{+94}');

--IV. Por ganancias y pérdidas actuariales y otros ajustes.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'IV. Por ganancias y pérdidas actuariales y otros ajustes.',
    '{-85, +95}');

--V. Por Activ. no corrientes y Pasiv. vinculados, mantenidos para la venta
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'V. Por Activ. no corrientes y Pasiv. vinculados, mantenidos para la venta',
    '{+860, +960}');

--VI. Diferencias de conversión
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'VI. Diferencias de conversión',
    '{+811, +820, +911, +920}');

--VII. Efecto impositivo.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'VII. Efecto impositivo.',
    '{-8300, +8301, -833, +834, +835, +838}');

--B) Total ingresos y gastos imputados directamente en el patrimonio neto (I+II+III+IV+V+VI+VII).
INSERT INTO SeccionIGR (tipo_registro,id_IGR,Seccion,grupo_cuentas) 
    VALUES ('TIGIDPN',1,'B) Total ingresos y gastos imputados directamente en el patrimonio neto (I+II+III+IV+V+VI+VII).',
    '{}');

--Transferencias a la cuenta de pérdidas y ganancias
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'Transferencias a la cuenta de pérdidas y ganancias',
    '{}');

--VIII. Por valoración de instrumentos financieros.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'VIII. Por valoración de instrumentos financieros.',
    '{-802, +902, +993, +994}');

--1. Activos financieros disponibles para la venta.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'1. Activos financieros disponibles para la venta.',
    '{}');

--2. Otros ingresos/gastos.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'2. Otros ingresos/gastos.',
    '{}');

--IX. Por coberturas de flujos de efectivo.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'IX. Por coberturas de flujos de efectivo.',
    '{-812, +912}');

--X. Subvenciones, donaciones y legados recibidos.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'X. Subvenciones, donaciones y legados recibidos.',
    '{-84}');

--XI. Por Activ. no corrientes y Pasiv. vinculados, mantenidos para la venta.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'XI. Por Activ. no corrientes y Pasiv. vinculados, mantenidos para la venta.',
    '{-862, +962}');

--XII. Diferencias de conversión
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'XII. Diferencias de conversión',
    '{-821, +921, -813, +913}');

--XIII. Efecto impositivo.
INSERT INTO SeccionIGR (id_IGR,Seccion,grupo_cuentas) 
    VALUES (1,'XIII. Efecto impositivo.',
    '{+8301, -836, -837}');

--C) Total transferencias a la cuenta de pérdidas y ganancias(VIII+IX+X+XI+XII+XIII)
INSERT INTO SeccionIGR (tipo_registro,id_IGR,Seccion,grupo_cuentas) 
    VALUES ('TTCPYG',1,'C) Total transferencias a la cuenta de pérdidas y ganancias(VIII+IX+X+XI+XII+XIII)',
    '{}');

--TOTAL DE INGRESOS Y GASTOS RECONOCIDOS (A + B + C) 
INSERT INTO SeccionIGR (tipo_registro,id_IGR,Seccion,grupo_cuentas) 
    VALUES ('TIGR',1,'TOTAL DE INGRESOS Y GASTOS RECONOCIDOS (A + B + C)',
    '{}');


-- **********************************************************************
--                              myHD
-- **********************************************************************

--
-- Tabla que custodia los documentos que se han generado fuera del sistema y son
-- incorporados por los usuarios.
--

CREATE TABLE doc_custodia (
    id serial  NOT NULL,
    id_user Integer,
    tipo    varchar(15) default 'clientes',--clientes | terceros | personal
    filename varchar(250),
    fecha TIMESTAMP default now(),
    hash_algo varchar(128), -- almacenar la representación del algoritmo en hexadecimal sha1 sha224/256/384/512
    url_nube  text,
    fichero bytea,
    PRIMARY KEY (id)
);

COMMENT ON TABLE doc_custodia IS 'Tabla que almacena los documentos, sus firmas y demas metadatos';
create index doc_custodia_FILENAME on doc_custodia(FILENAME);
create index doc_custodia_hash_algo on doc_custodia(hash_algo);


--
-- 
--

CREATE TABLE doc_compartir (
    id serial  NOT NULL,
    id_doc INTEGER references doc_custodia(id),
    id_personal_rrhh INTEGER,
    id_share        Integer, -- id del usuario al que se le comparte un docuemnto, hace referencia a un customer o a personal
    tipo_share    varchar(15) default 'clientes', --clientes | terceros | personal que indica el tipo de usuario de id_share
    n_lecturas INTEGER DEFAULT 0,
    PRIMARY KEY (id)
);

COMMENT ON TABLE doc_compartir IS 'Tabla que almacena los apuntes de quien puede ver los docuementos';

-- 
-- Carpetas de documentos, son vistas de lista de documentos asociadas 
-- a un nombre de carpeta, mediante el origen diferenciamos las carpetas en 
-- función de su origen de creación interno o externo.
--


CREATE TABLE CARPETA (
    ID              SERIAL not null,
    ID_USUARIO      INTEGER,
    tipo_usuario    varchar(15) default 'clientes',--clientes | terceros | personal que indica el tiepo de usaurio de id_share
    NOMBRE          varchar(100),
    FECHA TIMESTAMP default now(),
    origen  varchar(25) default 'system', -- system o external la carpeta es creada y utilizada por el sistema el usuario no la puede eliminar
    primary key(id)
);

--
-- relación de los documentos con sus carpetas
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


--
-- Crear una tabla que contiene una referencia a todos los documentos
--

CREATE TABLE doc_world (
    id 				serial NOT NULL,
    tipo    			varchar(15) default 'tabla', --tabla | proceso
    tabla_proceso_name          varchar(250),
    id_tabla_proceso		integer,
    numero_doc                  integer, -- para las tablas que tienen más de un campo bytea saber cual buscamos
    hash_algo    		varchar(128),
    PRIMARY KEY (id)
);
create index doc_world_tabla_proceso_name on doc_world(tabla_proceso_name);
create index doc_world_id_tabla_proceso on doc_world(id_tabla_proceso);
create index doc_world_hash_algo on doc_world(hash_algo);

--
-- Firmas y sellos de tiempo de un documento
--
CREATE TABLE firmas_doc_world (
    id 				serial NOT NULL,
    id_doc_world 		integer references doc_world(id),
    formato_firma		varchar(15) default 'PAdES_LTV',
    sello_tiempo		bytea,
    firma			bytea,
    PRIMARY KEY (id)
);
create index firmas_doc_world_id_doc_world on firmas_doc_world(id_doc_world);

--
-- Log de sesión de Terceros (de los clientes de nuestros clientes)
--
CREATE TABLE LogSesionTerceros
(
    id                  serial      NOT NULL,
    Fecha               TIMESTAMP default now(),
    ip                  varchar(20),
    hostname            varchar(90),
    mail                varchar(90),
    URI                 text,
    primary key (id)
);