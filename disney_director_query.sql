-- ######### These are the queries used to clean disney_director table ######### --



-- Display all data in Disney Director table
SELECT 
    *
FROM
    disney.disney_director;
    


-- #### 1. Remove index column #### --

ALTER TABLE disney_director DROP COLUMN `index`;