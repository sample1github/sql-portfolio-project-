select * from [Portfolio Project].dbo.[seattle-weather]

--select data we are going to using
select date,precipitation,temp_max,temp_min,weather 
from [Portfolio Project].dbo.[seattle-weather]
order by weather

--showing Highest temperature in rain
select date,MAX(cast(temp_max as numeric)) as MaximumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='rain'
group by date,weather
order by weather

--showing lowest temperature in rain

select date,Min(cast(temp_min as numeric)) as MinimumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='rain'
group by date,weather
order by weather

--showing Highest wind of rain
select date,MAX(wind) as HighestWindRain, weather
from [Portfolio Project].dbo.[seattle-weather]
where weather='rain'
group by date,weather
order by HighestWindRain desc


--showing maximum temperature of weather
select date,MAX(temp_max)as MaximumTemperature,weather 
from [Portfolio Project].dbo.[seattle-weather]
where weather is not null
group by date,weather
order by weather

--showing minimum temperature of weather
select date,MIN(temp_min)as MinimumTemperature,weather 
from [Portfolio Project].dbo.[seattle-weather]
group by date,weather
order by weather

--showing precipitation of weather
select date,MAX(precipitation)as Precipitation,weather
from [Portfolio Project].dbo.[seattle-weather]
group by date,weather
order by Precipitation desc

--showing Temperature of weather [rain,fog,snow)
--this is maximum temperature of weather
select date,MAX(temp_max)as MaximumTemperature ,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather in('rain','fog','snow')
group by date,weather
order by weather
--this is minimum temperature of weather
select date,Min(temp_min)as MinimumTemperature ,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather in('rain','fog','snow')
group by date,weather
order by weather

--showing distinct weather
select COUNT(distinct(weather)) as DistinctWeather 
from [Portfolio Project].dbo.[seattle-weather]


--showing maximum temperature in fog
select date,MAX(cast(temp_max as numeric)) as MaximumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='fog'
group by date,weather
order by weather

--showing minimum temperature in fog
select date,MIN(cast(temp_min as numeric)) as MinimumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='fog'
group by date,weather
order by weather


--showing maximum temperature in sun
select date,MAX(cast(temp_max as numeric)) as MaximumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='sun'
group by date,weather
order by weather

--showing minimum temperature in fog
select date,MIN(cast(temp_min as numeric)) as MinimumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='sun'
group by date,weather
order by weather


--showing maximum temperature in drizzle
select date,MAX(cast(temp_max as numeric)) as MaximumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='drizzle'
group by date,weather
order by weather

--showing minimum temperature in drizzle
select date,MIN(cast(temp_min as numeric)) as MinimumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='drizzle'
group by date,weather
order by weather


--showing maximum temperature in snow
select date,MAX(cast(temp_max as numeric)) as MaximumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='snow'
group by date,weather
order by weather

select date,MIN(cast(temp_min as numeric)) as MinimumTemp,weather
from [Portfolio Project].dbo.[seattle-weather]
where weather ='snow'
group by date,weather
order by weather