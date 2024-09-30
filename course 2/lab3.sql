DROP TABLE unesco_raw;
CREATE TABLE unesco_raw
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
    region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER);
--file csv
--https://www.pg4e.com/tools/sql/whc-sites-2018-small.csv?PHPSESSID=016e0716ca1b4c2d6e2381473e8f43b6%22

\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM 'whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;

   
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

SELECT unesco.name, year, category.name, state.name, region.name, iso.name
  FROM unesco
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
  ORDER BY iso.name, unesco.name
  LIMIT 3;