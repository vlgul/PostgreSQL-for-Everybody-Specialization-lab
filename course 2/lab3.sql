DROP TABLE unesco_raw;
CREATE TABLE unesco_raw
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
    region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER);

   
select * from unesco_raw ur ;
CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

insert into category (name) select distinct category from unesco_raw order by category;

select * from category c ;

update unesco_raw set category_id = (select id from category where category.name = unesco_raw.category); 

create table state (
id SERIAL,
name VARCHAR(128) unique,
primary key(id)
);

insert into state(name) select distinct state from unesco_raw order by state;
select * from state;
update unesco_raw set state_id = (select id from state where state.name = unesco_raw.state);

create table region(
id SERIAL,
name VARCHAR(128) unique,
primary key(id)
);
insert into region(name) select distinct region from unesco_raw order by region;

update unesco_raw set region_id = (select id from region where region.name = unesco_raw.region);


select distinct iso from unesco_raw;
create table iso(
id SERIAL,
name VARCHAR(8) unique,
primary key(id)
);
insert into iso(name) select distinct iso from unesco_raw order by iso;
update unesco_raw set iso_id = (select id from iso where iso.name = unesco_raw.iso);


CREATE TABLE unesco
 (id SERIAL,name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category_id INTEGER, state_id INTEGER,
    region_id INTEGER, iso_id INTEGER, primary key(id));
  
insert into unesco(name, description, justification, year, longitude, latitude, area_hectares, category_id, state_id, region_id, iso_id) select name, description, justification, year, longitude, latitude, area_hectares, category_id, state_id, region_id, iso_id from unesco_raw; 



select * from unesco;