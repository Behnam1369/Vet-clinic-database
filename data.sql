/* Populate database with sample data. */

INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Agumon',
             '2020-02-03',
             0,
             '1',
             10.23); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Gabumon',
             '2018-11-15',
             2,
             '1',
             8); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Pikachu',
             '2021-01-07',
             1,
             '0',
             15.04); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Devimon',
             '2017-05-12',
             5,
             '1',
             11); 

INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Charmander',
             '2020-02-08',
             0,
             '0',
             -11); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Plantmon',
             '2021-11-15',
             2,
             '1',
             -5.7); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Squirtle',
             '1993-04-02',
             3,
             '0',
             -12.13); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Angemon',
             '2005-06-12',
             1,
             '1',
             -45); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Boarmon',
             '2005-06-07',
             7,
             '1',
             20.4); 


INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (1
             'Blossom',
             '1998-10-13',
             3,
             '1',
             17); 
			 

INSERT INTO animals
            (
             NAME,
             date_of_birth,
             escape_attempts,
             neutered,
             weight_kg)
VALUES      (
             'Ditto',
             '2022-05-14',
             4,
             '1',
             22); 

/*Polpulate owners table*/

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);


/*Polpulate owners table*/

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');


/*Update species_id in the animals table*/

UPDATE animals 
	SET species_id = species.id
FROM species 
WHERE animals.name LIKE '%mon' AND species.name = 'Digimon';

UPDATE animals 
	SET species_id = species.id
FROM species 
WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';


/*Update owners_id in the animals table*/

UPDATE animals 
	SET owner_id = owners.id
FROM owners 
WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

UPDATE animals 
	SET owner_id = owners.id
FROM owners 
WHERE animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell';

UPDATE animals 
	SET owner_id = owners.id
FROM owners 
WHERE animals.name in ('Devimon', 'Plantmon') and owners.full_name = 'Bob';

UPDATE animals 
	SET owner_id = owners.id
FROM owners 
WHERE animals.name in ('Charmander', 'Squirtle', 'Blossom') and owners.full_name = 'Melody Pond';

UPDATE animals 
	SET owner_id = owners.id
FROM owners 
WHERE animals.name in ('Angemon', 'Boarmon') and owners.full_name = 'Dean Winchester';


/*Populate vets table*/

INSERT INTO vets (
	name,
	age,
	date_of_graduation
) VALUES (
	'William Tatcher', 
	45,
	'2000-04-23'
);

INSERT INTO vets (
	name,
	age,
	date_of_graduation
) VALUES (
	'Maisy Smith', 
	26,
	'2019-01-17'
);

INSERT INTO vets (
	name,
	age,
	date_of_graduation
) VALUES (
	'Stephanie Mendez', 
	64,
	'1981-05-04'
);

INSERT INTO vets (
	name,
	age,
	date_of_graduation
) VALUES (
	'Jack Harkness', 
	38,
	'2008-06-08'
);


/*Populate specializations table*/

INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'William Tatcher' AND species.name = 'Pokemon';

INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND species.name = 'Pokemon';

INSERT INTO specializations (specie_id, vet_id) 
SELECT species.id , vets.id
FROM species
INNER JOIN vets ON vets.name = 'Jack Harkness' AND species.name = 'Digimon';


/*Populate visits table*/

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-24'
FROM animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Agumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-06-22'
FROM animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Agumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-02-02'
FROM animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Gabumon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-01-05'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-03-08'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-14'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Pikachu';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-05-04'
FROM animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Devimon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-02-24'
FROM animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Charmander';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-12-21'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-08-10'
FROM animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-04-07'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Plantmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-09-29'
FROM animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Squirtle';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-10-03'
FROM animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Angemon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-11-04'
FROM animals
INNER JOIN vets ON vets.name = 'Jack Harkness' AND animals.name = 'Angemon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-01-24'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2019-05-15'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-02-27'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-08-03'
FROM animals
INNER JOIN vets ON vets.name = 'Maisy Smith' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2020-05-24'
FROM animals
INNER JOIN vets ON vets.name = 'Stephanie Mendez' AND animals.name = 'Boarmon';

INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT animals.id , vets.id , '2021-01-11'
FROM animals
INNER JOIN vets ON vets.name = 'William Tatcher' AND animals.name = 'Boarmon';
