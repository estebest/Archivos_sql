   SET SERVEROUTPUT ON;

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

declare
   numero int;
begin
    -- LA VARIABLE ES NULL
   numero := 19;
end;

-- SE IMPRIME POR PANTALLA
declare
    -- DECLARAMO UNA VARIABLE
   numero int;
   texto  varchar2(40);
begin
   texto := 'MI PRIMER PL/SQL';
   dbms_output.put_line('TEXTO: ' || texto);
   dbms_output.put_line('MI PRIMER BLOQUE ANÓNIMO 1');
   numero := 47;
   dbms_output.put_line('VALOR NÚMERO: ' || numero);
   numero := 22;
   dbms_output.put_line('VALOR NÚMERO: ' || numero);
   numero := numero * 22;
   dbms_output.put_line('VALOR NÚMERO 3: ' || numero);
end;

--POR EJEMPLO SI SE QUIERE PEDIR UNO PARA EL USUARIO// UTILIZAR VARIABLE DE SUSTITUCIÓN PARA EL USUARIO

declare
   nombre varchar2(30);
begin
   nombre := '&DATO';
   dbms_output.put_line('SU NOMBRE ES ' || nombre);
end;

-- SE PUEDE UTILIZAR CUALQUIER CARACTERÍSTICA


declare
   fecha    date;
   texto    varchar2(50);
   longitud int;
begin
   fecha := sysdate;
   texto := '&NOMBRE';
   longitud := length(texto);
   dbms_output.put_line('HOY ES: ' || fecha);
   dbms_output.put_line('LA LONGITUD DE SU TEXTO ES: ' || longitud);
   dbms_output.put_line('LA LONGITUD DE SU TEXTO ES: ' || length(texto));
end;


-- PROGRAMA PARA PEDIR NÚMEROS AL USUARIO

declare
   n1 int;
   n2 int;
begin
   n1 := '&N1';
   n2 := '&N2';
   dbms_output.put_line('LA SUMA DE'
                        || n1
                        || ' + '
                        || n2
                        || ' = '
                        ||(n1 + n2));
end;

UNDEFINE N1;
UNDEFINE N2;

-- DENTRO DE ESTOS BLOQUES NO SE PUEDEN PONER UN SELECT, AUNQUE SÌ INSSERT UPDATE AND DELETE
-- LAS VARIABLES NO SE PUEDEN LLAMAR IGUAL QUE LOS NOMBRES

select *
  from emp;

declare
   v_departamento int;
begin
   v_departamento := &dept;
   update emp
      set
      salario = salario + 1
    where dept_no = v_departamento;
end;


UNDEFINE DEPT;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

select *
  from dept;

declare
   v_numero    dept.dept_no%type;
   v_nombre    dept.dnombre%type;
   v_localidad dept.loc%type;
begin
   v_numero := '&numero';
   v_nombre := '&nombre';
   v_localidad := '&localidad';
   insert into dept values ( v_numero,
                             v_nombre,
                             v_localidad );
end;

UNDEFINE numero;
UNDEFINE nombre;
UNDEFINE localidad;

delete from dept
 where dnombre = 'CASTELLANA';

-- PRÁCTICA PL/SQL
-- 1) Crear un bloque anónimo que sume dos números introducidos por teclado y muestre el resultado por pantalla.

declare
   n1 int;
   n2 int;
begin
   n1 := '&N1';
   n2 := '&N2';
   dbms_output.put_line('LA SUMA DE'
                        || n1
                        || ' + '
                        || n2
                        || ' = '
                        ||(n1 + n2));
end;

UNDEFINE N1;
UNDEFINE N2;

-- 2)     2. Insertar en la tabla EMP un empleado con código 9999 asignado directamente en la variable con %TYPE, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.

select *
  from emp;

declare
   v_emp_no   emp.emp_no%type;
   v_apellido emp.apellido%type;
   v_oficio   emp.oficio%type;
   v_dept_no  emp.dept_no%type;
begin
   v_emp_no := 9999;
   v_apellido := 'PEREZ';
   v_oficio := 'ANALISTA';
   v_dept_no := 10;
   insert into emp (
      emp_no,
      apellido,
      oficio,
      dept_no
   ) values ( v_emp_no,
              v_apellido,
              v_oficio,
              v_dept_no );
end;

-- 3) Incrementar el salario en la tabla EMP en 200 EUROS a todos los trabajadores que sean ‘ANALISTA’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada con %TYPE.

select *
  from emp;

declare
   v_oficio  emp.oficio%type;
   v_salario emp.salario%type;
begin
   v_oficio := 'ANALISTA';
   v_salario := 200;
   update emp
      set
      salario = ( salario + v_salario )
    where oficio = v_oficio;
end;

--4) Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.

declare
   n1 int;
begin
   n1 := '&1';
   dbms_output.put_line('EL NÚMERO DE CIFRAS ES: ' || length(n1));
end;

UNDEFINE N1;

--5) Crear un bloque PL para insertar una fila en la tabla DEPT. Todos los datos necesarios serán pedidos desde teclado

declare
   v_numero    dept.dept_no%type;
   v_nombre    dept.dnombre%type;
   v_localidad dept.loc%type;
begin
   v_numero := '&numero';
   v_nombre := '&nombre';
   v_localidad := '&localidad';
   insert into dept values ( v_numero,
                             v_nombre,
                             v_localidad );
end;

UNDEFINE numero;
UNDEFINE nombre;
UNDEFINE localidad;

--6) Crear un bloque PL que actualice el salario de los empleados que no cobran comisión en un 5%.

select *
  from emp;

declare
   v_aumento int;
begin
   v_aumento := 0.05;
   update emp
      set
      salario = ( salario + ( salario * v_aumento ) + 1 )
    where comision = 0;

end;

--7) Crear un bloque PL que almacene la fecha del sistema en una variable. Solicitar un número de meses por teclado y mostrar la fecha del sistema incrementado en ese número de meses.

declare
   v_mes  int;
   v_date date;
begin
   v_mes := '&MES';
   v_date := v_mes + sysdate;
   dbms_output.put_line('EL AUMENTO ES DE: '
                        || v_mes
                        || ' MESES, LA NUEVA FECHA ES: '
                        || v_date);
end;


-- 8) Introducir dos números por teclado y devolver el resto de la división de los dos números.

declare
   n1 int;
   n2 int;
begin
   n1 := '&NUM_1';
   n2 := '&NUM_2';
   dbms_output.put_line('EL RESTO DE LA DIVISION ENTRE '
                        || n1
                        || ' Y '
                        || n2
                        || ' ES: '
                        || mod(
      n1,
      n2
   ));

end;


--9) Solicitar un nombre por teclado y devolver ese nombre con la primera inicial en mayúscula.

declare
   v_nombre1 varchar2(50);
begin
   v_nombre1 := '&NOMBRE';
   dbms_output.put_line(initcap(v_nombre1));
end;

UNDEFINE NOMBRE;

--10) Crear un bloque anónimo que permita borrar un registro de la tabla emp introduciendo por parámetro un número de empleado

declare
   v_emp_no emp.emp_no%type;
begin
   v_emp_no := '&EMPLEADO_NUMERO';
   delete from emp
    where emp_no = v_emp_no;

end;

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


declare
   v_numero int;
begin
   v_numero := &numero;
   if ( v_numero > 0 ) then
      dbms_output.put_line('POSITIVO: ' || v_numero);
   elsif ( v_numero < 0 ) then
      dbms_output.put_line('NEGATIVO: ' || v_numero);
   else
      dbms_output.put_line('NI POSITIVO, NI NEGATIVO, ES:' || v_numero);
   end if;
        --DBMS_OUTPUT.PUT_LINE('FIN DE PROGRAMA');
end;

-- EJEMPLO CON ESTANCIONES

UNDEFINE NUMERO;

declare
   v_numero int;
begin
   v_numero := &numero;
   if ( v_numero = 1 ) then
      dbms_output.put_line('PRIMAVERA: ' || v_numero);
   elsif ( v_numero = 2 ) then
      dbms_output.put_line('VERANO: ' || v_numero);
   elsif ( v_numero = 3 ) then
      dbms_output.put_line('OTOÑO: ' || v_numero);
   elsif ( v_numero = 4 ) then
      dbms_output.put_line('INVIERNO: ' || v_numero);
   else
      dbms_output.put_line('ERROR, ESTÁ MAL: ' || v_numero);
   end if;
   dbms_output.put_line('FIN DE PROGRAMA');
end;

declare
   n1 int;
   n2 int;
begin
   n1 := &num_1;
   n2 := &num_2;
   if ( n1 > n2 ) then
      dbms_output.put_line('EL NÚMERO MAYOR ES: ' || n1);
   elsif ( n2 > n1 ) then
      dbms_output.put_line('EL NÚMERO MAYOR ES: ' || n2);
   else
      dbms_output.put_line(n1
                           || ' Y '
                           || n2
                           || ' SON IGUALES');
   end if;
   dbms_output.put_line('FIN DE PROGRAMA');
end;

UNDEFINE NUM_1;
UNDEFINE NUM_2;


--  pedir un número al usuario e indicar si es par

select mod(
   9,
   2
) as resto
  from dual;

declare
   n1 int;
begin
   n1 := &num_1;
   if ( mod(
      n1,
      2
   ) = 0 ) then
      dbms_output.put_line('EL NÚMERO ' || ' ES PAR');
   elsif ( mod(
      n1,
      2
   ) > 0 ) then
      dbms_output.put_line('EL NÚMERO ' || ' ES IMPAR');
   else
      dbms_output.put_line('HAY UN ERROR');
   end if;
   dbms_output.put_line('FIN DE PROGRAMA');
end;

UNDEFINE NUM_1;


-- LA FUNCIÓN SE PUEDE PROBAR DESDE EL DUAL// ES IMPORTANTE SIMPLIFICAR LOS TEMAS 

-- SE PUEDE UTILIZAR CUALQUIER OPERADOR TANTO DE COMPARACIÓN (>, =, <) COMO RELACIONAL (AND, OR) EN LOS CÓDIGOS

-- Si la letra es vocal 


declare
   v_letra varchar(1);
begin
   v_letra := lower('&LETRA');
   if ( v_letra in ( 'a',
                     'e',
                     'i',
                     'o',
                     'u' ) ) then
      dbms_output.put_line('ES UNA VOCAL ' || v_letra);
   else
      dbms_output.put_line('ES UNA CONSONANTE' || v_letra);
   end if;
   dbms_output.put_line('FIN DE PROGRAMA');
end;

-- ES EL MISMO JERCICIO CON DOS OPERADORES


declare
   v_letra varchar(1);
begin
   v_letra := lower('&LETRA');
   if ( v_letra = 'a'
   or v_letra = 'e'
   or v_letra = 'i'
   or v_letra = 'o'
   or v_letra = 'u' ) then
      dbms_output.put_line('ES UNA VOCAL ' || v_letra);
   else
      dbms_output.put_line('ES UNA CONSONANTE ' || v_letra);
   end if;
   dbms_output.put_line('FIN DE PROGRAMA');
end;


UNDEFINE NUM_1;
UNDEFINE NUM_2;
UNDEFINE NUM_3;


-- PEDIR TRES NÚMEROS AL USUARIO
-- SE DEBE MOTRAR EL MAYOR DE ELLOS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

declare
   n1 int;
   n2 int;
   n3 int;
begin
   n1 := &num_1;
   n2 := &num_2;
   n3 := &num_3;

    -- PREGUNTA 1 (ES MAYOR)

   if (
      n1 > n2
      and n1 > n3
   ) then
      dbms_output.put_line(n1 || ' ES MAYOR');
   elsif (
      n2 > n1
      and n2 > n3
   ) then
      dbms_output.put_line(n2 || ' ES MAYOR');
   else
      dbms_output.put_line(n3 || ' ES MAYOR');
   end if;

    -- PREGUNTA 2 (ES MENOR)

   if (
      n1 < n2
      and n1 < n3
   ) then
      dbms_output.put_line(n1 || ' ES MENOR');
   elsif (
      n2 < n1
      and n2 < n3
   ) then
      dbms_output.put_line(n2 || ' ES MENOR');
   else
      dbms_output.put_line(n3 || ' ES MENOR');
   end if;

    -- PREGUNTA 3 (ES INTERMEDIO)

   if ( (
      n1 < n2
      and n1 > n3
   )
   or (
      n1 > n2
      and n1 < n3
   ) ) then
      dbms_output.put_line(n1 || ' ES INTERMEDIO');
   elsif ( (
      n2 < n1
      and n2 > n3
   )
   or (
      n2 > n1
      and n2 < n3
   ) ) then
      dbms_output.put_line(n2 || ' ES INTERMEDIO');
   elsif ( (
      n3 < n1
      and n3 > n2
   )
   or (
      n3 > n1
      and n3 < n2
   ) ) then
      dbms_output.put_line(n3 || ' ES INTERMEDIO');
   else
      dbms_output.put_line('HAY ERROR');
   end if;
    
    -- SE ACABA EL PROGRAMA

   dbms_output.put_line('FIN DE PROGRAMA');
end;



select max(2,
           3,
           5)
  from dual;




----- prueba de ejercicio días del año

declare
   v_fecha       date;
   v_mes         int;
   v_dia         int;
   v_ano         int;
   v_fecha_final date;
   op_1          int;
   op_2          int;
   op_3          int;
   op_4          int;
   op_5          int;
   op_6          int;
   op_7          int;
   texto_dia     varchar2(50);
begin
   v_fecha := to_date ( '22/06/1983','DD/MM/YYYY' );
   v_dia := to_number ( to_char(
      v_fecha,
      'DD'
   ) );
   v_mes := to_number ( to_char(
      v_fecha,
      'MM'
   ) );
   v_ano := to_number ( to_char(
      v_fecha,
      'YY'
   ) );
   if ( v_mes = 13 ) then
      v_ano := ( v_ano + 1 );
      v_mes := 1;
   elsif ( v_mes = 14 ) then
      v_ano := ( v_ano + 1 );
      v_mes := 2;
   end if;

   v_fecha_final := to_date ( v_ano
                              || '-'
                              || v_mes
                              || '-'
                              || v_dia,'YYYY-MM-DD' );
   op_1 := ( ( v_mes + 1 ) * 3 ) / 5;
   op_2 := v_ano / 4;
   op_3 := v_ano / 100;
   op_4 := v_ano / 400;
   op_5 := v_dia + ( v_mes * 2 ) + v_ano + op_1 + op_2 - op_3 + op_4 + 2;
   op_6 := op_5 / 7;
   op_7 := ( op_5 - ( op_6 * 7 ) ) + 1;
   if ( op_7 = 0 ) then
      texto_dia := 'Sábado';
   elsif ( op_7 = 1 ) then
      texto_dia := 'Domingo';
   elsif ( op_7 = 2 ) then
      texto_dia := 'Lunes';
   elsif ( op_7 = 3 ) then
      texto_dia := 'Martes';
   elsif ( op_7 = 4 ) then
      texto_dia := 'Miércoles';
   elsif ( op_7 = 5 ) then
      texto_dia := 'Jueves';
   elsif ( op_7 = 6 ) then
      texto_dia := 'viernes';
   end if;


   dbms_output.put_line('Inicio DE PROGRAMA ' || v_fecha);
   dbms_output.put_line('FIN DE PROGRAMA ' || v_fecha_final);
   dbms_output.put_line('EL día es: ' || to_char(
      v_fecha_final,
      'day'
   ));
   dbms_output.put_line('Del mes: ' || to_char(
      v_fecha_final,
      'month'
   ));
   dbms_output.put_line('Del año: ' || to_char(
      v_fecha_final,
      'year'
   ));
   dbms_output.put_line('El día final es: ' || texto_dia);
end;


undefine fecha;

--- ejercicio 2 calcular salario

declare
   n_horas    int;
   p_horas    int;
   distancia  int;
   pago_total int;
   h_extra    int;
   dieta      int;
begin
   n_horas := 40;
   p_horas := 10;
   distancia := 400;
   pago_total := n_horas * p_horas;
   if ( n_horas > 36 ) then
      h_extra := n_horas - 36;
      dbms_output.put_line('Tiene horas extra');
      dbms_output.put_line('Total horas extra:' || h_extra);
   else
      h_extra := 0;
   end if;

   if ( distancia < 100 ) then
      dieta := 0;
   elsif (
      distancia > 100
      and distancia < 250
   ) then
      dieta := 200;
   elsif (
      distancia > 251
      and distancia < 500
   ) then
      dieta := 400;
   elsif ( distancia > 501 ) then
      dieta := 0;
   end if;

   pago_total := pago_total + ( h_extra * 2 ) + dieta;
   dbms_output.put_line('Dietas provinciales: €' || dieta);
   dbms_output.put_line('El pago total es de: €' || pago_total);
end; 

-- Prueba 3

declare
   dni       int;
   resultado int;
   letra     varchar2(1);
begin
   dni := 12345678;
   resultado := ( round(dni / 23) * 23 ) - dni;
   if ( resultado = 0 ) then
      letra := 'T';
   elsif ( resultado = 1 ) then
      letra := 'R';
   elsif ( resultado = 2 ) then
      letra := 'W';
   elsif ( resultado = 3 ) then
      letra := 'A';
   elsif ( resultado = 4 ) then
      letra := 'G';
   elsif ( resultado = 5 ) then
      letra := 'M';
   elsif ( resultado = 6 ) then
      letra := 'Y';
   elsif ( resultado = 7 ) then
      letra := 'F';
   elsif ( resultado = 8 ) then
      letra := 'P';
   elsif ( resultado = 9 ) then
      letra := 'D';
   elsif ( resultado = 10 ) then
      letra := 'X';
   elsif ( resultado = 11 ) then
      letra := 'B';
   elsif ( resultado = 12 ) then
      letra := 'N';
   elsif ( resultado = 13 ) then
      letra := 'J';
   elsif ( resultado = 14 ) then
      letra := 'Z';
   elsif ( resultado = 15 ) then
      letra := 'S';
   elsif ( resultado = 16 ) then
      letra := 'Q';
   elsif ( resultado = 17 ) then
      letra := 'V';
   elsif ( resultado = 18 ) then
      letra := 'H';
   elsif ( resultado = 19 ) then
      letra := 'L';
   elsif ( resultado = 20 ) then
      letra := 'C';
   elsif ( resultado = 21 ) then
      letra := 'K';
   elsif ( resultado = 22 ) then
      letra := 'E';
   elsif ( resultado = 23 ) then
      letra := 'T';
   end if;

   dbms_output.put_line('la letra del dni '
                        || dni
                        || ' es: '
                        || letra);
end;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*

21 de abril de 2025

LOOPS

LAS VARIABLES CONTADOR SUELEN LLAMARSE CON UNA SOLA LETRA

BÚCLES CONDICIONALES (SON PELIGROSOS PORQUE PUDEN SER INFINITOS): 
SIMPLE: ENTRA AL BÚCLE PERO TOCA CONIGURAR SI LA CONDICIÓN SE CUMPLE. EVALÚA EL CIERRE AL FINAL
WHILE: EVALUA LA CONDICIÓN PARA ENTRAR AL BÚCLE, SI NO PUES NO LO HACE/ SE PUEDE USAR LA OPCIÓN EXIT

BÚCLES FOR (SON NÚMERICOS DONDE INDICO DONDE EMPIEA Y DONDE CIERRA, NO ES NECESARIO DECLARAR LA VARIABLE)

*/

-- BÚCLE SIMPLE (LOOP .. END LOOP)
-- SUMA DE LOS PRIMEROS 100 NÚMEROS
-- EN DECLARE SE DEBE INICIAR I, SINO SERÁ NULL

declare
   i    int;
   suma int;
begin
   i := 1;
   suma := 0;
   loop
      suma := suma + i;
      i := i + 1;
      exit when i = 101;
   end loop;

   dbms_output.put_line('a suma dee los primeros 100 números es: ' || suma);
end;

-- SINTAXÍS USANDO EL WHILE
-- LA CONDICIÓN SE EVALÚA ANTES DE ENTRAR

declare
   i    int := 1;
   suma int := 0;
begin
   while i <= 100 loop
      suma := suma + i;
      i := 1 + i;
   end loop;

   dbms_output.put_line('a suma dee los primeros 100 números es: ' || suma);
end;

-- CONDICIONAL FOOR LOOP
-- SUELE SER EL MÁS UTILIZADO
-- SABEMOS EL INICIO Y EL FINAL

declare
   suma int;
begin
   suma := 0;
   for i in 1..100 loop
      suma := suma + i;
      dbms_output.put_line('a suma dee los primeros 100 números es: ' || suma);
   end loop;

   dbms_output.put_line('a suma dee los primeros 100 números es: ' || suma);
end;

-- ETIQUETA GO TO
-- SE SALTA BLOQUES DEL CÓDIGO Y SE MENCIONA DONDE DEBERÍA REAPARCER
-- NO SE PUEDE CREAR ETIQUETAS CON EL MISMO NOMBRE
-- LA ETIQUETA DEBE ESTAR SIEMPRE PARA ABAJO, OEA EN EL BEGIN
-- NO PUEDE ESTAR ANTES DEL IF O EN MITAD DEL LOOP

declare
   suma int;
begin
   suma := 0;
   dbms_output.put_line('INICIO');
   goto codigo;
   dbms_output.put_line('ANTES DEL BÚCLE');
   for i in 1..100 loop
      suma := suma + i;
   end loop;
   << codigo >> dbms_output.put_line('DESUPUÉS DEL BÚCLE');
   dbms_output.put_line('a suma dee los primeros 100 números es: ' || suma);
end;

-- EJEMPLOSS

-- UN BÚCLE PARA MOSTRAR LOS NÚMERO ENTRE 1 Y 10 
-- CON UN BÚCLE WHILE Y FOR

declare
   i int := 0;
begin
   while i < 11 loop
      i := i + 1;
      dbms_output.put_line('EL NÚMERO ES:' || i);
   end loop;
   dbms_output.put_line('FINAL DE PROCESO');
end;

-- EJERCICIO LOOP FOR

declare begin
   for i in 1..10 loop
      dbms_output.put_line('EL NÚMERO ES:' || i);
   end loop;
end;

-- PEDIR AL USUARIO UN NÙMERO INICIAL Y OTRO FINAL
-- MOSTRAR LOS NÚMEROS QUE HAY ENTRE EL RANGO 
-- SE LE PUEDE AGREGAR UN IF PARA MEJORAR LA CALIDAD

declare
   n_inicial int;
   n_final   int;
begin
   n_inicial := 1;
   n_final := 10;
   if ( n_inicial >= n_final ) then
      dbms_output.put_line('EL NÚMERO INICIAL DEBE SER MAYOR AL FINAL');
   else
      for i in n_inicial..n_final loop
         dbms_output.put_line('EL NÚMERO ES:' || i);
      end loop;
   end if;

end;

UNDEFINE NUM1;
UNDEFINE NUM2;

-- COMBINACIÓN
-- UN BÚCLE CON UN INICIO Y UN FIN. MOSTRAR LOS PARES QUE HAY ENTRE EL INICIO Y EL FIN


declare
   n_inicial int;
   n_final   int;
   resultado int := 0;
begin
   n_inicial := &num1;
   n_final := &num2;
   for i in n_inicial..n_final loop
      resultado := mod(
         i,
         2
      );
      if ( resultado = 0 ) then
         dbms_output.put_line('ES PAR EL NÚMERO: ' || i);
      end if;

   end loop;

   dbms_output.put_line('FINAL DEL PROGRAMA');
end;

-- CUALQUIER NÚMERO SIEMPRE LLEGARÀ A SER 1 SIGUIENDO UNA SERIE DE INSTRUCCIONES
-- SI EL NÚMERO ES PAR SE DIVIDE ENTRE 2
-- SI ES IMPAR SE MÙLTIPLICA POR 3 Y SE SUMA 1


declare
   inicio int := &v_inicio;
   i      int := 0;
begin
   loop
      if ( mod(
         inicio,
         2
      ) = 0 ) then
         inicio := inicio / 2;
         dbms_output.put_line(inicio);
         i := i + 1;
      else
         inicio := ( inicio * 3 ) + 1;
         dbms_output.put_line(inicio);
         i := i + 1;
      end if;

      exit when inicio = 1;
   end loop;

   dbms_output.put_line('EL PROCESO TERMINÓ EN: '
                        || i
                        || ' ITERACCIONES');
end;

UNDEFINE V_INICIO;

-- Mostrar la tabla de multiplicar de un número que pidamos al usuario


declare
   n_usuario int := &v_usuario;
   resultado int;
begin
   for i in 1..10 loop
      resultado := n_usuario * i;
      dbms_output.put_line(n_usuario
                           || ' * '
                           || i
                           || ' = '
                           || resultado);


   end loop;

   dbms_output.put_line('fIN DE PROGRAMA');
end;

UNDEFINE V_USUARIO;

-- DISEÑAR UN PROGRAMA QUE PEDIRÁ UN TEXTO
-- SE DEBE RECORRER EL TEXTO LETRA A LETRA, MOSTRANDO CADA LETRA DE FORMA INDIVIDUAL

declare
   v_texto  varchar2(50) := '&V_TEXTO';
   v_lenght int;
   v_letra  varchar2(2);
begin
   v_lenght := length(v_texto);
   for i in 1..v_lenght loop
      v_letra := substr(
         v_texto,
         i,
         1
      );
      dbms_output.put_line(v_letra);
   end loop;
   dbms_output.put_line('FIN DE PROGRAMA, TOTAL LETRAS: ' || v_lenght);
end;

-- PROGRAMA DONDE EL USUARIO COLOQUE UN TEXTO NUMÉRICO
-- MOSTRAR LA SUMA DE TODOS LOS CARACTERÉS NUMÉRICOS EN UN MENAJE


declare
   v_texto      varchar2(50) := '&1234';
   v_numero     int;
   v_lenght     int;
   n1           int;
   v_numero_fin int;
begin
   v_numero_fin := to_number ( v_texto );
   v_lenght := length(v_texto) + 1;
   v_numero := 0;
   for i in 1..v_lenght loop
      n1 := to_number ( substr(
         v_texto,
         i,
         1
      ) );
      v_numero := v_numero + n1;
      dbms_output.put_line(v_numero);
   end loop;

   dbms_output.put_line('FIN DE PROGRAMA, TOTAL LETRAS: ' || v_numero);
end;

UNDEFIN TEXTO_USUARIO;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*

  22 de abril de 2025

  Cursores

permite almacenar en variables consultas que tena (guardar un elect en variables)
en pl/sql no se puede usar un select a menos que lo guarde directamente en una variable

EL SELECT SOLO FUNCIONA SI ES UNA SUBCONSULA

SE TIENEN DOS TIPOS DE CURSOS:

IMPLÌCITO: SOLO SE PUEDE DEVOLVER UNA ÚNICA FILA Y NO TENGO QUE DECLARARLO
EXPLÌCITO: TENGO QUE DECLARAR EL CURSO Y EL VALOR IS

*/

-- INSERTAR 5 DEPARTAMENTOS EN UN BLOQUE PL/SQL DINÁMICO A TRAVÉS DE UN BÚCLE
declare
   v_nombre dept.dnombre%type;
   v_loc    dept.loc%type;
begin
   for i in 1..5 loop
      v_nombre := 'DEPARTAMENTO_' || i;
      v_loc := 'LOCALIDAD_' || i;
      insert into dept values ( (
         select max(dept_no) + 1
           from dept
      ),
                                v_nombre,
                                v_loc );

   end loop;

   dbms_output.put_line('FIN DEL PROGRAMA');
end;

select *
  from dept;

rollback;

-- REALIAR UN BLOQUE QUE PEDIRÁ UN NÚMERO Y MOSTRARÁ EL DEPARTAMENTO CON DICHO NÚMERO
-- YA QUE SALE SUSTITUCIÓN CANCELADA, LO PONGO COMO 10

declare
   v_id int := 10;
begin
   select *
     from dept
    where dept_no = v_id;

end;

-- EJEMPLO DE CURSOR IMPLÌCITO, DONDE VOY A RECUPERAR EL OFICIO DEL APELLIDO REY

declare
   v_oficio emp.oficio%type;
begin
   select oficio
     into v_oficio
     from emp
    where upper(apellido) = 'REY';
   dbms_output.put_line('EL APELLIDO DE REY ES ' || v_oficio);
end;

-- EJEMPLO DE CURSOR EXPLÌCITO
-- PUEDE DEVOLVER MÀS DE UNA FILA Y ES NECESARIO DECALRARLOS A TRAVÉS DE LA PALABRA CURSOR

declare
   v_ape emp.apellido%type;
   v_sal emp.salario%type;
    -- DECLARAMOS CURSOR CON UNA CONSULTA
    -- LA CONSULTA DEBE TENER LOS MISMOS DATOS PARA HACE EL FET (TANTOS EN EL SELECT COMO CON LA DECLARACIÓN)
   cursor cursoremp is
   select apellido,
          salario
     from emp;

begin
    -- SE ABRE EL CURSOS
   open cursoremp;
   loop
        -- EXTREMOS LOS DATOS DEL CUROSRA TRAVÉS DE FTCH
      fetch cursoremp into
         v_ape,
         v_sal;
      dbms_output.put_line('APELLIDO: '
                           || v_ape
                           || ',SALARIO: '
                           || v_sal);
      exit when cursoremp%notfound;
   end loop;
   close cursor;
end;

-- ATRIBUTOSS 
-- NOTFOUND: SE ACTIVA SI NO HA RECUPERADO NINGUNA FILA EL CURSOR
-- FOUND DONDE HA RECUPERADO ALGUNA FILA
-- ROWCOUNT: NÑUMERO D FILAQUE CONTIENE EL CURSOR
-- IS OPEN
-- ATRIBUTOS PARACONSULTA DE ACCIÓN

-- IMCREMENTAR EN 1 EL SALARIO DE LOS EMPLEADOS
begin
   update emp
      set
      salario = salario + 1
    where dept_no = 10;
   dbms_output.put_line('EMPLEADOS: ' || sql%rowcount);
end;


----

-- INCREMENTAR EN 10000 AL EMPLEADO QUE MENOS COBRE EN LA EMPRESA
-- 

select *
  from emp;


declare
   v_salario  emp.salario%type;
   v_apellido emp.apellido%type;
begin
   select min(salario)
     into v_salario
     from emp;
   select apellido
     into v_apellido
     from emp
    where salario = v_salario;
   update emp
      set
      salario = salario + 10000
    where salario = v_salario;
   dbms_output.put_line('SALARIO INCREMENTADO A '
                        || sql%rowcount
                        || ' EMPLEADOS');
   dbms_output.put_line('La persona a la que se le subió es ' || v_apellido);
end;


-- rEALIZAR UN CÓDIGO PL/SQL DONDE SE PEDIRÁ EL NÚMERO, NOMBRE Y LOCALIDAD DE UN DEPARTAMENTO
-- SI EL DEPARTAMENTO EXISTE, MODIFICAMOS SU NOMBRE Y LOCALIDAD
-- SI EL DEPARTAMENTO NO EXISTE, LO MODIFICAMOS 


select *
  from dept;


declare
    -- VARIABLES PARA AGREGAR
   v_dept_no dept.dept_no%type;
   v_dnombre dept.dnombre%type;
   v_loc     dept.loc%type;
   v_existe  dept.dept_no%type;
    
    -- APERTURA DEL CURSOR
   cursor cursordept is
   select dept_no
     from dept
    where dept_no = v_dept_no;

begin
    -- SE ABREN LOS DATOS DEL USUARIO
   v_dept_no := 10;
   v_dnombre := 'I+D';
   v_loc := 'GIJON';

    -- INICIA EL CURSOR /EL FETCH ES OPCIONAL/ 
   open cursordept;
   fetch cursordept into v_existe;
   if cursordept%found then
      update dept
         set
         dnombre = v_dnombre
       where dept_no = v_dept_no;
      update dept
         set
         loc = v_loc
       where dept_no = v_dept_no;
      dbms_output.put_line('UPDATE');
   else
      insert into dept values ( v_dept_no,
                                v_dnombre,
                                v_loc );
      dbms_output.put_line('INSERT');
   end if;

end;

--- count puede ser una opción muy útil que funciona/ incluso sin cursor
declare
   v_dept_no dept.dept_no%type;
   v_dnombre dept.dnombre%type;
   v_loc     dept.loc%type;
   v_existe  dept.dept_no%type;
begin
   v_dept_no := 10;
   v_dnombre := 'I+D';
   v_loc := 'GIJON';
   select count(dept_no)
     into v_existe
     from dept
    where dept = v_dept_no;
   if ( v_existe = 0 ) then
      dbms_output.put_line('INSERT');
   else
      dbms_output.put_line('UPDATE');
   end if;
end;

-- REALIZAR UN CÓDIGO PARA MODIFICAR EL SALARIO DEL EMPLEADO AROYO
-- SI EL EMPLEADO COBRA MÁS DE 250.000 SE LE BAJA EL SUELDO EN 10.000
-- SI NO, SE SUBE EL SUELDO EN 100.000

select *
  from emp
 where apellido = 'arroyo';


declare
   v_salario  emp.salario%type;
   v_apellido emp.apellido%type;
begin
   select count(salario)
     into v_salario
     from emp
    where salario > 250000
      and apellido = 'arroyo';

   if ( v_salario = 0 ) then
      update emp
         set
         salario = salario + 10000
       where apellido = 'arroyo';
      dbms_output.put_line('aumento de salario');
   else
      update emp
         set
         salario = salario - 10000
       where apellido = 'arroyo';
      dbms_output.put_line('SALARIO REDUCIDO');
   end if;

end;


--- incrementar el salario de los doctores de la paz
--- si la suma salarial supera 1.000.000 bajamos salarios en 10.000 a todos
-- si la suma salarial no supera el 1.000.000 subimos un millon
-- mostrar el número de filas que se han modificado

select *
  from doctor;

select *
  from hospital;



declare
    -- DECLARO LAS DOS VARIABLES QUE VOY A USAR. UNA PARA LA SUMA DEL SALARIO Y OTRA PARA EL CONTEO DE LO DOCTORES
   v_salario int;
   v_paz     int;
begin
    -- HAGO UNA CONSULTA QUE GUARDE LAS DOS VARIABLES TENIENDO EN CUNTA LA PRIMAREY KEY
   select count(doctor_no)
     into v_paz
     from doctor
    inner join hospital
   on doctor.hospital_cod = hospital.hospital_cod
    where lower(hospital.nombre) = 'la paz';

   select sum(doctor.salario)
     into v_salario
     from doctor
    inner join hospital
   on doctor.hospital_cod = hospital.hospital_cod
    where lower(hospital.nombre) = 'la paz';

    -- APLICO EL RESPECTIVO CONDICIONAL TENIENDO EN CUENTA LA SUMA DE TODOS LOS SALARIOS DEL HOSPITAL LA PAZ
   if ( v_salario > 1000000 ) then
      update doctor
         set
         salario = salario - 10.000
       where hospital_cod = (
         select hospital_cod
           from hospital
          where nombre = 'la paz'
      );
      dbms_output.put_line('DOCTORES MÁS POBRES: ' || sql%rowcount);
   else
      update doctor
         set
         salario = salario + 10.000
       where hospital_cod = (
         select hospital_cod
           from hospital
          where nombre = 'la paz'
      );
      dbms_output.put_line('DOCTORES CON SUERTE: ' || sql%rowcount);
   end if;

end;

rollback;

-- OTRA FORMA

declare
   v_suma_salarial doctor.salario%type;
begin
   select sum(doctor.salario)
     into v_suma_salarial
     from doctor
    inner join hospital
   on doctor.hospital_cod = hospital.hospital_cod
    where lower(hospital.nombre) = 'la paz';
   dbms_output.put_line('SUMA SALARIAL: ' || v_suma_salarial);
   if ( v_suma_salarial > 1000000 ) then
      update doctor
         set
         salario = salario + 10.000
       where hospital_cod = (
         select hospital_cod
           from hospital
          where nombre = 'la paz'
      );
      dbms_output.put_line('DOCTORES MÁS POBRES: ' || sql%rowcount);
   else
      update doctor
         set
         salario = salario - 10.000
       where hospital_cod = (
         select hospital_cod
           from hospital
          where nombre = 'la paz'
      );
      dbms_output.put_line('DOCTORES CON SUERTE: ' || sql%rowcount);
   end if;

end;


-- una solución más rápida

declare
   v_suma_salarial doctor.salario%type;
   v_codigo        hospital.hospital_cod%type;
begin
   select hospital_cod
     into v_codigo
     from hospital
    where lower(nombre) = 'la paz';


   select sum(doctor.salario)
     into v_suma_salarial
     from doctor
    where hospital_cod = v_codigo;
   dbms_output.put_line('SUMA SALARIAL: ' || v_suma_salarial);
   if ( v_suma_salarial > 1000000 ) then
      update doctor
         set
         salario = salario + 10.000
       where hospital_cod = v_codigo;
      dbms_output.put_line('DOCTORES MÁS POBRES: ' || sql%rowcount);
   else
      update doctor
         set
         salario = salario - 10.000
       where hospital_cod = v_codigo;
      dbms_output.put_line('DOCTORES CON SUERTE: ' || sql%rowcount);
   end if;

end;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

describe dept;


declare
   v_id number;
begin
   dbms_output.put_line('valor variable ' || v_id);
end;




-- se puede almacenar todos los departamentos (uno a uno) en un rowtype
declare
   v_fila dept%rowtype;
   cursor cursor_dept is
   select *
     from dept;

begin
   open cursor_dept;
   loop
      fetch cursor_dept into v_fila;
      exit when cursor_dept%notfound;
      dbms_output.put_line('ID '
                           || v_fila.dept_no
                           || ', nombre '
                           || v_fila.dnombre
                           || ', localidad '
                           || v_fila.loc);
   end loop;

   close cursor_dept;
end;

-- hay una sintaxis para cuando hay un cursor que sea màs sencillo. no se abre ni se pone el fetch
-- e agrega una variable que no hay que declarar
-- lo ùnico que se necesita es el cursor
-- acá el alias también es obligatorio 

declare
   cursor cursor_doctor is
   select apellido,
          especialidad
     from doctor;
begin
   for v_reg_doctor in cursor_doctor loop
      dbms_output.put_line(v_reg_doctor.apellido
                           || '___'
                           || v_reg_doctor.especialidad);
   end loop;
end;

select *
  from emp;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 
24 de abril 
excepciones
cuando hay error me sale una excepción
pero puedo hacer algo con ello 
exception es para declarar las posibles excepciones
si existe la excepciòn e trata, si no da error
se tienen que capturar las que yo quiera
Si el bloque no tiene excpeciòn, se para. Se pone al final, antes del end

puden ser 
implìcitas: las de Oracle
Explìcitas: las puedo generar yo mismo. Se debe poner en la zona de declaración y se usa raise
*/

-- CUANDO LA EXCEPCIÒN YA ESTÁ CREADA

declare
   v_n1  number := 100;
   v_n2  number := 0;
   v_div number;
begin
   v_div := v_n1 / v_n2;
   dbms_output.put_line('LA DIVISIÒN ES ' || v_div);
exception
   when zero_divide then
      dbms_output.put_line('ERROR AL DIVIDIR NTRE 0');
end;


-- CUANDO YO QUIERO CREAR LA EXCEPCIÓN
-- CUANDO LOS EMPLEADOS TENGAN UNA COMISIÒN CON VALOR DE 0, LANZO UNA EXCEPCIÓN
-- TENER UNA TABLA CON LOS EMPLEADOS SEAN MAYOR A CERO

select apellido,
       comision
  from emp
 order by comision desc;

create table emp_comision (
   apellido varchar2(50),
   comision number(9)
);

drop table emp_comision;

declare
   cursor cursor_emp is
   select apellido,
          comision
     from emp
    order by comision desc;
    -- DELCARO UNA EXCEPCIÓN
   exception_comision exception;
begin
   for v_record in cursor_emp loop
      insert into emp_comision values ( v_record.apellido,
                                        v_record.comision );
      if ( v_record.comision > 0 ) then
         raise exception_comision;
      end if;
   end loop;
exception
   when exception_comision then
      dbms_output.put_line('COMISIONES A ZERO');
-- QUIERO DETENER ESTO CUANDO LA COMISIÓN SEA 0

end;

select *
  from emp_comision;
-- PRAGMA
-- ESTÀ LA OPCIÓN PRAGMA EXCEPTION_INIT PARA DEFINIR LO QUE SIGNIFICA EL ERROR

SELECT * FROM DEPT;
DESCRIBE DEPT;

DELETE FROM DEPT
WHERE DEPT_NO IS NULL;

ALTER TABLE DEPT
MODIFY DEPT_NO NOT NULL;


declare
   exception_nulos exception;
   pragma exception_init ( exception_nulos,-1400 );
begin
   insert into dept values ( null,
                             'DEPARTAMENTO',
                             'PRAGMA' );
EXCEPTION
    WHEN exception_nulos THEN
        DBMS_OUTPUT.PUT_LINE('NO ME SIRVEN LOS NULOS');
end;

ROLLBACK;


--- opción others

select * from dept; 

DECLARE
    v_id number;

BEGIN
    SELECT DEPT_NO INTO V_ID
    FROM DEPT
    WHERE DNOMBRE = 'sevilla';
    DBMS_OUTPUT.PUT_LINE('VENTAS ES EL NÚMERO' || V_ID);

EXCEPTION
    when too_many_rows then
        DBMS_OUTPUT.PUT_LINE('demasiada fila en cursor');
    when others then
        DBMS_OUTPUT.PUT_LINE('algo está pasando');
        DBMS_OUTPUT.PUT_LINE(to_char(sqlcode)||'  '||sqlerrm);

END;

-- raise_application error
-- puedo mandar mensajes de error donde me dice el mensaje y el número
-- tiene que ser rangos entre 20.000 y 20.900 

select * from dept; 

DECLARE
    v_id number;

BEGIN
    raise_application_error(-20001, 'puedo hacer esto con esta exepción?');
    SELECT DEPT_NO INTO V_ID
    FROM DEPT
    WHERE DNOMBRE = 'sevilla';
    DBMS_OUTPUT.PUT_LINE('VENTAS ES EL NÚMERO' || V_ID);
END;

-- IMPORTANTE: PROCEDIMIENTOS ALMACENADOS
-- hasta el momento  SE PERDÌAN LOS BLOQUES ANÓNIMOS 
-- SE ALMACENA LO QUE SE QUIERA EN UN OBJETO PERSISTENTE EN UNA BASE DE DATOS
-- ES PARECIDO A LAS FUNCIONES//
-- NO SE PUED UTILIZAR LAS FUNCIONES CREATE, ALTER Y DROP
-- EL CREAR UN PROCEDIMIENTO NO IMPLICA QUE SE HAYA CREADO BIEN
-- SE DEBE LLAMAR EN UN BLOQUE ANÓNIMO

CREATE OR REPLACE PROCEDURE SP_MENSAJE
AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END;

-- PARA LLAMAR AL PROCEDIMIENTO

BEGIN
    SP_MENSAJE;
END;

-- PROCEDIMENTO CON BLOQUE PLSQL

create or replace procedure sp_ejmeplo_plsql as
begin
   declare
      v_numero int := 24;
   begin
      if v_numero > 0 then
         dbms_output.put_line('POSITIVO');
      else
         dbms_output.put_line('NEGATIVO');
      end if;

   end;
end;

-- LLAMADA DE LOS DATOS
begin
   sp_ejmeplo_plsql;
end;

-- TENEMOS OTRA SINTAXIS PARA TENER VARIABLES DENTRO DE UN PROCEDIMIENTO
-- NO SE UTILIZA EL DECLARE DENTRO DEL PROCEDIMIENTO

CREATE OR REPLACE PROCEDURE sp_ejmeplo_plsql2
AS
    V_NUMERO NUMBER := 8;
BEGIN
          if v_numero > 0 then
         dbms_output.put_line('POSITIVO');
      else
         dbms_output.put_line('NEGATIVO');
      end if;
END;

begin
   sp_ejmeplo_plsql2;
end;


--- PROCEDIMIENTO DINÀMICOS
-- VAN DECLARADOS ANTES DEL (AS O IS)
-- ES MEJOR SEPARAR LAS VARIABLES TIPO V_... Y LOS PARÁMETROS P_...


CREATE OR REPLACE PROCEDURE sp_EJEMPLO_IF
(P_1 NUMBER)
IS
    V_NUMERO NUMBER := P_1;
BEGIN
          if v_numero > 0 then
         dbms_output.put_line('POSITIVO');
      else
         dbms_output.put_line('NEGATIVO');
      end if;
END;


begin
   sp_ejmeplo_plsql2;
end;

-- EJEMPLO CON SUMA

CREATE OR REPLACE PROCEDURE sp_SUMA
(P_1 NUMBER, P_2 NUMBER)
as
    V_SUMA NUMBER;

BEGIN
    V_SUMA:= P_1 + P_2;
    dbms_output.put_line('LA SUMA DE LOS NÚMEROS ES ' || V_SUMA);
END;

-- LOS PARÁMETROS SE SUMAN EN EL MISMO ORDEN QUE ESTÀN LLAMADOS

BEGIN
    SP_SUMA (5,6);
END;


CREATE OR REPLACE PROCEDURE SP_DIVIDIR_NUMEROS
(P1 NUMBER, P2 NUMBER)
AS
    V_DIV NUMBER;
BEGIN
    V_DIV := P1/ P2;
    dbms_output.put_line('LA DIVISIÓN DE LOS NÚMEROS ES ' || V_DIV);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        dbms_output.put_line('DIVISIÓN ENTRE CERO PROCEDURE');
END;

BEGIN
    SP_DIVIDIR_NUMEROS (10,0);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('DIVISIÒN PL/SQL OUTER 3');
END;

--- AGREGAR PROCEDURE DENTRO DE OTRO
create or replace procedure sp_dividir_numeros (
   p1 number,
   p2 number
) as
begin
   declare
      v_div number;
   begin
      v_div := p1 / p2;
      dbms_output.put_line('LA DIVISIÓN DE LOS NÚMEROS ES ' || v_div);
   exception
      when zero_divide then
         dbms_output.put_line('DIVISIÓN ENTRE CERO PROCEDURE  1');
   end;
exception
   when zero_divide then
      dbms_output.put_line('DIVISIÓN ENTRE CERO PROCEDURE  2');
end;
--el excepcion màs cercano a la condición

-- en los procedimiento no se puede agregar o limitar las condiciones. La idea es usar columna.type 
-- crear un procedimiento para ingrar un departamento
-- normalmente en los procedimientos de acciòn se incluye commit o rollback si se diera una excepciòn

select * from dept;
create or replace procedure sp_instdept (
   p_id        dept.dept_no%type,
   p_nombre    dept.dnombre%type,
   p_localidad dept.loc%type
) as
begin
   insert into dept values ( p_id,
                             p_nombre,
                             p_localidad );
end;

-- version mejorada /se agrega el max para que automàticamente lo agregue

create or replace procedure sp_instdept (
   --p_id        dept.dept_no%type,
   p_nombre    dept.dnombre%type,
   p_localidad dept.loc%type
) 
as
   v_max_id dept.dept_no%type;
begin
   -- realizamos el cursor implìcito para buscar el max id
   select max(dept_no) +10 into v_max_id from dept;
   insert into dept values ( v_max_id,
                             p_nombre,
                             p_localidad );
   commit;
exception
   when no_data_found then
   dbms_output.put_line('No existen datos');
   rollback;
end;

-- llamada al procedimiento
begin
   sp_instdept ( 'martes', 'jueves');
end;

select * from dept;
select * from emp; 
-- aumentar los empleados por un oficio, debemos enviar el oficio y el incremento 

create or replace procedure sp_aumento_salario
   (p_oficio emp.oficio%type,
   P_salario_aumento emp.salario%type)
as
begin
   update emp set salario = salario + P_salario_aumento where upper (oficio)
   = upper(p_oficio); 
end;

begin
   sp_aumento_salario ('Director',1);
end;

-- Insertar un doctor, e envìan todos los datos del doctor.
-- RECUPERAR EL MAX ID DEL PROCEDIMIENTO 

select * from doctor;

describe doctor;

select * from hospital;

create or replace procedure sp_insertar_doctor (
   p_nombre       doctor.apellido%type,
   p_especialidad doctor.especialidad%type,
   p_salario      doctor.salario%type,
   p_hospital     hospital.hospital_cod%type
) as
   v_doctor_no doctor.doctor_no%type;
begin
   select max(doctor_no) + 1
     into v_doctor_no
     from doctor;

   insert into doctor values ( p_hospital,
                               v_doctor_no,
                               p_nombre,
                               p_especialidad,
                               p_salario );
   dbms_output.put_line('Número de filas insertadas' || sql%rowcount);
   commit;
end;

-- enviamos el nombre del hospital en vez del id del hospital
-- enviar el nombre del hospital en vz del id del hopital

select * from hospital ;

create or replace procedure sp_insertar_doctor (
   p_nombre       doctor.apellido%type,
   p_especialidad doctor.especialidad%type,
   p_salario      doctor.salario%type,
   p_hospital     hospital.nombre%type
) as
   v_doctor_no doctor.doctor_no%type;
   v_hopital_cod hospital.HOSPITAL_COD%TYPE;

begin

   select hospital_cod into v_hopital_cod from hospital ; 

   select max(doctor_no) + 1 into v_doctor_no from doctor;

   insert into doctor values ( p_hospital,
                               v_doctor_no,
                               p_nombre,
                               p_especialidad,
                               p_salario );
   commit;
   dbms_output.put_line('Número de filas insertadas' || sql%rowcount);

   exception
   when no_data_found then
   dbms_output.put_line('No existen datos');

end;


begin
   sp_insertar_doctor ('prueba 1','prueba', 100,'la paz');
end;

-- podemo utilizar cursores explìcitos dentro de los procedimientos 
-- motrar los empleados de determinado nùmeros de departamentos

create or replace procedure sp_dempleados_dept
(p_deptno emp.dept_no%type)
as

   cursor cursor_emp is
   select * from emp
   where dept_no = p_deptno; 

begin

   for v_reg_emp in cursor_emp
   loop
      dbms_output.put_line('aplleido: ' || v_reg_emp.apellido ||', oficio: '|| v_reg_emp.oficio);
   end loop;

end;

begin
   sp_dempleados_dept(10);
end;

-- los paràmtros son obligaorios. Aunque está la opción de hacer parametros opcionales. Estos valores tienen un valor por defecto aunque si yo ls doy valor, s e los doy. 


-- Procedimientos almacenados con parámetros de salida
-- Los procedimientoss pueden modificar su valor i tienen un parámetro de salida. Hata el momento no se podría modificar. 
-- Sirve mucho paa conectar con otros lenguajes. se guarda la variable para que la pueda usar en muchos otros sitios

-- enviar el nombre del departamento y devolver su número
-- la herramienta de uno, me sirve para comunicar y enviar entre otros.

create or replace procedure sp_numerodeparamento
(p_nombre dept.dnombre%type, p_iddept out dept.dept_no%type  )
as
   v_iddept dept.DEPT_NO%TYPE;

begin
   select dept_no into v_iddept from dept where upper (dnombre) = upper (p_nombre);
   p_iddept := v_iddept;
   dbms_output.put_line('el numero de departamento es'|| v_iddept );
end;

begin
   sp_numerodeparamento('ventas');
end;

--- un procedimiento para incrementar el salario de 1 departamento
-- se envìa al procedimiento el nombre del departamento 
---
create procedure sp_incrementar_sal_dept
(p_nombre dept.dnombre%type)

as
   V_num dept.dept_no%type;

begin

   -- lamamos al procedimiento de nùmero para recuerarlo a partir del nombre
   sp_numerodeparamento(p_nombre, v_num);
   update emp set salario = salario +1 where dept_no=v_num ;
   dbms_output.put_line('salario modificado '|| sql%rowcount );
end;

--
begin 
 sp_incrementar_sal_dept ('ventas');
end;

/* 

05 d mayo de 2025

FUNCIONES
similar a procedimientos. Es algo que se tiene pero permite devolver un valor a una llamada
Un funciòn siempre devuelve un valor.
Siempre debe tener return

*/
-- ejemplo función para sumar dos números

create or replace function f_sumarnumeros
(p_1 number, P_2 number)
return number
as
   v_suma number;
begin
   v_suma := nvl(p_1,0) + nvl(P_2,0);
   -- siempre return
   return v_suma;
end;

-- llamada con código pl/sql

declare
   v_resultado number;
begin
   V_RESULTADO := f_sumarnumeros (100,2000);
   DBMS_OUTPUT.PUT_LINE('La suma es ' || v_resultado);
end;

-- llamada desde select

select f_sumarnumeros(5,8) as suma from dual;

select apellido, f_sumarnumeros(salario, comision) as total from emp;

-- crear una función para aber el nùmero de persona de un oficio
create or replace function f_num_per_oficio
(p_oficio emp.oficio%type)
return number

as
   v_personas int;

begin
   select count(emp_no) into v_personas from emp
   where lower(oficio) = p_oficio;
   return v_personas;
   
end; 

DECLARE
   v_resultado int;
begin
   v_resultado := f_num_per_oficio('analista');
   DBMS_OUTPUT.PUT_LINE('La cuena otal es es ' || v_resultado);
   
end;

create or replace function F_mayor_menor
(p1 number, p2 number)
return number

as
   v_mayor number;
begin
   if p1 > P2 then
      v_mayor := p1;
   elsif p2 > p1  then
      v_mayor := p2;
   else
      v_mayor := 0;
   end if;

   return v_mayor;

end;

select F_mayor_menor(5,5) as mayor from dual;


-- ralizar una función para devolver el mayor de tres números
-- no utilizar if
-- buscar función de oracle que nos devuelva el mayor

create or replace function f_mayor_sinif
(p1 number,p2 number,p3 number)
return number

as 
   v_mayor number;
begin
   v_mayor := greatest(p1,p2,p3);
   return v_mayor;
end;


select f_mayor_sinif(1,2,3) as mayor from dual;

--- funciòn para calcular el iva
-- se puede dejar predeterminada la función

create or replace function f_iva
(p_precio number, p_iva number :=1.18)
return number

as

begin
   return p_precio * p_iva;
end;

select f_iva(100, 1.21) as iva from dual;

-- vistas
-- Herramienta de la base de datos, es básica
-- Ess una imagen de una tabla. No puede ser creada, solo por tabla o vista
-- los datos siempre sadran de una tabla y nunca almacenara datos
-- Se recupera de las tablas que se especìfica
-- Se usa para trabajar consultas
-- Un programadar simpre trabaja con vistas
-- Las consoultas son lass más rapidas.
-- CREAR UNA VISTA PARA TENER LOS DATOS DE LOS EMPLEADOS SIN EL SALARIVI LA HBAITAL

create OR REPLACE VIEW AS F__EMPLEADOS_MP
AS 
   SELECT EMP_NO APELLLID, OFICIO, ESCHA_ALT, DEPT_NO FROM EMP;

--UNA VISTA SIMPLIFICA LAS CONSUKLTAS-- MOSTRAR EL APLLIDO OFICIO, SALARIO

CREATE OR REPLACE VIEW V_EMP_DEPT
AS
      SELECT EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, DEPT.DNOMBRE, DEPT.LOC
      FROM EMP
      INNER JOIN DEPT
      ON EMP.DEPT_NO = DEPT.DEPT_NO

      SELECT * FROM V_EMP_DEPT WHERE upper(LOC)= upper ('madrid');

-- s puede hacer vistas con càlculos calculados y siempre debe tener alias
create or replace view v_empleados_virtual
as
   select emp_no, apellido, oficio, salario + comision as total, dept_no from emp;

-- modiificar el salario de los empleados analista

update emp set salario = salario +1 where oficio = 'ANALISTA';
update v_empleados_virtual set salario = salario +1 where oficio = 'ANALISTA';


select * from v_empleados_virtual;

-- ELIMINAMOS AL EMPLEADO CON ID 7917

DELETE FROM v_empleados_virtual WHERE EMP_NO= 7917;

INSERT INTO v_empleados_virtual VALUES (11111,'LUNES','LUNES',0,40);

-- QUÉ SUCCEDE SI LAS COLUMNAS NO ADMITEN NULL

UPDATE V_EMP_DEPT SET SALARIO = SALARIO +1 WHERE LOC = 'MADRID';

DELETE FROM V_EMP_DEPT WHERE LOC = 'BARCELONA';

-- SI LA CONSULTA MODIFICA DOS TABLAS, NO PERMITE
-- UN TRRIGER AFECTA TABLAS Y VISTA/ SIRVE PARA CONDICIONAR EL DESARROLLO 

ROLLBACK;

-- VISTAS QUE PUEDEN SER INÙTILES

CREATE OR REPLACE VIEW V_VENDEDORES
AS
   SELECT EMP_NO, APELLIDO, OFICIO, SALARIO, DEPT_NO FROM EMP
   WHERE OFICIO = 'VENDEDOR'
   WITH CHECK OPTION;


UPDATE V_VENDEDORES SET SALARIO = SALARIO +1;

UPDATE V_VENDEDORES SET OFICIO = 'VENDIDOS';

SELECT * FROM V_VENDEDORES;



--- debemos pedir un nùmero narcisita
--- la función es Power

create or replace function f_narcista
(n1 varchar2(50))
return boolean

as
   potencia number:= len(n1);
   resultado number:= 0
   inicial number := to_number(n1)
   v_resultado := 
   
begin

   for i in 1..potencia loop
      resultado := resultado + power( to_number(substr(n1,i,1)), potencia)
   end loop;
   
   if resultado = inicial then
      v_resultado := false
   else
      v_resultado := true
   end if;
   
end;

