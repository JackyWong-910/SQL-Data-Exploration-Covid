select count(*)
from portfolio_project.covidvaccinations
;

select count(*)
from portfolio_project.coviddeaths
;

select location, date, total_cases, new_cases, total_deaths,population
from portfolio_project.coviddeaths
order by 1
;

-- looking at total_cases vs total_deaths
select location, date, total_cases, total_deaths, round((total_deaths/total_cases)*100,2) as death_rate
from portfolio_project.coviddeaths
where  continent !='0' and
date like '%2021%'
order by 1, str_to_date(date, "%d/%m/%Y")
;

-- looking at total cases vs population
-- tell the population got covid
-- only one where-clause allowed
select location, population, max(total_cases) as highest_infection_rate,
 max((total_cases/population)*100) as covid_rate
from portfolio_project.coviddeaths
where continent !='0'
group by location, population
order by covid_rate desc
;

-- looking at countryies with highest infection rate compared to population
-- the records are tracked by date, need to use Group_by function'
#error message: every column need to be either in group_by or aggregate function
#population do not change but date change
select location, population,max(cast(total_cases as unsigned)) as highest_infection_count ,
max(total_cases/population)*100 as highest_covid_rate
from portfolio_project.coviddeaths
where continent != '0'
group by location, population
order by highest_covid_rate desc
;

-- showing countries with highest death count per population
select location, population, max(cast(total_deaths as unsigned)) as total_death_count
,max(total_deaths/population)*100 as highest_death_rate
from portfolio_project.coviddeaths
where continent !='0'
group by location, population
order by total_death_count desc
;

-- work as continent-wise

-- showing continent with highest death count
select continent, max(cast(total_deaths as unsigned)) as highest_continent_death_count
from portfolio_project.coviddeaths
where continent !='0'
group by continent
order by highest_continent_death_count desc
;

-- global numbers
-- showing the day with total new cases found
-- sum() would add up all the data in the column
-- cast() as signed can be positive or negative, unsigned = non-negative, decimal(10,2)
select  date,sum(new_cases) as total_new_cases_found, sum(cast(new_deaths as unsigned)) as total_new_death,
round(sum(cast(new_deaths as unsigned))/sum(new_cases) *100, 2) as death_percentage
from portfolio_project.coviddeaths
where continent !='0'
group by date
order by str_to_date(date,"%d/%m/%Y") desc
;


-- joinning two tables to see New Vaccinations per Day
-- use STR_TO_DATE in the ORDER BY so the rolling sum calculates in the correct time order
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as unsigned)) over (partition by dea.location order by str_to_date(dea.date, "%d/%m/%Y")) as rolling_vaccinations
from portfolio_project.coviddeaths as dea
join portfolio_project.covidvaccinations as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent !='0'
;

##Using a CTE to calculate Percentage of Population Vaccinated
With PopvsVac (continent, location, date, population, new_vaccinations, rolling_vaccinations)
as 
(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as unsigned)) 
over (partition by dea.location order by str_to_date(dea.date, "%d/%m/%Y")) as rolling_vaccinations
from portfolio_project.coviddeaths as dea
join portfolio_project.covidvaccinations as vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent !='0')
select *
, (rolling_vaccinations / population) * 100 AS percentage_vaccinated
from PopvsVac
order by location, str_to_date(date, "%d/%m/%Y") 









