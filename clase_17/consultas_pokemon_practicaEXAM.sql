/*Where*/
	/*1-Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150.
	Tablas: pokemon
	Campos: nombre, peso, altura*/
    
    SELECT nombre, peso, altura
    FROM pokemon 
    WHERE peso > 150;

	/*2-Muestra los nombres y potencias de los movimientos que tienen una precisión mayor 90.
	Tablas: movimiento, tipo
	Campos: m.nombre, t.nombre, potencia*/
    
    SELECT  t.nombre AS tipo,m.nombre AS nombre_movimiendo, m.potencia
    FROM tipo t
    INNER JOIN movimiento m
    ON  t.id_tipo = m.id_tipo
    WHERE precision_mov >  90;
    
/*Operadores & joins*/
	/*1-Mostrar tipo, nombre y potencia de los movimientos que tienen una potencia mayor igual que 120.
	Tablas: movimiento, tipo
	Campos: m.nombre, t.nombre, potencia*/
    
	SELECT  t.nombre AS tipo,m.nombre AS nombre_movimiendo, m.potencia
    FROM tipo t
    INNER JOIN movimiento m
    ON  t.id_tipo = m.id_tipo
    WHERE m.potencia >=  120;
    
    /*2-Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0.
	Tablas: tipo, tipo_ataque, movimiento
	Campos: t.nombre ta.tipo m.potencia*/
    
    SELECT  t.nombre, ta.tipo,m.potencia
    FROM tipo t
    INNER JOIN tipo_ataque ta ON t.id_tipo_ataque = ta.id_tipo_ataque
    INNER JOIN movimiento m ON t.id_tipo = m.id_tipo
    WHERE potencia = 0;
    
/*Order by*/
	/*1-Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético.
	Tablas: pokemon
	Campos: numero_pokedex, nombre*/
    
    SELECT nombre,numero_pokedex
    FROM pokemon
    ORDER BY nombre DESC
    LIMIT 10;
    
	/*2-Muestra los nombres y alturas de los Pokémon de tipo "Eléctrico", ordenados por altura de forma descendente.
	Tablas: pokemon, pokemon_tipo, tipo
	Campos: nombre, altura
	*/
    
    SELECT p.nombre,p.altura,t.nombre
	FROM tipo t
    INNER JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
    INNER JOIN  pokemon  p ON p.numero_pokedex = pt.numero_pokedex
    WHERE t.nombre LIKE 'Eléctrico'
    ORDER BY p.altura DESC;
    
/*Funciones de agregación*/
	/*1-¿Cuál es la suma total de los valores de "Defensa" en todas las estadísticas base?
	Tablas: estadisticas_base
	Campos: defensa*/
    
	SELECT SUM(defensa) AS suma_defensa
    FROM estadisticas_base;
    
	/*2-¿Cuántos Pokémon tienen el tipo "Fuego"?
		Tablas: pokemon_tipo, tipo
	Campos:* */

	SELECT COUNT(pt.numero_pokedex) AS total_pokemones, t.nombre AS tipo
    FROM tipo t
    INNER JOIN pokemon_tipo pt  ON t.id_tipo = pt.id_tipo
    WHERE  t.nombre LIKE 'Fuego'
    GROUP BY t.nombre;                 
   
/*Group by*/
	/*1-Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
	Tablas: pokemon_tipo, tipo
	Campos: nombre, numero_pokedex*/
    
    SELECT t.nombre, COUNT(pt.numero_pokedex)
    FROM tipo t
    INNER JOIN pokemon_tipo pt  ON t.id_tipo = pt.id_tipo
    GROUP BY t.nombre;
    
	/*2-Muestra los nombres de los tipos de Pokémon junto con el promedio de peso de los Pokémon de cada tipo. Ordena los resultados de manera descendente según el promedio de peso.
	Tablas: pokemon, pokemon_tipo, tipo
	Campos: t.nombre, p.peso*/
    
	SELECT t.nombre, AVG(peso)
	FROM tipo t
    INNER JOIN pokemon_tipo pt  ON t.id_tipo = pt.id_tipo
    INNER JOIN pokemon p ON p.numero_pokedex =  pt.numero_pokedex
    GROUP BY t.nombre
    ORDER BY AVG(peso) DESC;
    
/*Having*/
	/*1-Muestra los nombres de los Pokémon que tienen más de un tipo.
	Tablas: pokemon, pokemon_tipo
	Campos: nombre*/
    
    SELECT DISTINCT p.nombre
    FROM pokemon p
    INNER JOIN pokemon_tipo pt  ON p.numero_pokedex =  pt.numero_pokedex
    GROUP BY p.nombre
    HAVING COUNT(pt.id_tipo) > 1;
    
    
	/*2-Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen un peso promedio mayor a 10.
	Tablas: pokemon, pokemon_tipo, tipo
	Campos: nombre, numero_pokedex*/
    
    SELECT t.nombre , COUNT(pt.numero_pokedex) AS cantidad_tipo
	FROM tipo t
    INNER JOIN pokemon_tipo pt  ON t.id_tipo = pt.id_tipo
    INNER JOIN pokemon p ON p.numero_pokedex =  pt.numero_pokedex
    GROUP BY t.nombre
    HAVING AVG(p.peso) > 10;
    
/*Funciones de alteración*/
	/*1-Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 y una descripción que contenga al menos 20 palabras.
	Tablas: movimiento, tipo_ataque
	Campos: nombre, potencia, tipo, descripcion*/
    
    SELECT m.nombre, m.potencia, ta.tipo, descripcion
    FROM movimiento m
    INNER JOIN tipo t ON m.id_tipo = t.id_tipo
    INNER JOIN tipo_ataque ta ON ta.id_tipo_ataque = t.id_tipo_ataque
    WHERE ta.tipo LIKE 'Especial'
    AND m.potencia > 10
    AND LENGTH(m.descripcion) >= 20;
    
	/*2-Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 80.
    Solo incluye tipos que tienen al menos 3 Pokémon con esas características.
		Tablas: tipo, pokemon_tipo, estadisticas_base
	Campos: t.nombre,* */
    
    SELECT t.nombre, COUNT(*)  AS cantidad_pokemon
    FROM estadisticas_base eb
    INNER JOIN pokemon p ON  eb.numero_pokedex = p.numero_pokedex
    INNER JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
    INNER JOIN tipo t ON t.id_tipo = pt.id_tipo
    GROUP BY t.nombre 
    HAVING AVG(velocidad) > 80
    AND COUNT(*) >= 3;
    
    /*Registros*/
	/*1-Muestra el nombre de cada Pokémon junto con su tipo, velocidad base y puntos de salud (PS) base. Ordena los resultados por la velocidad base de forma descendente.
		Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
	Campos: p.nombre, t.nombre, eb.velocidad, eb.ps*/
    
    SELECT p.nombre, t.nombre, eb.velocidad, eb.ps
    FROM estadisticas_base eb
    INNER JOIN pokemon p ON  eb.numero_pokedex = p.numero_pokedex
    INNER JOIN pokemon_tipo pt ON p.numero_pokedex = pt.numero_pokedex
    INNER JOIN tipo t ON t.id_tipo = pt.id_tipo
    ORDER BY eb.velocidad DESC;
    
	/*2-Muestra los nombres de los movimientos de tipo "Agua" junto con los nombres de los Pokémon que pueden aprenderlos y el peso promedio de estos Pokémon.
		Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
	Campos: m.nombre, p.nombre, peso */
	
    SELECT p.nombre, m.nombre, AVG(p.peso)
	FROM movimiento m
    INNER JOIN tipo t ON m.id_tipo = t.id_tipo 
    INNER JOIN tipo_ataque ta ON ta.id_tipo_ataque = t.id_tipo_ataque
    INNER JOIN pokemon_tipo pt ON t.id_tipo = pt.id_tipo
    INNER JOIN pokemon p ON p.numero_pokedex = pt.numero_pokedex
    WHERE t.nombre LIKE 'Agua' 
	GROUP BY m.nombre, p.nombre;
    



