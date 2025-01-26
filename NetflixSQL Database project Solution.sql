-- Netflix project
DROP TABLE IF EXISTS Netflix;
CREATE TABLE Netflix 
(
     show_id       VARCHAR (6),
     typess	       VARCHAR (10),
     title         VARCHAR (150),
     Director      VARCHAR (208),
     castS         VARCHAR (1000),
     country       VARCHAR(150),
     date_added	   VARCHAR(50),
     release_year  INT,
     rating	       VARCHAR(10),
     duration      VARCHAR (15),
     listed_in     VARCHAR (100),
     description   VARCHAR (250)
);

Select * From Netflix;

Select Count (*) as total_content 
From Netflix;

 

--15 Business Problems

--1) Count the number of movies and TV Shows

SELECT 
        typess,
		Count (*) as total__contant 
		from Netflix
		Group by typess

--2) Find the most common rating of movies and TV shows 

SELECT
     typess,
	 rating
FROM
(
  SELECT
   typess,
    rating,
    COUNT(*),
     Rank() over(partition by typess order by count(*) Desc) as ranking
     from Netflix
    group by 1, 2
) as t1
WHERE  
ranking = 1
	 
--3) list all movies released in a specific year eg(2020)

SELECT * from netflix  
-- filter 2020
-- movies

SELECT * FROM Netflix 
WHERE
    typess = 'Movie'
	AND
	release_year = 2020

--4) five countries with the most content of netflix

SELECT
   UNNEST( STRING_TO_ARRAY(COUNTRY, ',')) AS NEW_COUNTRY,
   COUNT(SHOW_ID) AS TOTAL_COUNT
   FROM Netflix
   Group by 1
   order by 2 desc
   Limit 5 

--5) Identitfy the longest movie 

SELECT * from Netflix
     Where
      typess = 'Movie'
    And 
   duration = (SELECT MAX (duration) from Netflix )
   
--6) Find the content added in last 5 years 

SELECT 
       *,
	   FROM Netflix
	   WHERE
	   
	   To_Date(Date_added, 'Month DD, YYYY') >= current_date  - Interval '5 Years'

	   SELEC = Current_date - '5 Years'