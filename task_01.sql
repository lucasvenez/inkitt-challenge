--
-- Creating structure and importing data
--
DROP DATABASE IF EXISTS INKITT_CHALLENGE;
CREATE DATABASE INKITT_CHALLENGE;

USE INKITT_CHALLENGE;

CREATE TABLE `Read` (
  isAppEvent   ENUM('True', 'False')  NULL,
  visitorId    CHAR(36) NULL,
  id           CHAR(36) NULL,
  visitId      CHAR(36) NULL,
  trackingTime DATETIME NULL,
  createdTime  DATETIME NULL,
  storyId      INT NULL,
  userId       INT NULL
);

CREATE TABLE `Visit` (
   visitorId        CHAR(36)     NULL,
   userId           CHAR(36)     NULL,
   country	        VARCHAR(100) NULL,
   timezone	        VARCHAR(100) NULL,
   locationAccuracy INT
);

CREATE TABLE `Story` (
  id          INT          NULL,
  userId      INT          NULL,
  teaser      TEXT         NULL,
  title       VARCHAR(150) NULL,
  cover       VARCHAR(100) NULL,
  categoryOne VARCHAR(50)  NULL,
  categoryTwo VARCHAR(50)  NULL
);

LOAD DATA LOCAL INFILE "/home/lucas/git/inkitt-challenge/data/stories.csv"
INTO TABLE Story
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "/home/lucas/git/inkitt-challenge/data/visits.csv"
INTO TABLE Visit
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE "/home/lucas/git/inkitt-challenge/data/reading.csv"
INTO TABLE `Read`
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Write an SQL query that sums up reading for horror readers by day:
-- Task 1.1 - How much did they read?
--
SELECT DATE(trackingTime) AS readDate, COUNT(*) AS readCount
FROM `Read` AS R INNER JOIN `Story` AS S ON(S.id = R.storyId)
WHERE LOWER(S.categoryOne) = 'horror' OR LOWER(S.categoryTwo) = 'horror'
GROUP BY readDate;

-- Write an SQL query that sums up reading for horror readers by day:
-- Task 1.2 - How many readers are there?
--
SELECT DATE(trackingTime) AS readDate, COUNT(DISTINCT R.visitorId) AS readersCount
FROM `Read` AS R INNER JOIN `Story` AS S ON(S.id = R.storyId)
WHERE LOWER(S.categoryOne) = 'horror' OR LOWER(S.categoryTwo) = 'horror'
GROUP BY readDate;

-- Write an SQL query that sums up reading for horror readers by day:
-- Task 1.3 - What country are the readers from?
--
-- WARNING! Maybe there is an inconsistence into Visit or Read tables. Data into
-- Read.visitorId or Visit.visitorId columns do not match each other.
-- Changing Read.visitorId by Read.visitId generated the expected output.
SELECT DATE(trackingTime) AS readDate,
       GROUP_CONCAT(DISTINCT V.country) AS countries,
       COUNT(DISTINCT V.country) AS countryCount
FROM `Visit` AS V INNER JOIN
     `Read`  AS R ON(V.visitorId = R.visitId) INNER JOIN
     `Story` AS S ON(S.id = R.storyId)
WHERE LOWER(S.categoryOne) = 'horror' OR LOWER(S.categoryTwo) = 'horror'
GROUP BY readDate;
