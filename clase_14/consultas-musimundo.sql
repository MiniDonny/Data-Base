/*Listar las canciones cuya duración sea mayor a 2 minutos.*/
SELECT nombre  , milisegundos
FROM canciones
WHERE milisegundos > 120000
ORDER BY milisegundos DESC;
/*Listar las canciones cuyo nombre comience con una vocal. */
SELECT nombre
FROM canciones
WHERE nombre LIKE 'A%' OR nombre LIKE 'E%' OR nombre LIKE 'I%' OR nombre LIKE 'O%' OR nombre LIKE'U%' 
ORDER BY nombre ASC;
/*Canciones*/
/*Listar las canciones ordenadas por compositor en forma descendente.*/
SELECT compositor, nombre
FROM canciones
ORDER BY compositor DESC;
/*Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor. */
SELECT compositor, nombre
FROM canciones
WHERE compositor != ""
ORDER BY compositor ASC;
/*Canciones*/
/*Listar la cantidad de canciones de cada compositor. */
SELECT compositor, COUNT(id) AS cantidad_canciones
FROM canciones
WHERE compositor != ""
GROUP BY compositor
ORDER BY compositor ASC;
/*Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. */
SELECT compositor, COUNT(id) AS cantidad_canciones
FROM canciones
WHERE compositor != ""
GROUP BY compositor
HAVING COUNT(id) > 10
ORDER BY compositor ASC;
/*Facturas*/
/*Listar el total facturado agrupado por ciudad.*/
SELECT ciudad_de_facturacion, SUM(id) AS total_facturado
FROM facturas
GROUP BY ciudad_de_facturacion;
/*Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.*/
SELECT pais_de_facturacion , COUNT(ciudad_de_facturacion), SUM(id) AS total_facturado
FROM facturas
WHERE pais_de_facturacion LIKE 'Canada%' 
GROUP BY pais_de_facturacion;
/*Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.*/
/*Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.*/
/*6. Canciones / Géneros*/
/*Listar la duración mínima, máxima y promedio de las canciones. */
/*Modificar el punto (a) mostrando la información agrupada por género.*/
