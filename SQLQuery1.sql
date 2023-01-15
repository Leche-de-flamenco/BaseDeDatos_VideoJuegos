use steam

--Lista todas las columnas de la tabla.
select * from dbo.juegos
go

--Lista todos los diferentes g�neros, eliminando duplicados.
select distinct(Genre) 
from dbo.juegos
order by genre asc
go

--Lista �nicamente aquellos juegos que puedan ser jugados �nicamente en Linux
select nombre
from dbo.juegos
where PlatformLinux='true'
go

--Lista todos los juegos de rol, ordenador por nota.
select nombre,Metacritic,genre
from dbo.juegos
where genre like '%RPG%'
order by Metacritic desc
go

--Lista todos aquellos juegos que puedan ser jugados en Espa�ol pero no en Frances
select nombre,SupportedLanguages
from dbo.juegos
where SupportedLanguages not like '%french%' and SupportedLanguages like '%spanish%'
go