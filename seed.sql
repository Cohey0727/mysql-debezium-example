create schema example;
use example;
create table movies
(
    id   int auto_increment,
    name varchar(64) null,
    constraint example_pk
        primary key (id)
);

INSERT INTO movies (name) VALUES ('Titanic1');
INSERT INTO movies (name) VALUES ('Titanic2');
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
INSERT INTO movies (name) SELECT name FROM movies;
