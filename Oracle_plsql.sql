-- Acà se define el plato fuerte
-- este es el certificado único y propio de oracle
-- todo esto es único y acá está la parte de desarrollo y programación
-- todo es variable y undependent
-- hay objetos que no tiene otro lenguaje
-- es una estrucutra de código, por lo que no es variable
-- Oracle utiliza una estructura de bloque
-- Ya se tiene variables y tipo para definir
-- Hay estructuras de control según lo que yo quiera
-- Los códigos y lo que escriba está afuera y no guarda la bases de datos, aunque después se pueden guardar en la base de datos
-- todos tienen la misma structura:
-- Declare
--      declaración de variables del programa (opcional)
-- Begin
--      Lógica del programa
-- Exceción
--      Qué ocurre si la lógica da error
--End;
--      obligatoria y cierra la declaración
-- para asignar valor a la variable se usa :=
-- ejemplo

DECLARE
    numero int;
begin
    -- LA VARIABLE ES NULL
    NUMERO :=19;
END;

-- SE IMPRIME POR PANTALLA
declare
    -- DECLARAMO UNA VARIABLE
   numero int;
   TEXTO VARCHAR2(40);
begin
   TEXTO := 'MI PRIMER PL/SQL';
   dbms_output.put_line('TEXTO: '|| TEXTO);   
   dbms_output.put_line('MI PRIMER BLOQUE ANÓNIMO 1');
   numero := 47;
   dbms_output.put_line('VALOR NÚMERO: ' || numero);
   numero := 22;
   dbms_output.put_line('VALOR NÚMERO: ' || numero);
   numero := numero * 22;
   dbms_output.put_line('VALOR NÚMERO 3: ' || numero);
end;

--POR EJEMPLO SI SE QUIERE PEDIR UNO PARA EL USUARIO// UTILIZAR VARIABLE DE SUSTITUCIÓN PARA EL USUARIO

DECLARE
    NOMBRE VARCHAR2(30);
BEGIN
    NOMBRE := '&DATO';
    DBMS_OUTPUT.PUT_LINE('SU NOMBRE ES '|| NOMBRE);
END;

-- SE PUEDE UTILIZAR CUALQUIER CARACTERÍSTICA


DECLARE
    FECHA DATE;
    TEXTO VARCHAR2(50);
    LONGITUD INT;
BEGIN
    FECHA := SYSDATE;
    TEXTO := '&NOMBRE';
    LONGITUD :=  LENGTH(TEXTO);
    dbms_output.put_line('HOY ES: '|| FECHA );
    dbms_output.put_line('LA LONGITUD DE SU TEXTO ES: ' || LONGITUD);
    dbms_output.put_line('LA LONGITUD DE SU TEXTO ES: ' || LENGTH(TEXTO));
END;


-- PROGRAMA PARA PEDIR NÚMEROS AL USUARIO

DECLARE
    N1 INT;
    N2 INT;
BEGIN
    N1 := '&N1';
    N2 := '&N2';
    dbms_output.put_line('LA SUMA DE' || N1 || ' + ' || N2 || ' = ' || (N1+N2) );
END;

UNDEFINE N1;
UNDEFINE N2;

-- DENTRO DE ESTOS BLOQUES NO SE PUEDEN PONER UN SELECT, AUNQUE SÌ INSSERT UPDATE AND DELETE
-- LAS VARIABLES NO SE PUEDEN LLAMAR IGUAL QUE LOS NOMBRES

SELECT * FROM EMP;

DECLARE
    V_DEPARTAMENTO INT;
BEGIN
    V_DEPARTAMENTO := &DEPT;
    UPDATE EMP SET SALARIO= SALARIO + 1 WHERE DEPT_NO=V_DEPARTAMENTO;
END;


UNDEFINE DEPT;

/* 

10 de abril de 2025
Si vamos a utilizar variables que reprsentan el valor de una columna
Tener siempre presente el tipo de columna sobre el que se construye
Se puede aplicar un tipo de variable que se ajuste a cómo se define en la tabla

declare
    v_variable tabla.columna%type
begin
end;

*/

SELECT * FROM DEPT;

DECLARE
    V_NUMERO DEPT.DEPT_NO%TYPE;
    V_NOMBRE DEPT.DNOMBRE%TYPE;
    V_LOCALIDAD DEPT.LOC%TYPE;
BEGIN
    V_NUMERO := '&numero';
    V_NOMBRE := '&nombre';
    V_LOCALIDAD := '&localidad';
    INSERT INTO DEPT VALUES (V_NUMERO, V_NOMBRE, V_LOCALIDAD);
END;

UNDEFINE numero;
UNDEFINE nombre;
UNDEFINE localidad;

DELETE FROM DEPT WHERE DNOMBRE='CASTELLANA';

-- PRÁCTICA PL/SQL
-- 1) Crear un bloque anónimo que sume dos números introducidos por teclado y muestre el resultado por pantalla.

DECLARE
    N1 INT;
    N2 INT;
BEGIN
    N1 := '&N1';
    N2 := '&N2';
    dbms_output.put_line('LA SUMA DE' || N1 || ' + ' || N2 || ' = ' || (N1+N2) );
END;

UNDEFINE N1;
UNDEFINE N2;

-- 2)     2. Insertar en la tabla EMP un empleado con código 9999 asignado directamente en la variable con %TYPE, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.

SELECT * FROM EMP;

DECLARE
    V_EMP_NO EMP.EMP_NO%TYPE;
    V_APELLIDO EMP.APELLIDO%TYPE;
    V_OFICIO EMP.OFICIO%TYPE;
    V_DEPT_NO EMP.DEPT_NO%TYPE;
BEGIN
    V_EMP_NO := 9999;
    V_APELLIDO := 'PEREZ';
    V_OFICIO := 'ANALISTA';
    V_DEPT_NO := 10;
    INSERT INTO EMP (EMP_NO, APELLIDO, OFICIO, DEPT_NO)
    VALUES (V_EMP_NO, V_APELLIDO, V_OFICIO, V_DEPT_NO);
END;

-- 3) Incrementar el salario en la tabla EMP en 200 EUROS a todos los trabajadores que sean ‘ANALISTA’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada con %TYPE.

SELECT * FROM EMP;

DECLARE
    V_OFICIO EMP.OFICIO%TYPE;
    V_SALARIO EMP.SALARIO%TYPE;
BEGIN
    V_OFICIO := 'ANALISTA';
    V_SALARIO := 200;

    UPDATE EMP SET SALARIO = (SALARIO + V_SALARIO) WHERE OFICIO= V_OFICIO; 
END;

--4) Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.

DECLARE
    N1 INT;
BEGIN
    N1:= '&1';
    dbms_output.put_line('EL NÚMERO DE CIFRAS ES: '|| LENGTH(N1) );
END;

UNDEFINE N1;

--5) Crear un bloque PL para insertar una fila en la tabla DEPT. Todos los datos necesarios serán pedidos desde teclado

DECLARE
    V_NUMERO DEPT.DEPT_NO%TYPE;
    V_NOMBRE DEPT.DNOMBRE%TYPE;
    V_LOCALIDAD DEPT.LOC%TYPE;
BEGIN
    V_NUMERO := '&numero';
    V_NOMBRE := '&nombre';
    V_LOCALIDAD := '&localidad';
    INSERT INTO DEPT VALUES (V_NUMERO, V_NOMBRE, V_LOCALIDAD);
END;

UNDEFINE numero;
UNDEFINE nombre;
UNDEFINE localidad;

--6) Crear un bloque PL que actualice el salario de los empleados que no cobran comisión en un 5%.

SELECT * FROM EMP;

DECLARE
    V_AUMENTO INT;
BEGIN
    V_AUMENTO := 0.05;
    
    UPDATE EMP SET SALARIO= (SALARIO + (SALARIO*V_AUMENTO) +1 ) WHERE COMISION = 0;

END;

--7) Crear un bloque PL que almacene la fecha del sistema en una variable. Solicitar un número de meses por teclado y mostrar la fecha del sistema incrementado en ese número de meses.

DECLARE
    
    V_MES INT;
    V_DATE DATE;

BEGIN
    v_MES := '&MES';
    V_DATE:= V_MES + SYSDATE;
    dbms_output.put_line('EL AUMENTO ES DE: ' || V_MES || ' MESES, LA NUEVA FECHA ES: ' || V_DATE);
    
END;


-- 8) Introducir dos números por teclado y devolver el resto de la división de los dos números.

DECLARE

    N1 INT;
    N2 INT;

BEGIN
    N1:= '&NUM_1';
    N2:= '&NUM_2';

    dbms_output.put_line('EL RESTO DE LA DIVISION ENTRE '|| N1 || ' Y '|| N2|| ' ES: ' || MOD(N1,N2));

END;


--9) Solicitar un nombre por teclado y devolver ese nombre con la primera inicial en mayúscula.

DECLARE
    V_NOMBRE1 VARCHAR2(50);

BEGIN
    V_NOMBRE1 := '&NOMBRE';
    dbms_output.put_line(INITCAP(V_NOMBRE1));

END;

UNDEFINE NOMBRE;

--10) Crear un bloque anónimo que permita borrar un registro de la tabla emp introduciendo por parámetro un número de empleado

DECLARE
    V_EMP_NO EMP.EMP_NO%TYPE;
BEGIN
    V_EMP_NO := '&EMPLEADO_NUMERO';
    DELETE FROM EMP WHERE EMP_NO = V_EMP_NO;

END;

/*

LÓGICA DE PROGRAMAR

