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