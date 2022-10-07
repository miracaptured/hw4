CREATE SCHEMA hospital;

CREATE TABLE IF NOT EXISTS hospital.station_
(
	statnr_ NUMERIC(3,0) PRIMARY KEY,
	name_ VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS hospital.room_
(
	roomnr_ NUMERIC(3,0) PRIMARY KEY,
	statnr_ NUMERIC(3,0) NOT NULL REFERENCES hospital.station_ (statnr_),
	beds_ NUMERIC(3, 0) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS hospital.stationpersonell_
(
	persnr_ NUMERIC(4,0) PRIMARY KEY,
	name_ VARCHAR(40) NOT NULL,
	statnr_ NUMERIC(3,0) NOT NULL REFERENCES hospital.station_ (statnr_)
);

CREATE TABLE IF NOT EXISTS hospital.caregiver_
(
	persnr_ NUMERIC(4,0) NOT NULL UNIQUE REFERENCES hospital.stationpersonell_ (persnr_),
	qualification_ VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS hospital.doctor_
(
	persnr_ NUMERIC(4,0) NOT NULL UNIQUE REFERENCES hospital.stationpersonell_ (persnr_),
	area_ VARCHAR(40) NOT NULL,
	rank_ VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS hospital.patient_
(
	patientnr_ NUMERIC(4,0) PRIMARY KEY,
	name_ VARCHAR(40) NOT NULL,
	disease_ VARCHAR(40) NOT NULL,
	doctor_ NUMERIC(4,0) NOT NULL REFERENCES hospital.doctor_ (persnr_),
	roomnr_ NUMERIC(3,0) NOT NULL REFERENCES hospital.room_ (roomnr_)
);
	