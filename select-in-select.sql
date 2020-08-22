
-- List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2.Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

--List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent = ANY (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER by name;


-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population 
FROM world
WHERE population > (SELECT population FROM world WHERE name ='Canada') AND population < (SELECT population FROM world WHERE name ='Poland')

-- 
SELECT name, CONCAT(ROUND(100 *(population/(SELECT population FROM world WHERE name = 'Germany'))), '%') 
FROM world
WHERE continent = 'Europe'


--Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0);

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
