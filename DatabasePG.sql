create database triangulos;

CREATE OR REPLACE PROCEDURE crear_tabla_y_insertar_triangulos()
    LANGUAGE PLPGSQL AS $$
BEGIN

DROP TABLE IF EXISTS triangulo;
CREATE TABLE triangulo (
                           lados INT[]
);

FOR i IN 1..20 LOOP
INSERT INTO triangulo (lados)
VALUES (ARRAY[FLOOR(1 + RANDOM() * 5), FLOOR(1 + RANDOM() * 5), FLOOR(1 + RANDOM() * 5)]);
END LOOP;
END;
$$;

CALL crear_tabla_y_insertar_triangulos();

-- -----------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION tipo_triangulo(lados INTEGER[])
    RETURNS VARCHAR AS $$
DECLARE
    tipo VARCHAR(20);
BEGIN
    IF lados[1] = lados[2] AND lados[2] = lados[3] THEN
        tipo := 'Equilátero';
ELSIF lados[1] = lados[2] OR lados[2] = lados[3] OR lados[1] = lados[3] THEN
        tipo := 'Isósceles';
ELSE
        tipo := 'Escaleno';
END IF;

RETURN tipo;
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION calcular_perimetro_triangulo(lados INTEGER[])
    RETURNS INTEGER AS $$
DECLARE
    perimetro INTEGER;
BEGIN
    perimetro := lados[1] + lados[2] + lados[3];
RETURN perimetro;
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------------------------------------------

SELECT
    lados[1] AS lado1,
    lados[2] AS lado2,
    lados[3] AS lado3,
    calcular_perimetro_triangulo(lados) AS perimetro,
    tipo_triangulo(lados) AS tipo
FROM
    triangulo;
