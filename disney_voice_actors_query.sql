-- ######### These are the queries used to clean disney_voice_actors table ######### --



-- Display all data in Disney Voice Actors table
SELECT 
    *
FROM
    disney.disney_voice_actors;
    
    
    
-- #### 1. REMOVE INDEX COLUMN #### --

ALTER TABLE disney_voice_actors
DROP COLUMN  `index`;