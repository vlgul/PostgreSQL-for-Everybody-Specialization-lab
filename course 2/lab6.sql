create table bigtext(
content text
);

insert into bigtext(content) select x from generate_series(100000 , 199999) as x;
delete from bigtext;
create index idx on bigtext(content);
drop index idx;
explain select content from bigtext;
select content from bigtext;