CREATE TABLE pg4e_debug (
  id SERIAL,
  query VARCHAR(4096),
  result VARCHAR(4096),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(id)
);

SELECT query, result, created_at FROM pg4e_debug;

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

alter table pg4e_debug add neon263 INTEGER;

SELECT neon263 FROM pg4e_debug LIMIT 1;


SELECT distinct state FROM taxdata order by state LIMIT 5;

CREATE TABLE keyvalue ( 
  id SERIAL,
  key VARCHAR(128) UNIQUE,
  value VARCHAR(128) UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY(id)
);

create or replace function trigger_set_timestamp()
returns trigger as $$
begin
	NEW.updated_at = NOW();
	return NEW;
end; $$ language plpgsql;

create trigger set_timestamp
before update on keyvalue
for each row 
execute procedure trigger_set_timestamp();