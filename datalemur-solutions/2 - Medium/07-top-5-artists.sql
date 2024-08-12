-- Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. 
-- Display the top 5 artist names in ascending order, along with their song appearance ranking.

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