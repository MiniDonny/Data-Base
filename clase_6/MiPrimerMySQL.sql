	/* CREAR ESQUEMA */
    CREATE DATABASE pruebas;
    
    /*USAR ESQUEMA*/
	USE pruebas;
    
    /*CREAR ENTIDADES CON VARIABLES*/
    CREATE TABLE peliculas (
		id INT PRIMARY KEY AUTO_INCREMENT,
        nombre CHAR(200) NOT NULL,
        rating DECIMAL(3,1) NOT NULL,
        duracion TIME NOT NULL
    );
    
    /* AGREGAR ALGO A UNA ENTIDAD */
    ALTER TABLE peliculas 
    ADD estreno DATE NOT NULL, ADD actors VARCHAR (300) NOT NULL;
    
    /* ELIMINAR VARIABLES
    ALTER TABLE peliculas
    DROP estreno;  */
    
    /*MODIFICAR ENTIDAD */
    ALTER TABLE peliculas
    MODIFY rating DECIMAL(4,1) NOT NULL;
    
    /* AGREGAR DATOS A LAS VARIABLES */
    INSERT INTO peliculas (id, nombre, rating, duracion, estreno, actors)
    VALUES (DEFAULT, "kill BILL 2", 5.0, "01:40:00", "2004-04-29", "LUCY LUI" );
    
    
    
    /* BORRAR UNA ENTIDAD =   DROP TABLE IF EXISTS peliculas   */
    
    /* COMENTARIO = Mi Primera Vez en MySQL :D */
    