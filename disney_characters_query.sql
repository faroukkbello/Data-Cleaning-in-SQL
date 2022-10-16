-- ######### These are the queries used to clean disney_characters table ######### --



-- Display all data in Disney Characters table
SELECT 
    *
FROM
    disney_characters;
    
    

-- #### 1. Remove index column #### --

ALTER TABLE disney_characters DROP COLUMN `index`;



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
RENAME column `release_date` to `release`;

-- Create a new release_date column with DATE data type
ALTER TABLE disney_characters
ADD release_date DATE;

-- Poulate release_date column based on the data from release column
UPDATE disney_characters 
SET 
    release_date = STR_TO_DATE(`release`, '%d/%m/%Y');

-- Delete 'release' column from the table
ALTER TABLE disney_characters drop column `release`