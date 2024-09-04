/* A sports team wants to see their record for the season, as well as how much they won or lost by for each game.

Given table scores , which holds the date, result, and score differential of each game, create a varchar column scoreline which contains the summary of the game represented in the following format: 

{Result} by {Score}, and write a query to retrieve this new data. */

ALTER TABLE scores
ADD Scoreline VARCHAR();

UPDATE scores
SET Scoreline = CONCAT(Result, ' by ', Differential);