-- Carlos Bernal Barrionuevo - 3º Trimestre

-- Ejercicio 10.
-- Escribir un disparador en la base de datos de los ejercicios anteriores que haga fallar 
-- cualquier operación de modificación del apellido o del número de un empleado, o que 
-- suponga una subida de sueldo superior al 10%

CREATE OR REPLACE FUNCTION actualizacion_empleado()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.last_name <> OLD.last_name OR NEW.employee_id <> OLD.employee_id OR NEW.salary > OLD.salary * 1.1 THEN
        RAISE EXCEPTION 'No se permite la modificación del empleado';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizacion_empleado_trigger
    BEFORE UPDATE ON employees
    FOR EACH ROW
    EXECUTE FUNCTION actualizacion_empleado();




-- Ejemplos para probar:

-- Cambiar el nombre. (Salta excepción)
UPDATE employees
SET last_name = 'Gómez'
WHERE employee_id = 11111111;

--Cambiar el salario. (Salta excepción)
UPDATE employees
SET salary = 3000
WHERE employee_id = 11111111;

-- Cambiar id del empleado. (Salra excepción)
UPDATE employees
SET employee_id = 12345678
WHERE employee_id = 11111111;

--Cambiar el salario. (No salta excepción)
UPDATE employees
SET salary = 1400
WHERE employee_id = 11111111;


----------------------------------------------------------------
----------------------------------------------------------------


-- Ejercicio 13. 
-- Queremos que se guarde en una tabla altas_empleados el historial de inserciones de registros
-- realizadas en la tabla empleados, además de los datos del empleado se deberá guardar en la 
-- tabla el usuario que realizó la inserción del empleado y la fecha/hora de la operación. La 
-- primera vez que se ejecute el disparador deberá crear la tabla si no existe y rellenarla con los
-- empleados que contenga la base de datos en ese momento.

CREATE OR REPLACE FUNCTION altas_empleados()
RETURNS TRIGGER AS $$
BEGIN
    -- Comprobar si la tabla existe o no.
    IF NOT EXISTS (SELECT 1 FROM pg_tables WHERE schemaname = 'public' AND tablename = 'altas_empleados') THEN
        CREATE TABLE altas_empleados (
            codigo_empleado INTEGER NOT NULL,
            nombre VARCHAR(50) NOT NULL,
            apellido1 VARCHAR(50) NOT NULL,
            apellido2 VARCHAR(50) DEFAULT NULL,
            extension VARCHAR(10) NOT NULL,
            email VARCHAR(100) NOT NULL,
            codigo_oficina VARCHAR(10) NOT NULL,
            codigo_jefe INTEGER DEFAULT NULL,
            puesto VARCHAR(50) DEFAULT NULL,
            usuario TEXT NOT NULL,
            fecha TIMESTAMP NOT NULL
        );
    END IF;
        INSERT INTO altas_empleados (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto, usuario, fecha)
        SELECT e.codigo_empleado,e.nombre,e.apellido1,e.apellido2,e.extension,e.email,e.codigo_oficina,e.codigo_jefe,e.puesto,current_user,current_timestamp
        FROM empleado AS e
        WHERE NOT EXISTS (SELECT * FROM altas_empleados AS a WHERE a.codigo_empleado = e.codigo_empleado);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER altas_empleados_trigger
AFTER INSERT ON empleado
FOR EACH ROW
EXECUTE FUNCTION altas_empleados();


-- Ejemplos para probar:

INSERT INTO empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina)
VALUES (32, 'Carlos', 'Bernal', 'Barrionuevo', '1234', 'john.doe@example.com', 'TAL-ES');


----------------------------------------------------------------
----------------------------------------------------------------


-- Ejercicio 14.
-- Hacer que se actualicen automáticamente las existencias de los productos cuando se inserte 
-- un nuevo pedido o cuando se rectifique la cantidad de uno existente. Se supone que un 
-- pedido produce una reducción del stock (existencias) del producto

-- Insertar
CREATE OR REPLACE FUNCTION insert_pedido()
  RETURNS TRIGGER AS $$
BEGIN
  UPDATE producto
  SET cantidad_en_stock = cantidad_en_stock - NEW.cantidad
  WHERE codigo_producto = NEW.codigo_producto;
  RAISE NOTICE 'El stock se insertó correctamente';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_pedido_trigger
AFTER INSERT ON detalle_pedido
FOR EACH ROW
EXECUTE FUNCTION insert_pedido();



-- Actualizar
CREATE OR REPLACE FUNCTION update_pedido()
  RETURNS TRIGGER AS $$
BEGIN
  UPDATE producto
  SET cantidad_en_stock = cantidad_en_stock + OLD.cantidad - NEW.cantidad
  WHERE codigo_producto = NEW.codigo_producto;
  RAISE NOTICE 'El stock se actualizó correctamente';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_pedido_trigger
AFTER UPDATE ON detalle_pedido
FOR EACH ROW
EXECUTE FUNCTION update_pedido();


-- Ejemplos para probar:

-- Insertar nuevo stock:
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea)
VALUES (1, 'OR-140', 3, 50, 1);

-- Rectificar cantidad de stock: 
UPDATE detalle_pedido
SET cantidad = 15
WHERE codigo_pedido = 1
AND codigo_producto = 'OR-140';