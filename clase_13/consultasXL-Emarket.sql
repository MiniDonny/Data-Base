/*Generar un listado de todas las facturas del empleado 'Buchanan'. */
SELECT *
FROM empleados e
INNER JOIN facturas f 
ON e.EmpleadoID = f.EmpleadoID
WHERE e.Apellido LIKE 'Buchanan%';
/*Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.*/
SELECT *
FROM correos c
INNER JOIN facturas f
ON f.EnvioVia = c.CorreoID
WHERE c.Compania LIKE 'Speedy Express';
/*Generar un listado de todas las facturas con el nombre y apellido de los empleados.*/
SELECT e.Nombre, e.Apellido, f.*
FROM empleados e
INNER JOIN facturas f
ON e.EmpleadoID = f.EmpleadoID;
/*Mostrar un listado de las facturas de todos los clientes “Owner”  y país de envío “USA”.*/
SELECT *
FROM clientes c
INNER JOIN facturas f
ON c.ClienteID = f.ClienteID
WHERE c.Titulo LIKE 'Owner' AND f.PaisEnvio = 'USA';
/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = 42*/
SELECT e.Apellido, f.*
FROM facturas f
JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
WHERE e.Apellido LIKE 'Leverling%';

SELECT p.ProductoID, fc.*, f.*, e.Apellido, p.ProductoNombre
FROM facturas f
JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
JOIN facturadetalle fc ON fc.FacturaID = f.FacturaID
JOIN productos p ON p.ProductoID = fc.ProductoID
WHERE p.ProductoID = 42
AND e.Apellido LIKE 'Leverling%';
/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”*/
SELECT p.ProductoID, fc.*, f.*, e.Apellido, p.ProductoNombre
FROM facturas f
JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
JOIN facturadetalle fc ON fc.FacturaID = f.FacturaID
JOIN productos p ON p.ProductoID = fc.ProductoID
WHERE e.Apellido LIKE 'Leverling%' 
AND p.ProductoID IN ('80', '42');
/*Generar un listado con los cinco mejores clientes, 
según sus importes de compras total (PrecioUnitario * Cantidad).*/
SELECT c.Compania AS cliente, SUM(fd.PrecioUnitario * fd.Cantidad) AS total_compras
FROM clientes c
JOIN facturas f ON c.ClienteID = f.ClienteID
JOIN facturadetalle fd ON fd.FacturaID = f.FacturaID
GROUP BY c.Compania
ORDER BY total_compras DESC
LIMIT 5;
/*Generar un listado de facturas, con los campos id, nombre y apellido del cliente, 
fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
*/
SELECT c.ClienteID AS ID, c.Compania, c.Titulo, f.FechaFactura, f.PaisEnvio
FROM clientes c
INNER JOIN facturas f ON c.ClienteID = f.ClienteID
ORDER BY f.FechaFactura DESC
LIMIT 10;
