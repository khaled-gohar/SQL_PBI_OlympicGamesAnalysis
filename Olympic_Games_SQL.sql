SELECT *
FROM olympic_games og 	




--no dublicated row 
with row_num as (
	Select *,
		   (row_number() over (
		   partition by id ,"Name", age ,sex ,noc ,games 
		   order by id) -1 
		   ) as Duplicated 
	From olympic_games

)


SELECT og.id,
	   og."Name" AS "Competitor Name",
	   CASE WHEN og.sex = 'M' THEN 'Male' ELSE 'Female' END AS "Sex", 
	   og.age ,
	   CASE WHEN og.age < 18 THEN 'Under 18'
	        WHEN og.age BETWEEN 18 AND 25 THEN '18 - 25'
	        WHEN og.age BETWEEN 25 AND 30 THEN '25 - 30'
	        WHEN og.age > 30 THEN 'Over 30'
	   END AS "Age Grouping"
	   -- ,height AS "Height",weight AS "Weight"
	   ,
	   og.noc AS "Nation Code",
	  -- games ,
	   --POSITION (' ' IN games),LENGTH(games),
	   LEFT(og.games,POSITION (' ' IN og.games)-1) AS "Year",
	   RIGHT(og.games,LENGTH(og.games)-POSITION (' ' IN og.games)) AS "Season",og.city AS "City" ,og.sport AS "Sport",og."Event",
	   CASE WHEN og.medal = 'NA' THEN 'Not Registered' ELSE og.medal END AS "Medal"	--,Duplicated   
FROM row_num og 
WHERE RIGHT(og.games,LENGTH(og.games)-POSITION (' ' IN og.games)) = 'Summer' AND og.Duplicated = 0 
ORDER BY id 

