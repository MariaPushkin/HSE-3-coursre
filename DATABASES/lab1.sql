-- отношение "Разделы науки"

CREATE TABLE science_sections (
    code numeric(4) PRIMARY KEY,
    name varchar(100) NOT NUll);
	
	
	--добавление данных
		INSERT INTO science_sections
		VALUES
		(1, 'Компьютерные науки'),
		(301, 'Экономика'),
		(105, 'Социология'),
		(106, 'Педагогика');
		(20, 'Физика'),
		(23, 'Электроника'),
		(400, 'Биология'),
		(408, 'Медицина')

--тношение "Научные направления"

CREATE TABLE scientific_fields (
    code numeric(6) PRIMARY KEY,    
    name varchar(100) NOT NULL,
    sci_section numeric(4) NOT NULL,
    FOREIGN KEY(sci_section) REFERENCES science_sections(code));
	
	
	--добавление данных
	INSERT INTO scientific_fields
	VALUES
	(100, 'Машинное обучение', 1),
	(4005, 'Дошкольное обучение', 106),
	(107, 'Компьюетерная графика', 1),
	(111, 'Программная инженерия', 1),
	(5000, 'Микроэкономика', 301),
	(5010, 'Макроэкономика', 301),
	(5033, 'Финансовое управление', 301);
	(560, 'Теплофизика', 20),
	(7800, 'Биология безпозвоночных', 400);
	
-- отношение "Авторы"

CREATE TABLE authors (
	id numeric(7) PRIMARY KEY,
	name varchar(100) NOT NULL,
	birth date,
    sex char,
	pas_data varchar(100));
  
  
	-- добавление данных
	INSERT INTO AUTHORS (id,name,birth,sex)
	VALUES
		(1, 'Бобров Михаил Петрович', '1979-05-21', 'м'),
		(2, 'Кокосинов Антон Викторович', '1987-10-05', 'м','1234-789098'),
    	(3, 'Бобрикова Анна Петровна', '1990-04-12', 'ж', '1123-890678'),
    	(4, 'Тонишенская Виктория Николаевна','1989-03-15','ж','1278-456345'),
		(5, 'Столичнов Павел Антонович', '1976-06-05', 'м', '1234-567435'),
		(6, 'Зимина Алевтина Сергеевна', '1987-10-11', 'ж','1234-456378'),
    	(7, 'Полевая Ирина Петровна', '1992-11-12', 'ж', '1123-834578'),
    	(8, 'Кокшеков Дмитрий Анатольевич','1987-06-15','м','1278-456567');
	
-- отношение "Диссертации"
CREATE TABLE dissertations (
	id numeric(5) PRIMARY KEY,
	sci_field numeric(6),
	author numeric(7) NOT NULL,
	name varchar(200) NOT NULL,
	type varchar(15) NOT NULL,
	pres_date date NOT NULL,
	org varchar(60) NOT NULL,
	app_date date,
	diploma_no varchar(20) UNIQUE,
	FOREIGN KEY(sci_field) REFERENCES scientific_fields(code),
	FOREIGN KEY(author) REFERENCES authors(id));

	-- добавление данных
	INSERT INTO dissertations
	VALUES
	(1,111,2, 'Разработка программных компонентов для тестирования технологий компании ОАО "Эстек','кандидатская','2010-06-23','НИУ ВШЭ','2010-07-24','67548934'),
	(2,120,5, 'Сетевые технологии в качестве поддержки работоспособности систем контроля','кандидатская','2004-12-15','НИЯУ МИФИ','2005-01-20','14562563'),
	(3,120,7, 'Распределение сетевых моделей на уровне транзакций','кандидатская','2015-06-20','МГУ','2015-07-23','34562785'),
	(4,111,3, 'Разработка систем защиты информации для компонентов МКС','докторская','2012-05-30','МГТУ им.Баумана','2012-06-24','56389087'),
	(5,107,8, 'Моделирование и графиеское прототипирование алгоритмических моделей','докторская','2011-05-28','НИУ ВШЭ','2011-06-27','65749345');
	(6,100,1,'Технологии компьютерного зрения в орагнизации образования', 'докторская','2017-05-12','НИУ ВШЭ','2017-06-14','46382906'),
	(7,5033,4, 'Формирование финансовых компетиций в управленческой сфере', 'кандидатская', '2017-04-15', 'НИУ ВШЭ','2017-05-20','89634234'),
	(8,4005,6, 'Выявление дефектов речи у детей 2-3 лет', 'докторская', '2017-02-02', 'МПГУ', '2017-03-10','90872675'),
	(9,120,2, 'Разработка теплорезестивного шунта для трансляции телесегналов', 'докторская', '2017-03-15', 'НИУ ВШЭ', '2017-04-13','90871234');

-- ТРИГГЕРЫ
-- Для таблицы Диссертации
delimiter //
create trigger check_dissartations before insert on dissertations
for each row 
begin 
if ((new.type <> 'кандидатская' && new.type <> 'докторская') || new.id < 0) then 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Неправльно заданные данные. Проверьте, что тип работы "кандидатская" или "докторская", id больше 0'; 
end if; 
end//

delimiter //
create trigger check_dissartations_upd before UPDATE on dissertations
for each row 
begin 
if ((new.type <> 'кандидатская' && new.type <> 'докторская') || new.id < 0) then 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Неправльно заданные данные. Проверьте, что тип работы "кандидатская" или "докторская", id больше 0'; 
end if; 
end//

delimiter //
create trigger check_authors before insert on authors
for each row 
begin 
if ((new.sex <> 'м' && new.sex <> 'ж') || new.id < 0) then 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Неправльно заданные данные. Проверьте, что пол "ж" или "м", id больше 0'; 
end if; 
end//

delimiter //
create trigger check_authors_upd before update on authors
for each row 
begin 
if ((new.sex <> 'м' && new.sex <> 'ж') || new.id < 0) then 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Неправльно заданные данные. Проверьте, что пол "ж" или "м", id больше 0'; 
end if; 
end//

SELECT sec.name, count(d.sci_field) FROM science_sections as sec LEFT JOIN scientific_fields as f
ON (f.sci_section = sec.code)
LEFT JOIN dissertations as d
ON (d.sci_field = f.code)
WHERE year(d.pres_date) = year(now())
GROUP BY sec.name;