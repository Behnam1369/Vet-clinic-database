/* Create vet clinic database */

 CREATE DATABASE vet_clinic;

/* Switch database to recently created database by running: \c vet_clinic; */

/* Create animals table */

CREATE TABLE animals (
	id int, 
	name varchar(100), 
	date_of_birth date, 
	escape_attempts int, 
	neutered bit, 
	weight_kg float
);


/*Add a column species of type string to your animals table. Modify your schema.sql file.*/

ALTER TABLE animals ADD species varchar(100);


/*Create owners table*/

CREATE TABLE owners (
	id int GENERATED ALWAYS AS IDENTITY,
	full_name varchar(250),
	age int,
	PRIMARY KEY (id) 
);


/*Create species table*/

CREATE TABLE species (
	id int GENERATED ALWAYS AS IDENTITY,
	name varchar(100),
	PRIMARY KEY (id)
);


/*Modify animals table*/

ALTER TABLE animals ADD PRIMARY KEY (id); 

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id int REFERENCES species (id);

ALTER TABLE animals ADD owner_id  int REFERENCES owners (id);


/*Create vets table*/

CREATE TABLE vets (
	id int GENERATED ALWAYS AS IDENTITY, 
	name varchar(100),
	age int,
	date_of_graduation date,
	PRIMARY KEY (id)
);


/*Create specializations table*/

CREATE TABLE specializations (
	specie_id int REFERENCES  species (id), 
	vet_id int REFERENCES  vets (id) 
);


/*Create visits table*/

CREATE TABLE visits (
	animal_id int REFERENCES  animals (id), 
	vet_id int REFERENCES  vets (id) ,
	visit_date date
);


/*Add email column to the owners table*/

ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


-- Query 1: SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX IF NOT EXISTS animal_id
    ON public.visits USING btree
    (animal_id ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.visits
    CLUSTER ON animal_id;

-- Query 2: SELECT * FROM visits where vet_id = 2;
CREATE INDEX IF NOT EXISTS vet_id_index
    ON public.visits USING btree
    (vet_id ASC NULLS LAST)
    INCLUDE(animal_id, visit_date)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.visits
    CLUSTER ON vet_id_index;


-- Query 3: SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX IF NOT EXISTS owner_index
    ON public.owners USING btree
    (email COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.owners
    CLUSTER ON owner_index;