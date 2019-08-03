﻿CREATE TABLE ESTUDIANTE (
NOESTUDIANTE        INT NOT NULL,
NOMBRE       	   	CHAR(20),   
APELLIDO         	CHAR(20),
SEXO 	           	CHAR,
FNACIMIENTO         DATE,  
ALERGIA            	CHAR(20),
NOCASA              INT,
DIALAVADO           CHAR(9)
);

ALTER TABLE ESTUDIANTE
ADD CONSTRAINT ESTUD_PK PRIMARY KEY (NOESTUDIANTE);

CREATE TABLE CASA(
NOCASA              INT NOT NULL,
TIPO                CHAR(8),
CAPACIDAD           INT,
NOCUARTOS           INT,
TERMINADOLIMPIEZA   NUMBER(1)
);

ALTER TABLE CASA
ADD CONSTRAINT CASA_PK PRIMARY KEY (NOCASA);

CREATE TABLE CUARTO(
NOCUARTO            INT NOT NULL,
NOCASA              INT NOT NULL,
CAPACIDAD           INT,
TIENEBANO           NUMBER(1)
);

ALTER TABLE CUARTO
ADD CONSTRAINT CUARTO_PK PRIMARY KEY (NOCUARTO, NOCASA);

ALTER TABLE CUARTO
ADD CONSTRAINT CUARTO_FK FOREIGN KEY (NOCASA) REFERENCES CASA(NOCASA) ON DELETE CASCADE;

ALTER TABLE ESTUDIANTE
ADD CONSTRAINT ESTUD_FK_ONE FOREIGN KEY (NOCASA) REFERENCES CASA(NOCASA);

CREATE TABLE MENUDIARIO(
FECHA               DATE NOT NULL,
DESAYUNO            CHAR(20),
COMIDA              CHAR(20),
CENA                CHAR(20)
);

ALTER TABLE MENUDIARIO
ADD CONSTRAINT MENU_PK PRIMARY KEY (FECHA);

CREATE TABLE PLATILLO(
NOMPLATILLO         CHAR(20) NOT NULL,
INGREDIENTES        VARCHAR(50)
);

ALTER TABLE PLATILLO
ADD CONSTRAINT PLATILLO_PK PRIMARY KEY (NOMPLATILLO);

CREATE TABLE TRABAJADOR(
WORKERID            INT NOT NULL,
NOMWORKER           CHAR(20),
APWORKER            CHAR(20),
FNAC                DATE,
SUELDO              INT,
CASALIMPIAR         INT
);

ALTER TABLE TRABAJADOR
ADD CONSTRAINT WORKER_PK PRIMARY KEY (WORKERID);

ALTER TABLE TRABAJADOR
ADD CONSTRAINT WORKER_FK FOREIGN KEY (CASALIMPIAR) REFERENCES CASA(NOCASA);

CREATE TABLE DIALAVADO(
DIALAVADO           CHAR(9) NOT NULL,
NOESTUDIANTE        INT,
TERMINADOLAVADO     NUMBER(1)
);

ALTER TABLE DIALAVADO
ADD CONSTRAINT LAVADO_PK PRIMARY KEY (DIALAVADO);

ALTER TABLE DIALAVADO
ADD CONSTRAINT LAVADO_FK1 FOREIGN KEY (NOESTUDIANTE) REFERENCES ESTUDIANTE (NOESTUDIANTE);

CREATE TABLE ESTUDIANTEENCASA (
NOESTUDIANTE		INT NOT NULL,
NOCASA			    INT NOT NULL,
NOCUARTO			INT
);

ALTER TABLE ESTUDIANTEENCASA
ADD CONSTRAINT EC_PK PRIMARY KEY (NOESTUDIANTE, NOCASA);

ALTER TABLE ESTUDIANTEENCASA
ADD CONSTRAINT EC_FK1 FOREIGN KEY (NOESTUDIANTE) REFERENCES ESTUDIANTE(NOESTUDIANTE) ON DELETE CASCADE; 

ALTER TABLE ESTUDIANTEENCASA
ADD CONSTRAINT EC_FK2 FOREIGN KEY (NOCASA) REFERENCES CASA(NOCASA) ON DELETE CASCADE;

ALTER TABLE ESTUDIANTEENCASA
ADD CONSTRAINT EC_FK3 FOREIGN KEY (NOCASA, NOCUARTO) REFERENCES CUARTO (NOCASA, NOCUARTO) ON DELETE CASCADE;

ALTER TABLE CUARTO
ADD MENSUALIDAD INT;

ALTER TABLE MENUDIARIO
ADD CONSTRAINT FK_BF FOREIGN KEY (DESAYUNO) REFERENCES PLATILLO(NOMPLATILLO);

ALTER TABLE MENUDIARIO
ADD CONSTRAINT FK_LN FOREIGN KEY (COMIDA) REFERENCES PLATILLO(NOMPLATILLO);

ALTER TABLE MENUDIARIO
ADD CONSTRAINT FK_DN FOREIGN KEY (CENA) REFERENCES PLATILLO(NOMPLATILLO);

ALTER TABLE ESTUDIANTE
ADD CONSTRAINT FK_TWO FOREIGN KEY (DIALAVADO) REFERENCES DIALAVADO(DIALAVADO);

/*
INSERTS
*/

INSERT INTO CASA
VALUES(63, 'Hombres', 7, 5, 0);

INSERT INTO CASA
VALUES(27, 'Mujeres', 7, 6, 0);

INSERT INTO CASA
VALUES(53, 'Mixta', 8, 6, 0);

INSERT INTO CASA
VALUES(19, 'Hombres', 10, 5, 1);

INSERT INTO ESTUDIANTE
VALUES(226702, 'Victor Alfonso', 'Zazueta Marquez', 'M', TO_DATE('20-02-1999','DD-MM-YYYY'),NULL, 63, NULL);

INSERT INTO ESTUDIANTE
VALUES(224966, 'Luis Fernando', 'Wilson Elias', 'M', TO_DATE('13-12-1999','DD-MM-YYYY'),NULL, 63, NULL);

INSERT INTO ESTUDIANTE
VALUES(222910,'Mauricio Adrian', 'Munoz Pineda', 'M', TO_DATE('27-05-1997','DD-MM-YYYY'), 'CHAMPI�ONES', 19, NULL);

INSERT INTO ESTUDIANTE
VALUES(256377, 'Jose Roberto', 'Zarate Corral', 'M', TO_DATE('05-07-1999','DD-MM-YYYY'), 'CAMARONES', 53, NULL);


INSERT INTO CUARTO
VALUES(3, 63, 2, 1, 7500);

INSERT INTO CUARTO
VALUES(1, 19, 1, 1, 7000);

INSERT INTO CUARTO
VALUES(5, 53, 2, 0, 8000);

INSERT INTO ESTUDIANTEENCASA 
VALUES (226702, 63, 3);

INSERT INTO ESTUDIANTEENCASA
VALUES (224966, 63, 3);

INSERT INTO ESTUDIANTEENCASA
VALUES (222910, 19, 1);

INSERT INTO ESTUDIANTEENCASA
VAlUES (256377, 53, 5);

INSERT INTO PLATILLO
VALUES ('Huevo Revuelto' , 'huevo, jamon, frijoles');

INSERT INTO PLATILLO
VALUES ('Res en su jugo','carne de res, frijoles, verduras');

INSERT INTO PLATILLO
VALUES ('Sopa de fideo','fideos, pollo');

INSERT INTO PLATILLO
VALUES ('Chilaquiles','tortillas, tomate, queso, frijoles');

INSERT INTO PLATILLO
VALUES ('Fajitas de Pollo','pollo, verduras, salsa');

INSERT INTO PLATILLO
VALUES ('Pan frances','pan, huevo, mantequilla');

INSERT INTO MENUDIARIO
VALUES (TO_DATE('07-04-2019','DD-MM-YYYY'),'Chilaquiles','Fajitas de Pollo','Pan frances');

INSERT INTO MENUDIARIO
VALUES (TO_DATE('08-04-2019','DD-MM-YYYY'),'Huevo Revuelto', 'Res en su jugo', 'Sopa de fideo');

INSERT INTO TRABAJADOR
VALUES(1, 'Carmelina', 'de la Vega', TO_DATE('04-09-1965','DD-MM-YYYY'), 1500.0, 19);

INSERT INTO TRABAJADOR
VALUES(2, 'Rosa', 'Escobedo', TO_DATE('20-11-1973','DD-MM-YYYY'), 1200.0, 19);

INSERT INTO DIALAVADO
VALUES('Lunes', 226702, 1);

INSERT INTO DIALAVADO
VALUES('Martes',256377, 1);

INSERT INTO DIALAVADO
VALUES('Jueves', 224966, 1);

INSERT INTO DIALAVADO
VALUES('Viernes', 226702, 1);

UPDATE ESTUDIANTE SET DIALAVADO = 'Martes' WHERE NOESTUDIANTE = 256377;
UPDATE ESTUDIANTE SET DIALAVADO = 'Jueves' WHERE NOESTUDIANTE = 224966;
UPDATE ESTUDIANTE SET DIALAVADO = 'Lunes' WHERE NOESTUDIANTE = 222910;
UPDATE ESTUDIANTE SET DIALAVADO = 'Viernes' WHERE NOESTUDIANTE = 226702;

create table apartado (
fecha date not null,
platillo CHAR(20) not null,
comentario VARCHAR(50),
noestudiante int not null,
atendido number(1)
);

alter table apartado
add constraint apartado_pk primary key (fecha, platillo, noestudiante);

alter table apartado
add constraint apEst_fk foreign key (noestudiante) references estudiante(noestudiante);

alter table apartado
add constraint apPlat_fk foreign key (platillo) references platillo(nomplatillo);



