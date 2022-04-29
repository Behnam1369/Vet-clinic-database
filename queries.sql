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


/*test deleting all records from the animal table*/

BEGIN TRANSACTION;

DELETE FROM animals; 

SELECT * FROM animals;

ROLLBACK TRANSACTION;

SELECT * FROM animals;


/*Update animals with negative weight*/

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01'; 
SAVEPOINT SP1; 

UPDATE animals SET weight_kg = -weight_kg;

ROLLBACK TO SP1; 

UPDATE animals SET weight_kg = -weight_kg where weight_kg < 0;

COMMIT TRANSACTION;


/*How many animals are there?*/

SELECT COUNT(*) AS COUNT_OF_ANIMALS FROM animals;


/*How many animals have never tried to escape?*/

SELECT COUNT(*) AS COUNT_OF_CALM_ANIMALS 
FROM animals
WHERE escape_attempts = 0;


/*What is the average weight of animals?*/

SELECT AVG(weight_kg) AS AVERAGE_WEIGHT 
FROM animals;


/*Who escapes the most, neutered or not neutered animals?*/

SELECT name 
FROM animals 
ORDER BY escape_attempts DESC
limit 1;


/*What animals belong to Melody Pond?*/

SELECT
	animals.name
FROM animals INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


/*List of all animals that are pokemon (their type is Pokemon).*/

SELECT
	animals.name
FROM animals INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


/*List all owners and their animals, remember to include those that don't own any animal.*/

SELECT 
	owners.full_name, STRING_AGG (animals.name, ',') as animals
FROM owners LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name;


/*How many animals are there per species?*/

SELECT
	species.name, COUNT(animals.name) AS qty
FROM animals INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;


/*List all Digimon owned by Jennifer Orwell.*/

SELECT
	animals.name
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon' ;


/*List all animals owned by Dean Winchester that haven't tried to escape.*/

SELECT
	animals.name
FROM animals INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;


/*Who owns the most animals?*/

SELECT
	owners.FULL_name
FROM animals INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name 
ORDER BY COUNT(animals.id) DESC
LIMIT 1;


/*Who was the last animal seen by William Tatcher?*/

SELECT animals.name 
FROM visits 
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC 
LIMIT 1;


/*How many different animals did Stephanie Mendez see?*/

SELECT COUNT(DISTINCT(animal_id)) as Qty_Different_Animals
FROM visits 
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';


/*List all vets and their specialties, including vets with no specialties.*/

SELECT vets.name, STRING_AGG(species.name, ',') as specializations
FROM vets 
LEFT JOIN specializations on vets.id = specializations.vet_id
LEFT JOIN species ON specializations.specie_id = species.id
GROUP BY vets.name;


/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/

SELECT DISTINCT(animals.name) AS Animal_name 
FROM animals 
INNER JOIN visits on animals.id = visits.animal_id
INNER JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';


/*What animal has the most visits to vets?*/

SELECT animals.name   
FROM animals 
INNER JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;


/*Who was Maisy Smith's first visit?*/

SELECT animals.name   
FROM vets 
INNER JOIN visits ON vets.id = visits.vet_id
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date
LIMIT 1;


/*Details for most recent visit: animal information, vet information, and date of visit.*/

SELECT 
	animals.*, vets.* , visit_date
FROM visits 
INNER JOIN animals ON animals.id = visits.animal_id 
INNER JOIN vets ON vets.id = visits.vet_id
ORDER BY visit_date DESC
LIMIT 1;


/*How many visits were with a vet that did not specialize in that animal's species?*/

SELECT COUNT(*) AS Qty
FROM visits 
INNER JOIN animals ON visits.animal_id = animals.id 
INNER JOIN vets ON visits.vet_id = vets.id
WHERE animals.species_id NOT IN (
	SELECT specie_id FROM specializations 
	WHERE vet_id = vets.id
);


/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/

SELECT species.name
FROM visits 
INNER JOIN vets on visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id 
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;
