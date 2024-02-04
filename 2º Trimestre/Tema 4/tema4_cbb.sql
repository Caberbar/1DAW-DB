CREATE DATABASE ejercicio8;

\c ejercicio8;

CREATE TABLE town (
    zip_code numeric(5),
    name_town varchar(10),
    PRIMARY KEY (zip_code)
);

CREATE TABLE branch (
    zip_code numeric(5),
    telephone numeric(9),
    address varchar(30),
    name varchar(20),
    PRIMARY KEY (name),
    FOREIGN KEY (zip_code)
        REFERENCES town(zip_code)
);

CREATE TABLE worker (
    ID numeric(9),
    email varchar(30),
    telephone numeric(9),
    name varchar(20),
    address varchar(30),
    PRIMARY KEY (ID)
);

CREATE TABLE employers (
    salary money,
    ID numeric(9),
    name_branch varchar(20),
    PRIMARY KEY (ID, name_branch),
    FOREIGN KEY (ID) REFERENCES worker (ID) ,
    FOREIGN KEY (name_branch) REFERENCES branch (name)
);

CREATE TABLE journalist (
    ID numeric(9),
    field varchar(10),
    PRIMARY KEY (ID),
    FOREIGN KEY (ID)
        REFERENCES worker (ID)
);

CREATE TABLE section (
    title varchar(10),
    extension numeric(10),
    PRIMARY KEY (title)
);

CREATE TABLE magazine (
    type varchar(10),
    frequency varchar(10),
    found_date date,
    code numeric(5),
    director varchar(20),
    name_branch varchar(20),
    PRIMARY KEY (code, name_branch),
    UNIQUE (code),
    FOREIGN KEY (name_branch)
        REFERENCES branch (name)
);

CREATE TABLE edition (
    copies_sold numeric(10),
    pg_number numeric(10),
    ed_date date,
    edition_number numeric(10),
    code_magazine numeric(5),
    PRIMARY KEY (edition_number, code_magazine),
    FOREIGN KEY (code_magazine)
        REFERENCES magazine (code)
);

CREATE TABLE article (
    subject varchar(10),
    length numeric(5),
    date date,
    code_magazine numeric(5),
    ID numeric(9),
    PRIMARY KEY (subject, code_magazine, ID),
    FOREIGN KEY (code_magazine) 
        REFERENCES magazine(code),
    FOREIGN KEY (ID) 
        REFERENCES worker (ID)
);
 
CREATE TABLE belongs_to (
    code_magazine numeric(5),
    title_section varchar(10),
    PRIMARY KEY (code_magazine, title_section),
    FOREIGN KEY (code_magazine) 
        REFERENCES magazine(code),
    FOREIGN KEY (title_section) 
        REFERENCES section (title)
);

INSERT INTO town VALUES (11111, 'Madrid');
INSERT INTO town VALUES (11112, 'Barcelona');
INSERT INTO town VALUES (11113, 'Sevilla');
INSERT INTO town VALUES (11114, 'Malaga');
INSERT INTO town VALUES (11115, 'Valencia');

INSERT INTO branch VALUES(11111, 902507150, 'Avd. Tomas García, N 1', 'Ediciones AE');
INSERT INTO branch VALUES(11112, 917449060, 'c/ Torrelaguna, N 60', 'Alfaguara');
INSERT INTO branch VALUES(11111, 954652311, 'c/ Javier, N 22', 'Algaida editores');
INSERT INTO branch VALUES(11112, 952714395, 'c/ Pavia, N 8', 'Ediciones Aljibe');
INSERT INTO branch VALUES(11113, 956878018, 'c/ Doctor Pariente, N 28', 'Anaya');

INSERT INTO worker VALUES(111111112, 'fernandoRos@gmail.com', 635489584, 'Fernando Ros', 'c/ Plaza Manuela, N 341');
INSERT INTO worker VALUES(111111121, 'alberto.hidalgo@gmail.com', 687459684, 'Alberto Hidalgo', 'c/ Plaza Salma, N 458');
INSERT INTO worker VALUES(111111211, 'manuela.trujillo@gmail.com', 687458965, 'Manuela Trujillo', 'c/ Paseo Valentín, N 5');
INSERT INTO worker VALUES(111111113, 'jesus.madera@hotmail.com', 698745321, 'Jesus Madera', 'c/ Velez, N 9');
INSERT INTO worker VALUES(111111131, 'eduardopalomino@hotmail.com', 632148795, 'Eduardo Palomino', 'c/ Gonzalo, N 38');
INSERT INTO worker VALUES(111111311, 'soleva@outlook.com', 632145986, 'Eva Solano', 'c/ Asensio, N 55');
INSERT INTO worker VALUES(111111114, 'martmoran@gmail.com', 695478126, 'Marta Moran', 'c/ Montes, N 93');
INSERT INTO worker VALUES(111111141, 'figueroa.laura@hotmail.com', 695784125, 'Laura Figueroa', 'c/ Paseo Lorente, N 36');
INSERT INTO worker VALUES(111111411, 'aaron.ruiz@gmail.com', 648751236, 'Aron Ruiz', 'c/ Paseo Aguilera, N 646');
INSERT INTO worker VALUES(111111115, 'tejadaire@gmail.com', 643197564, 'Irene Tejada', 'c/ Miguel, N 4');

INSERT INTO employers VALUES('1500,00', 111111112, 'Ediciones AE');
INSERT INTO employers VALUES('1300,00', 111111121, 'Ediciones AE');
INSERT INTO employers VALUES('1200,00', 111111211, 'Alfaguara');
INSERT INTO employers VALUES('1600,00', 111111113, 'Alfaguara');
INSERT INTO employers VALUES('1400,00', 111111131, 'Alfaguara');

INSERT INTO  journalist VALUES(111111311, 'Deportes');
INSERT INTO  journalist VALUES(111111114, 'Actualidad');
INSERT INTO  journalist VALUES(111111141, 'Actualidad');
INSERT INTO  journalist VALUES(111111411, 'Tiempo');
INSERT INTO  journalist VALUES(111111115, 'Bolsa');

INSERT INTO section VALUES ('Portada', 20);
INSERT INTO section VALUES ('Anuncios', 20);
INSERT INTO section VALUES ('Editorial', 10);
INSERT INTO section VALUES ('Indice', 100);
INSERT INTO section VALUES ('Articulos', 8000);

INSERT INTO magazine VALUES ('Deportes', 'semanal', '2022-09-28', 12548, 'Manolo Garcia', 'Ediciones AE');
INSERT INTO magazine VALUES ('Moda', 'mensual', '2023-01-01', 12496, 'Pedro Rodriguez', 'Alfaguara');
INSERT INTO magazine VALUES ('Actualidad', 'diaria', '2022-05-13', 18745, 'Luis Gonzalez', 'Algaida editores');
INSERT INTO magazine VALUES ('Bolsa', 'semanal', '2022-12-05', 16957, 'Maria Lopez', 'Ediciones Aljibe');
INSERT INTO magazine VALUES ('Tiempo', 'diaria', '2022-10-30', 13548, 'Teresa Sanchez', 'Anaya');

INSERT INTO edition VALUES (10000, 80, '2022-09-20', 11125, 12548);
INSERT INTO edition VALUES (5000, 20, '202-12-30', 11223, 12496);
INSERT INTO edition VALUES (100000, 100, '2022-05-10', 11112, 18745);
INSERT INTO edition VALUES (20000, 30, '2022-12-01', 11122, 16957);
INSERT INTO edition VALUES (15000, 15, '2022-10-20', 11116, 13548);

INSERT INTO article VALUES ('Deportes', 1205, '24-10-2022', 12548, 111111112);
INSERT INTO article VALUES ('Moda', 1100, '12-12-2022', 12496, 111111121);
INSERT INTO article VALUES ('Actualidad', 1007, '11-10-2022', 18745, 111111211);
INSERT INTO article VALUES ('Bolsa', 1701, '17-01-2022', 16957, 111111113);
INSERT INTO article VALUES ('Tiempo', 840, '20-07-2022', 13548, 111111131);

INSERT INTO belongs_to VALUES (12548, 'Portada');
INSERT INTO belongs_to VALUES (12496, 'Anuncios');
INSERT INTO belongs_to VALUES (18745, 'Editorial');
INSERT INTO belongs_to VALUES (16957, 'Indice');
INSERT INTO belongs_to VALUES (13548, 'Portada');