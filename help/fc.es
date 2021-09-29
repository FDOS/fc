FC v. 3.03 (c) 2004 Maurizio Spagni

FC compara dos archivos, o conjuntos de archivos, tanto en modo texto como en
modo binario; y muestra las diferencias entre ellos.

FC es una implementación del algoritmo de Paul Heckel del número de abril de
1978 de «Communications of the Association for Computing Machinery»,
páginas 264-268, «A Technique for Isolating Differences Between Files».

Las ventajas de este algoritmo son su velocidad y que puede detectar las
diferencias de cualquier número de líneas. Para la mayoría de las aplicaciones,
el algoritmo aísla diferencias similares a las aisladas por la subsecuencia
común más larga.

Sintaxis:

FC [opciones] [unidad1:][ruta1]archivo1 [unidad2][ruta2]archivo2 [opciones]

 /A    Muestra solo la primera y última línea para cada conjunto de diferencias
 /B    Comparación binaria
 /C    No diferenciar mayúsculas de minúsculas
 /L    Comparar texto ASCII
 /LBn  n son las máximas líneas ASCII consecutivas
 /Mn   n son las máximas diferencias en la comparación binaria
 /N    Mostar números de línea al comparar textos
 /Q    No mostrar diferencias
 /R    Muestra un resumen al final
 /S    Procesar también los archivos en subcarpetas. Implica /R
 /T    No convertir caracteres tabuladores en espacios
 /U    Mostrar los nombres de los archivos sin correspondencias
 /W    Comprimir espacios en blanco (sangrías y espacios) al comparar texto
 /X    No mostrar contexto al comparar texto
 /nnn  nnn son las líneas iguales mínimas a mostrar para resincronizar la
 comparación

El programa es compatible con nombres largos, y los usará automaticamente si el
sistema operativo lo permite.

Por omisión FC entra en modo binario con las extensiones .EXE, .COM, .SYS, .OBJ,
.BIN, .DLL y .LIB.

En modo binario FC muestra el desplazamiento entre los octetos no coincidentes,
su valor hexadecimal y, si se puede, imprime el caracter ASCII correspondiente.

Por omisión la comparación binaria termina tras 20 diferencias, pero esto puede
cambiarse con la opción /M. /M0 y /M indican «todas las diferencias».

Un problema de diseño de este programa es que, en modo texto, solo compara las
primeras 32765 líneas; el resto son ignoradas. No hai límite en la longitud de
cada línea.

Apuntes sobre usar comodines en los archivos:
- Indicar una carpeta es lo mismo que indicar todos los archivos de esa carpeta
  («*.*»).
  Por ejemplo: «FC C:\ A:» es equivalente a «FC C:\*.* A:*.*»
- Si no hay archivo2 se asume la carpeta actual-
  Por ejemplo: «FC C:\NOTA.TXT» es lo mismo que «FC C:\NOTA.TXT *.*»
- Si archivo1 tiene comodines, pero archivo2 no, todos los archivos que
  coincidan con archivo1 se comparan con archivo2.
  Por ejemplo: «FC FOO.BK? FOO.TXT»
               Todos los archivos que coincidan con FOO.BK? se comparan con
               FOO.TXT
- Si archivo1 tiene comodines y archivo2 es una ruta seguida de *.* entonces
  todos los archivos que coincidan con archivo1 se comparan con aquellos
  archivos de la ruta de archivo2 cuyo nombre coincida (si existen, claro).
  Por ejemplo: «FC *.* A:*.*», o más corto «FC . A:»
               Todos los ficheros en la carpeta actual se comparan con su
               copia en A:
- Si archivo1 y archivo2 tienen comodines entonces todos los archivos de
  archivo1 se comparan con el archivo en archivo2 que le correspondiere a cada
  uno. (si existieren, claro).
  Por ejemplo: «FC *.TXT COPIAS\*.BAK»
               Todos los archivos en la carpeta actual se comparan con su copia
               de seguridad con la extensión BAK guardada en la carpeta COPIAS.
Pero del dicho al hecho hay un trecho.
Si en verdad quiere comparar cada archivo de una carpeta con todos los archivos
de otra puede usar:
FC *.* CARPETA\????????.???

La opción /S reusa el mismo patrón al buscar en cada subcarpeta cuyo nombre en
cada lado coincida.
  Por ejemplo: «FD /S C:*.TXT D:*.BAK»
               Si hay una carpeta llamada LIBROS tanto en C: como en D: esto
               compara todos los archivos que coincidan con *.TXT con sus copias
               *.BAK en la carpeta actual, y todos los archivos LIBROS\*.TXT con
               sus copias en LIBROS\*.BAK.

Al salir los valores en ERRORLEVEL pueden ser los siguientes:
	0	Todos los archivos coinciden
	1	Difieren como mínimo un par de archivos
	2	Parámetro inválido
	3	Archivo no encontrado
	4	No se pudieron abrir el archivo o archivos
