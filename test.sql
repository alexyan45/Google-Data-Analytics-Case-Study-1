CREATE TABLE cyclistic AS
SELECT*FROM 2022_06 UNION ALL  SELECT*FROM 2022_07 UNION ALL 
SELECT*FROM 2022_08 UNION ALL  SELECT*FROM 2022_09 UNION ALL 
SELECT*FROM 2022_10 UNION ALL  SELECT*FROM 2022_11 UNION ALL 
SELECT*FROM 2022_12 UNION ALL  SELECT*FROM 2023_01 UNION ALL 
SELECT*FROM 2023_02 UNION ALL  SELECT*FROM 2023_03 UNION ALL 
SELECT*FROM 2023_04 UNION ALL  SELECT*FROM 2023_05 
DROP TABLE cyclistic
SELECT*FROM cyclistic

--gets total number of rides
SELECT COUNT(*) as totalrows FROM cyclistic 

--gets total number of rides by rider type
SELECT member_casual, COUNT(*) as totalrows FROM cyclistic GROUP BY member_casual

--heatmap for casual riders
SELECT weekday, hour(STR_TO_DATE(started_at, '%h:%i:%s %p')) AS converted_time,
count(hour(STR_TO_DATE(started_at, '%h:%i:%s %p'))) as Number_of_rides
 from cyclistic where member_casual like 'casual' 
group by converted_time,weekday
order by weekday desc, converted_time asc
 
 --heatmap for members
SELECT weekday, hour(STR_TO_DATE(started_at, '%h:%i:%s %p')) AS converted_time,
count(hour(STR_TO_DATE(started_at, '%h:%i:%s %p'))) as Number_of_rides
 from cyclistic where member_casual like 'member' 
group by converted_time,weekday
order by weekday desc, converted_time asc

--gets average  ridelength (947 seconds for casual, 690 for member)
SELECT member_casual, AVG(time_to_sec(ridelength)) as avgtime from cyclistic 
group by member_casual

--gets average ridelength by day of the week
SELECT weekday, AVG(time_to_sec(ridelength)) as avgtime from cyclistic 
group by weekday order by avgtime desc

--gets average ridelength by day of the week for casuals
SELECT weekday, AVG(time_to_sec(ridelength)) as avgtime from cyclistic where member_casual like 'casual' 
group by weekday order by avgtime desc

--gets average ridelength by day of the week for members
SELECT weekday, AVG(time_to_sec(ridelength)) as avgtime from cyclistic where member_casual like 'member' 
group by weekday order by avgtime desc

--most popular rides by day of week
select weekday, count(ride_id) as count from cyclistic group by weekday order by count desc

--most popular rides by day of week for casuals
 (high/ sat fri thur sun wed tue mon/ low)
--do it for leisure
select weekday, count(ride_id) as count from cyclistic
 where member_casual like 'casual' 
group by weekday order by count desc

--most popular rides by day of week for members (high/ thur wed fri tue sat mon sun/ low)
--do it for transportation, use it more for work for transportation
select weekday, count(ride_id) as count from cyclistic where member_casual like 'member' 
group by weekday order by count desc

--bike types
select distinct rideable_type from cyclistic

--avg length of each type 
select member_casual, rideable_type, AVG(time_to_sec(ridelength)) as avgtime from cyclistic
group by member_casual, rideable_type
order by avgtime desc

--which bikes do members and casuals prefer?
 --electric bikes used most, but casuals especially use it more than classics
select member_casual, rideable_type, count(*) as count from cyclistic
group by member_casual, rideable_type
order by member_casual desc, count desc

--strategy = allocate more docked bike stations near touristy areas

-- 0-5 min number of riders for each type
SELECT member_casual, COUNT(*) AS ride_count
FROM cyclistic
WHERE time_to_sec(ridelength) < 300 
group by member_casual

---5-15 min of riders for each type
SELECT member_casual, COUNT(*) AS ride_count
FROM cyclistic
WHERE time_to_sec(ridelength) > 300 and time_to_sec(ridelength) < 900
group by member_casual

--15-30 min of riders for each type
SELECT member_casual, COUNT(*) AS ride_count
FROM cyclistic
WHERE time_to_sec(ridelength) > 900 and time_to_sec(ridelength) < 1800
group by member_casual

--30+ min of riders for each type 
--since casual riders like riding so long, introduce a discount rate after riding for so long
--introduce first three graphs and talk about how both types are equal, then casual surpasses annual  
SELECT member_casual, COUNT(*) AS ride_count
FROM cyclistic
WHERE time_to_sec(ridelength) > 1800  
group by member_casual

--average coordinates of riders in general
SELECT AVG(start_lat) AS avg_lat, AVG(start_lng) AS avg_lng FROM cyclistic
SELECT STDDEV(start_lat) FROM cyclistic

--average coordinates of casual riders
SELECT AVG(start_lat) AS avg_lat, AVG(start_lng) AS avg_lng FROM cyclistic
WHERE member_casual LIKE 'casual'


--average coordinates of member riders
SELECT AVG(start_lat) AS avg_lat, AVG(start_lng) AS avg_lng FROM cyclistic
WHERE member_casual LIKE 'member'
SELECT STDDEV(start_lat) FROM cyclistic WHERE member_casual LIKE 'member'

--tableau density map of casual startpoints
SELECT start_lat, start_lng FROM cyclistic
WHERE member_casual LIKE 'casual'
ORDER BY RAND()
LIMIT 600

--tableau density map of member startpoints
SELECT start_lat, start_lng FROM cyclistic
WHERE member_casual LIKE 'member'
ORDER BY RAND()
LIMIT 600

--tableau density map of casual destinations
SELECT end_lat, end_lng FROM cyclistic
WHERE member_casual LIKE 'casual'
ORDER BY RAND()
LIMIT 600

--tableau density map of member destinations
SELECT end_lat, end_lng FROM cyclistic
WHERE member_casual LIKE 'member'
ORDER BY RAND()
LIMIT 600

---creates casual average ride length by month
CREATE TABLE casualavgridelength_month  AS
SELECT AVG(time_to_sec(ridelength)) FROM 2022_06 
WHERE member_casual LIKE 'casual'
UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_07 
WHERE member_casual LIKE 'casual' 
UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_08
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_09 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_10
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_11
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_12 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_01 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_02 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_03 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_04 
WHERE member_casual LIKE 'casual' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_05 
WHERE member_casual LIKE 'casual' 
DROP TABLE casualavgridelength_month
SELECT*FROM casualavgridelength_month

---creates member average ride length by month
CREATE TABLE memberavgridelength_month AS
SELECT AVG(time_to_sec(ridelength)) FROM 2022_06 
WHERE member_casual LIKE 'member'
UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_07 
WHERE member_casual LIKE 'member' 
UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_08
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_09 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_10
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_11
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2022_12 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_01 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_02 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_03 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_04 
WHERE member_casual LIKE 'member' UNION ALL
SELECT AVG(time_to_sec(ridelength)) FROM 2023_05 
WHERE member_casual LIKE 'member' 
DROP TABLE memberavgridelength_month
SELECT*FROM memberavgridelength_month

