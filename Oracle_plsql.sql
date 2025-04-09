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