

UPDATE PersonalRRHH SET Nombre='Roberto Jódar Lozano', cargo='gerencia',
            email='loexisasesores@gmail.com' where id=1;

INSERT INTO PersonalRRHH (tipo,nombre,email,cargo,certificado) 
    VALUES ('empleado','Francisco Jódar Lozano','franjodar@loexisasesore.es','Departamento Contable',
    pg_read_binary_file('24.p12'));

INSERT INTO PersonalRRHH (tipo,nombre,email,cargo,certificado) 
    VALUES ('empleado','Ruth Porras Gallegos','laboral@loexisasesores.es','Departamento Laboral',
    pg_read_binary_file('25.p12'));

INSERT INTO PersonalRRHH (tipo,nombre,email,cargo,certificado) 
    VALUES ('empleado','Manuel Molina Estévez','financiero@loexisasesores.es','Departamento Fiscal',
    pg_read_binary_file('26.p12'));


UPDATE datosper SET tipo_de_cuenta=4, forma_juridica='SL',url_web='http://www.loexisasesores.es';