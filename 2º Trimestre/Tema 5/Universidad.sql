SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

---- \i C:/Users/DAW-B/Desktop/Universidad.sql

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

DROP DATABASE IF EXISTS universidad;
CREATE DATABASE universidad;
\c universidad

--
-- Name: _alumno_se_matricula_asignatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumno_se_matricula_asignatura (
    id_alumno smallint,
    id_asignatura smallint,
    id_curso_escolar smallint
);


ALTER TABLE public.alumno_se_matricula_asignatura OWNER TO postgres;

--
-- Name: _asignatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asignatura (
    id smallint,
    nombre character varying(80) DEFAULT NULL::character varying,
    creditos numeric(2,1) DEFAULT NULL::numeric,
    tipo character varying(11) DEFAULT NULL::character varying,
    curso smallint,
    cuatrimestre smallint,
    id_profesor character varying(2) DEFAULT NULL::character varying,
    id_grado smallint
);


ALTER TABLE public.asignatura OWNER TO postgres;

--
-- Name: _curso_escolar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.curso_escolar (
    id smallint,
    anyo_inicio character varying(10) DEFAULT NULL::character varying,
    anyo_fin character varying(10) DEFAULT NULL::character varying
);


ALTER TABLE public.curso_escolar OWNER TO postgres;

--
-- Name: _departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    id smallint,
    nombre character varying(25) DEFAULT NULL::character varying
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- Name: _grado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grado (
    id smallint,
    nombre character varying(560) DEFAULT NULL::character varying
);


ALTER TABLE public.grado OWNER TO postgres;

--
-- Name: _persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id smallint,
    nif character varying(9) DEFAULT NULL::character varying,
    nombre character varying(9) DEFAULT NULL::character varying,
    apellido1 character varying(10) DEFAULT NULL::character varying,
    apellido2 character varying(10) DEFAULT NULL::character varying,
    ciudad character varying(10) DEFAULT NULL::character varying,
    direccion character varying(25) DEFAULT NULL::character varying,
    telefono character varying(9) DEFAULT NULL::character varying,
    fecha_nacimiento character varying(10) DEFAULT NULL::character varying,
    sexo character varying(1) DEFAULT NULL::character varying,
    tipo character varying(8) DEFAULT NULL::character varying
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: _profesor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesor (
    id_profesor smallint,
    id_departamento smallint
);


ALTER TABLE public.profesor OWNER TO postgres;

--
-- Data for Name: _alumno_se_matricula_asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumno_se_matricula_asignatura (id_alumno, id_asignatura, id_curso_escolar) FROM stdin;
1	1	1
1	2	1
1	3	1
2	1	1
2	2	1
2	3	1
4	1	1
4	2	1
4	3	1
19	1	5
19	2	5
19	3	5
19	4	5
19	5	5
19	6	5
19	7	5
19	8	5
19	9	5
19	10	5
23	1	5
23	2	5
23	3	5
23	4	5
23	5	5
23	6	5
23	7	5
23	8	5
23	9	5
23	10	5
24	1	5
24	2	5
24	3	5
24	4	5
24	5	5
24	6	5
24	7	5
24	8	5
24	9	5
24	10	5
\.


--
-- Data for Name: _asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asignatura (id, nombre, creditos, tipo, curso, cuatrimestre, id_profesor, id_grado) FROM stdin;
1	Algegra lineal y matemática discreta	6.0	básica	1	1	3	4
2	Cálculo	6.0	básica	1	1	14	4
3	Física para informática	6.0	básica	1	1	3	4
4	Introducción a la programación	6.0	básica	1	1	14	4
5	Organización y gestión de empresas	6.0	básica	1	1	3	4
6	Estadística	6.0	básica	1	2	14	4
7	Estructura y tecnología de computadores	6.0	básica	1	2	3	4
8	Fundamentos de electrónica	6.0	básica	1	2	14	4
9	Lógica y algorítmica	6.0	básica	1	2	3	4
10	Metodología de la programación	6.0	básica	1	2	14	4
11	Arquitectura de Computadores	6.0	básica	2	1	3	4
12	Estructura de Datos y Algoritmos I	6.0	obligatoria	2	1	3	4
13	Ingeniería del Software	6.0	obligatoria	2	1	14	4
14	Sistemas Inteligentes	6.0	obligatoria	2	1	3	4
15	Sistemas Operativos	6.0	obligatoria	2	1	14	4
16	Bases de Datos	6.0	básica	2	2	14	4
17	Estructura de Datos y Algoritmos II	6.0	obligatoria	2	2	14	4
18	Fundamentos de Redes de Computadores	6.0	obligatoria	2	2	3	4
19	Planificación y Gestión de Proyectos Informáticos	6.0	obligatoria	2	2	3	4
20	Programación de Servicios Software	6.0	obligatoria	2	2	14	4
21	Desarrollo de interfaces de usuario	6.0	obligatoria	3	1	14	4
22	Ingeniería de Requisitos	6.0	optativa	3	1		4
23	Integración de las Tecnologías de la Información en las Organizaciones	6.0	optativa	3	1		4
24	Modelado y Diseño del Software 1	6.0	optativa	3	1		4
25	Multiprocesadores	6.0	optativa	3	1		4
26	Seguridad y cumplimiento normativo	6.0	optativa	3	1		4
27	Sistema de Información para las Organizaciones	6.0	optativa	3	1		4
28	Tecnologías web	6.0	optativa	3	1		4
29	Teoría de códigos y criptografía	6.0	optativa	3	1		4
30	Administración de bases de datos	6.0	optativa	3	2		4
31	Herramientas y Métodos de Ingeniería del Software	6.0	optativa	3	2		4
32	Informática industrial y robótica	6.0	optativa	3	2		4
33	Ingeniería de Sistemas de Información	6.0	optativa	3	2		4
34	Modelado y Diseño del Software 2	6.0	optativa	3	2		4
35	Negocio Electrónico	6.0	optativa	3	2		4
36	Periféricos e interfaces	6.0	optativa	3	2		4
37	Sistemas de tiempo real	6.0	optativa	3	2		4
38	Tecnologías de acceso a red	6.0	optativa	3	2		4
39	Tratamiento digital de imágenes	6.0	optativa	3	2		4
40	Administración de redes y sistemas operativos	6.0	optativa	4	1		4
41	Almacenes de Datos	6.0	optativa	4	1		4
42	Fiabilidad y Gestión de Riesgos	6.0	optativa	4	1		4
43	Líneas de Productos Software	6.0	optativa	4	1		4
44	Procesos de Ingeniería del Software 1	6.0	optativa	4	1		4
45	Tecnologías multimedia	6.0	optativa	4	1		4
46	Análisis y planificación de las TI	6.0	optativa	4	2		4
47	Desarrollo Rápido de Aplicaciones	6.0	optativa	4	2		4
48	Gestión de la Calidad y de la Innovación Tecnológica	6.0	optativa	4	2		4
49	Inteligencia del Negocio	6.0	optativa	4	2		4
50	Procesos de Ingeniería del Software 2	6.0	optativa	4	2		4
51	Seguridad Informática	6.0	optativa	4	2		4
52	Biologia celular	6.0	básica	1	1		7
53	Física	6.0	básica	1	1		7
54	Matemáticas I	6.0	básica	1	1		7
55	Química general	6.0	básica	1	1		7
56	Química orgánica	6.0	básica	1	1		7
57	Biología vegetal y animal	6.0	básica	1	2		7
58	Bioquímica	6.0	básica	1	2		7
59	Genética	6.0	básica	1	2		7
60	Matemáticas II	6.0	básica	1	2		7
61	Microbiología	6.0	básica	1	2		7
62	Botánica agrícola	6.0	obligatoria	2	1		7
63	Fisiología vegetal	6.0	obligatoria	2	1		7
64	Genética molecular	6.0	obligatoria	2	1		7
65	Ingeniería bioquímica	6.0	obligatoria	2	1		7
66	Termodinámica y cinética química aplicada	6.0	obligatoria	2	1		7
67	Biorreactores	6.0	obligatoria	2	2		7
68	Biotecnología microbiana	6.0	obligatoria	2	2		7
69	Ingeniería genética	6.0	obligatoria	2	2		7
70	Inmunología	6.0	obligatoria	2	2		7
71	Virología	6.0	obligatoria	2	2		7
72	Bases moleculares del desarrollo vegetal	4.5	obligatoria	3	1		7
73	Fisiología animal	4.5	obligatoria	3	1		7
74	Metabolismo y biosíntesis de biomoléculas	6.0	obligatoria	3	1		7
75	Operaciones de separación	6.0	obligatoria	3	1		7
76	Patología molecular de plantas	4.5	obligatoria	3	1		7
77	Técnicas instrumentales básicas	4.5	obligatoria	3	1		7
78	Bioinformática	4.5	obligatoria	3	2		7
79	Biotecnología de los productos hortofrutículas	4.5	obligatoria	3	2		7
80	Biotecnología vegetal	6.0	obligatoria	3	2		7
81	Genómica y proteómica	4.5	obligatoria	3	2		7
82	Procesos biotecnológicos	6.0	obligatoria	3	2		7
83	Técnicas instrumentales avanzadas	4.5	obligatoria	3	2		7
\.


--
-- Data for Name: _curso_escolar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.curso_escolar (id, anyo_inicio, anyo_fin) FROM stdin;
1	2014-01-01	2015-01-01
2	2015-01-01	2016-01-01
3	2016-01-01	2017-01-01
4	2017-01-01	2018-01-01
5	2018-01-01	2019-01-01
\.


--
-- Data for Name: _departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamento (id, nombre) FROM stdin;
1	Informática
2	Matemáticas
3	Economía y Empresa
4	Educación
5	Agronomía
6	Química y Física
7	Filología
8	Derecho
9	Biología y Geología
\.


--
-- Data for Name: _grado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grado (id, nombre) FROM stdin;
1	Grado en Ingeniería Agrícola (Plan 2015)
2	Grado en Ingeniería Eléctrica (Plan 2014)
3	Grado en Ingeniería Electrónica Industrial (Plan 2010)
4	Grado en Ingeniería Informática (Plan 2015)
5	Grado en Ingeniería Mecánica (Plan 2010)
6	Grado en Ingeniería Química Industrial (Plan 2010)
7	Grado en Biotecnología (Plan 2015)
8	Grado en Ciencias Ambientales (Plan 2009)
9	Grado en Matemáticas (Plan 2010)
10	Grado en Química (Plan 2009)
\.


--
-- Data for Name: _persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (id, nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo, tipo) FROM stdin;
1	26902806M	Salvador	Sánchez	Pérez	Almería	C/ Real del barrio alto	950254837	1991-03-28	H	alumno
2	89542419S	Juan	Saez	Vega	Almería	C/ Mercurio	618253876	1992-08-08	H	alumno
3	11105554G	Zoe	Ramirez	Gea	Almería	C/ Marte	618223876	1979-08-19	M	profesor
4	17105885A	Pedro	Heller	Pagac	Almería	C/ Estrella fugaz		2000-10-05	H	alumno
5	38223286T	David	Schmidt	Fisher	Almería	C/ Venus	678516294	1978-01-19	H	profesor
6	04233869Y	José	Koss	Bayer	Almería	C/ Júpiter	628349590	1998-01-28	H	alumno
7	97258166K	Ismael	Strosin	Turcotte	Almería	C/ Neptuno		1999-05-24	H	alumno
8	79503962T	Cristina	Lemke	Rutherford	Almería	C/ Saturno	669162534	1977-08-21	M	profesor
9	82842571K	Ramón	Herzog	Tremblay	Almería	C/ Urano	626351429	1996-11-21	H	alumno
10	61142000L	Esther	Spencer	Lakin	Almería	C/ Plutón		1977-05-19	M	profesor
11	46900725E	Daniel	Herman	Pacocha	Almería	C/ Andarax	679837625	1997-04-26	H	alumno
12	85366986W	Carmen	Streich	Hirthe	Almería	C/ Almanzora		1971-04-29	M	profesor
13	73571384L	Alfredo	Stiedemann	Morissette	Almería	C/ Guadalquivir	950896725	1980-02-01	H	profesor
14	82937751G	Manolo	Hamill	Kozey	Almería	C/ Duero	950263514	1977-01-02	H	profesor
15	80502866Z	Alejandro	Kohler	Schoen	Almería	C/ Tajo	668726354	1980-03-14	H	profesor
16	10485008K	Antonio	Fahey	Considine	Almería	C/ Sierra de los Filabres		1982-03-18	H	profesor
17	85869555K	Guillermo	Ruecker	Upton	Almería	C/ Sierra de Gádor		1973-05-05	H	profesor
18	04326833G	Micaela	Monahan	Murray	Almería	C/ Veleta	662765413	1976-02-25	H	profesor
19	11578526G	Inma	Lakin	Yundt	Almería	C/ Picos de Europa	678652431	1998-09-01	M	alumno
20	79221403L	Francesca	Schowalter	Muller	Almería	C/ Quinto pino		1980-10-31	H	profesor
21	79089577Y	Juan	Gutiérrez	López	Almería	C/ Los pinos	678652431	1998-01-01	H	alumno
22	41491230N	Antonio	Domínguez	Guerrero	Almería	C/ Cabo de Gata	626652498	1999-02-11	H	alumno
23	64753215G	Irene	Hernández	Martínez	Almería	C/ Zapillo	628452384	1996-03-12	M	alumno
24	85135690V	Sonia	Gea	Ruiz	Almería	C/ Mercurio	678812017	1995-04-13	M	alumno
\.


--
-- Data for Name: _profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesor (id_profesor, id_departamento) FROM stdin;
3	1
14	1
5	2
15	2
8	3
16	3
10	4
12	4
17	4
18	5
13	6
20	6
\.


--
-- PostgreSQL database dump complete
--
