-- Write a SQL Query to find the name of those movies where one or more actors acted in two or more movies.

SELECT
    movie_title
FROM movies m
INNER JOIN movies_cast mc
    ON m.movie_id = mc.movie_id
WHERE actor_id IN (
    SELECT
        actor_id
    FROM movies_cast
    GROUP BY actor_id
    HAVING COUNT(movie_id) >= 2
);