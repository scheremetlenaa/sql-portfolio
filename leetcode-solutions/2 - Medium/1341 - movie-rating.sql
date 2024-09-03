/* Write a solution to:

- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.

- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name. */

/* Write your T-SQL query statement below */

WITH results AS (
    SELECT
        TOP 1 u.name AS results
    FROM Users u
    INNER JOIN MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY u.name
    ORDER BY COUNT(movie_id) DESC, u.name

    UNION ALL

    SELECT
        TOP 1 title AS results
    FROM Movies m
    INNER JOIN MovieRating mr
        ON m.movie_id = mr.movie_id
        WHERE YEAR(created_at) = 2020 AND MONTH(created_at) = 2
    GROUP BY title
    ORDER BY AVG(rating * 1.00) DESC, title
)

SELECT * FROM results