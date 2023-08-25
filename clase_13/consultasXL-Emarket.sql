/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”*/
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

