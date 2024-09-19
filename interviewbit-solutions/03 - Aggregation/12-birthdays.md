# [Birthdays](https://www.interviewbit.com/problems/birthdays/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given one table ‘Students’ which consists of Id,Name and Birthdate of students. Write an SQL query to find for each date the number of students having their birthday on that day and their names (seperated by commas). Also the Dates should be ordered in ascending order.

## Datasets used

```Students``` Table:

| Field     | Type    |
| --------- | ------- |
| Id        | INT     |
| Name      | Varchar |
| BirthDate | DATE    |

## Solutions

```sql
SELECT
    GROUP_CONCAT(Name) AS Names
FROM Students
GROUP BY BirthDate
ORDER BY BirthDate;
```

## Result set

| **Names**                     |
| ----------------------------- |
| Sarette                       |
| Candy,Tarra                   |
| Adelle,Courtnay,Corina        |
| Pollyanna                     |
| Hope                          |
| Rivalee,Inga                  |
| Madelle,Dorene                |
| Grier,Vere,Joeann             |
| Florencia                     |
| Jany,Marti                    |
| Rosanne,Katleen,Clo           |
| Alleen                        |
| Karina,Lesly                  |
| Tobe                          |
| Misha                         |
| Alia,Clo                      |
| Leeanne,Deirdre,Merrie,Benita |
| Cristine,Kellen               |
| Roberta,Ginnie                |
| Hyacinthe,Shandie             |
| Cassondra                     |
| Linzy                         |
| Ebonee,Giustina,Grier         |
| Mathilda                      |
| Tybie                         |
| Merle,Mireielle               |
| Clo                           |
| Peri                          |
| Concettina                    |