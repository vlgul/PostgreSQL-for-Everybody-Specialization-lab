CREATE TABLE make (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE model (
  id SERIAL,
  name VARCHAR(128),
  make_id INTEGER REFERENCES make(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);

insert into make (name) values ('Mazda'), ('Suzuki');

select * from make;

insert into model (name, make_id) values ('3 5-Door 4WD', 1),
	('3 DI 4-Door', 1), ('3 DI 5-Door', 1),('SJ 410V 4WD', 2),('SJ410K P/U 4WD', 2);
	
select * from model;

SELECT make.name, model.name
    FROM model
    JOIN make ON model.make_id = make.id
    ORDER BY make.name LIMIT 5;