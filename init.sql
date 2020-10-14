-- library for managing predicate configuration and resolution.

drop schema if exists lib_random_name cascade;
create schema lib_random_name;
grant usage on schema lib_random_name to public;
set search_path = pg_catalog;

\ir ./random_name.sql


