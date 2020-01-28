-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
r = FOREACH u GENERATE ToDate(birthday,'yyyy-MM-dd') AS (date_time:DateTime);
x = FOREACH r GENERATE GetYear(date_time);
x = GROUP x BY $0;
z = FOREACH x GENERATE $0, COUNT($1);
x = FOREACH z GENERATE CONCAT((CHARARRAY)$0,',',(CHARARRAY)$1);
STORE x INTO 'output';