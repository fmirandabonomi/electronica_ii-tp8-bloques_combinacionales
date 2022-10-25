# Práctico 8 - Electrónica II 2022 para ingeniería electrónica - Circuitos combinacionales

El objetivo de este práctico es conseguir familiaridad con los bloques lógicos combinacionales más comunes. Consta de dos partes. En la primera parte implementarás en vhdl de bloques combinacionales comunes. En la segunda parte utilizarás los bloques combinacionales para la implementación de un circuito lógico combinacional.

Para cada componente a desarrollar hay implementado un banco de pruebas de VHDL. Para ejecutar las pruebas usar los siguientes comandos (para ejecutar en linux usar make en lugar de mingw32-make)

Para correr **todas** las pruebas (se detiene en la primera prueba que falla):

```
mingw32-make
```

Para correr las pruebas correspondientes a un módulo en particular usa ```mingw32-make <modulo>```. Por ejemplo para *cod_8_3* usa

```
mingw32-make cod_8_3
```

Es necesario tener instalado ghdl y make (mingw32-make en windows). Consultar el TP1 para instrucciones de como configurar un entorno.

Para completar el práctico consulta las secciones *Bloques combinacionales* y *Aplicación*. Para completar el práctico consulta la sección *Entrega del práctico*.

## Bloques combinacionales

Deberás implementar en VHDL los siguientes bloques combinacionales:

- Codificador $8$ a $3$ (archivo cod_8_3.vhd)
- Decodificador $2$ a $4$ (archivo decod_2_4.vhd)
- Multiplexor $8$ a $1$ (archivo mux_8_1.vhd)
- ROM $16\times 7$ (archivo rom_16x7.vhd)


### Codificador $8$ a $3$

El codificador $8$ a $3$ tiene una entrada de $8$ bits en código one-hot, una salida binaria de $3$ bits y una salida de palabra válida. Si el bit $n$ de la entrada es '1' y los demás bits son '0' entonces la salida binaria será $n$ y la salida de palabra válida será '1'. Si todos los bits de entrada son cero o hay más de un uno entonces el valor de salida binaria es indiferente y la salida de palabra válida será '0'. 
Ejemplos:
- Entrada: "00000100" -> Salida: "010" Palabra válida: '1'.
- Entrada: "00000000" -> Salida: "XXX" Palabra válida: '0'.

### Decodificador $2$ a $4$

El decodificador $2$ a $4$ tiene una entrada binaria de $2$ bits, una entrada de habilitación y una salida de $4$ bits. Cuando no está habilitado todas las salidas están en cero. Cuando está habilitado y la entrada es $n$ entonces la salida en posición $n$ será '1' y todas las demás serán '0'.

Ejemplos:
- Entrada: "11", Habilitación: '1' -> Salida: "1000"
- Entrada: "11", Habilitación: '0' -> Salida: "0000"

### Multiplexor $8$ a $1$

El multiplexor de $8$ a $1$ cuenta con una entrada de selección de $3$ bits, una entrada de habilitación, $8$ entradas de datos y una salida. Cuando el multiplexor está deshabilitado la salida estará en un estado de alta impedancia. Cuando el multiplexor está habilitado y la entrada de selección tiene el valor $n$ entonces la salida tendrá el valor lógico de la entrada de dato en posición $n$.

Ejemplos:
- Datos "01000000", Selector "110", Habilitación '1' -> Salida '1'
- Datos "01000000", Selector distinto de "110", Habilitación '1' -> Salida '0'
- Datos "01000000", Selector "XXX", Habilitación '0' -> Salida 'Z'

### ROM $16\times 7$

La ROM $16\times 7$ cuenta con una entrada de dirección de $7$ bits, una entrada de habilitación y una salida de $7$ bits. Si la habilitación es '0' entonces la salida estará en alta impedancia. Si la habilitación es '1' y la dirección $n$ entonces la salida corresponde al dato almacenado en la dirección $n$.

Ejemplos:
Contenido:  (0 =>"0000001",1 =>"1001111",2 =>"0010010",3 =>"0000110",4 =>"1001100",
             5 =>"0100100",6 =>"0100000",7 =>"0001111",8 =>"0000000",9 =>"0000100",
             others => "1111110")

- Dirección "0000", habilitación '1' -> salida "0000001"
- Dirección "XXXX", habilitación '0' -> salida "ZZZZZZZ"
- Dirección "0101", habilitación '1' -> salida "0100000"

## Aplicación

Aplicaremos bloques combinacionales al desarrollo de lo siguiente:

- Módulo conversor de BCD a 7 segmentos con lógica positiva (archivo bcd-7seg.vhd)
- Driver de teclado matricial de 4x4, parte combinacional (archivo teclado.vhd)

### Módulo conversor de BCD a 7 segmentos

El módulo tiene una entrada BCD de $4$ bits, una entrada de habilitación y una salida de $7$ bits de 7 segmentos con lógica positiva. Cuando la habilitación está en '0' la salida permanece en alta impedancia. Cuando la entrada de habilitación está en '1' la salida tiene unos en las posiciones correspondientes a los segmentos encendidos y ceros en las correspondientes a segmentos apagados, tal de representar en un display de 7 segmentos el número indicado por la entrada BCD.

El display de 7 segmentos tiene 7 segmentos luminosos ordenados formando un número 8 y comandados por las señales a,b,c,d,e,f,g, correspondientes a los bits 6 a 0 de la salida, en ese orden, dispuestos según el esquema siguiente:

```

 aaaaaaaa 
f        b
f        b
f        b
 gggggggg 
e        c
e        c
e        c
 dddddddd 

Fuente a usar:

:  —  :     :  —  :  —  :     :  —  :  —  :  —  :  —  :  —  : 
: | | :   | :   | :   | : | | : |   : |   : | | : | | : | | :
:     :     :  —  :  —  :  —  :  —  :  —  :     :  —  :  —  :
: | | :   | : |   :   | :   | :   | : | | :   | : | | :   | :
:  —  :     :  —  :  —  :     :  —  :  —  :     :  —  :  —  :

Para entrada > 9 la salida es indiferente
```

Los números BCD de $4$ bits válidos son $\{0;1;2;3;4;5;6;7;8;9\}$. La salida presentada ante cualquier otra entrada es indiferente.

### Driver de teclado matricial

Un teclado matricial 4x4 consiste en cuatro líneas lógicas de fila y cuatro líneas lógicas de columna. Las filas están conectadas a salidas de habilitación, las columnas están conectadas a entradas buffer con resistores pull-up. Dieciseis pulsadores están dispuestos de modo que conectan cada fila con cada columna al ser presionados.

```
                 H    H    H    H
                 |    |    |    |
                 v    v    v    v
drv_fila(0) =>--(1)--(2)--(3)--(A)
drv_fila(1) =>--(4)--(5)--(6)--(B)
drv_fila(2) =>--(7)--(8)--(9)--(C)
drv_fila(3) =>--(*)--(0)--(#)--(D)
                 |    |    |    +-=> buf_col(3)
                 |    |    +------=> buf_col(2)
                 |    +-----------=> buf_col(1)
                 +----------------=> buf_col(0)

hab           =>| Driver de teclado |=> drv_fila(3..0)
sel(1..0)     =>| matricial         |
buf_col(3..0) =>|                   |=> estado_col(3..0)

```

El driver de teclado matricial cuenta con una entrada de habilitación, una entrada de selección de fila de dos bits, una salida de excitación de fila de cuatro bits de drenador abierto (lógica invertida, el '1' cuenta como alta impedancia), una entrada de buffer de columnas de cuatro bits y una salida de estado de columnas de cuatro bits. La salidas de excitación de fila y entradas de buffer de columna son destinadas a conectar el teclado matricial. Si la entrada de habilitación es '0' entonces las salidas de excitación de fila deben mantenerse en '1' y estado de columna en alta impedancia ('Z'). Si la entrada de habilitación es '1' y la entrada de selección de fila es $n$ entonces la salida de excitación de fila número $n$ toma valor '0' mientras que las demás salidas de excitación toman el valor '1', y las salidas de estado de columna toman el valor '1' para las columnas en estado '0' y el valor '0' en otro caso.

## Entrega del práctico

Como este práctico cuenta con varios archivos fuente, para entregarlos generarás un archivo .tar que incluye todos los archivos fuente. Para prepararlo debes usar el comando

```
mingw32-make entrega
```

Nota: Este comando correrá primero todas las pruebas y fallará si hay algún error.

Si pasaron todas las pruebas generará el archivo *entrega.tar*, el cual debes subir al aula para entregar la tarea.

