CREATE SCHEMA trains;

CREATE TABLE IF NOT EXISTS trains.train_
(
	trainnr_ NUMERIC(5,0) PRIMARY KEY,
	length NUMERIC(2,0) NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS trains.city_
(
	name_ VARCHAR(40) PRIMARY KEY,
	region_ VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS trains.station_
(
	name_ VARCHAR(40) PRIMARY KEY,
	tracks_ NUMERIC(2,0) NOT NULL DEFAULT 2,
	city_ VARCHAR(40) NOT NULL REFERENCES trains.city_ (name_)
);

CREATE TABLE IF NOT EXISTS trains.checkpoint_
(
	trainnr_ NUMERIC(5,0) NOT NULL REFERENCES trains.train_ (trainnr_),
	departuretime_ TIMESTAMP NOT NULL,
	arrivaltime TIMESTAMP NOT NULL,
	station_ VARCHAR(40) NOT NULL REFERENCES trains.station_ (name_)
);