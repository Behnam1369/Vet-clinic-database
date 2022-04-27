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

