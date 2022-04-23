--Делал в PostgreSQL
--Оформил как справочник по операциям для себя
--Подскажите как правильно:
--1. Нужно сделать в стране поле статус - 3 вида статуса возможно. 
--Можно сделать ограничение на значение поля - только 3 вида значения доступно, либо сделать отдельную таблицу и ставить в первичный ключ. Как правильно?
--2. 

USE geodata;

select * from _countries;

--Таблица _coutries
	--удалить колонки
	ALTER TABLE _countries 
		DROP COLUMN title_en,
		DROP COLUMN title_ua,
		DROP COLUMN title_be,
		DROP COLUMN title_es,
		DROP COLUMN title_pt,
		DROP COLUMN title_de,
		DROP COLUMN title_fr,
		DROP COLUMN title_it,
		DROP COLUMN title_pl,
		DROP COLUMN title_ja,
		DROP COLUMN title_lt,
		DROP COLUMN title_lv,
		DROP COLUMN title_cz;


	--изменение поля title_ru
		--изменить тип колонки
			ALTER TABLE _countries ALTER COLUMN title_ru SET DATA TYPE VARCHAR(150);

		--сделать NOT NULL
			ALTER TABLE _countries ALTER COLUMN title_ru SET NOT NULL;

		--переименовать колонку
			ALTER TABLE _countries RENAME COLUMN title_ru TO title;
			
		--индекс 		
			create index idx_countries_title on _countries (title);

	--изменение поля coutry_id
		--переименование и NOT NULL
			ALTER TABLE _countries RENAME COLUMN country_id to id;			

		--Для Postgres, что бы сделать автоинкремент пришлось поискать в интернете
			CREATE SEQUENCE _countries_seq;
			ALTER TABLE _countries ALTER COLUMN id SET DEFAULT nextval('_countries_seq');
			ALTER TABLE _countries ALTER COLUMN id SET NOT NULL;
			ALTER SEQUENCE _countries_seq OWNED BY _countries.id;
			SELECT setval('_countries_seq', (SELECT max(id) FROM _countries));

		-- PRIMARY KEY;
			alter table _countries add primary key (id);

		

--Таблица _regions
	--удаление лишнего
		ALTER TABLE _regions 
			DROP COLUMN title_en,
			DROP COLUMN title_ua,
			DROP COLUMN title_be,
			DROP COLUMN title_es,
			DROP COLUMN title_pt,
			DROP COLUMN title_de,
			DROP COLUMN title_fr,
			DROP COLUMN title_it,
			DROP COLUMN title_pl,
			DROP COLUMN title_ja,
			DROP COLUMN title_lt,
			DROP COLUMN title_lv,
			DROP COLUMN title_cz;
			
	--Поле region_id	
		--переименование
			ALTER TABLE _regions RENAME COLUMN region_id to id;			

		--Для Postgres, что бы сделать автоинкремент пришлось поискать в интернете
			CREATE SEQUENCE _regions_seq;
			ALTER TABLE _regions ALTER COLUMN id SET DEFAULT nextval('_regions_seq');
			ALTER TABLE _regions ALTER COLUMN id SET NOT NULL;
			ALTER SEQUENCE _regions_seq OWNED BY _regions.id;
			SELECT setval('_regions_seq', (SELECT max(id) FROM _regions));

		-- PRIMARY KEY;
			alter table _regions add primary key (id);


	--Поле title_ru
		--переименовать колонку
			ALTER TABLE _regions RENAME COLUMN title_ru TO title;
			
		--изменить тип колонки
			ALTER TABLE _regions ALTER COLUMN title SET DATA TYPE VARCHAR(150);

		--сделать NOT NULL
			ALTER TABLE _regions ALTER COLUMN title SET NOT NULL;		
			
		--индекс 		
			create index idx_regions_title on _regions (title);
			
			
	--Поле country_id			
		--NOT NULL						
			ALTER TABLE _regions ALTER COLUMN country_id SET NOT NULL;
			
		-- FOREIGN KEY;
			alter table _regions add foreign key (country_id) references _countries (id);
			
			
			
			
			
--Таблица _cities
	--удаление лишнего
		ALTER TABLE _cities 
			DROP COLUMN title_en,
			DROP COLUMN title_ua,
			DROP COLUMN title_be,
			DROP COLUMN title_es,
			DROP COLUMN title_pt,
			DROP COLUMN title_de,
			DROP COLUMN title_fr,
			DROP COLUMN title_it,
			DROP COLUMN title_pl,
			DROP COLUMN title_ja,
			DROP COLUMN title_lt,
			DROP COLUMN title_lv,
			DROP COLUMN title_cz;
			
		ALTER TABLE _cities 
			DROP COLUMN area_ru,
			DROP COLUMN area_en,
			DROP COLUMN area_ua,
			DROP COLUMN area_be,
			DROP COLUMN area_es,
			DROP COLUMN area_pt,
			DROP COLUMN area_de,
			DROP COLUMN area_fr,
			DROP COLUMN area_it,
			DROP COLUMN area_pl,
			DROP COLUMN area_ja,
			DROP COLUMN area_lt,
			DROP COLUMN area_lv,
			DROP COLUMN area_cz;
								
		ALTER TABLE _cities 
			DROP COLUMN region_ru,
			DROP COLUMN region_en,
			DROP COLUMN region_ua,
			DROP COLUMN region_be,
			DROP COLUMN region_es,
			DROP COLUMN region_pt,
			DROP COLUMN region_de,
			DROP COLUMN region_fr,
			DROP COLUMN region_it,
			DROP COLUMN region_pl,
			DROP COLUMN region_ja,
			DROP COLUMN region_lt,
			DROP COLUMN region_lv,
			DROP COLUMN region_cz;
			
			
	--Поле city_id	
		--переименование
			ALTER TABLE _cities RENAME COLUMN city_id to id;			

		--Для Postgres, что бы сделать автоинкремент пришлось поискать в интернете
			CREATE SEQUENCE _cities_seq;
			ALTER TABLE _cities ALTER COLUMN id SET DEFAULT nextval('_cities_seq');
			ALTER TABLE _cities ALTER COLUMN id SET NOT NULL;
			ALTER SEQUENCE _cities_seq OWNED BY _cities.id;
			SELECT setval('_cities_seq', (SELECT max(id) FROM _cities));

		-- PRIMARY KEY;
			alter table _cities add primary key (id);


	--Поле title_ru
		--переименовать колонку
			ALTER TABLE _cities RENAME COLUMN title_ru TO title;
			
		--изменить тип колонки
			ALTER TABLE _cities ALTER COLUMN title SET DATA TYPE VARCHAR(150);

		--сделать NOT NULL
			ALTER TABLE _cities ALTER COLUMN title SET NOT NULL;		
			
		--индекс 		
			create index idx_cities_title on _cities (title);
			
			
	--Поле country_id			
		--NOT NULL						
			ALTER TABLE _cities ALTER COLUMN country_id SET NOT NULL;
			
		-- FOREIGN KEY;
			alter table _cities add foreign key (country_id) references _countries (id);
			
	--Поле region_id											
		-- FOREIGN KEY;
			alter table _cities add foreign key (region_id) references _regions (id);

	