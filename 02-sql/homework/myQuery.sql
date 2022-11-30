//Buscá todas las películas filmadas en el año que naciste.
SELECT * FROM movies WHERE year=2001;

//Cuantas películas hay en la DB que sean del año 1982?
SELECT COUNT(*) FROM movies WHERE year=1982;

//Buscá actores que tengan el substring stack en su apellido.
SELECT * FROM actors WHERE LOWER(last_name) LIKE '%stack%';

//Buscá los 10 nombres y apellidos más populares entre los actores. 
//Cuantos actores tienen cada uno de esos nombres y apellidos?
SELECT first_name, last_name, COUNT(*) AS total FROM actors
GROUP BY LOWER(last_name), LOWER(last_name) ORDER BY total DESC LIMIT 10;

//Listá el top 100 de actores más activos junto con el 
//número de roles que haya realizado.
SELECT act.first_name, act.last_name, COUNT(*) AS total FROM actors AS act
JOIN roles AS rol ON act.id = rol.actor_id GROUP BY act.id ORDER BY total DESC LIMIT 100;

//Cuantas películas tiene IMDB por género? Ordená la lista por el género menos popular.
SELECT genre, COUNT(*) AS total FROM movies_genres GROUP BY genre ORDER BY total;

//Listá el nombre y apellido de todos los actores que trabajaron en la película 
//"Braveheart" de 1995, ordená la lista alfabéticamente por apellido.

//Listá todos los directores que dirigieron una película de género 'Film-Noir' 
//en un año bisiesto (para reducir la complejidad, asumí que cualquier año divisible 
//por cuatro es bisiesto). Tu consulta debería devolver el nombre del director, el nombre 
//de la peli y el año. Todo ordenado por el nombre de la película.

//Listá todos los actores que hayan trabajado con Kevin Bacon en películas 
//de Drama (incluí el título de la peli). Excluí al señor Bacon de los resultados.
SELECT act.first_name, act.last_name, mov.name FROM actors AS act
JOIN roles AS rol ON act.id = rol.actor_id
JOIN movies AS mov ON rol.movie_id = mov.id
JOIN movies_genres AS movGen ON mov.id = movGen.movie_id
WHERE movGen.genre = 'Drama'
AND mov.id IN(
    SELECT mov.id
    FROM movies AS mov
    JOIN roles AS rol on mov.id = rol.movie_id
    JOIN actors AS act ON rol.actor_id = act.id
    WHERE act.first_name = 'Kevin' AND act.last_name = 'Bacon'
)
AND (act.first_name || act.last_name != 'KevinBacon')

//INDICES

//Qué actores actuaron en una película antes de 1900 y también 
//en una película después del 2000?
SELECT movies.year, COUNT(*) AS total
FROM movies
WHERE movies.id NOT IN (
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON actors.id = roles.actor_id
    WHERE actors.gender = 'M'
​
)
GROUP BY movies.year
ORDER BY movies.year DESC;

//Buscá actores que actuaron en cinco o más roles en la misma película después del año 1990. 
//Noten que los ROLES pueden tener duplicados ocasionales, sobre los cuales no estamos 
//interesados: queremos actores que hayan tenido cinco o más roles DISTINTOS 
//(DISTINCT cough cough) en la misma película. Escribí un query que retorne los nombres del 
//actor, el título de la película y el número de roles (siempre debería ser > 5).

//Para cada año, contá el número de películas en ese años que sólo tuvieron actrices femeninas.