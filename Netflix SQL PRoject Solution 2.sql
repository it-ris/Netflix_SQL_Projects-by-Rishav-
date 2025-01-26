SELECT * FROM public.netflix

--7)Find all the TV/Movies show by "Rajiv Chilaka"
SELECT  FROM Netflix
WHERE DIRECTOR ILIKE '%Rajiv Chilaka%'

--8) list all TV Shows with more then 5 seasons

SELECT  FROM netflix 
WHERE
typess = 'TV Shows'
AND
SPLIT_PART(DURATION, ' ', 1)::NUmERIC >5

--9) Count the number of content item in each genre

SELECT 
         UNNEST(STRING_TO_ARRAY(LISTED_IN, ',')) AS GENRE,
        COUNT(SHOW_ID) as TOTAL_CONTENT 
     FROM Netflix
   GROUP BY 1

--10 Find each year and average number of content released by India on Netflix return top 5 year with highest average content released 

SELECT 
  EXTRACT(YEAR FROM TO_DATE (DATE_ADDED, 'MONTH DD, YYYY'))as Year,
  COUNT(*) YEARLY_CONTENT,
  ROUND(
 COUNT(*)::Numeric/(SELECT COUNT(*) FROM NETFLIX WHERE COUNTRY = 'INDIA')::Numeric * 100
 ,2) as avg_content_per_year
 FROM NETFLIX
 WHERE country = 'India'
 GROUP BY 1

 11) List all movies that are docomentries

 SELECT * FROM Netflix
 WHERE
 LISTED_IN ILIKE '%Documentaries%'

 12) Find all content without a director 

  SELECT * FROM Netflix
 WHERE
 Director IS NULL

13) FInd How many movies actor 'Salman Khan' appeared in last 10 years 

SELECT * FROM NETFLIX
    WHERE
    CASTS ILIKE '%SALMAN KHAN%'
    AND
    RELEASE_YEAR > EXTRACT (YEAR FROM CURRENT_DATE)-10

	14) Find top 10 actors who appeared in the highest number of movies produced in india 

	SELECT 
	UNNEST (STRING_TO_ARRAY(CASTS, ',')) AS ACTORS,
	COUNT(*) AS TOTAL_CONTENT 
	FROM NETFLIX 
	 WHERE COUNTRY ILIKE '%India'
	 GROUP BY 1
	 ORDER BY 2 DESC
	 LIMIT 10

	 15) Categorize the content based on the keyword 'kills' and 'violence' in the descripttion field. 
	 lebel contain containing these keyword as 'bad and all other content 'good count how mnay items fall in each other category.

WITH NEW_TABLE 
AS(
	 SELECT
	 *,
	 CASE
	 WHEN 
	 Description ILIKE '%kill%'
	 or description ILIKE '%violence%'then 'bad content' 
	 else 'good content'
	 End category
	 From Netflix 
	 )
	 SELECT 
	 CATEGORY,
	 COUNT (*)  AS TOTAL_Content 
	 FROM NEW_TABLE
	 GROUP BY 1
	 