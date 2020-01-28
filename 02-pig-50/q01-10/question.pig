-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
-- Escriba el resultado a la carpeta `output` del directorio actual.
--
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
u = LOAD 'data.tsv' USING PigStorage('\t')
    AS (id:CHARARRAY,
        date:CHARARRAY,
        quantity:INT);
y = GROUP u BY $0;
x = FOREACH y GENERATE group, COUNT(u);
STORE x INTO 'output';
