--ЛАБА 3
--1. Представление "Количественные показатели": 
-- раздел науки – научное направление – количество кандидатов наук – количество докторов наук.
CREATE VIEW col_poc(section,field,cand,doct)
AS SELECT sec.name, f.name, (SELECT count(*) FROM dissertations as d1 WHERE d1.type = 'кандидатская' AND f.code = d1.sci_field) as con_col, 
(SELECT count(*) FROM dissertations as d2 WHERE d2.type = 'докторская' AND f.code = d2.sci_field) as doc_col  
FROM science_sections as sec LEFT JOIN scientific_fields as f
ON (f.sci_section = sec.code)
GROUP BY sec.name, f.name;