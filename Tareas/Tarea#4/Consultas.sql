-- 1. Proveedor, Parte y Proyecto en diferentes ciudades
SELECT S_id, P_id, J_id
FROM SPJ
JOIN S USING(S_id)
JOIN P USING(P_id)
JOIN J USING(J_id)
WHERE S.Ciudad <> P.Ciudad AND P.Ciudad <> J.Ciudad AND S.Ciudad <> J.Ciudad;

-- 2. Partes con cantidad promedio > 320
SELECT P_id
FROM SPJ
GROUP BY P_id
HAVING AVG(Cantidad) > 320;

-- 3. Proyectos donde se suministra la parte P1 con promedio mayor a la cantidad máxima de cualquier parte en el proyecto J1
SELECT J_id
FROM SPJ
WHERE P_id = 'P1'
GROUP BY J_id
HAVING AVG(Cantidad) > (
    SELECT MAX(Cantidad)
    FROM SPJ
    WHERE J_id = 'J1'
);

-- 4. Partes (sin repetir) suministradas a proyectos en Londres (usando EXISTS)
SELECT DISTINCT P_id
FROM SPJ spj
WHERE EXISTS (
    SELECT 1
    FROM J
    WHERE J.J_id = spj.J_id AND Ciudad = 'Londres'
);

-- 5. Actualizar cantidad a 0 para partes enviadas por proveedores de Londres
UPDATE SPJ
SET Cantidad = 0
WHERE S_id IN (
    SELECT S_id FROM S WHERE Ciudad = 'Londres'
);

-- 6. Pares de proveedores co-situados
SELECT s1.S_id AS Proveedor1, s2.S_id AS Proveedor2
FROM S s1, S s2
WHERE s1.S_id < s2.S_id AND s1.Ciudad = s2.Ciudad;

-- 7. Proveedores que suministran la parte P3 (subconsulta)
SELECT Snombre
FROM S
WHERE S_id IN (
    SELECT S_id FROM SPJ WHERE P_id = 'P3'
);

-- 8. Proveedores que suministran al menos una parte roja (subconsulta)
SELECT Snombre
FROM S
WHERE S_id IN (
    SELECT S_id
    FROM SPJ
    WHERE P_id IN (
        SELECT P_id FROM P WHERE Color = 'Rojo'
    )
);

-- 9. Proveedores que suministran la parte P3 (usando EXISTS)
SELECT Snombre
FROM S
WHERE EXISTS (
    SELECT 1 FROM SPJ WHERE SPJ.S_id = S.S_id AND P_id = 'P3'
);

-- 10. Proveedores que suministran todas las partes (EXISTS con NOT EXISTS doble)
SELECT Snombre
FROM S s
WHERE NOT EXISTS (
    SELECT P_id FROM P
    WHERE NOT EXISTS (
        SELECT 1 FROM SPJ WHERE SPJ.S_id = s.S_id AND SPJ.P_id = P.P_id
    )
);

-- 11. Pares de partes que algún proveedor suministre ambas
SELECT sp1.P_id AS Parte1, sp2.P_id AS Parte2
FROM SPJ sp1
JOIN SPJ sp2 ON sp1.S_id = sp2.S_id AND sp1.P_id < sp2.P_id
GROUP BY sp1.S_id, Parte1, Parte2;

-- 12. Colores de partes suministradas por el proveedor S1 (subconsulta)
SELECT DISTINCT Color
FROM P
WHERE P_id IN (
    SELECT P_id FROM SPJ WHERE S_id = 'S1'
);
