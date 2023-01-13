--EJERCICIOS DEL 6 AL 11(INCLUIDOS)--

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



