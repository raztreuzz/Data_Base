INSERT INTO S (S_id, Snombre, Situacion, Ciudad) VALUES
('S1', 'Proveedor Alfa', 30, 'Madrid'),
('S2', 'Proveedor Beta', 20, 'Londres'),
('S3', 'Proveedor Gamma', 10, 'París'),
('S4', 'Proveedor Delta', 40, 'Londres'),
('S5', 'Proveedor Épsilon', 15, 'Roma'),
('S6', 'Proveedor Zeta', 25, 'Madrid'),
('S7', 'Proveedor Eta', 50, 'Berlín'),
('S8', 'Proveedor Theta', 35, 'Tokio'),
('S9', 'Proveedor Iota', 45, 'México'),
('S10', 'Proveedor Kappa', 12, 'Buenos Aires');

INSERT INTO P (P_id, Pnombre, Color, Peso, Ciudad) VALUES
('P1', 'Tornillo M12', 'Rojo', 12.5, 'Madrid'),
('P2', 'Tuerca M12', 'Azul', 5.2, 'Londres'),
('P3', 'Eje central', 'Rojo', 15.0, 'París'),
('P4', 'Placa base', 'Verde', 8.3, 'Roma'),
('P5', 'Motor AC', 'Negro', 22.0, 'Berlín'),
('P6', 'Cableado', 'Amarillo', 3.5, 'Tokio'),
('P7', 'Disipador', 'Rojo', 7.1, 'Madrid'),
('P8', 'Carcasa', 'Gris', 9.9, 'Buenos Aires'),
('P9', 'Ventilador', 'Blanco', 4.7, 'México'),
('P10', 'Sensor térmico', 'Negro', 1.8, 'Londres');

INSERT INTO J (J_id, Jnombre, Ciudad) VALUES
('J1', 'Proyecto Solar', 'Madrid'),
('J2', 'Proyecto Eólico', 'Londres'),
('J3', 'Proyecto Hidro', 'París'),
('J4', 'Proyecto Nuclear', 'Roma'),
('J5', 'Proyecto Geo', 'Berlín'),
('J6', 'Proyecto Aeroespacial', 'Tokio'),
('J7', 'Proyecto Robótica', 'México'),
('J8', 'Proyecto IA', 'Buenos Aires'),
('J9', 'Proyecto Vehículo', 'Londres'),
('J10', 'Proyecto Biotecnología', 'Madrid');

INSERT INTO SPJ (S_id, P_id, J_id, Cantidad) VALUES
('S1', 'P1', 'J1', 300),
('S2', 'P1', 'J2', 350),
('S3', 'P2', 'J3', 200),
('S4', 'P3', 'J4', 500),
('S5', 'P3', 'J1', 250),
('S6', 'P4', 'J5', 330),
('S7', 'P5', 'J6', 100),
('S8', 'P6', 'J7', 400),
('S9', 'P1', 'J8', 320),
('S10', 'P1', 'J9', 400),
('S2', 'P3', 'J2', 450),
('S4', 'P1', 'J10', 310),
('S1', 'P7', 'J1', 500),
('S2', 'P3', 'J1', 370),
('S3', 'P3', 'J1', 330);
