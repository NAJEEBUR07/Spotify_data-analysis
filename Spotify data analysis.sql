-- ADVANCED SQL PROJECT -- Spotify Data Analysis
CREATE TABLE spotify (
    artist varchar(255),
	track varchar(255),
	album varchar(255),
	album_type varchar (50),
	Danceability float,
	energy float,
	loudness float,
	speechiness float,
	acousticness float,
	instrumentalness float,
	liveness float,
	valence float,
	tempo float,
	duration_min float,
	title varchar (255),
	channel varchar (255),
	views float,
	likes bigint,
	comments bigint,
	licensed boolean,
	official_video Boolean,
	stream BIGINT,
	energy_liveness float,
	most_played_on varchar(50));

-- EDA (Exploratory Data Analysis.....)
Select count (*) from spotify;
select count (Distinct artist) from spotify;
select count (distinct album) from spotify;
Select count (distinct album_type) from spotify;
Select  max(duration_min) from spotify;
select  min( duration_min) from spotify;
select * from spotify where duration_min = 0;
delete  from spotify where duration_min = 0;
select * from spotify where duration_min = 0;
select * from spotify limit 100;

-- Solved Queries for Spotify DataSet __
--Q.1) Retrieve the names of all tracks that have more than 1 billion streams...
Select * from spotify
where stream > 1000000000;

-- Q.2) List all the Albums along with their  respective artists ??
Select Distinct album,artist from spotify order by 1 ;

--Q.3)Get the Total Number of comments for tracks where licensed = true ..
Select Distinct  licensed from spotify ;
Select * from spotify where licensed = 'true'
select sum(comments) as total_comments from spotify where licensed = 'true'; 

--Q.4) Find all tracks that belong to the  album type single
Select * from spotify
where album_type like 'single'

--Q.5) Count the Total number  of tracks  by each artists....
select artist ,count(*) as total_no_songs from spotify
group by artist
order by 2 asc;

--Q.6) Calculate the  average danceability of tracks in each album ....
select album,
avg(danceability) as Avg_danceability from spotify
group by 1
order by 2 desc;

--Q.7)find the top 5 tracks with highest energy values !!!
Select * from spotify ;
Select track,Max(energy) from spotify 
group by 1
order by 2
desc limit 5;

--Q.8) List all the tracks along with their views and likes  official_video = true !!!
select track,
sum(views) as total_views,
sum(likes) as total_likes
from spotify where official_video = 'True'
group by 1
order by 2 
desc;


--Q.09)Retrieve  the track names that have been streamed on spotify more than youtube
select * from
(Select 
track,
coalesce(sum(case when most_played_on ='Youtube' then stream end),0)as streamed_on_youtube,
coalesce(sum(case when most_played_on ='spotify' then stream end),0)as streamed_on_spotify
from spotify
group by 1) as t1
where 
    streamed_on_spotify>streamed_on_youtube
	and
	streamed_on_youtube <> 0;

select * from spotify;

--Q.10) For Each album,Calculate the total view of all associated tracks
select 
    album,
    track,
    sum(views)
from spotify group by 1 ,2
order by 3 desc;

--Q.11) Find the top 3 views tracks for each  artists using window functions
with ranking_artist as
(select 
artist,
track,
Sum(views) as total_views, 
dense_rank()over (partition by artist order by sum(views)desc) as rank from spotify
group by 1 , 2
order by 1,3 desc)
select * from ranking_artist where rank = 3;

-- Q.12) Write a query to find tracks where the liveness score is above the average
select track,
artist,
liveness from spotify ---0.1963
where liveness > 0.1963;

-- Q.13)find tracks where the energy_liveness is greater than 1.2
select * from spotify;

select track,energy_liveness as enery_to_liveness from spotify where energy_liveness >1.2;

--Q.14)calculate the cumaltive sum of likes for tracks ordered by the number of views,using window functions
select * from spotify;
select 
track,
sum(likes) over (order by views) as cumulative_sum from spotify
order by sum(likes) over (order by views)desc;


































