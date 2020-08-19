
--
--
--
-- Vista con los totales agrupados por tipo de IVA

create or replace view total_bill (base,iva, id_bill) 
as select sum((importe-((importe*por_dto)/100))*unidades), por_vat, id_bill from row_bill
group by por_vat,id_bill;


-- Total a pagar
create or replace view total_a_pagar (total, id_bill) as 
select sum(((importe - getdto(importe,por_dto)) * unidades) + getiva(importe-getdto(importe,por_dto), por_vat)) as total,id_bill from row_bill
group by id_bill;

create or replace view vwhead_bill (id,id_cliente,fecha,fecha_vencimiento,fecha_apremio,numero,global_dto,nif,nombre,direccion,objeto,poblacion,movil,mail,
    estado,total,id_customers_type,fiscal_year,trimestre, remesa, fecha_mandato, iban , bic, Pais_ISO3166) 
as select h.id,h.id_cliente,h.fecha,h.fecha_vencimiento,h.fecha_apremio,h.numero,h.global_dto,c.nif,c.nombre,c.direccion,c.objeto,c.poblacion,c.movil,c.mail,
    h.estado,t.total,c.id_customers_type,h.fiscal_year,h.trimestre,h.id_remesa, c.fecha_orden_sepa,
    c.iban , c.bic, c.Pais_ISO3166
from head_bill h, customers c, datosper d, total_a_pagar t where h.id_cliente=c.id and d.id=1 and t.id_bill=h.id
order by h.id;



-- Total a pagar en facturas recibidas
create or replace view total_a_pagar_emi (total, id_inre) as 
select sum(((importe - getdto(importe,por_dto)) * unidades) + getiva(importe-getdto(importe,por_dto), por_vat)) as total,id_inre 
	from row_invoices_received
	group by id_inre;

create or replace view vw_recibidas (id,id_proveedor,id_suppliers_type,tipo_tercero,forma_pago,fecha,fecha_vencimiento,fecha_pago,fiscal_year,total,estado,trimestre,nombre,nif)
as select i.id,i.id_proveedor,s.id_suppliers_type, st.descripcion ,i.forma_pago,i.fecha,i.fecha_vencimiento,i.fecha_pago,i.fiscal_year,
	t.total, i.estado, i.trimestre,
	s.nombre,s.nif
	From invoices_received i, suppliers s, row_invoices_received r, total_a_pagar_emi t, suppliers_type st
	where i.id_proveedor=s.id
	and st.id = s.id_suppliers_type
	and r.id_inre=i.id
	and t.id_inre=i.id;

create or replace view total_recibidas (base,iva, id_inre) 
as select sum((importe-((importe*por_dto)/100))*unidades), por_vat, id_inre from row_invoices_received
group by por_vat,id_inre;


--
-- Vista vwApartadoSeccionBalance
--
create or replace view vwApartadoSeccionBalance (IDApartado,Norma,Seccion,Apartado,grupo_cuentas) AS
SELECT A.id, B.Norma, S.Seccion, A.Apartado, A.grupo_cuentas 
    FROM Balance B, SeccionBalance S, ApartadoSeccionBalance A
    WHERE B.id = S.id_balance AND S.id = A.id_SeccionBalance;


--
--
--

-- Vista de saldo de cuentas
create or replace view PlanCuentaSaldos (cuenta,concepto,debe,haber,saldo,year_fiscal) AS
SELECT C.cuenta,C.concepto,getCuentaDebe(C.cuenta) as debe,getCuentaHaber(C.cuenta) as haber,
getCuentaDebe(C.cuenta)-getCuentaHaber(C.cuenta) as saldo, C.year_fiscal
FROM Cuentas C;



--
-- Vista de Salarios
--
create or replace view Salarios (cuenta, concepto, fecha, year_fiscal,periodo,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '640%' and d.cuenta=c.cuenta and d.id_apunte=a.id;



--
-- Vista de la cuenta de la Seguridad Social
--
create or replace view SeguridadSocial (cuenta, concepto, fecha, year_fiscal,periodo,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '476%' and d.cuenta=c.cuenta and d.id_apunte=a.id;



--
-- Vista de la cuenta de la Hacienda IRPF trabajadores y profesionales
-- 'IRPF-111+216+115'
--
create or replace view IRPF (cuenta, concepto, fecha, year_fiscal,trimestre,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '4751%' and d.cuenta=c.cuenta and d.id_apunte=a.id;


--
-- Vista de la cuenta del IVA 
--
create or replace view IVA (cuenta, concepto, fecha, year_fiscal,trimestre,importe,debe_haber,id) as
select c.cuenta, a.concepto, a.fecha, a.year_fiscal,a.periodo,d.importe,d.debe_haber,a.id
from cuentas c, Apuntes a, Diario d 
where c.cuenta like '477%' and d.cuenta=c.cuenta and d.id_apunte=a.id;

--
-- lista de clientes por cifra de negocio
--
create or replace view ClientesCifraNegocio (id, total) as 
select id_cliente,sum(total) as total from head_bill, total_a_pagar 
    where total_a_pagar.id_bill=head_bill.id
    group by id_cliente
    order by sum(total) desc;

--
-- lista de clientes por pendiente de cobro
--
create or replace view ClientesPendiente (id, total) as 
select id_cliente,sum(total) as total from head_bill, total_a_pagar 
    where total_a_pagar.id_bill=head_bill.id and estado='PENDIENTE'
    group by id_cliente
    order by sum(total) desc;


-- Total a pagar para facturas pro forma
create or replace view total_a_pagar_proforma (total, id_head_budgetbill) as 
select sum(((importe - getdto(importe,por_dto)) * unidades) + getiva(importe-getdto(importe,por_dto), por_vat)) as total,id_head_budgetbill 
from row_budgetbill
group by id_head_budgetbill;

--
-- Facturas pro forma
--

create or replace view vwhead_proforma (id,id_cliente,fecha,numero,nif,nombre,direccion,objeto,poblacion,movil,mail,
    total,id_customers_type,fecha_mandato, iban , bic, Pais_ISO3166) 
as select h.id,h.id_cliente,h.fecha,h.numero,c.nif,c.nombre,c.direccion,c.objeto,c.poblacion,c.movil,c.mail,
    t.total,c.id_customers_type,c.fecha_orden_sepa,c.iban , c.bic, c.Pais_ISO3166
from head_budgetbill h, customers c, datosper d, total_a_pagar_proforma t 
where h.id_cliente=c.id and d.id=1 and t.id_head_budgetbill=h.id
order by h.id;


create or replace view total_proforma (base,iva, id_head_budgetbill) 
as select sum((importe-((importe*por_dto)/100))*unidades), por_vat, id_head_budgetbill from row_budgetbill
group by por_vat,id_head_budgetbill;