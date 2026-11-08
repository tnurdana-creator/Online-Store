
USE Online_store_db;

CREATE TABLE klient (
    id INT IDENTITY(1,1) PRIMARY KEY,
    aty VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefon VARCHAR(20)
);


CREATE TABLE tauar (
    id INT IDENTITY(1,1) PRIMARY KEY,
    atauy VARCHAR(150) NOT NULL,
    bagasy NUMERIC(10,2) NOT NULL CHECK (bagasy >= 0)
);


CREATE TABLE tapsyrys (
    id INT IDENTITY(1,1) PRIMARY KEY,
    martebesi VARCHAR(50) NOT NULL,
    zhalpy_soma NUMERIC(12,2) NOT NULL CHECK (zhalpy_soma >= 0),
    klient_id INT NOT NULL,
    FOREIGN KEY (klient_id) REFERENCES klient(id)
);


CREATE TABLE tolem (
    id INT IDENTITY(1,1) PRIMARY KEY,
    soma NUMERIC(12,2) NOT NULL CHECK (soma >= 0),
    martebesi VARCHAR(50) NOT NULL,
    tapsyrys_id INT NOT NULL,
    FOREIGN KEY (tapsyrys_id) REFERENCES tapsyrys(id)
);


CREATE TABLE zhetkizu (
    id INT IDENTITY(1,1) PRIMARY KEY,
    martebesi VARCHAR(50) NOT NULL,
    tapsyrys_id INT NOT NULL,
    FOREIGN KEY (tapsyrys_id) REFERENCES tapsyrys(id)
);


CREATE TABLE kuryer (
    id INT IDENTITY(1,1) PRIMARY KEY,
    aty VARCHAR(100) NOT NULL,
    telefon VARCHAR(20)
);


CREATE TABLE zhinaktau_nuktesi (
    id INT IDENTITY(1,1) PRIMARY KEY,
    mekenzhai VARCHAR(100)
);


CREATE TABLE qoima (
    id INT IDENTITY(1,1) PRIMARY KEY,
    mekenzhai VARCHAR(100)
);


CREATE TABLE qoima_qory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    qoima_id INT REFERENCES qoima(id),
    tauar_id INT REFERENCES tauar(id),
    sany INT
);


CREATE TABLE sebet (
    id INT IDENTITY(1,1) PRIMARY KEY,
    klient_id INT REFERENCES klient(id)
);


CREATE TABLE sebet_pozitsiyasy (
    id INT IDENTITY(1,1) PRIMARY KEY,
    sebet_id INT REFERENCES sebet(id),
    tauar_id INT REFERENCES tauar(id),
    sany INT
);


CREATE TABLE tapsyrys_pozitsiyasy (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tapsyrys_id INT REFERENCES tapsyrys(id),
    tauar_id INT REFERENCES tauar(id),
    sany INT,
    bagasy NUMERIC(10,2)
);


CREATE TABLE error_check (
    id INT IDENTITY(1,1) PRIMARY KEY,
    qate_turi VARCHAR(100),
    eskertu_matini VARCHAR(200),
    klient_rastady BIT,
    tapsyrys_id INT REFERENCES tapsyrys(id)
);


CREATE TABLE delivery_plan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    martebesi VARCHAR(50),
    tapsyrys_id INT REFERENCES tapsyrys(id)
);
