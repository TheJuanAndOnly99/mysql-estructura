-- Si us plau, DESCàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Question 1
SELECT apellido1 AS `Primer Cognom`, apellido2 AS `Segon Cognom`, nombre AS `Nom`
FROM persona 
WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC; 

-- Question 2
SELECT nombre, apellido1, apellido2 
FROM persona 
WHERE tipo = 'alumno' AND telefono IS NULL; 

-- Question 3
SELECT * 
FROM persona 
WHERE tipo = 'alumno' AND extract(YEAR FROM fecha_nacimiento) = 1999; 

-- Question 4
SELECT * 
FROM persona 
WHERE tipo = 'profesor' AND telefono IS NULL AND NIF like '%K'; 

-- Question 5
SELECT * 
FROM asignatura 
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7; 

-- Question 6
SELECT p.apellido1 AS `Primer Cognom`, p.apellido2 AS `Segon Cognom`, p.nombre AS `Nom`, d.nombre AS `Departament`
FROM persona p 
JOIN profesor pro ON p.id = pro.id_profesor 
JOIN departamento d ON pro.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY apellido1 ASC, apellido2 ASC, p.nombre ASC; 

-- Question 7
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin 
FROM persona p 
JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno 
JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id 
JOIN asignatura a ON ama.id_asignatura = a.id 
WHERE p.tipo = 'alumno' AND p.nif = '26902806M'; 

-- Question 8
SELECT d.nombre 
FROM departamento d 
JOIN profesor p ON p.id_departamento = d.id 
JOIN asignatura a ON a.id_profesor = p.id_profesor 
JOIN grado g ON a.id_grado = g.id 
WHERE g.id = 4 AND a.id_profesor IS NOT NULL GROUP BY d.nombre; 

-- Question 9
SELECT p.id, p.nombre, p.apellido1, p.apellido2, p.fecha_nacimiento, p.tipo
FROM persona p
JOIN alumno_se_matricula_asignatura ama ON p.id = ama.id_alumno 
JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id
WHERE p.tipo = 'alumno' AND ce.id = 5 
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2, p.fecha_nacimiento, p.tipo;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- Question 1
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre 
FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN departamento d ON prof.id_departamento = d.id 
WHERE p.tipo = 'profesor' 
ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC; 

-- Question 2
SELECT * 
FROM profesor prof 
LEFT JOIN persona p ON p.id = prof.id_profesor 
LEFT JOIN departamento d ON prof.id_departamento = d.id 
WHERE p.tipo = 'profesor' AND prof.id_departamento != d.id; 

-- Question 3
SELECT d.nombre, prof.id_profesor AS Profesor 
FROM departamento d 
LEFT JOIN profesor prof ON prof.id_departamento = d.id 
WHERE prof.id_profesor IS NULL; 

-- Question 4
SELECT p.nombre, a.nombre AS Asignatura 
FROM persona p 
LEFT JOIN profesor prof ON p.id = prof.id_profesor 
LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor 
WHERE p.tipo = 'profesor' AND a.nombre IS NULL;

-- Question 5
SELECT a.nombre, prof.id_profesor AS Profesor 
FROM asignatura a 
LEFT JOIN profesor prof ON a.id_profesor = prof.id_profesor
WHERE a.id_profesor IS NULL; 

-- Question 6
SELECT *
FROM departamento d
LEFT JOIN profesor prof ON prof.id_departamento = d.id
WHERE prof.id_profesor IS NULL
-- Si no hay profesor hay assignatura?

-- Consultes resum:
-- Question 1
SELECT count(persona.id) 
FROM persona 
WHERE persona.tipo = 'alumno'; 

-- Question 2
SELECT count(persona.id) 
FROM persona 
WHERE persona.tipo = 'alumno' AND extract(YEAR FROM fecha_nacimiento) = 1999; 

-- Question 3
SELECT d.nombre, count(prof.id_profesor) 
FROM departamento d
JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.nombre 
ORDER BY count(prof.id_profesor) DESC; 

-- Question 4
SELECT d.nombre, count(prof.id_profesor) 
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento 
GROUP BY d.nombre; 

-- Question 5
SELECT g.nombre, count(a.id) 
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre
 ORDER BY count(a.id) DESC; 

-- Question 6
SELECT g.nombre, count(a.id) 
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre 
HAVING count(a.id) > 40; 

-- Question 7
SELECT g.nombre, a.tipo, sum(a.creditos) 
FROM grado g
JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre, a.tipo; 

-- Question 8
SELECT ce.anyo_inicio, count(ama.id_alumno) 
FROM curso_escolar ce
JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar 
GROUP BY ce.anyo_inicio; 

