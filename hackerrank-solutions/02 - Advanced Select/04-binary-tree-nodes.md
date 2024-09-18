# [Binary Tree Nodes](https://www.hackerrank.com/challenges/binary-search-tree-1/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

- Root: If node is root node.
- Leaf: If node is leaf node.
- Inner: If node is neither root nor leaf node.

## Datasets used

```BST``` Table:

| Column | Type    |
| ------ | ------- |
| N      | Integer |
| P      | Integer |

## Solutions

```sql
SELECT 
    N,
    CASE
        WHEN P IS NULL THEN 'Root' 
        WHEN N IN (SELECT P FROM BST) THEN 'Inner' 
        ELSE 'Leaf' 
    END AS value 
FROM BST
ORDER BY N;
```

## Result set

| N  | value |
| -- | ----- |
| 1  | Leaf  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Inner |
| 5  | Leaf  |
| 6  | Inner |
| 7  | Leaf  |
| 8  | Leaf  |
| 9  | Inner |
| 10 | Leaf  |
| 11 | Inner |
| 12 | Leaf  |
| 13 | Inner |
| 14 | Leaf  |
| 15 | Root  |