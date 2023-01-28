use steam

--1.Lista todas las columnas de la tabla.
select * from dbo.juegos
go

--2.Lista todos los diferentes géneros, eliminando duplicados.
select distinct(Genre) 
from dbo.juegos
order by genre asc
go

--3.Lista únicamente aquellos juegos que puedan ser jugados únicamente en Linux
select nombre
from dbo.juegos
where PlatformLinux='true'
go

--4.Lista todos los juegos de rol, ordenador por nota.
select nombre,Metacritic,genre
from dbo.juegos
where genre like '%RPG%'
order by Metacritic desc
go

--5.Lista todos aquellos juegos que puedan ser jugados en Español pero no en Frances
select nombre,SupportedLanguages
from dbo.juegos
where SupportedLanguages not like '%french%' and SupportedLanguages like '%spanish%'
go


--6. Lista el nombre del juego, su precio inicial, su precio final y la diferencia entre ambos en una nueva columna.--

--TODOS LOS JUEGOS--
select Nombre, PriceInitial,PriceFinal,(PriceInitial-PriceFinal) as PriceDifference from juegos;
--SÓLO LOS QUE TIENEN DIFERENTE PRECIO INICIAL Y FINAL, ORDENADOS POR NOMBRE--
select Nombre, PriceInitial,PriceFinal,(PriceInitial-PriceFinal) as PriceDifference from juegos
where (PriceInitial-PriceFinal) <> 0
order by Nombre;


--7. ¿Cuántos juegos hay del siglo pasado?--

select count(*) from juegos
where ReleaseDate between '1900' and '1999';

--8. Devuelve todos los juegos que terminen o en N o en O.--

select Nombre from juegos 
where Nombre like '%[NO]';

--9. Devuelve todos los juegos que empiecen por A y que se puedan jugar con mando.--

select Nombre, ControllerSupport from juegos
where Nombre like 'A%' and ControllerSupport = 'true';

--10. Devuelve todos aquellos juegos que estén entre el 2000 y el 2010 (incluidos).--

select Nombre, ReleaseDate from juegos
where ReleaseDate between '2000' and '2010'
order by ReleaseDate;

--11. Devuelve todos los juegos que sean de la saga Final Fantasy.--

Select Nombre from juegos
where Nombre like '%Final fantasy%';

--12. Devuelve todos los juegos que sean de deportes y haya trabajado más de 3 desarrolladores.
SELECT Nombre FROM juegos
WHERE Genre like '%sports%' and DeveloperCount > 3;

--13 ¿Cuántos juegos hay asociados a cada categoría?
Select Genre, count(distinct Nombre) as 'Numero de juegos' from juegos
group by Genre;

--14 ¿Cuántos juegos se han sacado en cada año?
select ReleaseDate, count(Nombre) as 'Numero de juegos'from juegos
group by ReleaseDate
order by ReleaseDate desc;

--15 En base a la consulta anterior, devuelve aquellos años en los que la media de puntuación esté entre un 6 y un 8.
SELECT ReleaseDate, AVG(Metacritic) as 'Valoracion media de la critica'
FROM juegos
GROUP BY ReleaseDate
HAVING AVG(Metacritic) BETWEEN 6 and 8

--16 ¿Cuál es la máxima, mínima y puntuación mínima por género?
SELECT Genre, MAX(Metacritic) as 'Puntuacion maxima', MIN(Metacritic) as 'Puntuacion minima', 
AVG(Metacritic) as 'Puntuacion media'
FROM juegos
GROUP BY Genre

--17 Usando TOP, devuelve el top 10 de juegos con mayor puntuación del 2012.
SELECT TOP 10 with ties Nombre, Metacritic
FROM juegos
WHERE ReleaseDate = '2012'
ORDER BY Metacritic DESC;

--18 Devuelve el top 10 de juegos más nuevos de género single player.
SELECT  top 10 Nombre, ReleaseDate, Metacritic,Genre
FROM juegos
where Category like '%Single Player%'
order by Metacritic desc,ReleaseDate desc; 


--19 Devuelve la media de nota de todos aquellos juegos que sean para mayores de 18 años.
SELECT AVG(Metacritic) as Media
FROM juegos
WHERE RequiredAge >='18';

--20 ¿Cuántos juegos hay asociados a cada tipo (mayor de 18, de 17…)?
SELECT RequiredAge, Count(Nombre) as 'Numero de juegos'
FROM juegos
GROUP BY RequiredAge
order by RequiredAge;

--21 Devuelve todos aquellos años en los que haya menos de 300 juegos.
SELECT ReleaseDate,COUNT(Nombre) as 'Numero de juegos'
FROM juegos
GROUP BY ReleaseDate
HAVING COUNT(Nombre) < 300
order by ReleaseDate desc;

--22 Devuelve todos los juegos que estén para Mac pero no para Windows.
SELECT Nombre
FROM juegos
WHERE PlatformMac = 'True' AND PlatformWindows = 'False';


--23 Devuelve todos los juegos donde su precio final sea mayor a su precio inicial.
SELECT Nombre
FROM juegos
WHERE PriceFinal > PriceInitial;


--24 Devuelve todos los juegos que no estén valorados en dólares.
SELECT Nombre, PriceCurrency
FROM juegos
WHERE PriceCurrency != 'USD';

--25 Devuelve todos los juegos que tengan una mayor nota que 0, pero que hayan suspendido.
SELECT Nombre, Metacritic
FROM juegos
WHERE Metacritic > 0 AND Metacritic < 50
order by metacritic;

--26 Devuelve el top 15 de juegos con mayor número de DLC.
SELECT TOP 15 Nombre, DLCCount
FROM juegos
ORDER BY DLCCount DESC;

--27 Devuelve la información de los juegos que sólo se puedan jugar en Inglés.
SELECT *
FROM juegos
WHERE SupportedLanguages = 'English';

--28 Devuelve el nombre(en minúscula) y la web (en mayúscula) de los juegos de acción o casuales.
SELECT LOWER(Nombre) as Nombre, UPPER(website) as website,Genre
FROM juegos
WHERE Genre = ' Actio' OR Genre = ' Casual'
order by Nombre;

--29 ¿Cuál es el juego indie con mayor nota?
SELECT top 1 with ties Metacritic, Nombre,Genre
FROM juegos
WHERE Genre like '%indie%'
order by Metacritic desc;

--30 ¿Y con menor nota?
SELECT top 1 with ties Metacritic, Nombre,Genre
FROM juegos
WHERE Genre like '%indie%'
order by Metacritic;--Decepcionante...

--31 Devuelve toda la información del juego con menor nota, siempre que sea mayor a cero.
SELECT top 1 with ties *
FROM juegos
WHERE Metacritic <> 0 
ORDER BY Metacritic;

--32 Devuelve aquellos juegos que tengan mayor nota que la media.
--Media:
select avg(Metacritic)as Media from juegos
SELECT nombre, Metacritic from juegos
WHERE Metacritic > (SELECT AVG(Metacritic) FROM juegos)
order by Metacritic desc;

--33 Devuelve el juego con mayor nota del año 2008.
SELECT top 1 Nombre,Metacritic, ReleaseDate
FROM juegos
WHERE ReleaseDate = '2008'
ORDER BY Metacritic DESC;

--34 Devuelve toda la información de los juegos que valgan más que la media.
select avg(PriceFinal)as Media from juegos
SELECT *
FROM juegos
WHERE PriceInitial > (SELECT AVG(PriceInitial) FROM juegos);

--35 Devuelve toda la información de los juegos de Linux que tengan el mayor número de logros (achivements)
SELECT *
FROM juegos
WHERE PlatformLinux = 'True'
ORDER BY AchievementCount DESC

