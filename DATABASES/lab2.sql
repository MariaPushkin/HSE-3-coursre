-- номер 1: диссертации по научному направлению "Телекоммуникационные системы и компьютерные сети"; 
SELECT name 
FROM dissertations
WHERE sci_field = 120
ORDER BY name DESC;

-- номер 2: докторские диссертации по разделу "Компьютерные науки"; 
SELECT d.name FROM science_sections as sec LEFT JOIN scientific_fields as f
ON (f.sci_section = sec.code)
LEFT JOIN dissertations as d
ON (d.sci_field = f.code)
WHERE d.type = 'докторская' and sec.name LIKE 'Компьютерные науки' 
GROUP BY d.name
ORDER BY d.name DESC;

SELECT d.name
FROM dissertations as d
WHERE d.type = 'докторская' and d.sci_field IN
	(SELECT s.code FROM scientific_fields as s WHERE s.sci_section = 1)
ORDER BY name DESC;

-- номер 3: количество диссертаций по разделам науки, защищенных в текущем году;
SELECT sec.name, count(d.sci_field) FROM science_sections as sec LEFT JOIN scientific_fields as f
ON (f.sci_section = sec.code)
LEFT JOIN (SELECT sci_field FROM dissertations WHERE year(pres_date) = year(now())) d
ON (d.sci_field = f.code)
GROUP BY sec.name;

-- номер 4: научных направлений, по которым нет докторских диссертаций;
SELECT f.name FROM scientific_fields as f 
WHERE NOT EXISTS (SELECT d.type FROM dissertations as d WHERE d.sci_field = f.code and d.type = 'докторская')
GROUP BY f.code, f.name
ORDER BY f.name;

-- номер 5: авторов, которые защитили кандидатскую и докторскую диссертации по разным направлениям науки.
SELECT a.name FROM authors as a LEFT JOIN dissertations as d
ON (d.author = a.id)
GROUP BY a.id
HAVING count(DISTINCT d.type) > 1 and COUNT(DISTINCT d.sci_field) > 1;