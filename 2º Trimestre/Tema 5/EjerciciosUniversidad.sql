-- 1.5.4 Consultas sobre tablas

-- 1.
SELECT nombre, apellido1, apellido2 FROM persona 
    WHERE tipo='profesor' AND nif LIKE '%K' AND telefono =''; 



-- 1.5.5 Consultas multitablas (Composición interna)

-- 5.
SELECT DISTINCT dep.nombre FROM departamento AS dep 
    INNER JOIN profesor AS prof ON dep.id = prof.id_departamento 
    INNER JOIN asignatura AS asig ON prof.id_profesor=asig.id_profesor 
    INNER JOIN grado ON grado.id=asig.id_grado 
    WHERE grado.nombre LIKE 'Grado en Ingenier%a Inform%tica (Plan 2015)';

-- 6.
SELECT DISTINCT nombre, apellido1, apellido2 FROM persona 
    INNER JOIN matricula AS matri ON persona.id=matri.id_alumno 
    INNER JOIN curso_escolar AS curso ON matri.id_curso_escolar = curso.id 
    WHERE fin=2018 OR fin=2019;



-- 1.5.6 Consultas multitablas (Composición externa) 

-- 5.
SELECT asig.nombre, prof.id_profesor FROM asignatura AS asig LEFT JOIN profesor AS prof ON asig.id_profesor=prof.id_profesor WHERE prof.id_profesor IS NULL;

--6.
SELECT DISTINCT dep.nombre, asig.nombre, asig.id FROM asignatura AS asig LEFT JOIN matricula ON asig.id = matricula.id_asignatura LEFT JOIN profesor AS prof ON asig.id_profesor = prof.id_profesor LEFT JOIN departamento AS dep ON prof.id_departamento = dep.id WHERE matricula.id_asignatura IS NULL ORDER BY asig.id;



-- 1.5.7 Consultas resumen

 -- 1.
 SELECT COUNT(sexo) FROM persona WHERE tipo = 'alumno' AND sexo='M';


 -- 6.
 SELECT grado.nombre, COUNT(asignatura.nombre) FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.nombre) > 40;


-- 7.
SELECT grado.nombre, asignatura.tipo ,SUM(creditos) AS "Total de creditos" FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo ORDER BY grado.nombre, SUM(creditos) DESC;


-- 8.
SELECT curso_escolar.inicio, COUNT(DISTINCT id_alumno) FROM matricula INNER JOIN curso_escolar ON matricula.id_curso_escolar = curso_escolar.id GROUP BY curso_escolar.inicio;


-- 9.
SELECT persona.id, persona.nombre, apellido1, apellido2, COUNT(asignatura.id) FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor GROUP BY persona.id, persona.nombre, apellido1, apellido2 ORDER BY COUNT(asignatura.id) DESC;



-- 1.5.8 Subconsulta


-- 1. (Diferentes opciones)
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno' );

SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;

SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento >= ALL (SELECT fecha_nacimiento FROM persona WHERE tipo = 'alumno');

SELECT nombre, apellido1, apellido2 FROM persona AS p1 WHERE tipo = 'alumno' AND NOT EXISTS (SELECT fecha_nacimiento FROM persona AS p2 WHERE tipo = 'alumno' AND p1.fecha_nacimiento < p2.fecha_nacimiento);


-- 2.
SELECT per.nombre, per.apellido1, per.apellido2 FROM persona AS per WHERE per.id  IN (SELECT pro.id_profesor FROM profesor AS pro WHERE id_departamento IS NULL);

SELECT per.nombre, per.apellido1, per.apellido2 FROM persona AS per WHERE tipo = 'profesor' AND per.id NOT IN (SELECT pro.id_profesor FROM profesor AS pro WHERE id_departamento IS NOT NULL);

SELECT per.nombre, per.apellido1, per.apellido2 FROM persona AS per WHERE tipo = 'profesor' AND EXISTS (SELECT id_profesor FROM profesor AS prof WHERE prof.id_departamento IS NULL AND per.id = prof.id_profesor);

SELECT per.nombre, per.apellido1, per.apellido2 FROM persona AS per WHERE tipo = 'profesor' AND NOT EXISTS (SELECT id_profesor FROM profesor AS prof WHERE prof.id_departamento IS NOT NULL AND per.id = prof.id_profesor);


-- 3.
SELECT id_departamento FROM departamento WHERE departamento.id 