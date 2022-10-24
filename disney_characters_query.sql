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



-- #### 4. POPULATE BLANK VILLIAN COLUMN ENTRIES #### --

-- How many blank/empty string entries do we have?
SELECT 
    COUNT(villian)
FROM
    disney_characters
WHERE
    villian = '';
-- Let's do the same thing we did for hero column here as well.
SELECT 
    *
FROM
    disney_characters
WHERE
    villian = '';
    
-- Aconcagua is the villian in Saludos Amigos so let's populate
UPDATE disney_characters 
SET 
    villian = 'Aconcagua'
WHERE
    movie_title = 'Saludos Amigos';
    
-- The Toy Bull is an antagonist in Disney's 1945 animated feature
-- film The Three Caballeros. So let's populate.
UPDATE disney_characters 
SET 
    villian = 'The Toy Bull'
WHERE
    movie_title = 'The Three Caballeros';
    
-- Tetti-Tatti, is the main antagonist in the segment The Whale
-- Who Wanted to Sing at the Met from Disney's 8th full-length
-- animated feature film Make Mine Music.
UPDATE disney_characters 
SET 
    villian = 'Tetti-Tatti'
WHERE
    movie_title = 'Make Mine Music';
    
-- The Vultures are villains in the 1948 film, Melody Time.
-- They want to eat Widowmaker.
UPDATE disney_characters 
SET 
    villian = 'The Vultures'
WHERE
    movie_title = 'Melody Time';
    
-- Heff the Heffalump is a recurring villain in the movie, 
-- 'The Many Adventures of Winnie the Pooh'.
UPDATE disney_characters 
SET 
    villian = 'Heff the Heffalump'
WHERE
    movie_title = 'The Many Adventures of Winnie the Pooh';
    
-- The Firebird is the main antagonist of Disney's 38th
--  full-length animated feature film Fantasia 2000.
UPDATE disney_characters 
SET 
    villian = 'The Firebird'
WHERE
    movie_title = 'Fantasia 2000';
    
-- Heffalumps and Woozles are the overall main antagonists of
-- Disney's Winnie the Pooh franchise.
UPDATE disney_characters 
SET 
    villian = 'Heffalumps and Woozles'
WHERE
    movie_title = 'Winnie the Pooh';
    
-- Jacques von Hämsterviel, also simply known as Dr. Hämsterviel,
-- is the main antagonist of the Lilo & Stitch franchise.
UPDATE disney_characters 
SET 
    villian = 'Dr. Hämsterviel'
WHERE
    movie_title = 'Lilo & Stitch';
    
-- Dawn Bellwether is the main antagonist of Disney's 55th
-- full-length animated feature film Zootopia.
UPDATE disney_characters 
SET 
    villian = 'Dawn Bellwether'
WHERE
    movie_title = 'Zootopia';
    
-- Te Kā is the main antagonist of Disney's 56th full-length
-- animated feature film Moana.
UPDATE disney_characters 
SET 
    villian = 'Te Kā'
WHERE
    movie_title = 'Moana';



-- #### 4. POPULATE BLANK SONG COLUMN ENTRIES #### --

-- How many blank/empty string entries do we have?
SELECT 
    COUNT(song)
FROM
    disney_characters
WHERE
    song = '';
-- Let's do the same thing we did for hero column here as well.
SELECT 
    *
FROM
    disney_characters
WHERE
    song = '';
    
-- Fantasia: "Toccata and Fugue in D Minor" by Johann Sebastian Bach.
UPDATE disney_characters 
SET 
    song = 'Toccata and Fugue in D Minor'
WHERE
    movie_title = 'Fantasia';
    
-- The Three Caballeros: "The Three Caballeros".
UPDATE disney_characters 
SET 
    song = 'The Three Caballeros'
WHERE
    movie_title = 'The Three Caballeros';
    
-- Make Mine Music: "Make Mine Music".
UPDATE disney_characters 
SET 
    song = 'Make Mine Music'
WHERE
    movie_title = 'Make Mine Music';
    
-- Fun and Fancy Free: "Fun and Fancy Free".
UPDATE disney_characters 
SET 
    song = 'Fun and Fancy Free'
WHERE
    movie_title = 'Fun and Fancy Free';
    
-- The Black Cauldron: "The Black Cauldron"
UPDATE disney_characters 
SET 
    song = 'The Black Cauldron'
WHERE
    movie_title = 'The Black Cauldron';
    
-- Fantasia 2000: "Pomp and Circumstance" – Marches 1, 2, 3 and 4 by Edward Elgar.
UPDATE disney_characters 
SET 
    song = 'Pomp and Circumstance'
WHERE
    movie_title = 'Fantasia 2000';
    
-- Dinosaur: "The Egg Travels".
UPDATE disney_characters 
SET 
    song = 'The Egg Travels'
WHERE
    movie_title = 'Dinosaur';
    
-- Chicken Little: "One Little Slip".
UPDATE disney_characters 
SET 
    song = 'One Little Slip'
WHERE
    movie_title = 'Chicken Little';
    
-- Home on the Range: "Home on the Range"
UPDATE disney_characters 
SET 
    song = 'Home on the Range'
WHERE
    movie_title = 'Home on the Range';
    
-- The Rescuers Down Under: "Cody's Flight".
UPDATE disney_characters 
SET 
    song = 'Cody\'s Flight'
WHERE
    movie_title = 'The Rescuers Down Under';
    
# --- NOW WE CAN USE THIS TABLE FOR ANALYSIS --- #