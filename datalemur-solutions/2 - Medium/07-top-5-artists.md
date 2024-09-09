# [Top 5 Artists [Spotify SQL Interview Question]](https://datalemur.com/questions/top-fans-rank)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume there are three Spotify tables: ```artists```, ```songs```, and ```global_song_rank```, which contain information about the artists, songs, and music charts, respectively.

Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the ```global_song_rank``` table. Display the top 5 artist names in ascending order, along with their song appearance ranking.

If two or more artists have the same number of song appearances, they should be assigned the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).

## Datasets used

```artists``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| artist_id	| integer |
| artist_name |	varchar |
| label_owner |	varchar |

```songs``` Table:

| Column Name | Type |
| ----------- | ---- |
| song_id |	integer |
| artist_id | 	integer |
| name |	varchar |

```global_song_rank``` Table:

| Column Name | Type |
| ----------- | ---- |
| day |	integer (1-52) |
| song_id |	integer |
| rank |	integer (1-1,000,000) |


## Solutions

```sql
SELECT
    artist_name,
    artist_rank
FROM (
    SELECT
        artist_name,
        DENSE_RANK() OVER(ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
    FROM global_song_rank
    INNER JOIN songs
        ON global_song_rank.song_id = songs.song_id
    INNER JOIN artists
        ON artists.artist_id = songs.artist_id
    WHERE rank <= 10
    GROUP BY artist_name
) t1
WHERE artist_rank <= 5;
```

## Result set

| artist_name | artist_rank |
| ----------- | ----------- |
| Taylor Swift |	1 |
| Bad Bunny |	2 |
| Drake |	2 |
| Ed Sheeran |	3 |
| Adele |	3 |
| Lady Gaga |	4 |
| Katy Perry |	5 |