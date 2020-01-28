-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave 
-- `aaa`?
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
r = FOREACH u GENERATE FLATTEN(f3);
y = GROUP r BY $0;
-- z = FOREACH y GENERATE $0, COUNT($1);
z = FOREACH y GENERATE CONCAT($0,',',(CHARARRAY)COUNT($1));
STORE z INTO 'output';