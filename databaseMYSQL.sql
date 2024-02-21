create database triangulo;
use triangulo;

DELIMITER //
CREATE PROCEDURE crear_tabla_triangulo()
BEGIN
    DECLARE i INT DEFAULT 0;

DROP TABLE IF EXISTS triangulos;

CREATE TABLE triangulos (
    lado1 INT,
    lado2 INT,
    lado3 INT
);

WHILE i < 20 DO
    INSERT INTO triangulos (lado1, lado2, lado3)
    VALUES (FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5));
    SET i = i + 1;
END WHILE;

END //
DELIMITER ;


CALL crear_tabla_triangulo();

SELECT * FROM triangulo.triangulos;


-- ----------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION tipo_triangulo(lado1 INT, lado2 INT, lado3 INT) RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
    DECLARE tipo VARCHAR(20);

    IF lado1 = lado2 AND lado2 = lado3 THEN
        SET tipo = 'Equilatero';
    ELSEIF lado1 = lado2 OR lado2 = lado3 OR lado1 = lado3 THEN
        SET tipo = 'Isosceles';
ELSE
        SET tipo = 'Escaleno';
END IF;

RETURN tipo;
END //

DELIMITER ;

-- ----------------------------------------------------------------------------

DELIMITER //
CREATE FUNCTION calcular_perimetro_triangulo(lado1 INT, lado2 INT, lado3 INT)
    RETURNS INT DETERMINISTIC
BEGIN
    DECLARE perimetro INT;
    SET perimetro = lado1 + lado2 + lado3;
RETURN perimetro;
END //
DELIMITER ;

-- ----------------------------------------------------------------------------

SELECT
    lado1,
    lado2,
    lado3,
    calcular_perimetro_triangulo(lado1, lado2, lado3) AS perimetro,
    tipo_triangulo(lado1, lado2, lado3) AS tipo
FROM
    triangulos;
