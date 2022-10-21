-- ######### These are the queries used to clean disney_director table ######### --



-- Display all data in Disney Director table
SELECT 
    *
FROM
    disney.disney_director;
    


-- #### 1. REMOVE INDEX COLUMN #### --

ALTER TABLE disney_director
DROP COLUMN `index`;



-- #### 2. RENAME NAME COLUMN TO MOVIE #### --

ALTER TABLE disney_director
RENAME COLUMN `name` TO movie;



-- #### 3. CHECK FOR DATA QUALITY ISSUES #### --

-- Start with the movie column
SELECT DISTINCT
    movie
FROM
    disney_director;
-- 56 Rows implies the movie records are unique values. This is what
-- we expect to see as the movies are unique to Disney

-- Then the director column
SELECT DISTINCT
    director
FROM
    disney_director;
-- 29 Row? We have duplicates in this column.
-- We won't be removing it because a director can be in charge of multiple
-- movies. What we can do is count the no of times each director entry shows
-- up then sum it to see if we'll get 56 rows like we did for movie column
SELECT 
    SUM(movie_count)
FROM
    (SELECT 
        director, COUNT(director) AS movie_count
    FROM
        disney_director
    GROUP BY director
    ORDER BY movie_count DESC) AS D;
-- We have 56 in our result set. Perfect!

# --- NOW WE CAN USE THIS TABLE FOR ANALYSIS --- #