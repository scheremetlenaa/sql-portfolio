-- Write a SQL Query to find the movie_title and name of director (first and last names combined) who directed a movie that casted a role as ‘SeanMaguire’.

SELECT
    CONCAT(director_first_name, director_last_name) AS director_name,
    movie_title
FROM movies m
INNER JOIN movies_directors md
    ON m.movie_id = md.movie_id
INNER JOIN directors d
    ON md.director_id = d.director_id
INNER JOIN movies_cast mc
    ON m.movie_id = mc.movie_id    
WHERE mc.role = 'SeanMaguire';