DROP database if exists arcano;
create database arcano;
use arcano;

CREATE TABLE S (
    S_id VARCHAR(10) PRIMARY KEY,
    Snombre VARCHAR(50),
    Situacion INT,
    Ciudad VARCHAR(50)
);

CREATE TABLE P (
    P_id VARCHAR(10) PRIMARY KEY,
    Pnombre VARCHAR(50),
    Color VARCHAR(30),
    Peso FLOAT,
    Ciudad VARCHAR(50)
);

CREATE TABLE J (
    J_id VARCHAR(10) PRIMARY KEY,
    Jnombre VARCHAR(50),
    Ciudad VARCHAR(50)
);

CREATE TABLE SPJ (
    S_id VARCHAR(10),
    P_id VARCHAR(10),
    J_id VARCHAR(10),
    Cantidad INT,
    PRIMARY KEY (S_id, P_id, J_id),
    FOREIGN KEY (S_id) REFERENCES S(S_id),
    FOREIGN KEY (P_id) REFERENCES P(P_id),
    FOREIGN KEY (J_id) REFERENCES J(J_id)
);

