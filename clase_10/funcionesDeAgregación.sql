SELECT COUNT(*), MAX(title), SUM(length), AVG(rating)
FROM movies
WHERE title Like "Toy Story%";

SELECT genre_id, COUNT(*)
FROM movies
GROUP BY genre_id;

SELECT awards, title, COUNT(*)
FROM movies
GROUP BY awards;

SELECT genre_id, COUNT(*)
FROM movies
GROUP BY genre_id
HAVING COUNT(*) <= 2;

/*PRACTICA CONSULTAS*/
/*Cuantas películas hay?*/
SELECT COUNT(id)
FROM movies;
/*Cuantas peliculas tienen entre 3 y 7 premios*/
SELECT COUNT(id)
FROM movies
WHERE awards BETWEEN 3 AND 7;
/*Cuantas películas tienen entre 3 y 7 premios y un rating mayor a 7?*/
SELECT COUNT(id)
FROM movies
WHERE awards BETWEEN 3 AND 7
AND rating > 7;
/*Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.*/
SELECT genre_id, COUNT(genre_id)
FROM movies
GROUP BY genre_id;
/*De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.*/
SELECT genre_id, SUM(awards) AS sumatoria_de_premios,COUNT(awards) AS cantidad_premios
FROM movies
GROUP BY genre_id
HAVING SUM(awards) > 5;


