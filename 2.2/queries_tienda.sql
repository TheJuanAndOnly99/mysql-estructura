-- Question 1
SELECT nombre FROM producto;

-- Question 2
SELECT nombre, precio FROM producto; 

-- Question 3
SELECT * FROM producto; 

-- Question 4
SELECT nombre, precio, precio*1.09 FROM producto

-- Question 5
SELECT nombre AS `Product Name`, 
CONCAT('€', precio) AS `Price in Euros`, 
CONCAT('$', ROUND(precio*1.09, 2)) AS `Price in USD` 
FROM producto

-- Question 6
SELECT upper(nombre), precio FROM producto; 

-- Question 7
SELECT lower(nombre), precio FROM producto;

-- Question 8
SELECT nombre, upper(left(nombre, 2)) FROM fabricante;

-- Question 9
SELECT nombre, round(precio) FROM producto;

-- Question 10
SELECT nombre, floor(precio) FROM producto;

-- Question 11
SELECT fabricante.codigo 
FROM fabricante 
JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- Question 12
SELECT DISTINCT fabricante.codigo 
FROM fabricante 
JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- Question 13
SELECT nombre 
FROM fabricante 
ORDER BY nombre ASC; 

-- Question 14
SELECT nombre 
FROM fabricante 
ORDER BY nombre DESC; 

-- Question 15
SELECT nombre, precio 
FROM producto 
ORDER BY nombre ASC, precio DESC; 

-- Question 16
SELECT * FROM fabricante LIMIT 5; 

-- Question 17
SELECT * FROM fabricante LIMIT 2 offset 3; 

-- Question 18  
SELECT nombre, precio 
FROM producto 
ORDER BY precio LIMIT 1; 

-- Question 19
SELECT nombre, precio FROM producto ORDER BY -(precio) LIMIT 1; 

-- Question 20
SELECT nombre 
FROM producto 
WHERE producto.codigo_fabricante = 2; 

-- Question 21
SELECT producto.nombre, precio, fabricante.nombre 
FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo; 

-- Question 22
SELECT producto.nombre, precio, fabricante.nombre 
FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY fabricante.nombre ASC; 

-- Question 23
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre 
FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo; 

-- Question 24
SELECT producto.nombre, precio, fabricante.nombre 
FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY precio ASC LIMIT 1; 

-- Question 24
SELECT producto.nombre, precio, fabricante.nombre 
FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY precio DESC LIMIT 1; 

-- Question 25
SELECT p.nombre AS `Product Name`, 
       p.precio AS `Price`, 
       f.nombre AS `Manufacturer Name` 
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE p.precio = (SELECT MAX(precio) FROM producto);

-- Question 26
SELECT * 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = 'Lenovo'; 

-- Question 27
SELECT *
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = 'Crucial' AND precio > 200;

-- Question 28
SELECT * 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = 'ASUS' OR f.nombre = 'Seagate' OR f.nombre = 'Hewlett-Packard'; 

-- Question 29
SELECT *
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre IN ('ASus', 'Seagate', 'Hewlett-Packard'); 

-- Question 30
SELECT p.nombre, precio 
FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre LIKE '%e'; 

-- Question 31
SELECT p.nombre, precio 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre LIKE '%w%';

-- Question 32
SELECT p.nombre, precio, f.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE precio >= 180 ORDER BY precio DESC, p.nombre ASC; 

-- Question 33
SELECT f.nombre, f.codigo 
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante 
GROUP BY f.codigo;

-- Question 34
SELECT f.nombre, p.nombre 
FROM fabricante f 
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante; 

-- Question 35
SELECT *
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo_fabricante IS NULL;

-- Question 36
SELECT p.nombre 
FROM producto p 
LEFT JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Lenovo'; 

-- Question 37
SELECT * 
FROM producto p 
WHERE precio = (SELECT max(precio) FROM producto p
LEFT JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.nombre = 'Lenovo'); 

-- Question 38
SELECT p.nombre, p.precio
FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Lenovo' 
ORDER BY precio DESC LIMIT 1; 

-- Question 39
SELECT p.nombre, p.precio 
FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.nombre = 'Hewlett-Packard' 
ORDER BY precio ASC LIMIT 1; 

-- Question 40
SELECT * 
FROM producto p 
WHERE precio > (SELECT max(precio) FROM producto p
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.nombre = 'Lenovo'); 

-- Question 41
SELECT *
FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.nombre = 'ASUS' and precio > (SELECT avg(precio) FROM producto p
JOIN fabricante f on f.codigo = p.codigo_fabricante 
WHERE f.nombre = 'ASUS'); 



