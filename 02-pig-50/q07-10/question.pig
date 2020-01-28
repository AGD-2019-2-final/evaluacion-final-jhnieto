-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
u = LOAD 'data.tsv' USING PigStorage('\t')
    AS (f1:CHARARRAY,
        f2:BAG{t: TUPLE(p:CHARARRAY)},
        f3:MAP[]);
r = FOREACH u GENERATE f1, SIZE(f2), SIZE(f3);
z = ORDER r BY $0, $1, $2;
x = FOREACH z GENERATE CONCAT($0,',',(CHARARRAY)$1,',',(CHARARRAY)$2);
-- x = ORDER z BY $0, $1, $2;
STORE x INTO 'output';
