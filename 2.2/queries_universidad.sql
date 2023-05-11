-- Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select apellido1, apellido2, nombre from persona where tipo = 'alumno' order by apellido1 asc, apellido2 asc, nombre asc; -- Question 1
select nombre, apellido1, apellido2 from persona where tipo = 'alumno' and telefono is null; -- Question 2
select * from persona where tipo = 'alumno' and extract(year from fecha_nacimiento) = 1999; -- Question 3
select * from persona where tipo = 'profesor' and telefono is null and NIF like '%K'; -- Question 4
select * from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7; -- Question 5
select persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre from persona join profesor on persona.id = profesor.id_profesor join departamento on profesor.id_departamento = departamento.id where persona.tipo = 'profesor' order by apellido1 asc, apellido2 asc, persona.nombre asc; -- Question 6
select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin from persona join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id where persona.tipo = 'alumno' and persona.nif = '26902806M'; -- Question 7
select departamento.nombre from departamento join profesor on profesor.id_departamento = departamento.id join asignatura on asignatura.id_profesor = profesor.id_profesor join grado on asignatura.id_grado = grado.id where  grado.id = 4 and asignatura.id_profesor is not null group by departamento.nombre; -- Question 8
select * from persona join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where persona.tipo = 'alumno' and curso_escolar.id = 5 group by persona.id; -- Question 9
-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
select departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre from persona left join profesor on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id where persona.tipo = 'profesor' order by departamento.nombre asc, persona.apellido1 asc, persona.apellido2 asc, persona.nombre asc; -- Question 1
select * from profesor left join persona on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id where persona.tipo = 'profesor' and profesor.id_departamento != departamento.id; -- Question 2
select departamento.nombre, profesor.id_profesor as profesor from departamento left join profesor on profesor.id_departamento = departamento.id where profesor.id_profesor is null; -- Question 3
select persona.nombre, asignatura.nombre as asignatura from persona left join profesor on persona.id = profesor.id_profesor left join asignatura on profesor.id_profesor = asignatura.id_profesor where persona.tipo = 'profesor' and asignatura.nombre is null; -- Question 4
select asignatura.nombre, profesor.id_profesor as profesor from asignatura left join profesor on asignatura.id_profesor = profesor.id_profesor where asignatura.id_profesor is null; -- Question 5
-- Consultes resum:
select count(persona.id) from persona where persona.tipo = 'alumno'; -- Question 1
select count(persona.id) from persona where persona.tipo = 'alumno' and extract(year from fecha_nacimiento) = 1999; -- Question 2
select departamento.nombre, count(profesor.id_profesor) from departamento join profesor on departamento.id = profesor.id_departamento group by departamento.nombre order by count(profesor.id_profesor) desc; -- Question 3
select departamento.nombre, count(profesor.id_profesor) from departamento left join profesor on departamento.id = profesor.id_departamento group by departamento.nombre; -- Question 4
select grado.nombre, count(asignatura.id) from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre order by count(asignatura.id) desc; -- Question 5
select grado.nombre, count(asignatura.id) from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre having count(asignatura.id) > 40; -- Question 6
select grado.nombre, asignatura.tipo, sum(asignatura.creditos) from grado join asignatura on grado.id = asignatura.id_grado group by grado.nombre, asignatura.tipo; -- Question 7
select curso_escolar.anyo_inicio, count(alumno_se_matricula_asignatura.id_alumno) from curso_escolar join alumno_se_matricula_asignatura on curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar group by curso_escolar.anyo_inicio; -- Question 8

