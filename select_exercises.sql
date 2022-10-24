SHOW DATABASES;

USE albums_db;

SELECT * FROM albums;
/*
6 columns in the 'albums' table; 31 artists
*/

SELECT DISTINCT id, artist
FROM albums;

/*
31 unique artists
*/

DESCRIBE albums;

/* 
id is the primary key
*/

SELECT release_date FROM albums;

/*
oldest release date is 1967; newest is 2011
*/

SELECT name, artist FROM albums WHERE artist = 'Pink Floyd';

/*
'The Dark Side of the Moon' 'The Wall'
*/

SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

/*
196
*/

SELECT genre FROM albums WHERE name = 'Nevermind';

/*
Grunge, Alternative rock
*/

SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;

/*
The Bodyguard; Jagged Little Pill; Come On Over; Falling into You; Let's Talk About Love; Dangerous; The Immaculate Collection; Titanic: Music from the Motion Picture; Metallica; Nevermind; Supernatural
*/

SELECT name, sales FROM albums WHERE sales < 20;

/*
Bad; Sgt. Pepper's Lonely Hearts Club Band; Dirty Dancing; Let's Talk About Love; Dangerous; The Immaculate Collection; Abbey Road; Born in the U.S.A.; Brothers in Arms; Titanic: Music from the Motion Picture; Nevermind; The Wall; Grease: The Origional Soundtrack from the Motion Picture
*/

SELECT name, genre FROM albums WHERE genre = 'rock';

/* 
Sgt. Pepper's Lonely Hearts Club Band; 1; Abbey Road; Born in the U.S.A.; Supernatural;
These results only include 'rock' and not 'Hard ...' or 'Progressive ...' because the query is looking specifically for 'rock and nothing else. So it will not return any results with other words in the 'genre' column.
*/