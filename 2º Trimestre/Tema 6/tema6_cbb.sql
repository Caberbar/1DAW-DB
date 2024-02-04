-- Carlos Bernal Barrionuevo
-- BLOQUE A


-------------------------------------------------------------------------------------------------
-- Se desea habilitar los siguientes departamentos:

-- PUBLICIDAD --  Terminado
CREATE ROLE publicidad;

GRANT SELECT ON producto, gama_producto, cliente TO publicidad;
GRANT INSERT, DELETE ON producto, gama_producto, cliente TO publicidad;

-- COMERCIAL -- Terminado
CREATE ROLE comercial;

GRANT SELECT ON pedido, cliente, producto, pago TO comercial;  
GRANT UPDATE ON producto, gama_producto, pedido TO comercial;
GRANT UPDATE (limite_credito) ON cliente TO comercial;

-- TIENDA EN LINEA -- Terminado
CREATE ROLE tienda_en_linea;

GRANT INSERT, UPDATE ON cliente TO tienda_en_linea;
GRANT INSERT ON pago TO tienda_en_linea;
GRANT INSERT, UPDATE ON pedido TO tienda_en_linea;

-- RECURSOS HUMANOS -- Terminado
CREATE ROLE recursos_humanos;

GRANT SELECT ON empleado TO recursos_humanos;
GRANT UPDATE (telefono, linea_direccion1, linea_direccion2) ON oficina TO recursos_humanos;
REVOKE DELETE ON oficina FROM recursos_humanos;

-- ADMINISTRACIÓN -- Terminado
CREATE ROLE administracion;

GRANT ALL PRIVILEGES ON DATABASE jardineria TO administracion;



-- ¿Qué permisos y accesos correspondientes a las vistas creadas se deberían asignar a cada departamento? Indicar en un comentario

    -- 1º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla oficina.
        -- Departamento de Comercial: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla oficina.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla oficina.
        -- Departamento de Recursos humanos: No haría falta adignar ningún permiso.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 4º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Comercial: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Recursos humanos: No haría falta adignar ningún permiso.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 7º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Comercial: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Recursos humanos: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla cliente.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 10º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Comercial: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla empleado.
        -- Departamento de Recursos humanos: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla cliente.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 13º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Comercial: No haría falta asignar ningún permiso.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Recursos humanos: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 16º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Comercial: No haría falta asignar ningún permiso.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Recursos humanos: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Administración: No haría falta asignar ningún permiso.

    -- 19º Vista:
        -- Departamento de Publicidad: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Comercial: No haría falta asignar ningún permiso.
        -- Departamento de Tienda en línea: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido y detalle_pedido.
        -- Departamento de Recursos humanos: Se deberian asignar pernmisos para acceder a la informacion (SELECT) a la tabla pedido, detalle_pedido y cliente.
        -- Departamento de Administración: No haría falta asignar ningún permiso.


-- Crear tres usuarios correspondientes a tres de los grupos anteriores y comprobar sus permisos.

CREATE USER publicidad_usuario WITH PASSWORD 'password1';
CREATE USER comercial_usuario WITH PASSWORD 'password2';
CREATE USER tienda_usuario WITH PASSWORD 'password3';

GRANT publicidad TO publicidad_usuario;
GRANT comercial TO comercial_usuario;
GRANT tienda_en_linea TO tienda_usuario;

REVOKE ALL PRIVILEGES ON DATABASE jardineria FROM publicidad;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM publicidad;



-------------------------------------------------------------------------------------------------



-- 1. Listado con la ciudad y el teléfono de las oficinas de España --Terminado
CREATE VIEW oficinas_espana AS(
    SELECT pais, ciudad, telefono 
    FROM oficina 
    WHERE pais = 'España'
);

-- El programa o la base ed datos no reconoce la ñ.

-- 4. Listado de nombre, apellidos y cargo de los empleados que NO sean directores de oficina --Terminado
CREATE VIEW empleados_no_directores AS(
    SELECT nombre, apellido1, apellido2, puesto 
    FROM empleado
    WHERE puesto != 'Director Oficina'
);

-- 7. Listado con el nombre de los todos los clientes españoles junto al nombre completo (en un solo campo) de su representante de ventas --Terminado
CREATE VIEW clientes_con_representantes AS(
    SELECT c.nombre_cliente AS "Nombre cliente", (e.nombre|| ' ' ||e.apellido1|| ' ' ||e.apellido2) AS "Nombre completo representante"
    FROM cliente AS c
    INNER JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    WHERE c.pais LIKE 'Spain'
);

-- 10. Listado con el nombre de los clientes que hayan realizado pagos junto con el nombre completo (en una sola columna) de sus representantes de ventas
CREATE VIEW clientes_pago_representates AS(
    SELECT c.nombre_cliente AS "Nombre cliente", (e.nombre|| ' ' ||e.apellido1|| ' ' ||e.apellido2) AS "Nombre representante"
    FROM cliente AS c
    INNER JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
    INNER JOIN pago AS p ON c.codigo_cliente = p.codigo_cliente
    WHERE p.fecha_pago IS NOT NULL
);

-- 13. Realizar una vista con la información del pedido (código, fecha de pedido, fecha esperada, fecha entrega, nombre cliente y total en euros) ordenado por total de forma descendente
CREATE VIEW vista_pedido AS(
    SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega,c.nombre_cliente, SUM(dp.cantidad * dp.precio_unidad) AS total
    FROM pedido AS p
    INNER JOIN cliente AS c ON p.codigo_cliente = c.codigo_cliente
    INNER JOIN detalle_pedido AS dp ON p.codigo_pedido = dp.codigo_pedido
	GROUP BY p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega,c.nombre_cliente
    ORDER BY total DESC
);

-- 16. Listado de los pedidos donde el precio del mismo sea superior a la media de todos
CREATE VIEW pedido_media AS(
    SELECT * FROM pedido ped
    WHERE
        (SELECT SUM(dp.cantidad * dp.precio_unidad) AS total
            FROM detalle_pedido AS dp
            WHERE ped.codigo_pedido = dp.codigo_pedido
            GROUP BY dp.codigo_pedido)
    >
        (SELECT AVG(total)
        FROM (select p.codigo_pedido, SUM(dp.cantidad * dp.precio_unidad) AS total
            FROM pedido p
            INNER JOIN detalle_pedido AS dp ON p.codigo_pedido = dp.codigo_pedido
            GROUP BY p.codigo_pedido) total)
);

-- 19. Crear una vista en la que se desglose la cantidad de pedidos, clientes, y total facturado por países, ordenado por la última cifra -- PREGUNTAR AL PROFESOR
CREATE VIEW vista_pais_resumen AS(
    SELECT 
    cli.pais,
    COUNT(DISTINCT ped.codigo_pedido) AS cantidad_pedidos,
    COUNT(DISTINCT cli.codigo_cliente) AS cantidad_clientes,
    SUM(dp.cantidad * dp.precio_unidad) AS total_facturado
    FROM pedido ped 
    INNER JOIN cliente AS cli ON ped.codigo_cliente = cli.codigo_cliente
    INNER JOIN detalle_pedido AS dp ON ped.codigo_pedido = dp.codigo_pedido
    GROUP BY cli.pais
    ORDER BY total_facturado;
);