
Use Population
Go

-- Retrieve the total population on January 1st for the year 2000?
select TPopulation1Jan from dbo.WPP2022_Demographic_Indicators_Medium where time = 2000;

-- Find the location with the highest population growth rate?
select top 1 location 
from dbo.WPP2022_Demographic_Indicators_Medium 
order by popgrowthrate desc;

-- Calculate the average crude birth rate (CBR) across all locations.
select avg(CBR) from dbo.WPP2022_Demographic_Indicators_Medium;

-- List the locations with a population density greater than 500 people per square kilometer?
select location from dbo.WPP2022_Demographic_Indicators_Medium where popdensity > 500;

-- Determine the median age of the population for the year 2010?
select medianagepop from dbo.WPP2022_Demographic_Indicators_Medium where time = 2010;

-- List the locations with a population density greater than 500 people per square kilometer?
select location from dbo.WPP2022_Demographic_Indicators_Medium where popdensity > 500;

-- Determine the median age of the population for the year 2010?
select medianagepop from dbo.WPP2022_Demographic_Indicators_Medium where time = 2010;

-- Calculate the average life expectancy at birth (LEx) for males and females for a given year?
select time, avg(lexmale) as avg_lex_male, avg(lexfemale) as avg_lex_female from dbo.WPP2022_Demographic_Indicators_Medium group by time;

--  Find the location with the highest infant mortality rate (IMR)?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium order by imr desc;

-- Determine the location with the highest net migration rate (CNMR)?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium order by cnmr desc;

-- Calculate the total number of deaths and births for each year?
select time, sum(deaths) as total_deaths, sum(births) as total_births from dbo.WPP2022_Demographic_Indicators_Medium group by time;

--  Find the top 5 locations with the highest life expectancy for females at age 80?
select top 5 location, le80female from dbo.WPP2022_Demographic_Indicators_Medium order by le80female desc;

-- Calculate the percentage change in population from 1950 to 2000 for a specific location?
select location, ((tpopulation1jan - tpopulation1july) / tpopulation1jan) * 100 as percentage_change from dbo.WPP2022_Demographic_Indicators_Medium 
where time in (1950, 2000);

-- Determine the location with the highest net migration rate (CNMR) in the year 2015?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium where time = 2015 order by cnmr desc;

-- Calculate the crude birth rate (CBR) per 1000 people for each location in the year 2010?
select location, cbr from dbo.WPP2022_Demographic_Indicators_Medium where time = 2010;

-- Find the location with the lowest median age of the population?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium order by medianagepop;

-- Identify the locations where the population density is below 50 people per square kilometer?
select location from dbo.WPP2022_Demographic_Indicators_Medium where popdensity < 50;

-- Calculate the average total fertility rate (TFR) for each location?
select location, avg(tfr) as average_tfr from dbo.WPP2022_Demographic_Indicators_Medium group by location;

-- Find the location with the highest net reproduction rate (NRR)?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium order by nrr desc;

-- Determine the location with the highest sex ratio at birth (SRB)?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium order by srb desc;

-- Calculate the average net migration rate (CNMR) for countries in the year 2020?
select avg(cnmr) as avg_cnmr from dbo.WPP2022_Demographic_Indicators_Medium where time = 2020 and loctypeid = 4;

-- Identify the location with the highest increase in population from July 1st to January 1st in the year 2000?
select top 1 location, tpopulation1jan - tpopulation1july as population_increase from dbo.WPP2022_Demographic_Indicators_Medium where time = 2000
order by population_increase desc;

--  Calculate the percentage change in crude death rate (CDR) for each location between the years 1990 and 2000?
select location, ((cdr_2000 - cdr_1990) / cdr_1990) * 100 as cdr_percentage_change from (select location, 
max(case when time = 1990 then cdr end) as cdr_1990, max(case when time = 2000 then cdr end) as cdr_2000 from dbo.WPP2022_Demographic_Indicators_Medium
where time IN (1990, 2000) group by location) cdr_changes;

-- Determine the location with the highest birth rate for mothers aged 15-19 (Births1519) in the year 2018?
select top 1 location from dbo.WPP2022_Demographic_Indicators_Medium where time = 2018 order by births1519 desc;

--  Find the location with the highest difference in the sex ratio at birth (SRB) in the year 2010?
with SexRatioDiff as (select top 1 location, abs(srb) as srb_diff from dbo.WPP2022_Demographic_Indicators_Medium where time = 2010)
select location from SexRatioDiff order by srb_diff desc;

-- Calculate the average life expectancy at age 65 (LE65) for each location?
select location, avg(le65) as avg_le65 from dbo.WPP2022_Demographic_Indicators_Medium group by location;

-- Calculate the average net migration rate (CNMR) for each decade from 1960 to 2020?
select floor(time / 10) * 10 as decade, avg(cnmr) as avg_cnmr from dbo.WPP2022_Demographic_Indicators_Medium
where time between 1960 and 2020 group by floor(time / 10) * 10;

-- Determine the location with the highest increase in population density from 2000 to 2010?
select top 1 location, popdensity_2010 - popdensity_2000 as popdensity_increase from (select location, 
max(case when time = 2000 then popdensity end) as popdensity_2000,
max(case when time = 2010 then popdensity end) as popdensity_2010 from dbo.WPP2022_Demographic_Indicators_Medium where time in (2000, 2010)
group by location) popdensity_changes order by popdensity_increase desc;