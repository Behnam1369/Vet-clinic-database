/*Find all animals whose name ends in "mon".*/

select * from animals 
WHERE name LIKE '%mon';


/*List the name of all animals born between 2016 and 2019.*/

select name from animals 
WHERE date_of_birth between '2016-01-01' and '2019-12-31';


/*List the name of all animals that are neutered and have less than 3 escape attempts.*/

select name from animals 
WHERE neutered = '1' and escape_attempts < 3;


/*List date of birth of all animals named either "Agumon" or "Pikachu".*/

select date_of_birth from animals 
WHERE name IN ( 'Agumon', 'Pikachu');


/*List name and escape attempts of animals that weigh more than 10.5kg*/

select name, escape_attempts from animals 
WHERE weight_kg > 10.5;


/*Find all animals that are neutered.*/

select * from animals 
WHERE neutered = '1';


/*Find all animals not named Gabumon.*/

select * from animals 
WHERE name <> 'Gabumon';


/*Find all animals with a weight between 10.4kg and 17.3kg*/

select * from animals 
WHERE weight_kg between 10.4 and 17.3;