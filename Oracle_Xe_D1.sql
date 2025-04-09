-- comentarios con guiòn
/*
Así se hace para màs de una línea de comentario
Acá quedarán la consultas
Ctrl + enter ejecuta la lìnea en la que estoy
*/
-- No diferencia entr mayus o minus (en la palabra clave)--

select * from EMP;
SELECT * FROM dept;
SELECT dept_no, dnombre, loc from dept;
SELECT Apellido, Oficio from emp;

-- La mejor práxis es utilizar el nombre de los campos (ejemplo 2 o 3) --

/* 
La consulta de selecciòn permite:

- consultas bàsica
-Consultas de agrupaciòn
-Consultas de combinaciòn
-Consultas de unión
-Cosultas a nivel de fila
-Consultas to select

Consultas de acción:
-Inerrt: crea un registro en una tabla
-Update: modifica uno o vario registros
-Delete: Eliminar registros de una tabla
*/

--Ordenación de datos--
SELECT * FROM emp ORDER BY Apellido;
--En la ordenación desendente sí se debe especificar--
SELECT * FROM emp order BY apellido DESC;
-- Se puede ordenar por más de un campo separado por ,--
SELECT * FROM emp ORDER BY dept_no, Oficio, apellido;

--FILTRADO DE REGISTROS--
/*
Para el filtrado se usan lo operadores de comparación
= igual
<= menor o igual
< menor
>= mayor o igual
> mayot
<> distinto
Oracle,por diferencia entre mayús y minss en ssus extos (strings)
Todo lo que no sea un númro se escribe en comillas simples '' 
Para filtrar se usa WHERE y se escribe solamente una vz en la consulta
*/

SELECT * FROM emp WHERE dept_no= 10;

SELECT * FROM emp WHERE oficio= 'DIRECTOR';

SELECT * FROM emp WHERE oficio<>'DIRECTOR';


/*
OPRADORES RELACIONALES

OR = Muesra los datos de cada filtro
AND = Todos los filtro deben cumplirse
NOT = Negación de una condición
*/

SELECT  * FROM emp WHERE dept_no= 10 AND oficio='DIRECTOR';
SELECT * FROM emp WHERE dept_no= 10 OR oficio='DIRECTOR';
SELECT * FROM emp WHERE dept_no= 10 OR dept_no= 20;

/* Operadores opcionales ademá de los estandar
BETWEEN: Muestra los datos entre un rango inclusive
Podemos hacer la missma consulta con operadores y es eficiente
Intentar eviar la negación (EJ 4) y usar operadores (ej5)
*/
SELECT * FROM emp WHERE SALARIO BETWEEN 251000 and 390000 order by salario;
SELECT * FROM emp WHERE salario >= 251000 and salario <= 390000 order BY salario;
SELECT * FROM emp WHERE NOT oficio= 'DIRECTOR';
SELECT * FROM emp WHERE OFICIO <> 'DIRECTOR';

/*
Operador para buscar coincidencias en textos
%: busca cualquier carácter y longitud
_: busca un carácter cualquiera
?: Un carácter numérico
*/

SELECT * FROM emp WHERE Apellido like 's%';
SELECT * FROM emp WHERE Apellido like 's%a';
SELECT * FROM emp WHERE Apellido like '____';

/*
Operador para buscar concidencias de igualdad en un mismo campo
in (valor1, valor2) es similar al or pero facilita la escritura
not in (valor1, valor2) recupera los que no coinciden
*/
SELECT * FROM emp WHERE dept_no in (10,20);
SELECT * FROM emp WHERE dept_no not IN (10,20) order by apellido;

/*
CAMPO CALCULADO
Sirve para generar campos que no existen en la tabla y se puedan calcular
No existe pero lo puedo calcular yo en un sselect
Siempre debe tener un alias
Un campo calculado solo es para el cursos (el resultado del cálculo)
Para filtrarlo es necesario volver a llamar la operación. El cursor no existe
La ordenaciòn afecta al select (resultados) en cambio where no puede filtrar
porque la info no està la tabla
*/

SELECT apellido, salario, comision, (salario + comision)as Total from emp;
SELECT apellido, salario, comision, (salario + comision)as Total from emp where
(salario + comision)>= 344500;
SELECT apellido, salario, comision, (salario + comision)as Total from emp ORDER
BY total;

/*
CLAUSULA DISTINCT
Se utiliza en el select y permite eliminar repetidoss de la consulta
*/

SELECT oficio from emp;
SELECT DISTINCT oficio from emp;
SELECT DISTINCT oficio, apellido from emp;

/*
 -> -> ->  PRÁCTICA <- <- <- 
Mostrar todos los enfermos nacidos antes del 11/01/1970
Todo lo que no s un nùmero va entre '', incluyendo fechas.
*/

desc Enfermo;

SELECT * FROM enfermo where fecha_nac <'11/01/1970' order by fecha_nac;

-- Igual que el anterior, para los nacidos antes del 1/1/1970 ordenados por número de inscripción.

SELECT * FROM enfermo where fecha_nac <'01/01/1970' order by inscripcion;

--Listar todos los datos de la plantilla del hospital del turno de mañana

SELECT * FROM plantilla where Turno = 'M';

---Listar todos los datos de la plantilla del hospita del turno de tarde.

SELECT * FROM plantilla where Turno = 'T';

--Listar los doctores que su salario anual supere 3.000.000 €. //error en la base de data

Select Apellido, funcion, salario, turno, (salario * 12) as S_Anual from plantilla;

Select Apellido, funcion, salario, (salario * 12) as S_Anual from plantilla
where funcion='INTERINO' AND (salario * 12) > 3000000 order by S_Anual;

--Visualizar los empleados de la plantilla del turno de mañana que tengan un salario entre 2.000.000 y 2.250.000.

Select Apellido, funcion, salario, turno, (salario * 12) as S_Anual from plantilla 
where turno= 'M' and ((salario * 12) between 2000000 and 3250000);

--Visualizar los empleados de la tabla emp que no se dieron de alta entre el 01/01/1980 y el 12/12/1982

SELECT * FROM emp;

SELECT * FROM emp where fecha_alt <= '01/01/1986' or fecha_alt >= '12/12/1994' 
and oficio = 'EMPLEADO' order by fecha_alt;

--Mostrar los nombres de los departamentos situados en Madrid o en Barcelona.

SELECT Dnombre FROM dept where loc= 'MADRID' OR loc='BARCELONA';
SELECT Dnombre FROM dept where loc IN ('MADRID','BARCELONA');

/*
CONULTAS DE AGRUPACIÓN
Permite motrar un resumen sobre un grupo determinado de datos
Utiliza funciones de agrupación para conseguir el resumen
Las funciones deben tener alias
COUNT(*): Cuenta el número de regisstros, incluyendo nulos
COUNT(CAMPO): Cuenta el número de regitro sin nulo
SUM(NÚMERO): Suma el total de un campo número
AVG(NÚMERO): promedio de un campo número
MAX(CAMPO): Valor máximo de un campo
MIN(CAMPO): Valor mínimo de un campo

Los datos resultado de las funciones se pueden agrupar por algun campo de la tabla
Group by --- después del from
debemos agrupar por cada campo que no sea una función
*/

SELECT count(*) as N_doctor FROM doctor;
SELECT count(apellido) as N_doctor FROM doctor;

--Se puede combinar varias funciones

SELECT count(*) as doctores, max(salario) as maximo FROM doctor;

-- ejemplo de agrupación por la tabla 

select count(*) as doctores, ESPECIALIDAD
from Doctor
group by ESPECIALIDAD;

SELECT dept_no, oficio, count(*) as personas, max(salario) as M_salario
from emp
group by dept_no, oficio
order by oficio;

select * from plantilla;

select turno, funcion, count(*) as persona 
from plantilla
group by turno, funcion
order by turno, funcion;

/* 
FILTRAR EN CONSULTA DE AGRUPACIÒN
WHERE Antes del group by y para filtrar sobre la tabla
HAVING Después del group by para filtrar sobre el nuevo conjunto
*/

SELECT Oficio,count(*) as empleados 
FROM emp
where salario > 200000
group by Oficio;

SELECT Oficio,count(*) as empleados 
FROM emp
group by Oficio
having Oficio in ('PRESIDENTE', 'DIRECTOR');

SELECT Oficio,count(*) as empleados 
FROM emp
group by Oficio
HAVING count(*) >= 2;

/* 
----- DÌA 3 -----
  PRÁCTICA
*/

-- Encontrar el salario más alto, mas bajo y la diferencia entre ambos de todos los empleados con oficio EMPLEADO
--se puede filtrar por having o por where.

select * from emp where oficio= 'EMPLEADO';

select oficio, min(salario) as min_salario, max(salario) as max_salario
, max(salario) - min(salario) as diferencia
from emp
where oficio = 'EMPLEADO'
group by oficio;


--Visualizar el número de personas que realizan cada oficio en cada departamento ordenado por departamento.

SELECT * FROM emp;

select dept_no, oficio,count(*) as empleado 
from emp
group by oficio, dept_no
order by dept_no;

--Buscar aquellos departamentos con cuatro o más personas trabajando.

select dept_no ,count(*) as empleado 
from emp
group by dept_no
having count(*)>= 4;

--Visualizar el número de enfermeros, enfermeras e interinos que hay en la plantilla, ordenados por la función.

SELECT * FROM plantilla;

select funcion, count(*) as n_empleado
from Plantilla
group by funcion
having FUNCION in ('ENFERMERO', 'ENFERMERA', 'INTERINO')
order by funcion;

-- Visualizar departamentos, oficios y número de personas, para aquellos departamentos que tengan dos o más personas trabajando en el mismo oficio.

select * from emp;

select dept_no, oficio, count(*) as n_persona 
from emp
Group by dept_no, oficio
having count(*) >= 2;

--Calcular el valor medio de las camas que existen para cada nombre de sala. Indicar el nombre de cada sala y el número de cada una de ellas.

select * from sala;

select sala_cod, nombre, avg(num_cama)as avg_cama, COUNT(*) AS NUMERO
from sala
group by sala_cod, nombre;

-- Calcular el salario medio de la plantilla de la sala 6, según la función que realizan. Indicar la función y el número de empleados.
--el where se puede utilizar sin llamar a la columna en l selec

select * from emp;

select FUNCION, avg(salario) as avg_salario, count(*) as n_empleado 
from plantilla
where sala_cod=6
group by funcion;

--Mostrar el número de hombres y el número de mujeres que hay entre los enfermos.

select * from enfermo;

select sexo, count(*) as n_personas 
from enfermo
group by sexo;

--Calcular el número de salas que existen en cada hospital

select * from sala;

select hospital_cod, sum(num_cama) as sum_cama, count(*) as n_salas
from sala
group by hospital_cod;

--Mostrar el número de enfermeras que existan por cada sala
-- al igual que màs arriba, l filtro de enfermeras e muy especifico y se pide
--algo màs general. IMPORTANTE tener cuidado con eso y poder aplicar las bùsquedas


select * from plantilla;

select sala_cod, count(*) as n_personas
from plantilla
where funcion = 'ENFERMERA'
GROUP BY sala_cod;


/*
CONSULTAS DE COMBINACIÓN
Permiten mosstrar datos de varias tablas que deben estar relacionadas entre si
1) necesitamos la columnas de relación entre las tablas
2) Debemos poner el nombre de cada tabla y cada campo en la consulta
3) No importa el orden en el from 
Sintaxis: 

select tabla1.columna1,tabla1.columna2
tabla2.columna1, tabla2.columna2
from tabla1
inner join tabla2
on tabla1.columna_relacion = tabla2.columna_relacion

*/


select emp.apellido, emp.oficio
, dept.dnombre, dept.loc
from emp
inner join dept
on emp.dept_no = dept.dept_no;

-- Hay otra sintaxis para realizar los join, está bien pero mejor la primera

select emp.apellido, emp.oficio
, dept.dnombre, dept.loc
from emp, dept
where emp.dept_no = dept.dept_no;

--se puede realizar filtros where

select emp.apellido, emp.oficio
, dept.dnombre, dept.loc
from emp
inner join dept
on emp.dept_no = dept.dept_no
where loc= 'MADRID';

-- no es obligatorio incluir el nombre de la table antes del campo a motrar en el select
--pero es mejor tener la tabla para saber de qué tabla es
-- si hay dos columnas que se llamen igual, va a generar error 
-- NO RECOMENDAR

select apellido, oficio
, dnombre, loc
from emp
inner join dept
on emp.dept_no = dept.dept_no;

-- Se puede incluir alias a los nombres de las tablas/util para tablas con nombres iguale
--Al poner alias, la tabla se llamará así para toda la consulta

select e.apellido, e.oficio
, d.dnombre, d.loc
from emp e -- el alìas se coloca solo con un epacio y la tabla se llama así pa la consulta
inner join dept d
on e.dept_no = d.dept_no;

/*
HAY DIFERENTES TIPO DE JOINS EN LA BDD
INNER: combina resultados de las dos tablas, muetra solo donde hay datos a través de la llave
LEFT: combina las dos tablas y la parte izquierda de la otra tabla aunque haya un valor null en la tabla 1
RIGHT: combina las dos tablas y la parte derecha de la otra tabla
FULL: combina las dos tablas y fuerza todas las columnas
CROSS: producto cartesiano, combina cada dato de una tabla con los otros datos de la tabla
*/

--SE INSERTA UN NUEVO EMPLEADO PARA PROBAR
--INSERT INTO emp VALUES('99999', 'SIN_DEPT', 'ANALISTA', 7919, TO_DATE('20-10-1986', 'DD-MM-YYYY'), 258500, 50000, 50 );
-- En left se muestra el valor que està null en departamento

SELECT DISTINCT DEPT_NO FROM EMP;

-- EJEMPLO DE LEFT 

select e.apellido, e.oficio
, d.dnombre, d.loc
from emp e 
LEFT join dept d
on e.dept_no = d.dept_no
ORDER BY D.LOC;

-- EJEMPLO DE RIGHT 

select e.apellido, e.oficio
, d.dnombre, d.loc
from emp e 
right join dept d
on e.dept_no = d.dept_no
ORDER BY D.LOC;

--EJEMPLO DE FULL (NO ES RECOMENDABLE PORQUE NO TIENE SENTIDO LÓGICO QUE LA DOS TABLAS ESTÉN DESCONECTADAS)
select e.apellido, e.oficio
, d.dnombre, d.loc
from emp e 
FULL join dept d
on e.dept_no = d.dept_no
ORDER BY D.LOC;


-- EJEMPLO DE CROSS/ muestra toda las posibles combinaciones de cada tabla

select e.apellido, e.oficio
, d.dnombre, d.loc
from emp e 
cross join dept d
ORDER BY D.LOC;

-- MEDIA SALARIAL DE DOCTORES POR HOSITAL

select * from hospital;
SELECT * FROM doctor;

SELECT hospital.nombre, hospital.hospital_cod, avg(doctor.salario) as media 
FROM doctor
inner join hospital
on doctor.hospital_cod = hospital.hospital_cod
group by hospital.nombre, hospital.hospital_cod;

-- mostrar el número de empleados por cada localidad

select * from emp;

select * from dept;

select dept.loc, count(emp.emp_no) as n_empleados
from emp
right join dept
on dept.dept_no= emp.dept_no
group by dept.loc;

/*

------ DÍ 4 -----
PRÁCTICA
*/


--Seleccionar el apellido, oficio, salario, numero de departamento y su nombre 
--de todos los empleados cuyo salario sea mayor de 300000

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, EMP.DEPT_NO, DEPT.DNOMBRE
FROM EMP 
INNER JOIN DEPT
ON EMP.DEPT_NO = DEPT.DEPT_NO
WHERE EMP.SALARIO > 300000;

--Mostrar todos los nombres de Hospital con sus nombres de salas correspondientes.
--Aunque dos columnas tengan el mismo nombre y funcione, es necesario poner un alias

SELECT * FROM HOSPITAL;
SELECT * FROM SALA;

SELECT HOSPITAL.NOMBRE as n_hospital, SALA.NOMBRE as n_sala
FROM HOSPITAL
INNER JOIN SALA
ON HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD;

--Calcular cuántos trabajadores de la empresa hay en cada ciudad

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPT.LOC, COUNT(EMP_NO) AS TRABAJADOR
FROM DEPT
LEFT JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
GROUP BY DEPT.LOC;

-- Visualizar cuantas personas realizan cada oficio en cada departamento
-- mostrando el nombre del departamento.

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPT.DNOMBRE, EMP.OFICIO, COUNT(EMP_NO) AS N_TRABAJADOR
FROM DEPT
LEFT JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
GROUP BY DEPT.DNOMBRE, EMP.OFICIO;


--Contar cuantas salas hay en cada hospital, mostrando el nombre de las salas y el nombre del hospital.

SELECT * FROM HOSPITAL;
SELECT * FROM SALA;

SELECT HOSPITAL.NOMBRE, SALA.NOMBRE, COUNT(SALA_COD) AS N_SALAS
FROM HOSPITAL
INNER JOIN SALA
ON HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD
GROUP BY HOSPITAL.NOMBRE, SALA.NOMBRE;

--Queremos saber cuántos trabajadores se dieron de alta entre el año 1997 y 1998 y en qué departamento.

SELECT * FROM EMP;
SELECT * FROM DEPT;


SELECT DEPT.DNOMBRE, COUNT(EMP_NO) AS N_TRABAJADOR
FROM DEPT
INNER JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
WHERE FECHA_ALT >= '01/01/1997' AND FECHA_ALT <= '31/12/1998'
GROUP BY DEPT.DNOMBRE;

--Buscar aquellas ciudades con cuatro o más personas trabajando

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPT.LOC, COUNT(EMP.EMP_NO) AS N_TRABAJADOR
FROM DEPT
INNER JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
HAVING COUNT(EMP_NO) >= 4
GROUP BY DEPT.LOC;

-- Calcular la media salarial por ciudad.  Mostrar solamente la media para Madrid y Elche
-- having siempre debe estar depués del group_by.

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPT.LOC, AVG(EMP.SALARIO) AS AVG_SALARIO
FROM DEPT
LEFT JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
GROUP BY DEPT.LOC
HAVING DEPT.LOC IN ('MADRID','SEVILLA');

--Mostrar los doctores junto con el nombre de hospital en el que ejercen, la dirección y el teléfono del mismo.

SELECT * FROM HOSPITAL;
SELECT * FROM DOCTOR;

SELECT DOCTOR.APELLIDO, HOSPITAL.NOMBRE, HOSPITAL.DIRECCION, HOSPITAL.TELEFONO
FROM HOSPITAL
LEFT JOIN DOCTOR
ON HOSPITAL.HOSPITAL_COD = DOCTOR.HOSPITAL_COD;

--Mostrar los nombres de los hospitales junto con el mejor salario de los empleados de la plantilla de cada hospital.

SELECT * FROM HOSPITAL;
SELECT * FROM PLANTILLA;

SELECT HOSPITAL.NOMBRE, MAX(PLANTILLA.SALARIO) AS MAX_SALARIO
FROM HOSPITAL
INNER JOIN PLANTILLA
ON HOSPITAL.HOSPITAL_COD = PLANTILLA.HOSPITAL_COD
GROUP BY HOSPITAL.NOMBRE;

--Visualizar el Apellido, función y turno de los empleados de la plantilla junto con el nombre de la sala y el nombre del hospital con el teléfono.
-- se le coloca el and para que pueda eliminar los productos cartesianos. Si exite màs de una relación, hay que poner los dos. // si no sale un or

SELECT * FROM PLANTILLA;
SELECT * FROM HOSPITAL;
SELECT * FROM SALA;

SELECT PLANTILLA.APELLIDO, PLANTILLA.FUNCION, PLANTILLA.TURNO, SALA.NOMBRE,
HOSPITAL.NOMBRE, HOSPITAL.TELEFONO 
FROM PLANTILLA
INNER JOIN HOSPITAL
ON PLANTILLA.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
INNER JOIN SALA
ON SALA.HOSPITAL_COD = PLANTILLA.HOSPITAL_COD
and plantilla.sala_cod=sala.sala_cod;


--Visualizar el máximo salario, mínimo salario de los Directores dependiendo de la ciudad en la que trabajen. Indicar el número total de directores por ciudad.

SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT DEPT.LOC, EMP.OFICIO, COUNT(EMP.EMP_NO) AS N_DIRECT, MAX(EMP.SALARIO) AS MAX_SALARIO, MIN(EMP.SALARIO) AS MIN_SALARIO
FROM DEPT
LEFT JOIN EMP
ON DEPT.DEPT_NO = EMP.DEPT_NO
HAVING EMP.OFICIO = 'DIRECTOR'
GROUP BY DEPT.LOC, EMP.OFICIO;

--Averiguar la combinación de que salas podría haber por cada uno de los hospitales.

SELECT * FROM HOSPITAL;
SELECT * FROM SALA;

SELECT SALA.NOMBRE, HOSPITAL.NOMBRE
FROM HOSPITAL
CROSS JOIN SALA;


-- Calcular el salario medio por plantilla


SELECT * FROM HOSPITAL;
SELECT * FROM Doctor;
select * FROM plantilla;

select doctor.ESPECIALIDAD, avg(plantilla.salario) as salario
from doctor
INNER join plantilla
on doctor.hospital_cod = plantilla.hospital_cod
group by doctor.ESPECIALIDAD;

/* 
     SUBCONSULTAS
Son conultas que necesitan del resultado de otra consulta para poder ser ejecutadas
NO SON AUTONÓNMAS, NECESITAN DE ALGÚN VALOR
NO IMPORTA EL NIVEL DE anidamiento SUBCONSULTAS, aunque pueden relentizar las repuestas
generan bloqueos en consultas select, lo que también ralentiza las respuestas
Debemos evitar las medidas de los possible con select

PARA HACERLO SE JECUTAN las dos consultas a las vez y se anida el resultado de una consulta con la igualdad de 
respuesta de otra consulta. La subconsulta va entre parentesís
EJEMPLO:
quiero visualizar los datos del empleado que más cobra de la empresa
*/

select MAX(SALARIO) from EMP;

SELECT EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO from EMP WHERE SALARIO=(SELECT MAX(SALARIO) from EMP);

--mostrar quienes tienen el mismo oficio que gil 

SELECT * FROM EMP WHERE EMP.OFICIO=(SELECT OFICIO FROM EMP WHERE APELLIDO= 'gil');

SELECT * FROM EMP WHERE EMP.OFICIO=
(SELECT OFICIO FROM EMP WHERE APELLIDO= 'gil')
AND SALARIO < (SELECT EMP.SALARIO FROM EMP WHERE EMP.APELLIDO= 'jimenez');

--si trae dos iguales o busca entre dos elemento iguales de una tabla, paila. En el ejemplo, no tiene con quien bucar los datos.
--si una subconsulta trae más de un valor, se usa el operador IN
SELECT * FROM EMP WHERE EMP.OFICIO=
(SELECT OFICIO FROM EMP WHERE APELLIDO= 'gil' OR EMP.APELLIDO= 'jimenez');

SELECT * FROM EMP WHERE EMP.OFICIO in
(SELECT OFICIO FROM EMP WHERE APELLIDO= 'gil' OR EMP.APELLIDO= 'jimenez');

--Se puede usar subconsultas para otras tablas
-- por ejemplo para mostrar el apellido y oficio de empleados en Madrid
-- Aunque funciona, es horrible porque genera bloqueas y se puede usar desde las otras

SELECT apellido, oficio from EMP where DEPT_NO=
(select DEPT_NO from dept where loc='MADRID');


-- DEBERÌA SER ASÍ

SELECT EMP.APELLIDO, EMP.OFICIO
from EMP
INNER JOIN DEPT
ON EMP.DEPT_NO= DEPT.DEPT_NO
where DEPT.LOC= 'MADRID';

/*

    CONSULTA UNIÓN

Muestran en un mismo cursos un mimo conjunto de resultados
Se utilizan como concepto y no como relación. 
Se deben seguir tres normas
1) la primera consulta es la jefa
2) todas las consultas deben tener el mismo número de columnas
3) todas las columnas deben tener el mismo tipo de dato entre sí

*/

--en la base de datos hay persona en diferentes tablas (porque tienen datos distintos entre sí)

select * from emp;
select * from plantilla;
SELECT * FROM DOCTOR;

select apellido, oficio, salario from emp
union
select apellido, funcion, salario from PLANTILLA
union
select dnombre, loc, dept_no from dept;


--EJEMPLO DE ORDER BY - EN LAS CONSULTAS UNION SIEMPRE ES MEJOR USAR EL NÚMERO DE LA COLUMNA/ EL ALIAS NO FUNCIONA
--SI LOS CAMPOS NO SE LLAMAN IGUAL EN TODAS LAS CONSULTAS NO SE PUEDE HACER ORDER BY POR NOMBRE
select apellido, oficio, salario from emp
union
select apellido, funcion, salario from PLANTILLA
union
select apellido, especialidad, salario from DOCTOR
order by 2;


--EJEMPLO DE DATOS FILTRADOS. EL WHERE SE APLICA A CADA UNA DE LAS TABLAS QUE SE ESTÁ UNIENDO
--CADA WHERE ES INDEPENDIENTE DEL UNIÓN
-- EJEMPLO: MOSTRR LOS DATOS QUE COBREN MENOS DE 300000
select apellido, oficio, salario from emp
where SALARIO < 300000
union
select apellido, funcion, salario from PLANTILLA
where SALARIO < 300000
union
select apellido, especialidad, salario from DOCTOR
where SALARIO < 300000
ORDER BY 1;

--UNION ELIMINA LO RESULTADOS REPETIDOS EN EL CRUCE DE LAS TABLAS
-- SI QUEREMOS REPETIDOS DEBEMOS UNION ALL

SELECT APELLIDO, OFICIO FROM EMP
UNION ALL
SELECT APELLIDO, OFICIO FROM EMP;

/* 
          DÍA 5
*/

-- consulta select to select
-- es una consulta sobre un curos (sobre un select ya realizao)
-- Al hacer un select, recuperamos datos sobre una tabla. Estas consultan nos permiten rcuperar datos de un select ya realizado
-- los where y demás se hacen sobre el cursos.
-- es necesario hacer un select superior Y CREAR un alias para toda la consulta
-- Sintaxis:
select * from
(SELECT TABLA1.CAMPO1 AS ALIAS, TRABLA2,CAMPO2 FROM TABLA1
UNION
SELECT TABLA2.CAMPO1, TABLA2.CAMPO2 FROM TABLA2) CONSULTA
where CONSULTA.Alias= 'Valor';

--ejemplo práctico

SELECT * FROM
(select apellido, oficio, salario AS SUELDO from emp
union
select apellido, funcion, salario from PLANTILLA
union
select apellido, especialidad, salario from DOCTOR) CONSULTA
where CONSULTA.SUELDO < 300000;


/*
 Consultas a nivel de fila
Son consultas creadas para dar formato a la salida de datos.
No modifican los datos de la tabla, los muestra de otra forma según sea necesario y van con preguntas en la consulta
ejemplo, si viene x dato muestra y dato
sintaxis para evaluar un campo de igualdad: 
*/
SELECT TABLA1.CAMPO1, TABLA2.CAMPO1,
CASE CAMPO3
  WHEN 'DATO1' THEN 'VALOR1'
  WHEN 'DATO2' THEN 'DATO2'
  ELSE 'VALOR3'
END AS ALIAS
FROM TABLA;

--EJEMPLO PARA DARLE FORMATO AL TURNO Y QUE MUESTRE MAÑANA TARDE Y NOCHO

SELECT * FROM PLANTILLA;

SELECT apellido, funcion
, CASE TURNO
  WHEN 'T' THEN 'TARDE'
  WHEN 'M' THEN 'MAÑANA'
  ELSE 'NOCHE' -- ES OPCIONAL, NO SE PUEDE MANTENER EL VALOR DE LA PRIMER TABLA
END AS Turno
FROM PLANTILLA;

--sintaxìs para evaluar por un operador 8rango, mayor o menor, distinto)
--NO SE PONE EL CAMPO DESPUÉS DEL CASE
SELECT TABLA1.CAMPO1, TABLA2.CAMPO1,
CASE 
  WHEN CAMPO3 <= 800 THEN 'RESULTADO1'
  WHEN CAMPO3 > 800 THEN 'RESULTADO2'
END AS FORMATO
FROM TABLA;

-- SALARIOS 
SELECT apellido, funcion, SALARIO
, CASE
  WHEN SALARIO >=250000 THEN 'ALTO'
  WHEN SALARIO <=250000 THEN 'BAJO'
END AS RANGO_SALARIAL
FROM PLANTILLA;



-- 1)Mostrar la suma salarial de los empleados por su departamento

SELECT * FROM DEPT;
SELECT * from emp;

SELECT DEPT.DNOMBRE, SUM(EMP.SALARIO) AS S_SALARIO
FROM DEPT
INNER JOIN EMP
ON DEPT.DEPT_NO=EMP.DEPT_NO
GROUP BY DEPT.DNOMBRE;

--2) Mostrar la suma salarial de los doctores por su hospital

SELECT * FROM DOCTOR;
SELECT * FROM HOSPITAL;

SELECT HOSPITAL.NOMBRE, SUM(DOCTOR.SALARIO) AS S_SALARIO
FROM DOCTOR
INNER JOIN HOSPITAL
ON DOCTOR.HOSPITAL_COD= HOSPITAL.HOSPITAL_COD
GROUP BY HOSPITAL.NOMBRE;

--3) ver todo junto en una misma consulta

SELECT HOSPITAL.NOMBRE, SUM(DOCTOR.SALARIO) AS S_SALARIO
FROM DOCTOR
INNER JOIN HOSPITAL
ON DOCTOR.HOSPITAL_COD= HOSPITAL.HOSPITAL_COD
GROUP BY HOSPITAL.NOMBRE
UNION
SELECT DEPT.DNOMBRE, SUM(EMP.SALARIO) AS S_SALARIO
FROM DEPT
INNER JOIN EMP
ON DEPT.DEPT_NO=EMP.DEPT_NO
GROUP BY DEPT.DNOMBRE
ORDER BY 2;

/* 
 Consultas de acción
Lo más importante son consultas simples, de combinación y de acción
Son consultas para modificar los registros de la base de datos. En Oracle son transaccionales, 
se almacenan de forma temporal por sesión. Para deshacer o hacer permanente los cambios, se debe usar
"COMMIT:" que hace lo cambios permanentes y 
"ROLLBACK" Que deshac los cambios realizado 
1) inserto 2 registros nuevos
2) comiit permanente
3) inserto otro registro nuevo
4) roollback: quita olamene el punto 3.
HAY 3 TIPOS TIPOS DE CONSULTA DE ACCIÓN
INSERT: Inserta un nuevo registro en una tabla
Update: modifica uno o varios rgistros de una tabla
Delete: elimina uno varios regisros d un tabla
*/

--Insert
-- Cada registro a incertar es una instrucción insert. Si queremos 5 registros, son 5 insert (ansisql)
-- En Oracl hay más opciones
-- hay dos sintaxís
-- 1) insertar todos los datos de la tabla, indicando las columnas y campos siguiendo el mismo orden que estña en la tabla
insert into tabla values (valor1,valor2,valor3,valor4);

INSERT INTO DEPT VALUES(52,'Oracle_2','Bernabeu');
COMMIT;
INSERT INTO DEPT VALUES(53,'BORRAR_2','BORRAR');
ROLLBACK ;
SELECT * FROM DEPT;

--2) Inertar solamente algunos datos de la tabla
-- indicat l nombre de las columnas y los valores irán en ese orden

insert into DEPT (LOC, DEPT_NO) values (55,"Almería");

-- ON EVITABLES SI ETAMOS EN UN SELECT, PERO MUY ÚTIL SI ESTAMOS EN UNA DE ACCIÓN
-- GENERAR EL SIGUINETE NÚMEERO DISPONIBLE EN LA CONSULTA

SELECT MAX (DEPT_NO) +1 FROM DEPT;

INSERT INTO DEPT VALUES ((SELECT MAX (DEPT_NO) +1 FROM DEPT),'SIDRA', 'GUIJÒN');

ROLLBACK;

-- DELTE UNA O VARIAS FILAS DE UNA TABLA. SI NO HAY NADA PARA ELIMINAR, NO HACE NADA
-- CUIDADO CON LA SINTAXIS POR QUE ELIMINA TODA LA TABLA. SE PUEDE USAR WHERE

SELECT * FROM DEPT;

DELETE FROM DEPT WHERE DNOMBRE= 'Oracle_2';
SELECT * FROM DEPT;
ROLLBACK;

--MUY ÚTIL USAR SUBCONSULTAR PARA DELETE


DELETE FROM EMP WHERE DEPT_NO= (SELECT DEPT_NO FROM DEPT WHERE LOC = 'GRANADA');

SELECT * FROM EMP;

--UPDATE
--MODIFICA UNA O VARIAS FILAS DE UNA TABLA. PUEDE MODIFICAR VARIAS COLUMNAS A LA VEZ
--SINTAXIS: UPDATE TABLA SET CAMPO1=VALOR1, CAMPO2=VALOR2
-- AL IGUAL QUE DELETE MODIFICA TODAS LAS FILAS DE LA COLUMNA, ES CONVENIENTE UTILIZAR UN WHERE
--EJEMPLO MODIFICAR EL SALARIO DE LA PLANTILLA DEL TURNO DE NOCHE

SELECT * FROM PLANTILLA;


UPDATE PLANTILLA SET SALARIO=315000
WHERE TURNO = 'N'; 

ROLLBACK;

--EJEMPLO MODIFICAR LA CIUDAD Y EL NOMBRE DEL DEPARTAMENTO 10
-- SE LLAMARÁ CUENTA Y ES TOLEDO

UPDATE DEPT SET LOC= 'TOLEDO', DNOMBRE='CUENTAS'
WHERE DEPT_NO=10;

select * from dept;

--Podemos mantener el valor de una columna y asignar 'Algo' con operaciones matemáticas
-- ejemplo incrementar en 1 el salario de todos los empleados

update emp set salario= salario+1;

-- se puede usar subconsultas en el update
-- si las subconsultas están en el set, solamente deben devolver un dato

update emp set salario=(select salario from emp where apellido = 'sala' )
where apellido = 'arroyo';

update emp set salario= salario/2
where dept_no= (select dept_no from dept where loc='BARCELONA');  

select * from emp;

ROLLBACK;

/* 

PRÁCTICA 5

*/

-- 1) Dar de alta con fecha actual al empleado José Escriche Barrera como programador perteneciente al departamento de producción.  
--Tendrá un salario base de 70000 pts/mes y no cobrará comisión.

SELECT * FROM EMP;
SELECT * FROM DEPT;

INSERT INTO EMP (EMP_NO, APELLIDO ,OFICIO,FECHA_ALT, SALARIO, COMISION, DEPT_NO) 
VALUES ((SELECT MAX(EMP_NO)+1 FROM EMP),'Escriche','PROGRAMADOR','31/05/2025', 70000, 0, (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE= 'PRODUCCIÓN') );

-- 2) Se quiere dar de alta un departamento de informática situado en Fuenlabrada (Madrid).

INSERT INTO DEPT VALUES ((SELECT MAX (DEPT_NO) +1 FROM DEPT),'INFORMÁTICA', 'FUENLABRADA');

--3) El departamento de ventas, por motivos peseteros, se traslada a Teruel, realizar dicha modificación.

UPDATE DEPT SET LOC= 'TERUEL'
WHERE DNOMBRE= 'VENTAS';

-- 4) En el departamento ventas, se dan de alta dos empleados: Julián Romeral y Luis Alonso.  
--Su salario base es el menor que cobre un empleado, y cobrarán una comisión del 15% de dicho salario.

SELECT * FROM EMP;

INSERT INTO EMP
(EMP_NO, APELLIDO, SALARIO, COMISION)
VALUES ((SELECT MAX(EMP_NO)+1 FROM EMP),"Romeral", (SELECT MIN(SALARIO) FROM EMP WHERE OFICIO= 'EMPLEADO'), (SELECT MIN(SALARIO)*0.15 FROM EMP WHERE OFICIO= 'EMPLEADO'));


SELECT MIN(SALARIO)*0.15 FROM EMP WHERE OFICIO= 'EMPLEADO';
--5) Modificar la comisión de los empleados de la empresa, de forma que todos tengan un incremento del 10% del salario.

SELECT * FROM EMP;

UPDATE EMP SET COMISION= (SALARIO*0.1);

--6) Incrementar un 5% el salario de los interinos de la plantilla que trabajen en el turno de noche.

SELECT * FROM PLANTILLA;

UPDATE PLANTILLA SET SALARIO= (SALARIO + (SALARIO * 0.05))
WHERE TURNO='N';

--7) Incrementar en 5000 Pts. el salario de los empleados del departamento de ventas y del presidente, 
--tomando en cuenta los que se dieron de alta antes que el presidente de la empresa.

UPDATE EMP SET SALARIO= (SALARIO + 500)
WHERE EMP.FECHA_ALT < (SELECT FECHA_ALT FROM EMP WHERE OFICIO= 'PRESIDENTE' );

--8) El empleado Sanchez ha pasado por la derecha a un compañero.  
-- Debe cobrar de comisión 12.000 ptas más que el empleado Arroyo y su sueldo se ha incrementado un 10% respecto a su compañero.

UPDATE EMP SET COMISION= ((SELECT COMISION FROM EMP WHERE APELLIDO= 'arroyo' ) + 12000 ), 
SALARIO = (((SELECT salario FROM EMP WHERE APELLIDO= 'arroyo')*0.1)+ salario  )
where APELLIDO= 'sanchez';

--9) Se tienen que desplazar cien camas del Hospital SAN CARLOS para un Hospital de Venezuela.  Actualizar el número de camas del Hospital SAN CARLOS.
select * from HOSPITAL;

UPDATE HOSPITAL SET NUM_CAMA= (NUM_CAMA - 100)
WHERE NOMBRE= 'san carlos';

--10 Subir el salario y la comisión en 100000 pesetas y veinticinco mil pesetas respectivamente a los empleados que se dieron de alta en este año

SELECT * FROM EMP;

UPDATE EMP SET SALARIO= (SALARIO + 100000)
WHERE EMP.FECHA_ALT < '01/01/1995';

--11 Ha llegado un nuevo doctor a la Paz.  Su apellido es House y su especialidad es Diagnostico.   Introducir el siguiente número de doctor disponible.

SELECT * FROM DOCTOR;

SELECT * FROM HOSPITAL;

INSERT INTO DOCTOR (HOSPITAL_COD, DOCTOR_NO, APELLIDO, ESPECIALIDAD)
VALUES ((SELECT HOSPITAL_COD FROM HOSPITAL WHERE NOMBRE= 'la paz'),(SELECT MAX (DOCTOR_NO) +1 FROM DOCTOR),'Houe', 'Diagnostico');

-- 12) Borrar todos los empleados dados de alta entre las fechas 01/01/80 y 31/12/82.


SELECT * FROM EMP;

DELETE FROM EMP WHERE FECHA_ALT > '01/01/80' AND FECHA_ALT < '01/01/90';

-- 13) Modificar el salario de los empleados trabajen en la paz y estén destinados a Psiquiatría.  Subirles el sueldo 20000 Ptas. más que al señor Lopez A.

SELECT * FROM HOSPITAL;
SELECT * FROM DOCTOR;

UPDATE DOCTOR SET SALARIO= ((select salario from DOCTOR WHERE APELLIDO= 'Lopez A')+ 20000)
WHERE ESPECIALIDAD = 'Psiquiatria' AND HOSPITAL_COD=(SELECT HOSPITAL_COD FROM HOSPITAL WHERE NOMBRE= 'la paz');


-- 14) Insertar un empleado con valores null (por ejemplo la comisión o el oficio), y después borrarlo buscando como valor dicho valor null creado.

SELECT * FROM EMP;
INSERT INTO EMP (EMP_NO, APELLIDO)
VALUES ((SELECT MAX (EMP_NO) +1 FROM EMP), 'PEREZ');

DELETE FROM EMP WHERE OFICIO is null;

-- 15) Borrar los empleados cuyo nombre de departamento sea producción

SELECT * FROM DEPT;

UPDATE EMP SET DEPT_NO = (DEPT_NO+10);

SELECT * FROM EMP;

DELETE FROM EMP WHERE DEPT_NO= ( SELECT DEPT_NO FROM DEPT WHERE DNOMBRE= 'PRODUCCIÓN');

-- 16) Borrar todos los registros de la tabla Emp sin delete
SELECT * FROM EMP;

UPDATE EMP SET APELLIDO = NULL, OFICIO= NULL, DIR= NULL, FECHA_ALT= NULL, SALARIO= NULL, COMISION=NULL, DEPT_NO=NULL ; 

ROLLBACK;

--17) DEJAR LA BASE DE DATOS INTACTA
COMMIT;

select * from dept;

select * from emp;

/* 

DIA 6
RESTRICCIONES
DESDE HOY EMPIEZA EL TEMARÌO RELACIONADO A ORACLE SQL
eN ANSI SQL no existen consultas masivas de datos a no er que se recupere de otra tabla
*/

-- Bulk insert: insertar varios registros en una tabla que exista
-- el dual se pone porque el programa necesita una tabla// es un comodín
-- hace tantas filas según el tamaño del dept
-- Solo se puede usar en valores estáticos 

select * from dual;

insert all
  into tabla values (valor1, valor2)
  into tabla values (valor1, valor2)
  into tabla (campo1, campo2) values (valor1, valor2)
select fecha_actual() from tabla;

insert all
  into dept values (50, 'Oracle', 'Bernabeu')
  into dept values (60, 'i+d', 'Oviedo')
select * from dual;

INSERT INTO DEPT VALUES ((SELECT MAX(DEPT_NO) +1 FROM DEPT),'INTO1','INTO1');
INSERT INTO DEPT VALUES ((SELECT MAX(DEPT_NO) +1 FROM DEPT),'INTO2','INTO2');
INSERT INTO DEPT VALUES ((SELECT MAX(DEPT_NO) +1 FROM DEPT),'INTO3','INTO3');

SELECT * FROM DEPT;

INSERT ALL
  into dept values ((SELECT MAX(DEPT_NO) +1 FROM DEPT), 'ALL1', 'ALL1')
  into dept values ((SELECT MAX(DEPT_NO) +1 FROM DEPT), 'ALL2', 'ALL2')
  into dept values ((SELECT MAX(DEPT_NO) +1 FROM DEPT), 'ALL3', 'ALL3')
select * from dual;

ROLLBACK;

--Hay dos formas de crear tablas con insert
--inert into select inserta datos de una tabla a otra tabla existente
-- create into select crea una tabla y se le agregan los datos

CREATE TABLE DESTINO AS SELECT * FROM ORIGEN;

SELECT * FROM DEPT;
DESCRIBE DEPT;
DESCRIBE DEPARTAMENTOS;

CREATE TABLE departamentos
AS 
SELECT * FROM DEPT;

CREATE TABLE DOCTOR_HOSPITAL
AS
SELECT DOCTOR.DOCTOR_NO AS IDDOCTOR
, DOCTOR.APELLIDO, HOSPITAL.NOMBRE, HOSPITAL.TELEFONO
FROM DOCTOR
INNER JOIN HOSPITAL
ON DOCTOR.HOSPITAL_COD= HOSPITAL.HOSPITAL_COD;

SELECT * FROM DOCTOR_HOSPITAL;

-- insert into select
--Nos permite copiar atos de una tabla de origen a una detino
-- la diferencia es que en esta debe existir una tabla de destino
-- la tabla de destino dbe tener la misma estructura que los datos del select de origen

insert into destino select * from origen;

insert into DEPARTAMENTOS select * from dept;

select * from departamentos;

-- variables de sustitucion
-- es una herramienta 
--& se declara de esta forma

select apellido, oficio, salario, comision from emp
where emp_no=&numero;

select apellido, oficio, salario, comision from emp
where apellido ='&ape';

select apellido, oficio, salario from emp
where &condicion;


select apellido, &&campo1, salario, comsion, dept_no from emp where &campo1='&dato';

undefine dato;

-- FUNCIÓN JOINN - NATURAL JOIN
-- SOLO SE PUEDE SI LA COLUMNAS DE COINCIDENCIA SON IGUAL
-- SI COINCIDE SE PUEDE HACER 
-- TNER CUIDADO CON LAS COINCIDENCIA QUE SE PUEDAN DAR
-- SOLO FUNCIONA PARA DOS TABLAS

SELECT APELLIDO, LOC FROM EMP NATURAL JOIN DEPT;

SELECT APELLIDO, LOC FROM EMP NATURAL JOIN DEPT;


-- USING
-- SE PUEDE USAR USING Y E DICE EL CAMPO DE COINCIDENCIA, SI HAY MÁS SE SEPARAN POR,
SELECT * FROM EMP NATURAL JOIN DEPT;


-- RECUPERACIÓN JERÁRQUICA
SELECT * FROM EMP WHERE DIR=7698;

-- HAY UN PRESIDENTE QUE ES EL JEFE, SE LLAMA REY Y SU ID ES 7839
-- MOSTRAR TODOS LOS EMPLEADOS QUE TRABAJAN PARA REY
-- PERMITE VER LOS DISTINTOS NIVELES DE RECUPERACIÓN ENTRE CONSULTAS
-- SE VE EL NIVEL DE ORDENACION DE JERARQUIA

SELECT * FROM EMP WHERE DIR= 7839;

-- mostrar los empleados subordinados a partir del director jimenez

SELECT LEVEL, DIR, APELLIDO, OFICIO  
FROM EMP
CONNECT BY PRIOR EMP_NO= DIR
START WITH APELLIDO= 'jimenez'
ORDER BY 1;

SELECT LEVEL, DIR, APELLIDO, OFICIO  
FROM EMP
CONNECT BY  EMP_NO= PRIOR DIR
START WITH APELLIDO= 'jimenez'
ORDER BY 1;

SELECT LEVEL, DIR, APELLIDO, OFICIO  
FROM EMP
CONNECT BY  EMP_NO= PRIOR DIR
START WITH APELLIDO= 'arroyo'
ORDER BY 1;

-- by path
-- muestra el camino que sigue la red social
-- AGREGAR SYS_CONNECT_BY_PATH

SELECT LEVEL as nivel, DIR, APELLIDO, OFICIO , SYS_CONNECT_BY_PATH (APELLIDO, '/') AS RELACION 
FROM EMP
CONNECT BY PRIOR EMP_NO= DIR
START WITH APELLIDO= 'rey'
ORDER BY 1;

-- operaciones de conjunto
-- tienen que ver con unión dentro de un mismo cursor
-- unión y unión all están en cualquier base de datos
-- Oracle tiene
-- INTERSECT: VE LOS VALORES QUE ESTÁN EN LAS DOS CONDICIONES
-- MINUS : LOS QUE NO SIGUEN NINGUNA DE LAS DOS CONDICIONES


SELECT * FROM PLANTILLA WHERE TURNO='T'
UNION
SELECT * FROM PLANTILLA WHERE FUNCION = 'ENFERMERA';

SELECT * FROM PLANTILLA WHERE TURNO='T'
INTERSECT
SELECT * FROM PLANTILLA WHERE FUNCION = 'ENFERMERA';

SELECT * FROM PLANTILLA WHERE TURNO='T'
MINUS
SELECT * FROM PLANTILLA WHERE FUNCION = 'ENFERMERA';

-- DÍA 6
-- CREACIÓN DE TABLAS Y OBJETOS
-- NO SE DIFERENCIAN EN MAYUS O MINUS CON TABLA
-- NO HAY PALABRAS RESERVADAS
-- AL CREAR EL OBJETO, VAN ASOCIADOS A SYSTEM, EL PROPIETARIO
-- NO PUEDE EXISTIR DOS VECES EN EL MISMO USARIO

--SINTAXIS CREAR TABLA
--CREATE TABLE NOMBRE_TABLA
--(COLUMN1 TIPO_DATO NULL/NOT NULL,
--COLUMN2 TIPO_DATO); --NULL/NOT NULL );

COMMIT;

CREATE TABLE PRUEBA(
  IDENTIFICADOR INTEGER,
  TEXTO VARCHAR2(10) NOT NULL,
  TEXTOCHAR CHAR(5)
);
 
ROLLBACK; 
DESCRIBE PRUEBA;

INSERT INTO PRUEBA VALUES (1, 'ABCDEFGHI', 'AEIOU');
INSERT INTO PRUEBA VALUES (1, 'A', 'A'); --AUNQUE NO LO VEA, EN CHAR SE COMPLEMENTAN LOS VALORES EN 5
INSERT INTO PRUEBA VALUES (1, 'A', 'ABSCDEJF'); -- NO LO PERMITE POR RESTRICCIONES

SELECT * FROM PRUEBA;

DROP TABLE PRUEBA;

-- AGREGAR ELEMENTOS A LA TABLA
-- SE PUEDEN AGREGAR COLUMNAS Y ESTO AGREGA UN COMMIT A LA TABLA Y BASE DE DATOS
-- LA TABLA PRUEBA TIENE 1 REGISTRO Y VOY A A GREGAR UNA NUEVA COLUMNA DE TIPO TEXTO LLAMADA NUEVA
-- EL ALTER TABLE GNERA COMIIT
-- NO PUEDO AGREGAR UNA COLUMNA NOT NULL SI HAY REGISTROS EN LA TABLA
-- NOT NULL ES UNA RESTRICCIÓN DE BAJO NIVEL

ALTER TABLE PRUEBA 
ADD (NUEVA VARCHAR2(3));

ALTER TABLE PRUEBA 
ADD (SINNULOS VARCHAR2(7) not null );

DELETE FROM PRUEBA;

-- ELIMINA LA COLUMNA ESPECIFICADA AUNQUE SE TENGA O NO DATOS

ALTER TABLE PRUEBA
DROP COLUMN SINNULOS;

--MODIFICAR EL TIPO DE DATOS DE LAS COLUMNAS

ALTER TABLE PRUEBA
MODIFY (NUEVA FLOAT);

--CAMBIO DE NOMBRE DE UNA TABLA
RENAME PRUEBA TO PRUEBA1;
RENAME PRUEBA1 TO PRUEBA;

-- TRUNCATE ELIMINA TODO LO QUE HAY EN LA TABLA SIN BORRAR LA TABLA
-- NO DEJA REGISSTRO

TRUNCATE TABLE PRUEBA; 

-- AÑADIR COMENARIOS A PARTIR DE TABLA.COOMENT

COMMENT ON TABLE PRUEBA
IS 'HOY ES MIÉRCOLES Y MAÑANA JUEVES';

-- VER LOS COMENTARIOS DE LA TABLA
-- SI SE ELIMINA, SE BORRAN TAMBIÉN LOS COMENTARIOS
-- USER ES SOLO DE MI USUARIO
-- DESDE ALL, SI SOY SYSTEM, PUEDO VER LA TABLA

SELECT * FROM ALL_TAB_COMMENTS
WHERE TABLE_NAME= 'PRUEBA';

-- USER TABLES
-- HAY UN DICCIONARIO QUE SE LLAMA USER_TABLES Y AHÍ APARECEN TODAS LAS TABLAS DEL USUAIO

SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES;

-- PARA MOSTRAR TODOS LOS OBJETOS PROPIOS

SELECT DISTINCT OBJECT_TYPE FROM USER_OBJECTS;

-- OBJETOS QUE SON PRORIEDAD DEL USUARIO (TODOS LOS OBJETOS QUE SON MÌOS)

SELECT * FROM CAT;

-- RESTRICCIONES Y CARACTERISTICAS QUE AYUDAN A LA INTEGRIDAD DE LOS DATOS
-- DEFAULT:  REEMPLAZA EL NULL CUANDO SE CREA UNA TABLA
-- SUSTITUYE VALORES CUANDO LOS MARCO 

DESCRIBE PRUEBA;

INSERT INTO  PRUEBA VALUES (1, 'ABSJS', 'AEIOU');

SELECT * FROM PRUEBA;

ALTER TABLE PRUEBA 
ADD (TEST INT);

ALTER TABLE PRUEBA 
ADD (DEFECTO INT DEFAULT -1);

INSERT INTO PRUEBA
(IDENTIFICADOR, TEXTO, TEXTOCHAR)
VALUES
(2, 'AA', 'AA');

ALTER TABLE PRUEBA
MODIFY (TEST INT );

INSERT INTO PRUEBA
(IDENTIFICADOR, TEXTO, TEXTOCHAR,DEFECTO)
VALUES
(2, 'AA', 'AA', 22);

INSERT INTO PRUEBA
(IDENTIFICADOR, TEXTO, TEXTOCHAR,DEFECTO)
VALUES
(4, 'CC', 'CC', NULL);


-- RESTRICCIÓN DE MEDIO NIVEL /CONSTRAINS/
-- SE PUEDEN BUSCAR LA RESTRICCIONES 
-- SI SE CREA LA TABLA, CREA NOMBRES AUTOMÀTICOS
-- sE RECOMIENDA PRIMERO CREATE TABLE Y LUEGO EL CONSTRAINS
-- PRIMARY KEY: SOLO PUEDE HABER DATOS ÚNICOS, SOLO 1 POR TABLA O NO REPETIDOS, NO ADMITE VALORES NULOS
-- PUEDO HACER UNA TABLA Y QUE AFECTAN A VARIAS COLUMNAS
-- CREA ÍNDICES
-- TODAS LAS RESTRICCIONES DEL USUARIO SE ENCUENTRAN EN EL DICCIONARIO USER_CONSTRAINTS


-- UNIQUE: SIMILAR A PRIMARY KEY PERO DE ESTÁ SI PUEDO TENER MÁS DE UNA COLUMNA POR TABLA
-- SE PUEDEN TENER TODOS LOS QUE QUIERA EN LA TABLA
-- SE DENOMINA COMO U_TABLA_CAMPO


-- CHEK: VALIDACIÓN DE DATOS
-- SE AGREGAN VALORES QUE NO SON DINÀMICOS, SE DEBEN VALORES ESTÁTICOS
-- SE PUEDE LLAMAR CK_TABLA_CAMPO O CHK_TABLA_CAMPO


-- FOREIGN KEY: RESTRINCCIÓN DE RELACIÓN ENTRE TABLAS, NO SE PUEDE INSERTAR VALORES SI NO HAY CON QUÉ RELACIÓN
-- TIENE  QUE VER EN LA RELACIÓN ENTRE UNA O MÁS TABLAS
-- PARA CREARLA TIENE QUE SER REFERENCIADA A UN CAMPO CLAVE O UNIQUE
-- nO PUEDE TENER CAMPOS SIN RELACIONADOS
-- TABLA1 ES LA PRINCIPAL Y TABLA2 ES FOREIGN KEY (FK) SE DEFINE
-- IMPIDE ELIMINAR UN CAMPO UNICO SI TIENE REFERENCIAS

-- LAS RESTRICCIONES SE PUEDEN HACER AL CREAR LA TABLA O DESPUÉS DE... 

SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM EMP;
select * from dept;

ALTER TABLE DEPT
ADD CONSTRAINT PK_DEPT
PRIMARY KEY (DEPT_NO);

INSERT INTO DEPT VALUES (10,'REPE', 'REPE');
-- ELIMINAR LA RESTRICCIÓN DE PRIMARY KEY DE DEPARTAMENTOS

ALTER TABLE DEPT
DROP CONSTRAINT PK_DEPT;

DELETE FROM DEPT WHERE DEPT_NO= '10';

ROLLBACK;

-- EMPLEADOS

ALTER TABLE EMP
ADD CONSTRAINT PK_EMP
PRIMARY KEY (EMP_NO);

SELECT * FROM EMP;

-- RETRICCIÓN PARA COMPROBAR QUE EL SALARIO SIEMPRE SEA POSITIVO

ALTER TABLE EMP
ADD CONSTRAINT CHK_EMP_SALARIO
CHECK (SALARIO >= 0);

UPDATE EMP SET SALARIO =1
WHERE APELLIDO = 'rey';

-- SI LO VALORES DE LA TABLA NO CUMPLEN LA CONDICIÓN, NO PUEDO CREAR EL CONSTRAIN

-- sELECCIONAR VALORES UNIQUE DE LA TABLA Y PRIMARY KEEY EN LA MISMA TABLA
-- NO SE PUEDE REPEETIR PRIMARY KEY NI UNIQUE
-- THE PRIMARY KEY CAN`T HAVE NULL
-- UNIQUE ALLOW NULL, THE CONSTRAIN VERIFY VALUES AND NULL ISN`T A VALUE
-- NULL IS A TYPE THAT HAVEN`T A VALUE
-- THE ONLY WAY IS DEFINE NOT NULL WHEN I MAKE THE CONSTRAINS ON THE TABLE


SELECT * FROM ENFERMO;

ALTER TABLE ENFERMO
ADD CONSTRAINT PK_ENFERMO
PRIMARY KEY (INSCRIPCION);

ALTER TABLE ENFERMO
ADD CONSTRAINT UNQ_ENFERMO_NSS
UNIQUE (NSS);

INSERT INTO ENFERMO
VALUES (10995, 'NUEVO', 'CALLE NUEVA', '01/01/01','F', '123');

INSERT INTO ENFERMO
VALUES (10995, 'NUEVO', 'CALLE NUEVA', '01/01/01','F', '280862482');

INSERT INTO ENFERMO
VALUES (10998, 'NUEVO', 'CALLE NUEVA', '01/01/01','F', NULL);

DELETE FROM ENFERMO WHERE APELLIDO= 'NUEVO';

DESCRIBE ENFERMO; 

-- el ùltimo ejemplo está mal a propósito porque es necesario hacer primary key de dos columnas

rollback;

select * from enfermo;

ALTER TABLE ENFERMO
DROP CONSTRAINT UNQ_ENFERMO_NSS;

-- CREATE A DOBLE PRIMARY KEY (TWO OR MORE COLUMNS)
-- WITH THIS CONSTRAIN, THE UNIQUE APPLY IN THE RELATION OF TWO COLUMNS
-- IF I WANT APPLY UNIQUE IN ONE OF THE TOW COLUMNS, I CAN DO IT

ALTER TABLE ENFERMO
ADD CONSTRAINT PK_ENFERMO
PRIMARY KEY (INSCRIPCION, NSS);

ALTER TABLE ENFERMO
ADD CONSTRAINT UNQ_ENFERMO_INSCRIPCION
UNIQUE (INSCRIPCION);


INSERT INTO ENFERMO 
VALUES (10995, 'LANGUIA', 'GOYA 20','15/05/2020', 'M', 280862482);


INSERT INTO ENFERMO 
VALUES (10995, 'LANGUIA', 'GOYA 20','15/05/2020', 'M', 9188383);

SELECT * FROM ENFERMO;

DELETE FROM ENFERMO WHERE DIRECCION= 'GOYA 20';

-- FOREIGN KEY

-- rELACIÓN ENTRE DEPT Y EMP
-- SE NECESITA CREAR UNA PRIMARY KEY
-- EN LA FOREING KEY DEBEN EXISTIR LOS DATOS DE LA PRIMARY KEY.
-- SI QUIERO TENER NULOS, LO PUEDO DEJAR O MODIFICAR CON UN UNIQUE
-- LA FOREING KEY VA SÍ O SÍ PARA LA TABLA QUE TIENE LA RELACIÓN 



ALTER TABLE DEPT
ADD CONSTRAINT PK_DEPT
PRIMARY KEY(DEPT_NO);

ALTER TABLE EMP
ADD CONSTRAINT FK_EMP_DEPT
FOREIGN KEY (DEPT_NO)
REFERENCES DEPT(DEPT_NO);


SELECT * FROM EMP;
SELECT * FROM DEPT;

ROLLBACK;

--CREO UN VALOR A 50 EN DEPT PARA PODER AGREGAR DATOS AHÍ 

INSERT INTO DEPT VALUES (50, 'ORACLE','ITALIA');

INSERT INTO EMP VALUES (1111, 'NUEVO', 'EMPLEADO', 7902, '02/02/2020', 1,1,50);


INSERT INTO EMP VALUES (1111, 'NUEVO', 'EMPLEADO', 7902, '02/02/2020', 1,1,NULL);


-- ELIMINAR EN CASCADA Y SET NULL/ SE INDICA DE UNA VEZ EN EL CONTRAINT
-- PERO ELIMINA TODOS LOS EMPLEADOS RELACIONADOS
-- ES MEJOR NO USARLO NUNCA
-- LO MEJOR ES USAR 'ON DELETTE SET NULL'
-- SI QUIERO ELIMINAR ALGO, LO MEJOR ES EMPEZAR POR DÓNDE ESTÁ LA FOREIGN KEY

ALTER TABLE EMP
DROP CONSTRAINT FK_EMP_DEPT;

ALTER TABLE EMP
ADD CONSTRAINT FK_EMP_DEPT
FOREIGN KEY (DEPT_NO)
REFERENCES DEPT(DEPT_NO)
ON DELETE SET NULL;

DELETE FROM DEPT WHERE DEPT_NO=10 ;

SELECT * FROM EMP; 

/* 

    DÌA 8

    SECUENCIAS
  
  es un contador que le puede aplicar a la tabla.
  Si el ùltimo campo es 85, él pondrá 86
  Se debe usar de forma explícita en el insert
  es un objeto y se llama sequence

  se puede llamar usando 
  nextval: siguiente valor
  currval: nos devuelve el valor actuak

dual siempre se va a usar

--una secuencia no se puede modificar, solo se puede eliminar

EL STAR WITH DEBERÌA SER CON EL VALOR DONDE DEBE EMPEZAR LA TABLA

TODOS LOS VALORES SON FIJOS, PERO NO SE PUEDE MODIFICAR 
*/ 
-- sintaxís

drop sequence seq_DEPT;

create sequence seq_dept
increment by 10
start with 50;


select seq_dept.NEXTVAL AS SIGUIENTE FROM DUAL;

-- NO SE PUEDE ACCEDER A CURRENT VAL HASTA QUE SE EJECUTE LA TABLA PARA APLICAR 
SELECT SEQ_DEPT.CURRVAL AS ACTUAL FROM DUAL;


--SI SE QUIERE APLICAR AL INSERTAR, SE DEBE LLAMAR DE FORMA EXPLICITA

INSERT INTO DEPT VALUES (SEQ_DEPT.nextval, 'NUEVO', 'NUEVO');

SELECT * FROM DEPT;

DELETE FROM DEPT WHERE DNOMBRE = 'NUEVO';

-- UNA SECUENCIA NO ESTÁ ASOCIADA A LAS TABLA
-- SE PUEDE UTILIZAR PARA CUALQUIER COSA, POR EJEMPLO INSERTAR A OTRA TABLA

INSERT INTO HOSPITAL VALUES 
(SEQ_DEPT.nextval, 'EL CARMEN','CALLE PEX','12345',125);

DELETE FROM HOSPITAL WHERE NOMBRE= 'EL CARMEN';

SELECT * FROM HOSPITAL;


-- Práctica
-- Pk en hospital

SELECT * FROM HOSPITAL;

ALTER TABLE HOSPITAL
ADD CONSTRAINT PK_HOSPITAL
PRIMARY KEY (HOSPITAL_COD);


-- Pk en doctor
SELECT * FROM DOCTOR;

ALTER TABLE DOCTOR
ADD CONSTRAINT PK_DOCTOR
PRIMARY KEY (DOCTOR_NO);



-- relacionar doctor con hospital
SELECT * FROM HOSPITAL;

ALTER TABLE DOCTOR
ADD CONSTRAINT FK_DOCTOR_HOSPITAL
FOREIGN KEY (HOSPITAL_COD)
REFERENCES HOSPITAL(HOSPITAL_COD);



-- las personas de la plantilla solo pueden trabajar en turnos de mañana, tarde o noche

SELECT * FROM PLANTILLA;

ALTER TABLE PLANTILLA
ADD CONSTRAINT CHK_PLANTILLA_TURNO
CHECK (TURNO IN ('T','M','N'));

INSERT INTO PLANTILLA VALUES 
(19,6,123,'HOUSE', 'INTERNO','T',10202);


--- PRÁCTICA ---

------------- CREACIÓN DE TABLAS --------


-- CREAR LA TABLA COLEGIOS Y SUS RESTRICCIONES

CREATE TABLE COLEGIOS (
  COD_COLEGIO INTEGER NOT NULL,
  NOMBRE VARCHAR2(20) NOT NULL,
  LOCALIDAD VARCHAR2(15),
  PROVINCIA VARCHAR2(15),
  ANO_CONSTRUCCION DATE,
  COSTE_CONSTRUCCION INTEGER,
  COD_REGION INTEGER ,
  UNICO INTEGER NOT NULL);



--CREAR TABLA PROFESORES

CREATE TABLE PROFESORES (
  COD_PROFE VARCHAR2(100),
  NOMBRE VARCHAR2(100),
  APPELLIDO1 VARCHAR2(100),
  APELLIDO2 VARCHAR2(100),
  DNI VARCHAR2(9),
  EDAD INTEGER,
  LOCALIDAD VARCHAR2(100),
  PROVINCIA VARCHAR2(100),
  SALARIO INTEGER,
  COD_COLEGIO NUMBER
)


-- TABLA REGIONS

CREATE TABLE REGIONES(
  COD_REGION INTEGER,
  REGIONES VARCHAR2(20) NOT NULL
);

--TABLA ALUMNOS

CREATE TABLE ALUMNOS(
  DNI VARCHAR2(100),
  NOMBRE VARCHAR2(100) NOT NULL,
  APELLIDOS VARCHAR2(100),
  FECHA_INGRESO DATE,
  FECHA_NAC DATE,
  LOCALIDAD VARCHAR2(15),
  PROVINCIA VARCHAR2(100),
  COD_COLEGIO INTEGER
);

------------- RESTRICCIÓN DE TABLAS --------

-- RESTRICCIÓN COLEGIOS

SELECT * FROM COLEGIOS;

ALTER TABLE COLEGIOS
ADD CONSTRAINT PK_COLEGIOS
PRIMARY KEY (COD_COLEGIO);

ALTER TABLE COLEGIOS
ADD CONSTRAINT UNQ_COLEGIOS_NOMBRE
UNIQUE (UNICO);

create sequence seq_COD_COLEGIO
increment by 1
start with 1;

INSERT INTO COLEGIOS VALUES (seq_COD_COLEGIO.NEXTVAL,'PRUEBA', 'A','A','17/10/17',1,1,1);

-- RESTRICCIÓN PROFESORES

ALTER TABLE PROFESORES
ADD CONSTRAINT PK_PROFESORES
PRIMARY KEY (COD_PROFE);

ALTER TABLE PROFESORES
ADD CONSTRAINT UNQ_PROFESORES_DNI
UNIQUE (DNI);

ALTER TABLE PROFESORES
ADD CONSTRAINT FK_PROFESORES_COLEGIOS
FOREIGN KEY (COD_COLEGIO)
REFERENCES COLEGIOS(COD_COLEGIO);

-- RESTRICCIÓN REGIONES

ALTER TABLE REGIONES
ADD CONSTRAINT PK_REGIONES
PRIMARY KEY (COD_REGION);

--RESTRICCIÓN ALUMNOS

ALTER TABLE ALUMNOS
ADD CONSTRAINT PK_ALUMNOS
PRIMARY KEY (DNI);

-- Crear una nueva relación entre el campo Cod_Region de 
-- la tabla REGIONES y Cod_Region de la tabla colegios.

ALTER TABLE COLEGIOS
ADD CONSTRAINT FK_COLEGIO_REGIONES
FOREIGN KEY (COD_REGION)
REFERENCES REGIONES(COD_REGION);

ALTER TABLE COLEGIOS
DROP CONSTRAINT FK_COLEGIO_REGIONES;

--Añadir el campo Sexo, Fecha de nacimiento y Estado Civil a la tabla Profesores

ALTER TABLE PROFESORES
ADD(
  SEXO VARCHAR2(5),
  F_NACIMIENTO DATE,
  ESTADO_CIVIL VARCHAR2(10)
  );

-- Eliminar el campo Edad de la tabla Profesores.

ALTER TABLE PROFESORES
DROP (EDAD);

SELECT * FROM PROFESORES;

-- AÑADIR El campo Sexo, Dirección y Estado Civil a la tabla Alumnos.

ALTER TABLE ALUMNOS
ADD(
  SEXO VARCHAR2(5),
  DIRECCION VARCHAR2(15),
  ESTADO_CIVIL VARCHAR2(10)
  );

-- Borrar la relación existente entre la tabla profesores y Colegios.

ALTER TABLE PROFESORES
DROP CONSTRAINT FK_PROFESORES_COLEGIOS;

-- Crear de nuevo la relación borrada en el ejercicio anterior que tenga eliminación en cascada.

ALTER TABLE PROFESORES
ADD CONSTRAINT FK_PROFESORES_COLEGIOS
FOREIGN KEY (COD_COLEGIO)
REFERENCES COLEGIOS(COD_COLEGIO)
ON DELETE CASCADE;

--Agregar un valor por defecto con la fecha actual al campo Fecha_Ingreso de la tabla alumnos.

SELECT * FROM ALUMNOS;

ALTER TABLE ALUMNOS
MODIFY (FECHA_INGRESO DATE DEFAULT SYSDATE);

SELECT * FROM ALUMNOS;

INSERT INTO ALUMNOS (DNI,NOMBRE,APELLIDOS,PROVINCIA,LOCALIDAD) 
VALUES ('Y978643K','ANA','ORTIZ ORTEGA','MADRID','MADRID');

INSERT INTO ALUMNOS (DNI,NOMBRE,APELLIDOS,PROVINCIA,LOCALIDAD) 
VALUES ('Y9724343K','JAVIER','Palomo Provincia','ALICANTE','ARE DEL SOL');

INSERT INTO ALUMNOS (DNI,NOMBRE,APELLIDOS,PROVINCIA,LOCALIDAD) 
VALUES ('Y93113343Z','MIGUEL','Torres Tormo','BARCELONA','Llobregat');

INSERT INTO ALUMNOS (DNI,NOMBRE,APELLIDOS,PROVINCIA,LOCALIDAD) 
VALUES ('Y2442113343Z','PRUEBA','PRUEBA','MADRID','MADRID');



SELECT * FROM COLEGIOS;

SELECT * FROM REGIONES;

INSERT INTO REGIONES VALUES ('1','MADRID');
INSERT INTO REGIONES VALUES ('2','BARCELONA');
INSERT INTO REGIONES VALUES ('3','VALENCIA');


DROP TABLE REGIONES;

/* 

martes 08 de abril

funciones propias de Oracle

En cada base hay distintas funciones, pero la mayorìa son iguales.
Las que se ven acá son funciones únicas de Oracle

funciones de filtro según carácteres

LOWER : convierte de mayúcula a minúscula
UPPER: cinvierte de minúscula a mayúscula
INTICAP: s como la opción de nombre propio
*/


select * from emp where lower(oficio) = 'analista';

UPDATE EMP SET OFICIO = LOWER(OFICIO);

--TAMBIÉN SE PUEDEN INCLUIR VALORS DINÁMICOS, POR LO QUE SE TIENEN QUE CONVERTIR LA DOS COMPARACIONES

SELECT * FROM EMP WHERE UPPER (OFICIO) = UPPER('&DATO');

-- EN ORACLE ESTÁ LA POSIBILIDAD DE CONCATENAR TEXTOS EN UNA SOLA COLUMNA (CAMPO CALCULADO)
-- SE UTILIZA EL SIMBÒLO || PARA CONCATENAR
-- QUEREMOS MOSTRAR EN UNA COLUMNA EL APPELLIDO Y OFICIO DE LOS EMPLEADOS

SELECT APELLIDO ||'_' || OFICIO AS DESCRIPCION FROM EMP;

-- LA FUNCION INITCAMPO MUESTRA CADA PALABRA DE UNA FRASE CON LA PRIMERA LETRA EN MAYUCULA

SELECT INITCAP (OFICIO) AS INITC  FROM EMP;


SELECT INITCAP (APELLIDO ||'_' || OFICIO) AS INITC FROM EMP;

--MANIPULACIÓN DE CARÁCTERES 

SELECT CONCAT(APELLIDO, OFICIO) AS RESULTADO FROM EMP;

-- SUBSTRING: EXTRAE UNA CADENA DE CARÁCTERES SEGÚN UNA MEDIDA 
-- SUBSTR(CAD, M[N]), M ES LA POSICIÓN DE INICIO Y N LA CANTIDAD DE CARÁCTERES QUE QUIERO

SELECT SUBSTR('FLORERO', 2, 4) AS DATO FROM DUAL; 

--SI NO LE PONGO LA CANTIDAD DE CARÁCTERES, DEVOLVERÁ TODOS
SELECT SUBSTR('FLORERO', 3) AS DATO FROM DUAL; 

--MOTRAR LOS EMPLEADOS CUYOS APPELLIDOS EMPIEZAN CON S
-- like es menos eficiente, solo funcianará substr

SELECT * FROM EMP WHERE APELLIDO LIKE 's%';

SELECT SUBSTR (APELLIDO,1,1) AS UNA_LETRA FROM EMP;

SELECT * FROM EMP WHERE SUBSTR (APELLIDO,1,1)= 's';

SELECT * FROM EMP WHERE APELLIDO LIKE '____';

SELECT * FROM EMP WHERE LENGTH (APELLIDO)= 4;

-- INSTR busca una cadena de texto y dice en qué carácter o qué posición se encuentra ese carácter
-- si se repite devuelve la primera coincidencia que encuentra

select instr ('benito', 'nip') as posicion from dual; 

-- también sirve como campo calculado

select instr (apellido, 'a') as posicion from emp; 

select * from dual where instr ('mail@', '@')>0 ;

--LPAD INZERTA TANOS CARACÁCTERES SEGÚN SE MENCION (L A LA IZQUIERDA Y R A ÑA DERECHA RPAD)

select LPAD (DEPT_NO,5, '$') from emp;

-- FUNCIONES NUMÉRICAS
-- ROUND: REDONDE LOS DÉMICALS SEGÚN E LE DIGA

SELECT ROUND(45.923) AS RONDEDO FROM DUAL;

SELECT ROUND(45.923, 2) AS RONDEDO FROM DUAL;

-- TRUNC ELIMINA LOS DIGITOS INDICADOS

SELECT TRUNC(45.923) AS RONDEDO FROM DUAL;

SELECT TRUNC(45.923, 2) AS RONDEDO FROM DUAL;

-- MOD DEVUELVE EL RESTO DE LA DIVISIÓN ENTRE DOS NÚMEROS
-- AVERIGUAR SI UN NÚMRERO ES PAR

-- PERMITE SABER SI UN NÚMERO ES O NO DIVISIBLE 

SELECT MOD(99, 2) AS RESTO FROM DUAL;
SELECT MOD(98, 2) AS RESTO FROM DUAL;

--MOSTRAR LOS EMPLEADOS CUYO SALARIO SEA PAR

UPDATE EMP SET SALARIO = SALARIO + 1 WHERE DEPT_NO=20;

SELECT APELLIDO, MOD (SALARIO,2) AS SALARIO_PAR FROM EMP WHERE MOD (SALARIO,2)=0;


--FUNCIONES DE FECHAS
-- RESTAR MESAS Y DÍAS ADEMÁS DE SABER LA FECHA ACTUAL
-- HAY UNA FUNCIÓN PARA AVERIGUAR LA FECHA DEL SERVIDOR (SYSDATA)

SELECT SYSDATE  AS DFECHA_ACTUAL FROM DUAL;
SELECT SYSDATE + 10 AS DFECHA_ACTUAL FROM DUAL;
SELECT SYSDATE - 10 AS DFECHA_ACTUAL FROM DUAL;
SELECT SYSDATE + 38 AS DFECHA_ACTUAL FROM DUAL;
SELECT SYSDATE + 360 AS DFECHA_ACTUAL FROM DUAL;

-- MONTHS_BETWEEN DEVUELVE LA CANTIDAD DE MESES QUE HAY ENTRE DOS FECHAS. LA PRIMERA FECHA DEBE SER MAYOR

SELECT APELLIDO, MONTHS_BETWEEN (SYSDATE, FECHA_ALT) AS MES FROM EMP;

SELECT ADD_MONTHS (SYSDATE, 5) AS DENTRO FROM DUAL;

--NEXT_DAY DEVUELVE LA FECHA DEL DÍA SIGUIENTE A LA FECHA

SELECT NEXT_DAY (SYSDATE+30, 2) AS NLUNES FROM DUAL;

--lastday (fecha) devuelve el útlimo día de una fecha

SELECT  LAST_DAY (SYSDATE) AS FINMES FROM DUAL; 

--ROUND: REDONDEA SEGÚN EL FORMATO

SELECT APELLIDO, FECHA_ALT, ROUND (FECHA_ALT, 'MM') AS ROUNDMES FROM EMP;
SELECT APELLIDO, FECHA_ALT, ROUND (FECHA_ALT, 'DD') AS ROUNDMES FROM EMP;

-- TRUNC: BLOQUEA LA FECHA SEGÚN EL FORMATO

SELECT APELLIDO, FECHA_ALT, TRUNC (FECHA_ALT, 'YY') AS ROUNDMES FROM EMP;
SELECT APELLIDO, FECHA_ALT, TRUNC (FECHA_ALT, 'MM') AS ROUNDMES FROM EMP;

/*

FUNCIONE DE CONVERSIÓN
TO_CHAR PERMITE CO
*/

SELECT APELLIDO, FECHA_ALT, TO_CHAR (FECHA_ALT, 'MM-DD-YYYY') FROM EMP;

SELECT TO_CHAR(SYSDATE, 'DAY MONTH YEAR') AS NOMBREMES FROM DUAL;

--NÙMEROS

 SELECT TO_CHAR(8889, '0000L') AS NOMBREMES FROM DUAL;

--HORA DEL SISTEMA

SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') as Hora
FROM DUAL;

-- SI DESEAMOS INCLUIR TEXTO ENTRE TO_CHAR Y LO FORMATOS SE REALIZA CON COMILLAS DOBLES DENTRO DE LAS SIMPLES ' ... "... "... '

SELECT TO_CHAR (SYSDATE, '"TODAY IS" DD "OF" MONTH' ) AS FORMATO FROM DUAL;

SELECT TO_CHAR (SYSDATE, '"HOY ES" DD "DE" MONTH "DE" YEAR'  , 'NLS_DATE_LANGUAGE = SPANISH' ) AS FORMATO FROM DUAL;


-- FUNCIONES PARA CONVERTIR A SU FORMATO EXPLÌCITO
-- AUNQUE SE PUEDE OPERAR TEXTO Y NÙMEROS, PERO SOLO PARA FUNCIONES MUY MUY ESPECÍFICAS. SIEMPRE HAY QUE CONVERTIR EN NÙMERO LOS QUE ASÌ SON 
-- TO_NUMBER Y TO_DATE 

SELECT TO_DATE('08/04/2025') AS FECHA FROM DUAL;
SELECT '12'+2 AS RESULTADO FROM DUAL;
SELECT TO_NUMBER (12) +2 AS RESULTADO FROM DUAL;


-- FUNCIONES GENERALES (SIRVEN PA LO QUE SEA)
-- TENERLAS MUY PRESENTES
-- NVL SIRVE PARA EVITAR LOS NULOS Y SUSTITUIR
-- SE PUEDE INDICAR QUE EN LUGAR DE NULL ESCRIBA OTRO VALOR Y DEBE RESPONDER AL TIPO DE VALOR DE LA COLUMNA

SELECT apellido,salario, comision, NVL(comision,1) as "salario mensual" from emp;
SELECT apellido,salario, comision, salario + NVL(comision,0) as "salario mensual" from emp;

--DECODE: FUNCIÓN SIMILAR AL CASE PERO FUNCIONA SOLO EN ORACLE
-- MOSTRAR EN PALABRAS EL TURNO DE LA PLANTILLA
-- VA CON PARES Y SI ENCUENTRA UN IMPAR ÙNICO, SIRVE COMO ELSE

SELECT APELLIDO, TURNO FROM PLANTILLA;

SELECT APELLIDO, SALARIO, DECODE(TURNO, 'M', 'MAÑANA', 'N', 'NOCHE', 'TARDE') AS TURNO FROM PLANTILLA;

-- FUNCIONES ANIDADAS
-- INCLUIR CON LOS PARENTESÍS DISTINTAS FUNCIONES

SELECT TO_CHAR (NEXT_DAY (SYSDATE +2, 'FRIDAY'), '"EL DÍA" DAY DD "JUEGA EL MADRID"', 'NLS_DATE_LANGUAGE = SPANISH' ) AS CHAMPION FROM DUAL;


SELECT APELLIDO, FECHA_ALT
, TO_CHAR(NEXT_DAY(ADD_MONTHS(FECHA_ALT, 6)
, 'FRIDAY') , 'day, dd month, yyyy')
AS REVISION
FROM EMP;


-- EJERCICIO DE FUNCIONES

--Mostrar todos los apellidos de los empleados en Mayúsculas

SELECT UPPER(APELLIDO) AS APELLIDO FROM EMP;

/*
2. Construir una consulta para que salga la fecha de hoy con el siguiente formato:

FECHA DE HOY
-----------------------------------------
Martes 06 de Octubre de 2020
*/

select sysdate as fecha from dual;

select to_char(sysdate, 'DAY DD "DE" MONTH "DE" YYYY', 'NLS_DATE_LANGUAGE=SPANISH') as fecha from dual;

-- LO MISMO PERO EN ITALIANO

select to_char(sysdate, 'DAY DD "DE" MONTH "DE" YYYY', 'NLS_DATE_LANGUAGE=ITALIAN') as fecha from dual;

--    3. Queremos cambiar el departamento de Barcelona y llevarlo a Tabarnia.
--Para ello tenemos que saber qué empleados cambiarían de localidad y cuáles no.  
-- Combinar tablas y mostrar el nombre del departamento junto a los datos del empleado.



SELECT DEPT.DNOMBRE, EMP.APELLIDO,
CASE DEPT.LOC
  WHEN 'BARCELONA' THEN 'A TABARNIA'
  ELSE 'NO CAMBIA DE LOCALIDAD'
END AS TRASLADO
FROM EMP
INNER JOIN DEPT
ON EMP.DEPT_NO = DEPT.DEPT_NO;


--Mirar la fecha de alta del presidente. Visualizar todos los empleados dados de alta 330 días antes que el presidente. 

SELECT APELLIDO,OFICIO, FECHA_ALT FROM EMP 
WHERE FECHA_ALT < ((SELECT FECHA_ALT FROM EMP WHERE OFICIO= 'PRESIDENTE')-330);

-- HACER INFORME


SELECT APELLIDO, LENGTH(APELLIDO) AS LARGO FROM EMP;


select initcap (RPAD ( APELLIDO,14, '.')) AS I_APELLIDO,
    initcap (RPAD (OFICIO,14, '.')) AS I_OFICIO , 
    RPAD (SALARIO,14, '.') AS I_SALARIO,
    RPAD (NVL(COMISION,0), 14, '.') AS I_COMISION,
    RPAD (DEPT_NO, 14, '.') AS I_DEPT_NO
from emp;

SELECT RPAD(*,14, '.') AS INFORME FROM EMP; 

SELECT * FROM EMP;

/*
    6. Nos piden otro, en el que se muestren todos los empleados de la siguiente manera:


fechas de alta
------------------------------------------------------------------------------
El Señor Tovar con cargo de Vendedor se dió de alta el jueves  11 de noviembre  de 2095 en la empresa
*/

select to_char(sysdate, 'DAY DD "DE" MONTH "DE" YYYY', 'NLS_DATE_LANGUAGE=SPANISH') as fecha from dual;


SELECT * FROM EMP;

SELECT INITCAP ('EL SEÑOR ' ||APELLIDO ||'CON CARGO DE ' || OFICIO || 'SE DIÓ DE ALTA EL ' || to_char(sysdate, 'DAY DD "DE" MONTH "DE" YYYY "EN LA EMPRESA"', 'NLS_DATE_LANGUAGE=SPANISH')) AS INITC FROM EMP;


SELECT CONCAT( 
  INITCAP ('EL SEÑOR ' ||APELLIDO ||'CON CARGO DE ' || OFICIO || 'SE DIÓ DE ALTA EL ') ,
  to_char(sysdate, 'DAY DD "DE" MONTH "DE" YYYY "EN LA EMPRESA"', 'NLS_DATE_LANGUAGE=SPANISH') ) AS RESULTADO FROM EMP;