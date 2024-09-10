create table pg4e_debug(
id SERIAL,
query VARCHAR(4096),
result VARCHAR(4096),
created_at TIMESTAMP default CURRENT_TIMESTAMP,
primary key(id)
);


CREATE TABLE pg4e_result (
  id SERIAL,
  link_id INTEGER UNIQUE,
  score FLOAT,
  title VARCHAR(4096),
  note VARCHAR(4096),
  debug_log VARCHAR(8192),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);

create table ages(
name VARCHAR(128),
age INTEGER
);

DELETE FROM ages;
INSERT INTO ages (name, age) VALUES ('Basile', 40);
INSERT INTO ages (name, age) VALUES ('Gemma', 23);
INSERT INTO ages (name, age) VALUES ('Lexis', 36);
INSERT INTO ages (name, age) VALUES ('Mirren', 29);
INSERT INTO ages (name, age) VALUES ('Taliesin', 36);
INSERT INTO ages (name, age) VALUES ('Ziya', 16);

select * from AGES;
