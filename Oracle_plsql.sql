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

AHORA SE AGREGA UNA ESTRUCTURA DE PREGUNTAS, SE PLANTEAN LOS CONDICIONALES EN CASO DE QUE OCURRA CUALQUIER COSA/ CONDICIONALES IF
NOS PERMITE CONROLAR DEPENDIENDO DE LO QUE HACEMOS/ LA CONSULTA ESTÁ AHÍ PERO SOLO OCURRE CUANDO YO LA HAGO
EL PROGRAMA ES DINÀMICO Y NO SOLO LÌNEAL
CADA CONDICIÓN ES EXCLUYENTE DE LA SIGUIENTE

IF --- CONSULTA --- THEN CÓDIGO

*/


-- EJEMPLO COMPROBAR SI UN NÚMERO ES POSITIVO O NEGATIVO
-- EL ELSE DEPENDE DE LA PREGUNTA/// TENER PRESENTE IF - ELSIF - ELSE - END IF


DECLARE
    V_NUMERO INT;
BEGIN
    V_NUMERO := &NUMERO;
    IF (V_NUMERO > 0) THEN
        DBMS_OUTPUT.PUT_LINE('POSITIVO: '|| V_NUMERO);
    ELSIF (V_NUMERO < 0) THEN
        DBMS_OUTPUT.PUT_LINE('NEGATIVO: '|| V_NUMERO);
    ELSE
        DBMS_OUTPUT.PUT_LINE('NI POSITIVO, NI NEGATIVO, ES:'|| V_NUMERO);
    END IF;
        --DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');
END;

-- EJEMPLO CON ESTANCIONES

UNDEFINE NUMERO;

DECLARE
    V_NUMERO INT;

BEGIN
    V_NUMERO := &NUMERO;
    IF (V_NUMERO = 1) THEN
    DBMS_OUTPUT.PUT_LINE ('PRIMAVERA: '|| V_NUMERO);

    ELSIF (V_NUMERO = 2) THEN
    DBMS_OUTPUT.PUT_LINE('VERANO: '|| V_NUMERO);

    ELSIF (V_NUMERO = 3)THEN
    DBMS_OUTPUT.PUT_LINE('OTOÑO: '|| V_NUMERO);

    ELSIF (V_NUMERO = 4) THEN
    DBMS_OUTPUT.PUT_LINE('INVIERNO: '|| V_NUMERO);

    ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR, ESTÁ MAL: '|| V_NUMERO);

    END IF;
    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');
END;

DECLARE
    N1 INT;
    N2 INT;

BEGIN
    N1 := &NUM_1;
    N2 := &NUM_2;
    
    IF (N1 > N2) THEN
        DBMS_OUTPUT.PUT_LINE ('EL NÚMERO MAYOR ES: '|| N1);

    ELSIF (N2 > N1) THEN
        DBMS_OUTPUT.PUT_LINE ('EL NÚMERO MAYOR ES: '|| N2);

    ELSE
        DBMS_OUTPUT.PUT_LINE (N1 || ' Y ' || N2 || ' SON IGUALES');

    END IF;
    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');

END;

UNDEFINE NUM_1;
UNDEFINE NUM_2;


--  pedir un número al usuario e indicar si es par

SELECT MOD(9,2) AS RESTO FROM DUAL;

DECLARE
    N1 INT;
    
BEGIN
    N1 := &NUM_1;
    IF (MOD(N1,2)= 0 ) THEN
        DBMS_OUTPUT.PUT_LINE ('EL NÚMERO ' || ' ES PAR');

    ELSIF (MOD(N1,2) > 0) THEN
        DBMS_OUTPUT.PUT_LINE ('EL NÚMERO ' || ' ES IMPAR');

    ELSE
        DBMS_OUTPUT.PUT_LINE ('HAY UN ERROR');

    END IF;
    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');

END;

UNDEFINE NUM_1;


-- LA FUNCIÓN SE PUEDE PROBAR DESDE EL DUAL// ES IMPORTANTE SIMPLIFICAR LOS TEMAS 

-- SE PUEDE UTILIZAR CUALQUIER OPERADOR TANTO DE COMPARACIÓN (>, =, <) COMO RELACIONAL (AND, OR) EN LOS CÓDIGOS

-- Si la letra es vocal 


DECLARE
    V_LETRA VARCHAR(1);

BEGIN
    V_LETRA := LOWER('&LETRA');
    IF (V_LETRA IN ('a','e','i','o','u')) THEN
        DBMS_OUTPUT.PUT_LINE('ES UNA VOCAL '|| V_LETRA);
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('ES UNA CONSONANTE' || V_LETRA);

    END IF;
    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');
END;

-- ES EL MISMO JERCICIO CON DOS OPERADORES


DECLARE
    V_LETRA VARCHAR(1);

BEGIN
    V_LETRA := LOWER('&LETRA');
    IF (V_LETRA = 'a' OR V_LETRA = 'e' OR V_LETRA = 'i' OR
    V_LETRA = 'o' OR V_LETRA = 'u') THEN
        DBMS_OUTPUT.PUT_LINE('ES UNA VOCAL '|| V_LETRA);
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('ES UNA CONSONANTE ' || V_LETRA);

    END IF;
    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');

END;


UNDEFINE NUM_1;
UNDEFINE NUM_2;
UNDEFINE NUM_3;


-- PEDIR TRES NÚMEROS AL USUARIO
-- SE DEBE MOTRAR EL MAYOR DE ELLOS


DECLARE

    N1 INT;
    N2 INT;
    N3 INT;
    
BEGIN
    N1 := &NUM_1;
    N2 := &NUM_2;
    N3 := &NUM_3;

    -- PREGUNTA 1 (ES MAYOR)

    IF (N1 > N2 AND N1 > N3) THEN
        DBMS_OUTPUT.PUT_LINE( N1 || ' ES MAYOR');   

    ELSIF (N2 > N1 AND N2 > N3) THEN
        DBMS_OUTPUT.PUT_LINE( N2 || ' ES MAYOR');    

    ELSE
        DBMS_OUTPUT.PUT_LINE( N3 || ' ES MAYOR');  

    END IF;

    -- PREGUNTA 2 (ES MENOR)

    IF (N1 < N2 AND N1 < N3) THEN
        DBMS_OUTPUT.PUT_LINE( N1 || ' ES MENOR');   

    ELSIF (N2 < N1 AND N2 < N3) THEN
        DBMS_OUTPUT.PUT_LINE( N2 || ' ES MENOR');    

    ELSE
        DBMS_OUTPUT.PUT_LINE( N3 || ' ES MENOR');  

    END IF;

    -- PREGUNTA 3 (ES INTERMEDIO)

    IF ((N1 < N2 AND N1 > N3) OR (N1 > N2 AND N1 < N3) ) THEN
        DBMS_OUTPUT.PUT_LINE( N1 || ' ES INTERMEDIO');   

    ELSIF ((N2 < N1 AND N2 > N3) OR (N2 > N1 AND N2 < N3) ) THEN
        DBMS_OUTPUT.PUT_LINE( N2 || ' ES INTERMEDIO');

    ELSIF ((N3 < N1 AND N3 > N2) OR (N3 > N1 AND N3 < N2) ) THEN
        DBMS_OUTPUT.PUT_LINE( N3 || ' ES INTERMEDIO'); 

    ELSE 
        DBMS_OUTPUT.PUT_LINE( 'HAY ERROR');  

    END IF;
    
    -- SE ACABA EL PROGRAMA

    DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');

END;



SELECT MAX(2,3,5) FROM DUAL;




----- prueba de ejercicio días del año

DECLARE
    V_FECHA DATE;
    V_MES INT;
    V_DIA INT;
    V_ANO INT;
    V_FECHA_FINAL DATE;
    op_1 int;
    op_2 int;
    op_3 int;
    op_4 int;
    op_5 int;
    op_6 int;
    op_7 int;
    texto_dia varchar2(50);
    

    BEGIN

    V_FECHA := TO_DATE('22/06/1983', 'DD/MM/YYYY');
    V_DIA := TO_NUMBER(TO_CHAR(V_FECHA, 'DD'));
    V_MES := TO_NUMBER(TO_CHAR(V_FECHA, 'MM'));
    V_ANO := TO_NUMBER(TO_CHAR(V_FECHA, 'YY'));

    IF (V_MES = 13) THEN
        V_ANO := (V_ANO +1);
        V_MES := 1;

    ELSIF (V_MES = 14) THEN
        V_ANO := (V_ANO +1);
        V_MES := 2;
    END if;

    V_FECHA_FINAL := to_date ( v_ano || '-' || v_mes || '-' || v_dia,'YYYY-MM-DD' );
    op_1 := ((V_MES +1)*3)/5;
    op_2 := V_ANO/4;
    op_3 := V_ANO/100;
    op_4 := V_ANO/400;
    op_5 := V_DIA + (v_MES * 2) + V_ANO + op_1 + op_2 - op_3 + op_4 +2;
    op_6 := op_5/7;
    op_7 := (op_5 - (op_6 * 7))+1;

    if (op_7=0) THEN
        texto_dia := 'Sábado';
    elsif (op_7=1) THEN
        texto_dia := 'Domingo';
    elsif (op_7 = 2) THEN
        texto_dia := 'Lunes';
    elsif (op_7 =3) THEN
        texto_dia := 'Martes';
    elsif (op_7 = 4) THEN
        texto_dia := 'Miércoles';
    elsif (op_7 = 5) THEN
        texto_dia := 'Jueves';
    elsif (op_7 = 6) THEN
        texto_dia := 'viernes';

    end if;


    dbms_output.put_line('Inicio DE PROGRAMA ' || V_FECHA);
    dbms_output.put_line('FIN DE PROGRAMA ' || V_FECHA_FINAL);

    dbms_output.put_line('EL día es: ' || to_char(v_fecha_final, 'day'));
    dbms_output.put_line('Del mes: ' || to_char(v_fecha_final, 'month'));
    dbms_output.put_line('Del año: ' || to_char(v_fecha_final, 'year'));
    dbms_output.put_line('El día final es: ' || texto_dia);

END;


undefine fecha;

--- ejercicio 2 calcular salario

declare
N_horas int;
P_horas int;
Distancia int;
pago_total int;
h_extra int;
dieta int;

begin

N_horas :=  40;
P_horas := 10;
Distancia := 400;

pago_total := N_horas * P_horas;

if (N_horas > 36) then
    h_extra := N_horas - 36;
    dbms_output.put_line('Tiene horas extra');
    dbms_output.put_line('Total horas extra:' || h_extra);
else 
    h_extra := 0;
end if;

if (distancia < 100) then
    dieta := 0;
elsif (distancia > 100 and distancia < 250) then
    dieta := 200;
elsif (distancia > 251 and distancia < 500) then
    dieta := 400;
elsif (distancia > 501) then
    dieta := 0;
end if;

pago_total := pago_total + (h_extra * 2) + dieta;

dbms_output.put_line('Dietas provinciales: €' || dieta);
DBMS_OUTPUT.PUT_LINE('El pago total es de: €' || pago_total);


end; 

-- Prueba 3

declare

dni int;
resultado int;
letra varchar2(1);

begin
    dni := 12345678;

    resultado:=  (round(dni/23)*23) - dni;

    if (resultado = 0) THEN
        letra := 'T';
    elsif (resultado = 1) THEN
        letra := 'R';
    elsif (resultado = 2) THEN
        letra := 'W';
    elsif (resultado = 3) THEN
        letra := 'A';
    elsif (resultado = 4) THEN
        letra := 'G';
    elsif (resultado = 5) THEN
        letra := 'M';
    elsif (resultado = 6) THEN
        letra := 'Y';
    elsif (resultado = 7) THEN
        letra := 'F';        
    elsif (resultado = 8) THEN
        letra := 'P';
    elsif (resultado = 9) THEN
        letra := 'D';
    elsif (resultado = 10) THEN
        letra := 'X';
    elsif (resultado = 11) THEN
        letra := 'B';
    elsif (resultado = 12) THEN
        letra := 'N';
    elsif (resultado = 13) THEN
        letra := 'J';
    elsif (resultado = 14) THEN
        letra := 'Z';
    elsif (resultado = 15) THEN
        letra := 'S';
    elsif (resultado = 16) THEN
        letra := 'Q';
    elsif (resultado = 17) THEN
        letra := 'V';
    elsif (resultado = 18) THEN
        letra := 'H';
    elsif (resultado = 19) THEN
        letra := 'L';
    elsif (resultado = 20) THEN
        letra := 'C';
    elsif (resultado = 21) THEN
        letra := 'K';
    elsif (resultado = 22) THEN
        letra := 'E';
    elsif (resultado = 23) THEN
        letra := 'T';
    end if;

    dbms_output.put_line('la letra del dni ' || dni || ' es: ' || letra);

end;