/*Examen Final - Bases de datos
Consultas a la Base de datos Pokemon

Introducción 
¡Bienvenido al examen final del curso de Bases de Datos! 
En esta ocasión, pondrás a prueba tus habilidades en el uso de MySQL Workbench y tu capacidad para realizar consultas a una base de datos en equipo. Estamos emocionados de que hayas llegado hasta aquí y estés listo para enfrentar este desafío. 

En esta ocasión, nos sumergimos en el emocionante mundo de Pokémon a través de una base de datos que contiene información relevante sobre estas criaturas. Utilizaremos MySQL Workbench, una herramienta poderosa que te permitirá gestionar y consultar la base de datos de manera eficiente.

¿Empezamos?
Para iniciar, necesitamos que descargues la base de datos Pokémon click aquí. Esta base se encuentra en un archivo .sql que se debe importar desde MySQL Workbench. Luego, desde la pestaña “File -> Open SQL Script”, buscá y abrí el pokemon.sql que descargaste. Por último, ejecuta el script desde el ícono del rayo.

Cumplidos todos estos pasos, vamos a ver qué reportes nos solicitan.
¡Buena suerte! 😎✨✨

Consignas
A continuación encontrarás una serie de ejercicios a resolver:*/

/*Where*/
	/*Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5.
	Tablas: pokemon
	Campos: nombre, peso, altura*/
    SELECT nombre, altura, peso
    FROM pokemon
    WHERE altura < 0.5;
	/*Mostrar los nombres, descripciones, potencia y precisión de los movimientos cuya potencia esté entre 70 y 100, la precisión sea mayor a 80.
	Tablas: movimiento
	Campos: nombre, descripcion, potencia, precision_mov*/
    SELECT nombre, descripcion, potencia, precision_mov
    FROM movimiento
    WHERE potencia BETWEEN 70 AND 100
    AND precision_mov > 80;
/*Operadores & joins*/
	/*Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, junto con el nombre del tipo al que pertenecen.
	Tablas: movimiento, tipo
	Campos: m.nombre, t.nombre, potencia*/
    SELECT m.nombre, t.nombre, m.potencia
    FROM movimiento m
    INNER JOIN tipo t ON m.id_tipo = t.id_tipo
    WHERE m.potencia BETWEEN 50 AND 80;
    /*Mostrar los nombre, potencia y tipo de los movimientos que tienen un tipo de ataque "Físico" y una precisión mayor a 85.
	Tablas: tipo, tipo_ataque, movimiento
	Campos: m.nombre, m.potencia, m.precision_mov, ta.tipo*/
    SELECT m.nombre, m.potencia, m.precision_mov, ta.tipo
    FROM movimiento m
	JOIN tipo t ON m.id_tipo = t.id_tipo
    JOIN tipo_ataque ta ON ta.id_tipo_ataque = t.id_tipo_ataque
    WHERE ta.tipo LIKE 'Físico'
    AND m.precision_mov > 85 ;
/*Order by*/
	/*Mostrar los nombres y números de Pokédex de los Pokémon en orden descendente según su número de Pokédex.
	Tablas: pokemon
	Campos: numero_pokedex, nombre*/
    SELECT numero_pokedex, nombre
    FROM pokemon
    ORDER BY numero_pokedex DESC;
	/*Mostrar numero de pokedex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente.
	Tablas: pokemon
	Campos: numero_pokedex, nombre, altura
	*/
    SELECT p.numero_pokedex, p.nombre, p.altura, t.nombre
    FROM pokemon p
    JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
    JOIN tipo t ON pt.id_tipo = t.id_tipo
    WHERE t.nombre LIKE 'Roca'
    ORDER BY p.altura ASC;
/*Funciones de agregación*/
	/*¿Cuántos Pokémon tienen un promedio de defensa superior a 100?
		Tablas: estadisticas_base
	Campos: defensa*/
    SELECT p.numero_pokedex, AVG(eb.defensa) 
    FROM estadisticas_base eb
    INNER JOIN pokemon p ON eb.numero_pokedex = p.numero_pokedex
    GROUP BY p.numero_pokedex
    HAVING AVG(eb.defensa) > 100;
	/*Cuál es la potencia promedio de todos los movimientos en la base de datos? ¿Cuáles son los valores máximos y mínimos de la potencia?
	Tablas: estadisticas_base
	Campos: potencia*/
    SELECT AVG(potencia) AS promedio_movimiento, MAX(potencia) AS valores_maximos, MIN(potencia) AS valores_minimos
    FROM movimiento;
/*Group by*/
	/*Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo.
	Tablas: estadisticas_base, pokemon_tipo, tipo
	Campos: t.nombre, eb.velocidad*/
    SELECT t.nombre,AVG(e.velocidad) AS velocidad_promedio 
    FROM estadisticas_base e
    JOIN pokemon_tipo p ON e.numero_pokedex = p.numero_pokedex
    JOIN tipo t ON p.id_tipo = t.id_tipo
    GROUP BY t.nombre;
	/*Muestra los nombres de los tipos de Pokémon junto con la potencia máxima de movimientos de cualquier tipo que tienen una potencia superior a 80.
	Tablas: movimiento, tipo
	Campos: t.nombre, m.potencia
	*/
    SELECT t.nombre, MAX(m.potencia)
    FROM movimiento m
    INNER JOIN tipo t ON m.id_tipo = t.id_tipo
    WHERE m.potencia > 80 
    GROUP BY  t.nombre;
/*Having
	/*Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos.
	Tablas: tipo, pokemon_tipo, movimiento
	Campos: t.nombre, m.precision_mov*/
    SELECT  t.nombre, AVG(m.precision_mov) AS promedio_precision, COUNT(pt.id_tipo) AS  cantidad_pokemon
    FROM  movimiento m
    INNER JOIN tipo t ON m.id_tipo = t.id_tipo
    INNER JOIN pokemon_tipo pt ON pt.id_tipo = t.id_tipo
    GROUP BY t.nombre
    HAVING AVG(m.precision_mov) > 80;
	/*Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo.
	Tablas: pokemon, pokemon_tipo, estadisticas_base
	Campos: p.nombre, eb.ataque, pt.id_tipo
	*/
    SELECT p.nombre, AVG(eb.ataque) AS promeio_ataque
    FROM pokemon p
    INNER JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
    INNER JOIN estadisticas_base eb ON pt.numero_pokedex = eb.numero_pokedex
    GROUP BY p.nombre
    HAVING AVG(eb.ataque) > 70 
    AND COUNT(pt.id_tipo) > 1;
/*Registros
	/*Muestra el nombre de cada Pokémon junto con su tipo y velocidad base. Ordena los resultados por el nombre del Pokémon en orden descendente.
		Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
	Campos: p.nombre, t.nombre, eb.velocidad*/
    SELECT DISTINCT p.nombre, t.nombre, eb.velocidad
    FROM pokemon p 
    INNER JOIN estadisticas_base eb ON eb.numero_pokedex = p.numero_pokedex
    INNER JOIN pokemon_tipo pt ON eb.numero_pokedex = pt.numero_pokedex
    INNER JOIN tipo t ON t.id_tipo = pt.id_tipo
    ORDER BY p.nombre DESC;
	/*Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 60 y
    una precisión promedio mayor a 85 en sus movimientos.
		Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
	Campos: p.nombre*/
    SELECT t.nombre, COUNT(t.id_tipo) AS cantidad_pokemon
    FROM pokemon p
    INNER JOIN pokemon_tipo pt ON  p.numero_pokedex = pt.numero_pokedex
    INNER JOIN estadisticas_base eb ON eb.numero_pokedex = p.numero_pokedex
    INNER JOIN tipo t ON t.id_tipo = pt.id_tipo
    INNER JOIN movimiento m ON m.id_tipo = t.id_tipo
    INNER JOIN tipo_ataque ta ON ta.id_tipo_ataque = t.id_tipo_ataque
    GROUP BY t.nombre
    HAVING AVG(eb.velocidad) > 60 AND AVG(m.precision_mov) > 85;
	/*Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los Pokémon que pueden aprenderlos y el promedio de su altura.
    Solo incluye los movimientos con una potencia promedio mayor a 50.
			Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
	Campos: m.nombre, p.nombre, p.altura */
	SELECT p.nombre,m.nombre, AVG(p.altura)
    FROM movimiento m
    INNER JOIN pokemon_tipo pt ON pt.id_tipo = m.id_tipo
    INNER JOIN pokemon p ON p.numero_pokedex = pt.numero_pokedex
    INNER JOIN tipo t ON t.id_tipo = pt.id_tipo
    INNER JOIN tipo_ataque ta ON ta.id_tipo_ataque = t.id_tipo_ataque
    WHERE t.nombre LIKE 'Fuego'
    GROUP BY p.nombre,m.nombre
    HAVING AVG(m.potencia) > 50;
