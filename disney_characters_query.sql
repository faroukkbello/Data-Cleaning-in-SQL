-- ######### These are the queries used to clean disney_characters table ######### --



-- Display all data in Disney Characters table
SELECT 
    *
FROM
    disney_characters;
    
    

-- #### 1. REMOVE INDEX COLUMN #### --

ALTER TABLE disney_characters
DROP COLUMN `index`;



-- #### 2. CHANGE REALEASE DATE COLUMN FROM TEXT TO DATE #### --

-- Convert TEXT value into DATE value using the STR_TO_DATE().
-- Then confirm if it works by using the YEAR(), MONTH() and DAY()
-- on the new column.
SELECT 
    A.date_value,
    YEAR(A.date_value),
    MONTH(A.date_value),
    DAY(A.date_value)
FROM
    (SELECT 
        *, STR_TO_DATE(`release`, '%d/%m/%Y') AS date_value
    FROM
        disney_characters) AS A;
	
-- Rename 'release_date' column to 'release'
ALTER TABLE disney_characters
RENAME COLUMN `release_date` TO `release`;

-- Create a new release_date column with DATE data type
ALTER TABLE disney_characters
ADD release_date DATE;

-- Poulate release_date column based on the data from release column
UPDATE disney_characters 
SET 
    release_date = STR_TO_DATE(`release`, '%d/%m/%Y');

-- Delete 'release' column from the table
ALTER TABLE disney_characters
DROP COLUMN `release`;



-- #### 3. POPULATE BLANK HERO COLUMN ENTRIES #### --

-- How many blank/empty string entries do we have?
SELECT 
    COUNT(hero)
FROM
    disney_characters
WHERE
    hero = '';
-- We have 4 empty string entries. The hero column is a column that
-- represents the hero from the particular movie and that hero will
-- be universally known so let's do a little look up and fill each
-- empty string
-- Display records with empty string in the hero column
SELECT 
    *
FROM
    disney_characters
WHERE
    hero = '';
-- Look up each movie based on the movie title and release date

-- Mickey Mouse is the hero in Fantasia movie. So let's populate that
-- hero field with Mickey Mouse.
UPDATE disney_characters 
SET 
    hero = 'Mickey Mouse'
WHERE
    movie_title = 'Fantasia'; -- Done

-- Donald Duck is the hero in Fantasia 2000 movie. So let's populate that
-- hero field with Donald Duck.
UPDATE disney_characters 
SET 
    hero = 'Donald Duck'
WHERE
    movie_title = 'Fantasia 2000'; -- Done
    
-- Pecos Bill is the hero in Melody Time movie. So let's populate that
-- hero field with Pecos Bill.
UPDATE disney_characters 
SET 
    hero = 'Pecos Bill'
WHERE
    movie_title = 'Melody Time';
    
-- Benny Goodman is the hero in Make Mine Music/ so let's populate
-- that hero field with Benny Goodman.
UPDATE disney_characters 
SET 
    hero = 'Benny Goodman'
WHERE
    movie_title = 'Make Mine Music';