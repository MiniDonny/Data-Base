/*Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.*/
SELECT c.CategoriaNombre, p.ProductoNombre
FROM categorias c
LEFT JOIN productos p ON c.CategoriaID = p.CategoriaID;
/*Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.*/
SELECT c.Contacto, f.FacturaID
FROM clientes c
LEFT JOIN facturas f ON c.ClienteID = f.ClienteID
WHERE f.FacturaID IS NULL;
/*Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor.
Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor*/
SELECT product.ProductoNombre, product.CategoriaID, prov.Contacto
FROM productos AS product
LEFT JOIN proveedores AS prov 
ON product.ProveedorID = prov.ProveedorID 
ORDER BY prov.Contacto ASC;
/*Para cada categoría listar el promedio del precio unitario de sus productos.*/
SELECT CategoriaNombre, AVG(PrecioUnitario)
FROM categorias c
JOIN productos p
ON c.CategoriaID = p.CategoriaID
GROUP BY CategoriaNombre;
/*Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.*/
SELECT c.ClienteID, MAX(FechaFactura)
FROM clientes c
LEFT JOIN facturas f
ON f.ClienteID = c.ClienteID
GROUP BY c.ClienteID;
/*Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo,
 y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.*/
SELECT f.FacturaID, c.*
FROM correos c
RIGHT JOIN facturas f ON c.CorreoID = f.EnvioVia
