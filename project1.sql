select * from [Portfolio Project]..CovidDeaths$ order by 3,4

--Select data that we are going to be using
select location,date,total_cases,new_cases,total_deaths,population  from [Portfolio Project]..CovidDeaths$ order by 1,2

--Looking at Total Cases vs Total Deaths
--Some what percentage of population got covid
select location,date,total_cases,population,(total_cases/population)*100 as PercentageOfPopulation
from [Portfolio Project]..CovidDeaths$ 
order by 1,2

--Looking at countries with highest infection Rate 
select location,population, MAX(total_cases) as HighestInfectionCount , MAX((total_cases/population))*100 as PercentPopulationInfected
from [Portfolio Project]..CovidDeaths$ 
Group by location,population
order by PercentPopulationInfected desc;

--showing countries with highest death count per population 
select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeaths$
where continent is not null
Group by location
order by TotalDeathCount desc

select * from [Portfolio Project]..CovidDeaths$
where continent is not null
order by 3,4

--Let's Break things down by contient
select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeaths$
where continent is not null
Group by continent
order by TotalDeathCount desc

select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeaths$
where continent is null
Group by location
order by TotalDeathCount desc

--showing continents with the highest death count per population
select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [Portfolio Project]..CovidDeaths$
where continent is not null
Group by continent
order by TotalDeathCount desc

--Global numbers
select location, date, total_cases,total_deaths,
(total_deaths/total_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeaths$
where continent is not null
order by 1,2

select  date, SUM(new_cases)
from [Portfolio Project]..CovidDeaths$
where continent is not null
group by date
order by 1,2

select  date, SUM(new_cases), SUM(cast(new_deaths as int))
from [Portfolio Project]..CovidDeaths$
where continent is not null
group by date
order by 1,2

select  date, SUM(new_cases)as Total_cases, SUM(cast(new_deaths as int)) as  Total_deaths , SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeaths$
where continent is not null
group by date
order by 1,2

select  SUM(new_cases)as Total_cases, SUM(cast(new_deaths as int)) as  Total_deaths , SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from [Portfolio Project]..CovidDeaths$
where continent is not null
order by 1,2

select * from [Portfolio Project]..CovidVaccinations$ order by 3,4

--Looking at total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(convert(int,vac.new_vaccinations)) over(partition by dea.Location order by dea.location,dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population*100
from [Portfolio Project]..CovidDeaths$ dea
join [Portfolio Project]..CovidVaccinations$ vac
  on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
order by 1,2,3

--use cte
with PopvsVac(contient, location, date, population,new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(convert(int,vac.new_vaccinations)) over(partition by dea.Location order by dea.location,dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population*100
from [Portfolio Project]..CovidDeaths$ dea
join [Portfolio Project]..CovidVaccinations$ vac
  on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
)
select * ,(RollingPeopleVaccinated/population)*100 from  PopvsVac;

--Temp Table
Drop table if exists APercentPopulationVaccinated
create table APercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into APercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(convert(int,vac.new_vaccinations)) over(partition by dea.Location order by dea.location,dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population*100
from [Portfolio Project]..CovidDeaths$ dea
join [Portfolio Project]..CovidVaccinations$ vac
  on dea.location = vac.location
  and dea.date = vac.date
--where dea.continent is not null

select * ,(RollingPeopleVaccinated/population)*100 from APercentPopulationVaccinated;

--Creating view to store data for later visalization
create view PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(convert(int,vac.new_vaccinations)) over(partition by dea.Location order by dea.location,dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population*100
from [Portfolio Project]..CovidDeaths$ dea
join [Portfolio Project]..CovidVaccinations$ vac
  on dea.location = vac.location
  and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3

select * from PercentPopulationVaccinated