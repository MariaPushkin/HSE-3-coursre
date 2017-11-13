--ЛАБА 3
--1. Представление "Количественные показатели": 
-- раздел науки – научное направление – количество кандидатов наук – количество докторов наук.
CREATE VIEW col_poc(section,field,cand,doct)
AS SELECT sec.name, f.name, (SELECT count(*) FROM dissertations as d1 WHERE d1.type = 'кандидатская' AND f.code = d1.sci_field) as con_col, 
(SELECT count(*) FROM dissertations as d2 WHERE d2.type = 'докторская' AND f.code = d2.sci_field) as doc_col  
FROM science_sections as sec LEFT JOIN scientific_fields as f
ON (f.sci_section = sec.code)
GROUP BY sec.name, f.name;

SELECT * FROM col_poc

-- 2. Представление "Доктора наук": автор – данные о его кандидатской диссертации – данные о его докторской диссертации.
CREATE VIEW docs(name, cand, doc)
AS SELECT a.name, d1.name, d2.name 
FROM authors as a LEFT JOIN dissertations as d1 ON(a.id = d1.author AND d1.type = 'кандидатская'), dissertations d2
WHERE a.id = d2.author AND d2.type = 'докторская'
GROUP BY a.name, d1.name

SELECT * FROM docs

-- 3. Представление "Диссертации, с момента защиты которых прошло больше месяца, но диссертация ещё не утверждена".
CREATE VIEW not_app_diss
AS SELECT id, name, pres_date, app_date FROM dissertations
WHERE TO_DAYS(now()) - TO_DAYS(pres_date) > 30 AND app_date IS NULL
ORDER BY name;

SELECT * FROM `not_app_diss