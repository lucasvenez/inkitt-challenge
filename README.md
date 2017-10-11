# Inkitt Challenge Solutions

## Task #1: Write an SQL query that sums up reading for horror readers by day.

- 1.1 How much did they read?
- 1.2 How many readers are there?
- 1.3 What country are the readers from?

The solution for each question is available in the file 
[task_01.sql](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_01.sql). 
The code was prepared for the MySQL Database Management System.

I noticed maybe there is an inconsistence into `Visit` or `Read` tables. 
Data into `Read.visitorId` or `Visit.visitorId` columns do not match each other.
Changing `Read.visitorId` by `Read.visitId` generated the expected output.

## Task #2: Write the same query in Python and possibly with Pandas or Numpy.

All solutions for this task are enabled at [`task_02.py`](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_02.py). 
I used `pandas` in all solution steps.

## Task #3: The Stories table contains a field called `Teaser`. How would you extract geographic location from this?

The solution for this task are enabled at [`task_03.r`](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_03.r).

For this task I imported the countries names and acronyms available [here](http://www.nationsonline.org/oneworld/country_code_list.htm) 
using a Javascript code available [here](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_03.countries.export.js) wrote 
by me. The output of the function `getCountriesNames` was embeeded into the R file 
[`task_03.countries.r`](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_03.countries.r).

I employed the [`Word2Vector`](https://github.com/bmschmidt/wordVectors) in order to estimate the distance between teaser nouns and 
country names. Results show a set of country names with its semilarity score to the teaser. 
This approach limits geographic location keeps to countries.

**Warning**: for executing the script [`task_03.r`](https://github.com/lucasvenez/inkitt-challenge/blob/master/task_03.r), it is required
to download the `Word2Vect` file available [here](https://drive.google.com/uc?id=0B7XkCwpI5KDYNlNUTTlSS21pQmM&export=download).




