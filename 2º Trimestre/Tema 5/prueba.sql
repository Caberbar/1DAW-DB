DROP DATABASE company;
CREATE DATABASE company;
\c company;

CREATE TABLE employees (
                           employee_id numeric(8),
                           first_name varchar(30),
                           last_name varchar(30),
                           birthdate date,
                           address varchar(40),
                           gender char,
                           salary money,
                           supervisor_id numeric(8),
                           department_id numeric(8),
                           PRIMARY KEY (employee_id),
                           FOREIGN KEY (supervisor_id)
                               REFERENCES employees (employee_id)
)
;

CREATE TABLE departments (
                             department_id numeric(1),
                             name varchar(30),
                             manager_id numeric(8),
                             PRIMARY KEY (department_id),
                             FOREIGN KEY (manager_id)
                                 REFERENCES employees (employee_id)
)
;

CREATE TABLE projects (
                          project_id numeric(2),
                          name varchar(30),
                          place varchar(30),
                          budget money,
                          department_id numeric(8),
                          PRIMARY KEY (project_id),
                          FOREIGN KEY (department_id)
                              REFERENCES departments (department_id)
)
;

CREATE TABLE works_in (
                          employee_id numeric(8),
                          project_id numeric(8),
                          total_time  interval,
                          PRIMARY KEY (employee_id, project_id),
                          FOREIGN KEY (employee_id)
                              REFERENCES employees (employee_id),
                          FOREIGN KEY (project_id)
                              REFERENCES projects (project_id)
)
;

INSERT INTO employees (VALUES
                           (11111111, 'Pedro', 'Lopez Martínez', '26/05/1995', 'c/ Rumanía, 3', 'H', '1300', 11111111, 1),
                           (22222222, 'María', 'García Gonzalez', '14/07/1999', 'c/ Eslovaquia, 35', 'M', '1100', 22222222, 2),
                           (33333333, 'Pablo', 'Campos Pérez', '05/09/1993', 'c/ San Jacinto, 2', 'H', '1500', 33333333, 2),
                           (44444444, 'Ana', 'Muros Linares', '01/01/2000', 'c/ Solares, 57', 'M', '1300', 44444444, 3),
                           (55555555, 'José', 'Trujillo Muñoz', '19/03/1990', 'c/ las Mercedes', 'H', '1900', 55555555, 3)
)
;

INSERT INTO departments (VALUES
                             (1, 'Marketing', 11111111),
                             (2, 'Finances', 22222222),
                             (3, 'Desing', 33333333)
)
;

ALTER TABLE employees
    add constraint fk_employees
        FOREIGN KEY (department_id)
            REFERENCES departments (department_id)
;

INSERT INTO projects (VALUES
                          (1, 'Project1', 'Laboratory', 12000, 1),
                          (2, 'Project2', 'Laboratory', 25000, 1),
                          (3, 'Project3', 'Laboratory', 30000, 1),
                          (4, 'Project4', 'Laboratory', 8000, 1),
                          (5, 'Project5', 'Laboratory', 18500, 1),
                          (6, 'Project6', 'Laboratory', 10000, 2),
                          (7, 'Project7', 'Laboratory', 22500, 2),
                          (8, 'Project8', 'Laboratory', 50000, 3),
                          (9, 'Project9', 'Laboratory', 45000, 3),
                          (10, 'Project10', 'Laboratory', 35500, 3)
)
;

INSERT INTO works_in (VALUES
                          (11111111, 1, '30'),
                          (11111111, 2, '45'),
                          (11111111, 3, '60'),
                          (22222222, 4, '25'),
                          (22222222, 5, '75'),
                          (22222222, 6, '80'),
                          (33333333, 7, '70'),
                          (44444444, 8, '50'),
                          (44444444, 9, '80'),
                          (55555555, 10, '90')
)
;