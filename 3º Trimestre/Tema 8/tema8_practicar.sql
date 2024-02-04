-- Ejercicio 1. Escribir una función que reciba dos números y devuelva su suma. A continuación, escribir un procedimiento que muestre la suma al usuario.
CREATE OR REPLACE FUNCTION sumar_numeros(num1 integer, num2 integer) 
RETURNS integer AS
$$
BEGIN
  RETURN num1+num2;
END;
$$ LANGUAGE plpgsql;

SELECT public.sumar_numeros(
	3, 
	3
)


-- Ejercicio 2. Codificar un procedimiento que reciba una cadena de texto y la visualice al revés.
CREATE OR REPLACE PROCEDURE invertir_cadena(cadena IN VARCHAR)
RETURNS VARCHAR AS
$$
BEGIN
    RETURN REVERSE(cadena);
END;
$$ LANGUAGE plpgsql;


SELECT public.invertir_cadena(
    'HOLA'
)


-- Ejercicio 3. Escribir una función que reciba una fecha y devuelva el año de la fecha (como número).
CREATE OR REPLACE FUNCTION anio(fecha IN DATE) 
RETURNS INTEGER AS
$$
BEGIN
  RETURN EXTRACT(YEAR FROM fecha);
END;
$$ LANGUAGE plpgsql;

SELECT public.anio(
    '2015-05-13'
)

-- Ejercicio 4. Indicar cuáles de las siguientes llamadas son correctas y cuáles no. (Para que la llamada fuera correcta, ahy que llamarlos con call).

--  1.- Incorrecta.
--  2.- Correcta.
--  3.- Inorrecta.
--  4.- Correcta.
--  5.- Incorrecta.
--  6.- Correcta.
--  7.- Correcta.
--  8.- Incorrecta.
--  9.- Incorrecta.
--  10.- Incorrecta.

-- Ejercicio 5. Codificar un procedimiento que reciba una lista de hasta 5 números y visualice su suma.
CREATE OR REPLACE FUNCTION sumar_numeros(
num1 INTEGER DEFAULT 0, num2 INTEGER DEFAULT 0, num3 INTEGER DEFAULT 0, num4 INTEGER DEFAULT 0, num5 INTEGER DEFAULT 0)
RETURNS INTEGER AS
$$
BEGIN
	RETURN num1+num2+num3+num4+num5;
END;
$$ LANGUAGE plpgsql;

SELECT public.sumar_numeros(
    5,5,5,5,5
)


-- Ejercicio 6. Realizar los siguientes procedimientos y funciones sobre la base de datos de jardinería.
  --1.-  
      CREATE OR REPLACE FUNCTION calcular_precio_total_pedido(
            codigo_pedido INT
            )
        RETURNS FLOAT
        AS $$
        DECLARE
            precio_total FLOAT;
        BEGIN
            SELECT SUM(precio_unidad * cantidad)
            INTO precio_total
            FROM detalle_pedido
            WHERE detalle_pedido.codigo_pedido = calcular_precio_total_pedido.codigo_pedido;
            
            RETURN precio_total;
        END;
        $$ LANGUAGE plpgsql;

        SELECT calcular_precio_total_pedido(10);


  -- 2.-
        CREATE OR REPLACE FUNCTION calcular_suma_pedidos_cliente(
            codigo_cliente INT
        )
        RETURNS FLOAT AS
        $$
        DECLARE
            suma_pedidos FLOAT;
        BEGIN
            SELECT SUM(calcular_precio_total_pedido(codigo_pedido))
            INTO suma_pedidos
            FROM pedido
            WHERE pedido.codigo_cliente = calcular_suma_pedidos_cliente.codigo_cliente;
            
            RETURN suma_pedidos;
        END;
        $$LANGUAGE plpgsql;

      SELECT calcular_suma_pedidos_cliente(1);



      

  -- 3.-
        CREATE OR REPLACE FUNCTION calcular_suma_pagos_cliente(
            codigo_cliente_parametro INT
        )
        RETURNS FLOAT AS 
        $$
        DECLARE
            suma_pagos FLOAT;
        BEGIN
            SELECT SUM(total)
            INTO suma_pagos
            FROM pago
            WHERE pago.codigo_cliente = codigo_cliente_parametro;
            
            RETURN suma_pagos;
        END;
        $$ LANGUAGE plpgsql;

        SELECT calcular_suma_pagos_cliente(1);




  -- 4.- 
CREATE OR REPLACE PROCEDURE calcular_pagos_pendientes() 
  AS $$
  DECLARE 
    cliente INTEGER; -- Contiene el codigo del cliente
    total_pedidos FLOAT; -- Precio total de todos los pedidos
    total_pagos FLOAT; -- Precio total de todos los pagos
    pendiente_pago FLOAT;
  BEGIN

  CREATE TABLE IF NOT EXISTS clientes_con_pagos_pendientes (
    id_cliente INT PRIMARY KEY, 
    suma_total_pedidos FLOAT, 
    suma_total_pagos FLOAT, 
    pendiente_de_pago FLOAT
    );
    
  FOR cliente IN SELECT DISTINCT codigo_cliente FROM pedido
    LOOP
        total_pedidos := calcular_suma_pedidos_cliente(cliente);
        total_pagos := calcular_suma_pagos_cliente(cliente);
        pendiente_pago := total_pedidos - total_pagos;
            
        IF total_pedidos > total_pagos THEN
        INSERT INTO clientes_con_pagos_pendientes (id_cliente, suma_total_pedidos, suma_total_pagos, pendiente_de_pago)
        VALUES (cliente, total_pedidos, total_pagos, pendiente_pago);
        --ELSE
        --INSERT INTO clientes_con_pagos_pendientes (id_cliente, suma_total_pedidos, suma_total_pagos, pendiente_de_pago)
        --VALUES (cliente, total_pedidos, total_pagos, FALSE);
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL calcular_pagos_pendientes;
        

-- Ejercicio 7. 
CREATE OR REPLACE PROCEDURE cambiar_localidad_oficina(
  codigo_oficina VARCHAR, nueva VARCHAR)
AS $$
  BEGIN
  UPDATE public.oficina as ofi
	SET ciudad = nueva 
  WHERE ofi.codigo_oficina = cambiar_localidad_oficina.codigo_oficina;
END;
$$ LANGUAGE plpgsql;

CALL cambiar_localidad_oficina('BCN-ES','Granada');

-- Ejercicio 8.

CREATE OR REPLACE PROCEDURE subida_salario (
    department_id_procedimiento departments.department_id%TYPE,
    salary_procedimiento employees.salary%TYPE,
    porcentaje INTEGER
) AS $$
DECLARE
  empleado RECORD;
BEGIN
    FOR empleado IN (
        SELECT employee_id, salary
        FROM employees
        WHERE department_id = department_id_procedimiento
    ) 
    LOOP
        IF (salary_procedimiento / 12) > (empleado.salary * (porcentaje / 100)) THEN
            UPDATE employees
            SET salary = salary + salary_procedimiento / 12
            WHERE employee_id = empleado.employee_id;
        ELSE
            UPDATE employees
            SET salary = salary + empleado.salary * (porcentaje / 100)
            WHERE employee_id = empleado.employee_id;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL subida_salario(1,500::money,10);


-- Ejercicio 9.


CREATE OR REPLACE PROCEDURE aumentar_sueldo_oficio()
AS
$$ DECLARE
    dep_avg_sal RECORD;
    employee_data RECORD;
    subida DECIMAL;
BEGIN
        FOR dep_avg_sal IN SELECT department_id,avg(salary::decimal) AS average FROM employees GROUP BY department_id
            LOOP
                raise notice 'ID DEPARTAMENTO: %',dep_avg_sal.department_id;
                raise notice 'ID AVG: %',dep_avg_sal.average;
                FOR employee_data IN SELECT employee_id,salary::Decimal FROM employees WHERE department_id=dep_avg_sal.department_id
                    LOOP
                        raise notice '   ID EMPLEADO: %',employee_data.employee_id;
                        raise notice '   SALARIO    : %',employee_data.salary;
                        IF employee_data.salary<dep_avg_sal.average THEN
                            subida:=0.5*(dep_avg_sal.average-employee_data.salary);
                            raise notice '          Subida prevista es de: %',subida;
                            
                            UPDATE employees
                            SET salary=salary+subida::money
                            WHERE employee_id=employee_data.employee_id;
                        END IF;
                    END LOOP;
            END LOOP;
END;
$$
LANGUAGE plpgsql;

CALL aumentar_sueldo_oficio();

-- Ejercicio 11. 


CREATE TABLE IF NOT EXISTS ex_empleados (
    employee_id numeric(8),
    first_name varchar(30),
    last_name varchar(30),
    birthdate date,
    address varchar(40),
    gender char,
    salary money,
    supervisor_id numeric(8),
    department_id numeric(8),
    fecha_baja timestamp
);


CREATE OR REPLACE FUNCTION actualizacion_empleado_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        IF NEW.last_name <> OLD.last_name OR NEW.employee_id <> OLD.employee_id OR NEW.salary > OLD.salary * 1.1 THEN
            RAISE EXCEPTION 'No se permite la modificación del empleado';
        END IF;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO ex_empleados (employee_id, first_name, last_name, birthdate, address, gender, salary, supervisor_id, department_id, fecha_baja)
        VALUES (OLD.employee_id, OLD.first_name, OLD.last_name, OLD.birthdate, OLD.address, OLD.gender, OLD.salary, OLD.supervisor_id, OLD.department_id, CURRENT_TIMESTAMP);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER actualizacion_empleado
    BEFORE DELETE OR UPDATE ON employees
    FOR EACH ROW
    EXECUTE FUNCTION actualizacion_empleado_trigger();

DELETE FROM works_in WHERE employee_id = 55555555;
DELETE FROM employees WHERE employee_id = 55555555;

--Ejercicio 12.


ALTER TABLE pedido ADD COLUMN baja BOOLEAN DEFAULT FALSE;

CREATE OR REPLACE FUNCTION borrar_pedido() RETURNS TRIGGER AS $$
BEGIN
        UPDATE pedido
        SET baja = TRUE
        WHERE codigo_pedido = OLD.codigo_pedido;
        RAISE NOTICE 'El pedido % a sido marcado como baja.',OLD.codigo_pedido;
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_borrar_pedido
BEFORE DELETE ON pedido
FOR EACH ROW
EXECUTE FUNCTION borrar_pedido();


DELETE FROM pedido WHERE codigo_pedido = 1;
