-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código en Pig para manipulación de fechas que genere la siguiente 
-- salida.
-- 
--    1971-07-08,jul,07,7
--    1974-05-23,may,05,5
--    1973-04-22,abr,04,4
--    1975-01-29,ene,01,1
--    1974-07-03,jul,07,7
--    1974-10-18,oct,10,10
--    1970-10-05,oct,10,10
--    1969-02-24,feb,02,2
--    1974-10-17,oct,10,10
--    1975-02-28,feb,02,2
--    1969-12-07,dic,12,12
--    1973-12-24,dic,12,12
--    1970-08-27,ago,08,8
--    1972-12-12,dic,12,12
--    1970-07-01,jul,07,7
--    1974-02-11,feb,02,2
--    1973-04-01,abr,04,4
--    1973-04-29,abr,04,4
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
r = FOREACH u GENERATE birthday, ToDate(birthday,'yyyy-MM-dd') AS (date_time:DateTime);
x = FOREACH r GENERATE date_time, birthday, ToString($1,'MMM'), ToString($1,'MM'), ToString($1,'M');
x = FOREACH x GENERATE $1,
    CASE ToString($0,'MM') 
    WHEN '01' THEN 'ene' 
    WHEN '02' THEN 'feb' 
    WHEN '03' THEN 'mar' 
    WHEN '04' THEN 'abr' 
    WHEN '05' THEN 'may' 
    WHEN '06' THEN 'jun' 
    WHEN '07' THEN 'jul' 
    WHEN '08' THEN 'ago' 
    WHEN '09' THEN 'sep' 
    WHEN '10' THEN 'oct' 
    WHEN '11' THEN 'nov' 
    WHEN '12' THEN 'dic' 
    END,
    ToString($0,'MM'),
    ToString($0,'M');
x = FOREACH x GENERATE CONCAT((CHARARRAY)$0,',',(CHARARRAY)$1,',',(CHARARRAY)$2,',',(CHARARRAY)$3);
STORE x INTO 'output';