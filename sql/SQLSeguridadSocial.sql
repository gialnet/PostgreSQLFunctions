
--
-- Calculos de la seguridad social de una nómina
--

/*
Cuota

Las cantidades a ingresar a la Seguridad Social, llamadas cuotas, se calculan 
aplicando a la base de cotización del trabajador el porcentaje o tipo de 
cotización que corresponde a cada contingencia protegida.
Base de cotización

La base de cotización se calcula añadiendo a las retribuciones mensuales que 
tenga derecho a percibir el trabajador, o que realmente perciba, de ser éstas 
superiores, la parte proporcional de las pagas extraordinarias y las demás 
percepciones de vencimiento superior al mensual o que no tengan carácter 
periódico y se satisfagan en el ejercicio.

Base de cotización, mínimas y máximas

Anualmente se establecen bases de cotización (mensuales o diarias) mínimas y 
máximas para las distintas contingencias y categorías profesionales de los 
trabajadores (grupos de cotización). Para el año 2013 ver  
Bases de Cotización. 
La base de accidentes de trabajo y enfermedades profesionales también se 
utiliza para calcular las cotizaciones por Desempleo, Fondo de Garantía 
Salarial y Formación Profesional. 

Concepto                Empresa 	Trabajador 	Total
Contingencias comunes 	23,6                4,7 	28,3
Accidentes de trabajo y enfermedades profesionales 	
Tarifa Primas Disposición adicional cuarta , Ley 42/2006 de 28 de diciembre - 
P.G.E. 2007, en redacción dada por la disposición final décima séptima de la 
Ley 17/2012, de 27 de diciembre - P.G.E. para el 2013. 	No cotiza

*/

/*

En cuanto a las percepciones no salariales (plus de transportes, dietas) 
no cotizan a la seguridad social, ni por la empresa, ni por el trabajador. 

*/

CREATE TABLE Conceptos_cotizacion
(
    id          serial NOT NULL,
    concepto    varchar(90),
    empresa     numeric(4,2),
    trabajador  numeric(4,2),
    primary key (id)
);


INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) VALUES ('Contingencias comunes', 23.6, 4.7);
INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) VALUES ('Accidentes de trabajo y enfermedades profesionales', 0, 0);

INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) VALUES ('Desempleo Tipo General', 5.5, 1.55);
INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) 
    VALUES ('Desempleo Contrato duración determinada Tiempo completo', 6.7, 1.6);

INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) 
    VALUES ('Desempleo Contrato duración determinada Tiempo parcial', 7.7, 1.6);

INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) 
    VALUES ('Fondo de Garantía Salarial', 0.2, 0);

INSERT INTO Conceptos_cotizacion (CONCEPTO, EMPRESA, TRABAJADOR) 
    VALUES ('Formación Profesional', 0.6, 0.1);



CREATE TABLE CategoriasProfesionales
(
    grupo_cotizacion        serial NOT NULL,
    categoria               varchar(90),
    base_minima             numeric(4,2),
    base_maxima             numeric(4,2),
    primary key (id)
);

-- EUROS/MES
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(1,'Ingenieros y Licenciados.Personal de alta dirección no incluido en el artículo 1.3.c) del Estatuto de los Trabajadores',1051.50, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(2,'Ingenieros Técnicos, Peritos y Ayudantes Titulados', 872.10, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(3,'Jefes Administrativos y de Taller',758.70, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(4,'Ayudantes no Titulados ',753, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(5,'Oficiales Administrativos',753, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(6,'Subalternos',753, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(7,'Auxiliares Administrativos',753, 3425.70);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
-- EUROS/DÍA
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(8,'Oficiales de primera y segunda', 25.10 , 114.19);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(9,'Oficiales de tercera y Especialistas', 25.10 , 114.19);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(10,'Peones', 25.10 , 114.19);
INSERT INTO CategoriasProfesionales (grupo_cotizacion,CATEGORIA, BASE_MINIMA, BASE_MAXIMA) VALUES
(11,'Trabajadores menores de dieciocho años, cualquiera que sea su categoría profesional', 25.10 , 114.19);



/*

COTIZACIÓN POR CONTRATOS PARA LA FORMACIÓN : Concepto 	Empresa 	Trabajador 	Total
Por Contingencias Comunes                                  30,52€           6,09 € 	36,61 €
Por Accidentes de Trabajo y Enfermedades Profesionales 	IT: 2,35 €
                                                        IMS:1,85 €                      4,20 €
Desempleo (*)                                               41,42 €         11,67 € 	53,09 €
Fondo de Garantía Salarial                                  2,32 €                      2,32 €
Formación Profesional                                       1,12 €          0,15 € 	1,27 €

*/

CREATE TABLE CategoriasProfesionales
(
    codigo_CNAE             varchar(10),
    CNAE                    varchar(90),
    it                      numeric(4,2),
    ims                     numeric(4,2),
    primary key (codigo_CNAE)
);
