
--
-- Crear una plantilla de cuentas a partir del plan general
--
CREATE OR REPLACE FUNCTION  CrearCuentasPlanGeneral()
returns void
AS
$body$
DECLARE

    xSumasPatrimonio numeric(8,2) :=0;

    curs4 CURSOR IS select operativa,concepto from cuadrocuentas where length (operativa) >=3 order by id;

    cCursor RECORD;

    xCuenta varchar(10);

    xCuantos integer;

BEGIN


    -- cursor de la tabla cuadrocuentas
    -- select subcuenta from cuadrocuentas where subcuenta is not null order by id
FOR cCursor IN curs4 LOOP

    if length(cCursor.operativa) = 3 then
        xCuenta := cCursor.operativa || '0000000';
    elseif length(cCursor.operativa) = 4 then
        xCuenta := cCursor.operativa || '000000';
    else
        xCuenta := cCursor.operativa || '00000';
    end if;

    select count(*) into xCuantos from Cuentas where cuenta = xCuenta;

    if xCuantos is null OR xCuantos = 0 then
        INSERT INTO Cuentas (CUENTA, CONCEPTO, year_fiscal) VALUES (xCuenta, substr(cCursor.concepto,1,120), '2013');
    end if;
    

END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/

--
-- Crear asientos de pruebas
--

CREATE OR REPLACE FUNCTION  CrearAsientosPruebas()
returns void
AS
$body$
DECLARE

    xSumasPatrimonio numeric(8,2) :=0;

    curs4 CURSOR IS select cuenta from cuentas order by cuenta;

    cCursor RECORD;

    xId integer;

BEGIN


    -- cursor de la tabla cuadrocuentas
    -- select subcuenta from cuadrocuentas where subcuenta is not null order by id
FOR cCursor IN curs4 LOOP

    

    WITH Apuntes_ins AS (
    INSERT INTO Apuntes (concepto,fecha,year_fiscal,trimestre) 
    VALUES ('Asiento de carga prueba de rendimiento',to_date('2013-09-13','YYYY-MM-DD'),
            EXTRACT(year FROM to_date('2013-09-13','YYYY-MM-DD')),EXTRACT(QUARTER FROM to_date('2013-09-13','YYYY-MM-DD'))
            )
    RETURNING ID
    )
    select id into xID from Apuntes_ins;

    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,cCursor.cuenta,'D',1500);
    INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,cCursor.cuenta,'H',1000);
    

END LOOP;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
SECURITY INVOKER
COST 100;
/




--// Cuentas que deben de existir inicialmente

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
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000021','Hacienda Pública, IVA repercutido 21%');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000010','Hacienda Pública, IVA repercutido 10%');
INSERT INTO Cuentas (cuenta,concepto) VALUES ('4770000004','Hacienda Pública, IVA repercutido 4%');

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
 
/





--
-- Consulta de movimientos del banco en el año x
--
SELECT sum(importe) as debe FROM Diario where cuenta='5720000034' and debe_haber='D' and
id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal='2013')

SELECT sum(importe) as haber FROM Diario where cuenta='5720000034' and debe_haber='H' and
id_apunte in (SELECT id FROM Apuntes WHERE year_fiscal='2013')


--
--
--
Saldo de una cuenta 

--
-- Pago de recibo de autónomos, se recomienda no hacerlo y quew lo pague el socio en su cuenta propia
-- ya que no es un gasto deducible
--
640x Debe sueldos y salarios en especie
476x Haber SS acreedora
475x Haber HP acreedora por retenciones
551x Habser cuenta correinte con socios y administradores

--
-- pago de nóminas
--
Salarios 	24.000
Cuota de seguridad social a cargo de la empresa 	8.000
Cuota de seguridad social retenida en nómina 	800
IRPF retenido en nóminas 	750
Líquido a abonar a los trabajadores 	22.450


Apunte
                                                        Debe                   Haber
640 	 Sueldos y salarios                             24.000 	 
 642 	 Seguridad Social a cargo de la empresa 	 8.000 	 
476 	Organismos de la Seguridad Social, acreedores (8.000+800) 	  	8.800
4751 	HP, acreedora por retenciones practicadas                                 750
465 	Remuneraciones pendientes de pago                                       22.450

 Al pago de las remuneraciones 
Cuenta 	Nombre                                      Debe 	Haber
465 	 Remuneraciones pendientes de pago          22.450 	 
 572 	 Banco                                                  22.450

 

 Al pago de los seguros sociales 
Cuenta 	Nombre                                          Debe 	Haber
476 	Organismos de la Seguridad Social, acreedores 	8.800 	 
572 	Banco                                                   8.800

 

Al pago de las retenciones de IRPF 
Cuenta 	Nombre                                          Debe 	Haber
 4751 	 HP, acreedora por retenciones practicadas 	 750 	 
572 	 Banco                                                  750


-- Al pago de los seguros sociales 

 SELECT importe INTO xImporte FROM Diario where id_apunte=xIDNomina and cuenta='4760000000';
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4760000000','D',xImporte);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);

-- Al pago de las retenciones de IRPF 

 SELECT importe INTO xImporte FROM Diario where id_apunte=xIDNomina and cuenta='4751000000';
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,'4751000000','D',xImporte);
 INSERT INTO Diario (id_apunte,cuenta,debe_haber,importe) VALUES (xId,xBanco,'H',xImporte);

--
-- Movimientos bancarios
--

SELECT a.id,a.concepto,a.fecha,a.year_fiscal,a.trimestre,d.id_apunte,d.cuenta,d.importe,d.debe_haber
    FROM Diario d, Apuntes a WHERE d.cuenta=xBanco 
        and a.id=d.id_apunte and a.year_fiscal in (select year_fiscal from datosper where id=1);


--
-- Suma del IRPF a pagar
--
-- suma total
select sum(importe) from diario d, apuntes a 
    where a.id=d.id_apunte 
    and d.cuenta like '475100000%' 
    and d.debe_haber='H' 
    and a.year_fiscal='2013' 
    and a.trimestre='3';

-- nominas
select sum(importe) from diario d, apuntes a 
    where a.id=d.id_apunte 
    and d.cuenta='4751000000' 
    and d.debe_haber='H' 
    and a.year_fiscal='2013' 
    and a.trimestre='3';

-- servicios profesionales
select sum(importe) from diario d, apuntes a 
    where a.id=d.id_apunte 
    and d.cuenta='4751000001' 
    and d.debe_haber='H' 
    and a.year_fiscal='2013' 
    and a.trimestre='3';

-- alquileres
select sum(importe) from diario d, apuntes a 
    where a.id=d.id_apunte 
    and d.cuenta='4751000002' 
    and d.debe_haber='H' 
    and a.year_fiscal='2013' 
    and a.trimestre='3';


--
-- recargo de equivalencia
--
/*
El recargo de equivalencia es un régimen especial de IVA, obligatorio para comerciantes minoristas que no realicen ningún tipo de 
transformación en los productos que venden, es decir, para comerciantes autónomos que vendan al cliente final. Se aplica tanto a 
personas físicas de alta en autónomos como a las comunidades de bienes.

No se aplica en actividades industriales, de servicios o en el comercio mayorista. Existen algunas actividades exentas entre las que 
destacan joyerías, peleterías, concesionarios de coches, venta de embarcaciones y aviones, objetos de arte, gasolineras y establecimiento 
de comercialización de maquinaria industrial o minerales.

Los autónomos que en un ejercicio facturen más del 20% de sus ventas a clientes profesionales y empresarios pueden liberarse de esta obligación 
y pasar al régimen normal de IVA siempre y cuando informen a Hacienda al respecto a final de año aportando justificantes sufieientes.

Los tipos del recargo de equivalencia aplicables a partir del 1 de
septiembre de 2012 son: 5,2%, 1,4%, 0,5% y 1,75% (Labores del Tabaco).

    El 5,2% para los artículos que tienen un IVA al tipo general del 21%.
    El 1,4% para los artículos que tienen un IVA al tipo reducido del 10%.
    El 0,5% para los artículos que tienen un IVA al tipo reducido del 4%.
    El 0,75% para el tabaco.
*/
--
-- El IVA
--
-- 4%,10% y 21% respectivamente

-- Los datos de IVA se extraen de la facturación al estar más detallados en la tabla row_bill

-- hay que diferenciar el IVA intracomunitario y extracomunitario

-- LOS IVAS 4%,10% y 21%
SELECT SUM(r.importe),r.por_vat FROM row_bill r, head_bill h 
WHERE h.id=r.id_bill and h.fiscal_year and h.trimestre
GROUP BY r.por_vat

-- LOS RECARGOS DE EQUIVALENCIA 5,2%, 1,4%, 0,5% y 1,75%
SELECT SUM(r.importe),r.por_req FROM row_bill r, head_bill h 
WHERE h.id=r.id_bill and h.fiscal_year and h.trimestre
GROUP BY r.por_req

--
-- pasar una consulta a un array en formato JSON
--
select array_to_json(array_agg(row_bill)) from row_bill


SELECT CalculoIRPF('2013','3')
SELECT SumaIRPFCuentaPeriodo('4751000000','2013','3')


SELECT SumaIRPFPeriodo('2013','3')
SELECT SumaVentasPeriodo('2013','3')
SELECT SumaComprasPeriodo('2013','3')
SELECT SumaVentasYear('2013')
SELECT SumaComprasYear('2013')


alter TABLE CuadroCuentas drop column operativa
alter TABLE CuadroCuentas add column operativa varchar(10)
--update cuadrocuentas set grupo=left(nivel5,1),subgrupo=left(nivel5,2),cuenta=left(nivel5,3),subcuenta=left(nivel5,4) where nivel5 is not null
--update cuadrocuentas set grupo=left(subcuenta,1),subgrupo=left(subcuenta,2),cuenta=left(subcuenta,3) where subcuenta is not null
--update cuadrocuentas set grupo=left(cuenta,1),subgrupo=left(cuenta,2) where cuenta is not null and subgrupo is null
--update cuadrocuentas set grupo=left(subgrupo,1) where subgrupo is not null and grupo is null

select grupo,subgrupo,cuenta,subcuenta,nivel5,concepto from cuadrocuentas order by id

alter TABLE Cuentas add column year_fiscal varchar(4)
alter TABLE Cuentas alter column year_fiscal set default EXTRACT(year FROM now())



alter TABLE Apuntes add column reglas      json;
alter TABLE Apuntes drop column reglas;
alter TABLE Apuntes add column reglas text;

