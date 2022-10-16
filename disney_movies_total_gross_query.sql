-- ######### These are the queries used to clean disney_characters table ######### --



-- Display all data in Disney Movies Total Gross table
SELECT 
    *
FROM
    disney_movies_total_gross;
    


-- #### 1. Remove index column #### --

ALTER TABLE disney_movies_total_gross DROP COLUMN `index`;



-- #### 2. CHANGE REALEASE DATE COLUMN FROM TEXT TO DATE #### --

-- Rename 'release_date' column to 'release'
ALTER TABLE disney_movies_total_gross
RENAME column `release_date` to `release`;

-- Convert TEXT value into DATE value using the STR_TO_DATE().
-- Then confirm if it works by using the YEAR(), MONTH() and DAY()
-- on the new column.
SELECT 
	A.`release`,
    A.date_value,
    YEAR(A.date_value),
    MONTH(A.date_value),
    DAY(A.date_value)
FROM
    (SELECT 
        *, STR_TO_DATE(`release`, '%M %d, %Y') AS date_value
    FROM
        disney_movies_total_gross) AS A;

-- Create a new release_date column with DATE data type
ALTER TABLE disney_movies_total_gross
ADD release_date DATE;

-- Poulate release_date column based on the data from release column
UPDATE disney_movies_total_gross
SET 
    release_date = STR_TO_DATE(`release`, '%M %d, %Y');

-- Delete 'release' column from the table
ALTER TABLE disney_movies_total_gross drop column `release`