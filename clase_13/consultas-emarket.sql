/*Consultas queries XL parte I - GROUP BY
Vamos a practicar sobre consultas SELECT, enfocándonos en group by, having y distinct.
Tips:
Cada enunciado se corresponde con una consulta SELECT.
Recordá ir guardando las consultas. SQL.*/

/*Consignas*/

/*Clientes*/
/*¿Cuántos clientes existen?*/
SELECT COUNT(ClienteID) AS total_clientes
FROM clientes;
/*¿Cuántos clientes hay por ciudad?*/
SELECT Pais , COUNT(ClienteID) AS clientes
FROM clientes
GROUP BY Pais;

/*Facturas*/
/*¿Cuál es el total de transporte?*/
SELECT COUNT(Transporte) AS total_transporte
FROM facturas;
/*¿Cuál es el total de transporte por EnvioVia (empresa de envío)?*/
SELECT EnvioVia, COUNT(Transporte) AS total_transporte
FROM facturas
GROUP BY EnvioVia;
/*Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.*/
SELECT ClienteID, COUNT(FacturaID) AS total_facturas
FROM facturas
GROUP BY ClienteID
ORDER BY COUNT(FacturaID) DESC;
/*Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.*/
SELECT ClienteID, COUNT(FacturaID) AS total_facturas
FROM facturas
GROUP BY ClienteID 
HAVING COUNT(FacturaID) BETWEEN 19 AND 31
ORDER BY COUNT(FacturaID) DESC;
/*¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?*/
SELECT PaisEnvio, MIN(FacturaID)
FROM facturas
GROUP BY PaisEnvio
HAVING MIN(FacturaID)
LIMIT 1;
/*Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?*/
SELECT EmpleadoID, COUNT(FacturaID)
FROM facturas
GROUP BY EmpleadoID
HAVING COUNT(FacturaID) >= 156;
/*Factura detalle*/
/*¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?*/
SELECT ProductoID, COUNT(ProductoID) AS total
FROM facturadetalle
GROUP BY ProductoID
ORDER BY COUNT(ProductoID) DESC
LIMIT 1;
/*¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.*/

/*¿Cuál es el total facturado para los productos ID entre 30 y 50?*/
/*¿Cuál es el precio unitario promedio de cada producto?*/
/*¿Cuál es el precio unitario máximo?*/




