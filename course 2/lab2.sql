CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE track (
    id SERIAL,
    title VARCHAR(128),
    len INTEGER, rating INTEGER, count INTEGER,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track_raw;
CREATE TABLE track_raw
 (title TEXT, artist TEXT, album TEXT,
  count INTEGER, rating INTEGER, len INTEGER);
  
alter table track_raw add album_id INTEGER;
select * from track_raw tr;

insert into album(title) select distinct album from track_raw order by album;

select * from album;

update track_raw set album_id = (select id from album where album.title= track_raw.album);
insert into TRACK (title, len, rating, count, album_id) select title, len, rating, count, album_id from track_raw;


select * from track t;