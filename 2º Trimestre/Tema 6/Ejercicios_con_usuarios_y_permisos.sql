-- 1. -- Crear un usuario root y utilizarlo para iniciar sesión en la base de datos sakila del servidor local.

CREATE USER root WITH PASSWORD 'root';


-- 2. -- Crear un usuario con nombre de usuario myuser y contraseña mypass

CREATE USER myuser WITH PASSWORD 'mypass';


-- 3. -- Crear un nuevo usuario testUser con una contraseña testpwd. El usuario testUser tiene 
-- permisos de consulta y actualización en todos los datos, y se le otorgan permisos SELECT y 
-- UPDATE en todas las tablas de datos

CREATE USER testUser WITH PASSWORD 'testpwd';
GRANT SELECT,UPDATE ON ALL TABLES IN SCHEMA public TO testUser;


-- 4. -- Crear una nueva cuenta con el nombre de usuario customer1 y contraseña customer1.

CREATE USER customer1 WITH PASSWORD 'customer1';


-- 5. -- Utilizar DROP USER para eliminar el usuario 'myuser' @ 'localhost'

DROP USER myuser;
DROP USER localhost;


-- 6. -- Cambiar la contraseña del usuario root a "rootpwd2":

ALTER USER root WITH PASSWORD 'rootpwd2';


-- 7. -- Utilizar la instrucción GRANT para crear un nuevo usuario grantUser con la contraseña 
-- "grantpwd". El usuario grantUser tiene permisos de consulta e inserción para todos los 
-- datos, y además concede permisos GRANT.

CREATE USER grantUser WITH PASSWORD 'grantpwd';
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA public TO grantUser WITH GRANT OPTION;


-- 8. -- Utilizar la instrucción REVOKE para cancelar el permiso de actualización del usuario 
testUser

REVOKE UPDATE ON ALL TABLES IN SCHEMA public FROM testUser;


-- 9. -- Consultar la información de permisos del usuario testUser.

\du testUser


-- 10. -- Crea usuarios y permisos para la base de datos Sakila considerando las siguientes 
-- restricciones de seguridad:
-- • Administrador: todos los permisos.
-- • Operador nivel 1: tiene acceso de lectura en todas las tablas. Puede operar en todas tablas
-- menos en la tabla payment donde sólo puede consultar. No puede modificar la estructura de 
-- ninguna tabla.
-- • Operador nivel 2: puede consultar todas las tablas y modificar las tablas customer y payment
-- menos los campos customer_id, create_date y last_update.

CREATE USER Administrador WITH PASSWORD 'Administrador';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Administrador;

CREATE USER Operador1 WITH PASSWORD 'Operador1';
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO Operador1;
REVOKE INSERT, UPDATE, DELETE ON payment to Operador1;

CREATE USER Operador2 WITH PASSWORD 'Operador2';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Operador2;
GRANT INSERT, UPDATE, DELETE ON customer,payment TO Operador2;
REVOKE INSERT, UPDATE, DELETE ON customer_id, create_date y last_update to Operador2; --Mal

-- EJERCICIOS CON VISTAS -- 

-- 21. Escribir una vista que se llame listado_pagos_clientes que muestre un listado donde 
-- aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. La vista deberá 
-- tener las siguientes columnas: nombre y apellidos del cliente concatenados, teléfono, ciudad,
-- pais, fecha_pago, total del pago, id de la transacción.

CREATE VIEW listado_pagos_clientes AS(
    SELECT cli.nombre_contacto|| ' ' ||cli.apellido_contacto AS cliente, cli.telefono, cli.ciudad, cli.pais, p.fecha_pago, p.total, p.id_transaccion
    FROM cliente AS cli
    INNER JOIN pago AS p ON cli.codigo_cliente = p.codigo_cliente
);

SELECT * FROM listado_pagos_clientes;


-- 22. Escribir una vista que se llame listado_pedidos_clientes que muestre un listado donde 
-- aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos. La vista 
-- deáber tener las siguientes columnas: nombre y apellidos del cliente concatendados, 
-- teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha esperada, fecha de entrega 
-- y la cantidad total del pedido, que será la suma del producto de todas las cantidades por el 
-- precio de cada unidad, que aparecen en cada línea de pedido.

CREATE VIEW listado_pedidos_clientes AS(
    SELECT CONCAT(cli.nombre_contacto,' ',cli.apellido_contacto)AS cliente, cli.telefono, cli.ciudad, cli.pais, 
    p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, SUM(dp.cantidad * dp.precio_unidad)
    FROM cliente AS cli
    INNER JOIN pedido AS p ON cli.codigo_cliente = p.codigo_cliente
    INNER JOIN detalle_pedido AS dp ON p.codigo_pedido = dp.codigo_pedido
    GROUP BY cliente, cli.telefono, cli.ciudad, cli.pais, p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega
);


-- 23. Utilizar las vistas creadas en los ejercicios 21 y 22 para devolver un listado de los clientes de
-- la ciudad de Madrid que han realizado pagos.

SELECT DISTINCT cliente 
FROM listado_pagos_clientes
WHERE ciudad = 'Madrid' AND  total IS NOT NULL;


-- 24. Ídem para devolver un listado de los clientes que todavía no han recibido su pedido.

SELECT DISTINCT cliente 
FROM listado_pedidos_clientes 
WHERE fecha_entrega IS NULL;


-- 25.  Ídem para calcular el número de pedidos que se ha realizado cada uno de los clientes.

SELECT DISTINCT cliente, COUNT(codigo_pedido) 
FROM listado_pedidos_clientes
GROUP BY cliente;


-- 26. Ídem para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.

SELECT DISTINCT cliente, MAX(sum), MIN(sum)
FROM listado_pedidos_clientes
GROUP BY cliente;


-- 27. Modificar el nombre de las vista listado_pagos_clientes y asignarle el nombre 
-- listado_de_pagos. Una vez que haya modificado el nombre de la vista realizar una consulta 
-- utilizando el nuevo nombre de la vista para comprobar que sigue funcionando 
-- correctamente.

ALTER VIEW listado_pagos_clientes
RENAME TO listado_de_pagos;


-- 28. Eliminar las vistas creadas en los ejercicios 21 y 22.

DROP VIEW IF EXISTS listado_de_pagos, listado_pedidos_clientes;