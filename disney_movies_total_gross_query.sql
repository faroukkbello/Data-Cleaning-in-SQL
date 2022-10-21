-- ######### These are the queries used to clean disney_characters table ######### --



-- Display all data in Disney Movies Total Gross table
SELECT 
    *
FROM
    disney_movies_total_gross;
    


-- #### 1. REMOVE INDEX COLUMN #### --

ALTER TABLE disney_movies_total_gross
DROP COLUMN `index`;



-- #### 2. CHANGE REALEASE DATE COLUMN FROM TEXT TO DATE #### --

-- Rename 'release_date' column to 'release'
ALTER TABLE disney_movies_total_gross
RENAME COLUMN `release_date` TO `release`;

-- Convert TEXT value into DATE value using the STR_TO_DATE().
-- Then confirm if it works by using the YEAR(), MONTH() and DAY()
-- on the new column.
SELECT 
	G.`release`,
    G.date_value,
    YEAR(G.date_value),
    MONTH(G.date_value),
    DAY(G.date_value)
FROM
    (SELECT 
        *, STR_TO_DATE(`release`, '%M %d, %Y') AS date_value
    FROM
        disney_movies_total_gross) AS G;

-- Create a new release_date column with DATE data type
ALTER TABLE disney_movies_total_gross
ADD release_date DATE;

-- Poulate release_date column based on the data from release column
UPDATE disney_movies_total_gross
SET 
    release_date = STR_TO_DATE(`release`, '%M %d, %Y');

-- Delete 'release' column from the table
ALTER TABLE disney_movies_total_gross
DROP COLUMN `release`;



-- #### 3. REMOVE 'MPAA_rating' COLUMN #### --
ALTER TABLE disney_movies_total_gross
DROP COLUMN MPAA_rating;



-- #### 4. REMOVE '$' and ',' FROM GROSS COLUMNS #### --

-- Get rid of '$' with the use of SUBSTRING()
SELECT 
    total_gross,
    inflation_adjusted_gross,
    SUBSTRING(total_gross,
        2,
        LENGTH(total_gross)) AS t_gross,
    SUBSTRING(inflation_adjusted_gross,
        2,
        LENGTH(inflation_adjusted_gross)) AS ia_gross
FROM
    disney_movies_total_gross;
    
-- Then update the data in our table
UPDATE disney_movies_total_gross 
SET 
    total_gross = SUBSTRING(total_gross,
        2,
        LENGTH(total_gross)),
    inflation_adjusted_gross = SUBSTRING(inflation_adjusted_gross,
        2,
        LENGTH(inflation_adjusted_gross));
        
-- Also remove ',' with REPLACE() in our data
UPDATE disney_movies_total_gross 
SET 
    total_gross = REPLACE(total_gross, ',', ''),
    inflation_adjusted_gross = REPLACE(inflation_adjusted_gross,
        ',',
        '');
        


-- #### 5. CHANGE GROSS COLUMNS TO INT DATA TYPE #### --

-- Rename 'total_gross' column to 't_gross' and
--  'inflation_adjusted_gross' column to 'ia_gross'
ALTER TABLE disney_movies_total_gross
RENAME COLUMN `total_gross` TO `t_gross`,
RENAME COLUMN `inflation_adjusted_gross` TO `ia_gross`;

-- Create a new 'total_gross' and 'inflation_adjusted_gross' column with INT data type
ALTER TABLE disney_movies_total_gross
ADD total_gross BIGINT,
ADD inflation_adjusted_gross BIGINT;

-- Populate 'total_gross' and 'inflation_adjusted_gross' with the integer values
-- of 't_gross' and 'ia_gross' respectively
UPDATE disney_movies_total_gross 
SET 
    total_gross = CAST(t_gross AS SIGNED),
    inflation_adjusted_gross = CAST(ia_gross AS SIGNED);
    
-- Perform mini calculation on the two columns to confirm the data type
SELECT 
    *, total_gross * 0.001, inflation_adjusted_gross * 0.001
FROM
    disney_movies_total_gross;
    
-- Then drop 't_gross' and 'ia_gross' columns as we don't need them anymore
ALTER TABLE disney_movies_total_gross
DROP COLUMN t_gross,
DROP COLUMN ia_gross;



-- #### 6. REMOVE RECORDS with 0 AS TOTAL GROSS & INFLATION ADJUSTED GROSS #### --

DELETE FROM disney_movies_total_gross 
WHERE
    total_gross = 0;
    


-- #### 7. DEAL WITH RECORDS EMPTY GENRE COLUMN #### --

-- Check how many records have blank genre column to see if we can
-- remove them if and only if they are less than 5% of the total
-- observation.
 SELECT 
    COUNT(dmtg.genre) AS Total_Genre,
    E.Empty_Genre,
    (E.Empty_Genre / COUNT(dmtg.genre)) * 100 AS Percentage_Of_Empty
FROM
    disney_movies_total_gross dmtg,
    (SELECT 
        COUNT(*) AS Empty_Genre
    FROM
        disney_movies_total_gross
    WHERE
        genre = '') AS E;

-- Records with Empty Genre are only 2.61% which is less than 5%,
-- so let's go ahead and remove them. They don't have a genre and
-- they will affect our model later on.
DELETE FROM disney_movies_total_gross 
WHERE
    genre = '';
    
-- Display our dataset
SELECT 
    *
FROM
    disney_movies_total_gross

# --- NOW WE CAN USE THIS TABLE FOR ANALYSIS --- #