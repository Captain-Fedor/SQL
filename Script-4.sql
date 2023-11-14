

-- поправки домашнего задания


CREATE TABLE IF NOT EXISTS Artists (
	artist_id SERIAL PRIMARY KEY,
	artist_name VARCHAR UNIQUE
);

CREATE TABLE IF NOT EXISTS Genres (
	genre_id SERIAL PRIMARY KEY,
	genre_name VARCHAR UNIQUE
);

CREATE TABLE IF NOT EXISTS Albums (
	album_id SERIAL PRIMARY KEY,
	album_name VARCHAR UNIQUE,
	album_year DATE
);	
	
CREATE TABLE IF NOT EXISTS Songs (
	song_id SERIAL PRIMARY KEY,
	song_name VARCHAR UNIQUE,
	song_duration TIME,
	album_id INTEGER REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS Volumes (
	volume_id SERIAL PRIMARY KEY,
	volume_name VARCHAR,
	volume_year DATE
);	
	

CREATE TABLE IF NOT EXISTS ArtistsGenres (
	artist_id INTEGER REFERENCES Artists(artist_id),
	genre_id INTEGER REFERENCES Genres(genre_id),
	CONSTRAINT AG_key PRIMARY KEY (artist_id, genre_id)
);	
	
CREATE TABLE IF NOT EXISTS AlbumsArtists (
	artist_id INTEGER NOT NULL REFERENCES Artists(Artist_id),
	album_id INTEGER NOT NULL REFERENCES Albums(album_id),
	CONSTRAINT AA_key PRIMARY KEY (Artist_id, album_id)
);

	
CREATE TABLE IF NOT EXISTS VolumeSongs (
	Volume_id INTEGER NOT NULL REFERENCES Volumes(Volume_id),
	Song_id INTEGER NOT NULL REFERENCES Songs(Song_id),
	CONSTRAINT VS_key PRIMARY KEY (Volume_id, Song_id)
);



--TASK 1

INSERT INTO Artists (artist_name) VALUES ('Alfa'), ('Bravo F'), ('Charlie'), ('Delta'), ('Echo'), ('Fox'), ('Golf');
INSERT INTO Genres (genre_name) VALUES ('Pop'), ('Rock'), ('Classics'), ('Jazz'), ('Club');
INSERT INTO Albums (album_name, album_year) VALUES ('Power Up', '2020-01-01'), ('Rock of Bust', '2014-01-01'), ('Black Ice', '2008-01-01'), ('Stiff Upper Lip', '2000-01-01')
INSERT INTO Songs (song_name, song_duration, album_id) VALUES 
	('Thunderstruck', '00:03:35', '1'), 
	('My Highway to Hell', '00:04:15', '1'),
	('Back in Black', '00:02:54', '3'),  
	('TNT My', '00:03:24', '4'), 
	('MoneyTalks', '00:04:03', '4'), 
	('Realize', '00:02:59', '4');
INSERT INTO Volumes (volume_name, volume_year) VALUES
	('Volume 1', '2023-01-01'), 
	('Volume 2', '2023-01-01'), 
	('Volume 3', '2020-01-01'), 
	('Volume 4', '2019-01-01');

INSERT INTO AlbumsArtists (artist_id, album_id) VALUES
	(1,1), (1,2), (1,4), (2,1), (2,3), (3,3), (4,4), (4,3), (5,1), (5,2), (5,4), (6,3), (7,1);

INSERT INTO ArtistsGenres (artist_id, genre_id) VALUES
	(1,1), (1,2), (1,4), (2,1), (2,3), (3,5), (4,4), (4,3), (5,1), (5,5), (5,4), (6,3), (7,1);

INSERT INTO VolumeSongs (volume_id, song_id) VALUES
	(1,4), (1,5), (1,6), (2,4), (2,7), (2,5), (2,9), (3,8), (3,9), (3,5), (3,4), (4,8), (4,9), (4,7);

--TASK 2

SELECT song_name, song_duration FROM Songs
WHERE song_duration = (SELECT MAX(song_duration) FROM Songs);

SELECT song_name, song_duration FROM Songs
WHERE song_duration >= '00:03:30';

SELECT volume_name, date_part('YEAR', volume_year) AS year FROM Volumes
WHERE date_part('YEAR', volume_year) BETWEEN 2018 AND 2020;

SELECT artist_name FROM Artists
WHERE artist_name LIKE '% %';

SELECT song_name FROM Songs
WHERE song_name LIKE '%My%' OR song_name LIKE '%Мой%';

--TASK 3
SELECT genre_id, count(*) AS Artist_Count FROM ArtistsGenres
GROUP BY genre_id
ORDER BY genre_id;

--SELECT song_id, song_name, album_year, a.album_id  FROM Songs s
--LEFT JOIN Albums a ON s.album_id = a.album_id
--WHERE date_part('YEAR', album_year) BETWEEN 2019 AND 2020

SELECT COUNT(song_id) FROM Songs s
LEFT JOIN Albums a ON s.album_id = a.album_id
WHERE date_part('YEAR', album_year) BETWEEN 2019 AND 2020

SELECT album_id, date_trunc('second', SUM(song_duration)/COUNT(*)) AS avg_song_time FROM Songs
GROUP BY album_id 


SELECT a.artist_name FROM Artists a
FULL Join(
SELECT artist_name, aa.album_id, album_year FROM Artists a
JOIN AlbumsArtists aa ON a.artist_id = aa.artist_id
JOIN Albums ON aa.album_id = albums.album_id
WHERE date_part('year', album_year) = 2020) AS search ON a.artist_name = search.artist_name
WHERE album_year ISNULL 


SELECT DISTINCT(volume_name)  FROM volumes v 
JOIN volumesongs vs ON v.volume_id = vs.volume_id
JOIN Songs s ON vs.song_id = s.song_id
JOIN albumsartists a ON s.album_id = a.album_id
JOIN artists a2 ON a.artist_id = a2.artist_id 
WHERE a2.artist_name = 'Golf'










