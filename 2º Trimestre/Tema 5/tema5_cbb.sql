-- BLOQUE A --

-- 1.4.5 - 10: Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre_cliente FROM cliente AS c
INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_esperada < p.fecha_entrega; 


-- 1.4.6 - 9: Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostra el nombre, la descripción y la imagen del producto.
SELECT pr.nombre, g.descripcion_texto, g.imagen
FROM producto AS pr 
INNER JOIN gama_producto AS g ON pr.gama = g.gama
LEFT JOIN detalle_pedido AS dp ON pr.codigo_producto = dp.codigo_producto
LEFT JOIN pedido pe ON dp.codigo_pedido = pe.codigo_pedido
WHERE dp.codigo_producto IS NULL;


-- 1.4.7 - 12: Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, p.estado, COUNT(DISTINCT d.codigo_producto) AS n_de_productos_diferentes 
FROM pedido AS p
INNER JOIN detalle_pedido AS d ON d.codigo_pedido = p.codigo_pedido
GROUP BY p.codigo_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, p.estado;

-- 1.4.7 - 14: Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT p.nombre, det.codigo_producto , SUM(cantidad) AS  unidades
FROM detalle_pedido AS det
INNER JOIN producto AS p ON p.codigo_producto = det.codigo_producto
GROUP BY p.nombre, det.codigo_producto 
ORDER BY unidades DESC LIMIT 20;


-- 1.4.8.1 - 2: Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT p.nombre FROM producto AS p 
WHERE p.precio_venta = 
    (SELECT MAX(precio_venta) 
    FROM producto);


-- 1.4.8.1 - 5: Devuelve el producto que más unidades tiene en stock.
SELECT nombre, cantidad_en_stock FROM producto 
WHERE cantidad_en_stock = 
    (SELECT MAX(cantidad_en_stock) 
    FROM producto);


-- 1.4.8.2 - 8: Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente FROM cliente
WHERE limite_credito >= ALL 
    (SELECT limite_credito
    FROM cliente);


-- 1.4.8.3 - 16: Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT * FROM oficina o 
WHERE o.codigo_oficina NOT IN 
(SELECT DISTINCT ofi.codigo_oficina
    FROM oficina ofi 
    INNER JOIN empleado AS emp ON emp.codigo_oficina = o.codigo_oficina
    INNER JOIN cliente AS cli ON cli.codigo_empleado_rep_ventas = emp.codigo_empleado
    INNER JOIN pedido AS pe ON cli.codigo_cliente = pe.codigo_cliente
    INNER JOIN detalle_pedido AS dp ON pe.codigo_pedido = dp.codigo_pedido
    INNER JOIN producto AS pro ON dp.codigo_producto = pro.codigo_producto
    WHERE pro.gama = 'Frutales');


-- 1.4.8.4 - 20: Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM  producto AS p 
WHERE NOT EXISTS 
    (SELECT * FROM detalle_pedido AS d 
    WHERE d.codigo_producto=p.codigo_producto);

-- 1.4.9 - 4: Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
SELECT c.nombre_cliente, e.nombre , e.apellido1 , o.telefono FROM cliente AS c
LEFT JOIN empleado AS e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
LEFT JOIN oficina AS o ON e.codigo_oficina = o.codigo_oficina 
LEFT JOIN pago AS p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;