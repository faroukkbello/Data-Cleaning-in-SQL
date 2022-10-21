-- ######### These are the queries used to clean disney_voice_actors table ######### --



-- Display all data in Disney Voice Actors table
SELECT 
    *
FROM
    disney.disney_voice_actors;
    
    
    
-- #### 1. REMOVE INDEX COLUMN #### --

ALTER TABLE disney_voice_actors
DROP COLUMN  `index`;



-- #### 2. CHECK FOR DATA QUALITY ISSUES #### --

-- Start with the character column
SELECT DISTINCT
    `character`
FROM
    disney_voice_actors;
    
-- 922 Rows? Do we have duplicate entries?
-- Isolate the entries with characters appearing more than one
SELECT 
    dva.*
FROM
    disney_voice_actors dva
WHERE
    `character` IN (SELECT 
            Characters_More_Than_One.`character`
        FROM
            (SELECT 
                `character`, COUNT(`character`) AS character_count
            FROM
                disney_voice_actors
            GROUP BY `character`
            HAVING character_count > 1) AS Characters_More_Than_One)
ORDER BY `character`;
            
-- We can see that the voice actors differ for the same character per movie.
-- So let's do a disntinct count on the voice actors from the result set of
-- the query above. We should have 23 unique records.
SELECT DISTINCT
    COUNT(*)
FROM
    disney_voice_actors dva
WHERE
    `character` IN (SELECT 
            Characters_More_Than_One.`character`
        FROM
            (SELECT 
                `character`, COUNT(`character`) AS character_count
            FROM
                disney_voice_actors
            GROUP BY `character`
            HAVING character_count > 1) AS Characters_More_Than_One);
-- Perfect!
-- We have 23 Records. We will leave this column as it is because we'll
-- be performing our analysis on the character in a particular movie not
-- the voice actor in the movie.

-- On to the voice_actors column
SELECT DISTINCT
    voice_actor
FROM
    disney_voice_actors;
-- We have 655 distinct records with no empty string or blank data. This is
-- plausible as a character might be portrayed by the same voice_actor from another movie.

-- On to the movies column
SELECT DISTINCT
    movie
FROM
    disney_voice_actors
ORDER BY movie;
-- 139 Rows here only implies we have multiple characters in one movie.
-- This is also plausible hence we leave it as it is.

# --- NOW WE CAN USE THIS TABLE FOR ANALYSIS --- #