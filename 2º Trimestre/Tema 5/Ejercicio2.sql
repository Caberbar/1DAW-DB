CREATE DATABASE ejercicio2;
\c ejercicio2;

CREATE TABLE workers(
    id numeric(4) NOT NULL PRIMARY KEY,
    name varchar(20),
    fee real,
    job varchar(15)
);

ALTER TABLE workers ADD supervisor_id int NULL REFERENCES workers(id);

CREATE TABLE buildings(
    id numeric(3) NOT NULL PRIMARY KEY,
    address varchar(20),
    type varchar(20),
    level numeric(1),
    category numeric(1)
);

CREATE TABLE assignments (
    worker_id numeric(4) NOT NULL REFERENCES workers(id),
    building_id numeric(3) NOT NULL REFERENCES buildings(id),
    start_date date NOT NULL,
    days numeric(2),
    PRIMARY KEY(worker_id, building_id, start_date)
);

-- \i C:/Users/DAW-B/Desktop/Ejercicio2.sql
-- DROP DATABASE ejercicio2;

INSERT INTO workers VALUES(1311, 'C. Coulomb', 15.5, 'electrician', 1311);
INSERT INTO workers VALUES(1235,'M. Faraday',12.5,'electrician',1311);
INSERT INTO workers VALUES(1520, 'H. Rickover', 11.75, 'plumber', 1520);
INSERT INTO workers VALUES(1412, 'C. Nemo', 13.75, 'plumber', 1520);
INSERT INTO workers VALUES(2920, 'R. Garret', 10.0, 'builder', 2920);
INSERT INTO workers VALUES(3231, 'P. Mason', 17.4, 'carpenter', 3231);
INSERT INTO workers VALUES(3001, 'J. Barrister', 8.2, 'carpenter', 3231);

INSERT INTO buildings VALUES(111, '1213 Aspen', 'office', 4, 1);
INSERT INTO buildings VALUES(210, '1011 Birch', 'office', 3, 1);
INSERT INTO buildings VALUES(312, '123 Elm', 'office', 2, 2);
INSERT INTO buildings VALUES(435, '456 Maple', 'shop', 1, 1);
INSERT INTO buildings VALUES(460, '1415 Beach', 'warehouse', 3, 3);
INSERT INTO buildings VALUES(515, '789 Oak', 'residential', 3, 2);

INSERT INTO assignments VALUES(1235, 312, '2001-10-10', 5);
INSERT INTO assignments VALUES(1235, 515, '2001-10-17', 22);
INSERT INTO assignments VALUES(1311, 435, '2001-10-08', 12);
INSERT INTO assignments VALUES(1311, 460, '2001-10-23', 24);
INSERT INTO assignments VALUES(1412, 111, '2001-12-01', 4);
INSERT INTO assignments VALUES(1412, 210, '2001-11-15', 12);
INSERT INTO assignments VALUES(1412, 312, '2001-10-01', 10);
INSERT INTO assignments VALUES(1412, 435, '2001-10-15', 15);
INSERT INTO assignments VALUES(1412, 460, '2001-10-08', 18);
INSERT INTO assignments VALUES(1412, 515, '2001-11-05', 8);
INSERT INTO assignments VALUES(1520, 312, '2001-10-30', 17);
INSERT INTO assignments VALUES(1520, 515, '2001-10-09', 14);
INSERT INTO assignments VALUES(2920, 210, '2001-11-10', 15);
INSERT INTO assignments VALUES(2920, 435, '2001-10-28', 10);
INSERT INTO assignments VALUES(2920, 460, '2001-10-05', 18);
INSERT INTO assignments VALUES(3001, 111, '2001-10-08', 14);
INSERT INTO assignments VALUES(3001, 210, '2001-10-27', 14);
INSERT INTO assignments VALUES(3231, 111, '2001-10-10', 8);
INSERT INTO assignments VALUES(3231, 312, '2001-10-24', 20);

-- DROP DATABASE ejercicio2;
-- \i ‘C:/Users/DAW-B/Desktop/Ejercicio2.sql’
-- \i ‘C:/Users/caber/OneDrive/Escritorio/Ejercicio2.sql’

-- 1. SELECT name FROM workers WHERE fee>=10 AND fee<=12;
-- SELECT name FROM workers WHERE fee between 10 AND 12;
-- 2. SELECT w.job FROM workers w, assignments a WHERE w.id = a.worker_id AND a.building_id = 435;
-- 3. SELECT w1.name AS worker, w2.name AS supervisor FROM workers w1, workers w2 WHERE w1.supervisor_id = w2.id AND w1.id <> w2.id;
-- 4. SELECT DISTINCT name FROM workers INNER JOIN assignments ON id = worker_id WHERE building_id IN (SELECT id FROM buildings WHERE type='office');
-- SELECT DISTINCT name FROM workers INNER JOIN assignments ON workers.id = worker_id INNER JOIN buildings ON buildings.id = building_id WHERE type='office';
--5. SELECT w.name FROM workers w, workers s WHERE w.supervisor_id = s.id AND w.fee > s.fee;
-- 6. SELECT SUM(a.days) FROM assignments a, workers w WHERE w.id = a.worker_id AND w.job = 'plumber' AND a.building_id = 312;
-- 7. SELECT COUNT(DISTINCT job) FROM workers;
-- 8. SELECT supervisor_id, MAX(fee) FROM workers GROUP BY supervisor_id;
-- 9. SELECT supervisor_id, MAX(fee) FROM workers GROUP BY supervisor_id HAVING COUNT(*) > 1;
-- 10. SELECT type, AVG(level) FROM buildings WHERE category = 1 AND level < 3 GROUP BY type;
-- 11. SELECT name FROM workers WHERE fee < (SELECT AVG(fee) FROM workers);
-- 12. SELECT name FROM workers AS w1 WHERE fee < (SELECT AVG(fee) FROM workers AS w2 WHERE w1.job = w2.job);
-- 13. SELECT name FROM workers w WHERE w.fee < (SELECT avg(fee) FROM workers WHERE supervisor_id = w.supervisor_id);
-- 14. SELECT w.name, a.start_date FROM workers W, assignments a WHERE w.job = 'electrician' AND a.worker_id = w.id AND a.building_id = 435;
-- 15. SELECT DISTINCT s.name FROM workers w, workers s WHERE w.supervisor_id = s.id AND w.fee > 12;
-- 16. UPDATE workers SET fee=fee*1.05 WHERE supervisor_id = (SELECT id FROM workers WHERE name = "C. Coulomb");
