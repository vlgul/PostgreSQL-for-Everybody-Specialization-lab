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

select * from track_raw;

create table artist(
id SERIAL,
name varchar(128),
primary key(id)
);

insert into artist(name) select distinct artist from track_raw order by artist;

select * from artist;
create table tracktoartist(
track_id INTEGER references track(id) on delete cascade,
artist_id INTEGER references artist(id) on delete cascade
);
select * from track_raw;
alter table track_raw add artist_id INTEGER;
update TRACK_RAW set artist_id = (select id from artist where track_raw.artist = artist.name);

select * from artist;
select * from track;
select * from track_raw tr ;
alter table track_raw add track_id INTEGER;
update track_raw set track_id = (select id from track where track.title = track_raw.title);
select * from tracktoartist;
insert into tracktoartist(track_id) select track.id from track; 
select * from tracktoartist;
update tracktoartist set artist_id = (select artist_id from track_raw where tracktoartist.track_id = track_raw.track_id);