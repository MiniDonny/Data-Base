/*Obtener el nombre y apellido de los primeros 5 actores disponibles.
 Utilizar alias para mostrar los nombres de las columnas en español.
*/
SELECT CONCAT(first_name, " " ,last_name) AS nombre_completo
FROM actor
WHERE actor_id <= 5;
/*Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) inactivos.
 Utilizar alias para mostrar los nombres de las columnas en español.
 */
 SELECT CONCAT(first_name, " " ,last_name) AS nombre_completo, email AS correo_electronico
 FROM customer
 WHERE active = 0;
 /*Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco.
 Ordenar por rental_duration de mayor a menor. Utilizar alias para mostrar los nombres de las columnas en español.*/
 SELECT title AS titulo, description AS descripción, release_year AS año
 FROM film
 WHERE rental_duration >= 5
 ORDER BY rental_duration DESC;
 /*Obtener un listado de alquileres (rentals) que se hicieron durante el mes de mayo de 2005, 
 incluir en el resultado todas las columnas disponibles.
*/
SELECT rental_id AS alquileres , rental_date AS tiempo
FROM rental
WHERE YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05;
/*Obtener la cantidad TOTAL de alquileres (rentals).
 Utilizar un alias para mostrarlo en una columna llamada cantidad.*/
 SELECT  COUNT(rental_id) AS cantidad_alquileres
 FROM rental;
 /*Obtener la suma TOTAL de todos los pagos (payments).
 Utilizar un alias para mostrarlo en una columna llamada total, 
 junto a una columna con la cantidad de alquileres con el alias Cantidad y una columna que indique el Importe promedio por alquiler.
*/
SELECT SUM(payment_id) AS total_pagos,COUNT(customer_id) AS cantidad_alquileres, AVG(amount) AS promedio_por_alquiler
FROM payment;
/*Generar un reporte que responda la pregunta: 
¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen?
*/
SELECT c.customer_id AS cleintes , SUM(p.amount) AS total_dinero_gastado, COUNT(p.rental_id) AS total_aquileres
FROM customer c
INNER JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10; 
/*Generar un reporte que indique: ID de cliente,
 cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres.*/
 SELECT c.customer_id AS cliente , COUNT(rental_id) AS total_alquileres , SUM(p.amount) AS total_pagado
 FROM customer c
 JOIN payment p ON p.customer_id = c.customer_id
 GROUP BY c.customer_id
 HAVING SUM(p.amount) > 150 ;
 /*Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
 la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de alquiler 2005
 (rental_date de tabla rental).
*/
SELECT MONTH(r.rental_date) AS mes_alquiler , SUM(r.rental_id) , SUM(p.amount)
FROM rental r
JOIN payment p ON p.rental_id = r.rental_id
WHERE YEAR(r.rental_date) = 2005
GROUP BY MONTH(r.rental_date);
/*Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? 
(columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres.
*/
SELECT i.inventory_id AS inventarios , COUNT(r.rental_id) AS cantidad_alquileres
FROM rental r
JOIN inventory i 
ON i.inventory_id = r.inventory_id
GROUP BY i.inventory_id
ORDER BY COUNT(r.rental_id) DESC
LIMIT 5;

