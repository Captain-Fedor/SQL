

-- поправки домашнего задания


CREATE TABLE IF NOT EXISTS Artists (
	artist_id SERIAL PRIMARY KEY,
	artist_name TEXT
);

CREATE TABLE IF NOT EXISTS Genres (
	genre_id SERIAL PRIMARY KEY,
	genre_name TEXT
);

CREATE TABLE IF NOT EXISTS Albums (
	album_id SERIAL PRIMARY KEY,
	album_name TEXT,
	album_year DATE
);	
	
CREATE TABLE IF NOT EXISTS Songs (
	song_id SERIAL PRIMARY KEY,
	album_id INTEGER REFERENCES Albums(album_id)
	song_name TEXT,
	song_duration INTEGER
);

CREATE TABLE IF NOT EXISTS Volumes (
	volume_id SERIAL PRIMARY KEY,
	volume_name TEXT,
	volume_year DATE
);	
	

CREATE TABLE IF NOT EXISTS ArtistsGenres (
	artist_id INTEGER REFERENCES Artists(artist_id),
	genre_id INTEGER REFERENCES Genres(genre_id),
	CONSTRAINT AG_key PRIMARY KEY (artist_id, genre_id)
);	
	
CREATE TABLE IF NOT EXISTS AlbumsArtists (
	id SERIAL PRIMARY KEY,
	artist_id INTEGER NOT NULL REFERENCES Artists(Artist_id),
	album_id INTEGER NOT NULL REFERENCES Albums(album_id)
);

	
CREATE TABLE IF NOT EXISTS VolumeSongs (
	id SERIAL PRIMARY KEY,
	Volume_id INTEGER NOT NULL REFERENCES Volumes(Volume_id),
	Song_id INTEGER NOT NULL REFERENCES Songs(Song_id)
);

	