use adventure;


CREATE OR REPLACE VIEW Vista_Productos AS
SELECT 
    p.ProductID AS ID,
    p.Name AS Nombre,
    COALESCE(p.Color, 'N/A') AS Color, -- Manejo de valores NULL
    FORMAT(p.ListPrice, 2) AS Precio, -- Formato para precios
    c.Name AS Nombre_Categoria,
    s.Name AS Nombre_Subcategoria
FROM Product p
LEFT JOIN ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID -- LEFT JOIN para productos sin subcategoría
LEFT JOIN ProductCategory c ON s.ProductCategoryID = c.ProductCategoryID; -- LEFT JOIN para consistencia

-- Consultas de demostración mejoradas
-- Mostrar primeros 10 productos
SELECT * FROM Vista_Productos LIMIT 10;

-- Productos de una categoría específica con precio mayor a 100
SELECT * FROM Vista_Productos 
WHERE Nombre_Categoria = 'Bikes' AND Precio > 100
ORDER BY Precio DESC;

-- Resumen por color y categoría
SELECT Color, Nombre_Categoria, COUNT(*) as Cantidad, AVG(Precio) as Precio_Promedio
FROM Vista_Productos
GROUP BY Color, Nombre_Categoria
HAVING COUNT(*) > 5
ORDER BY Cantidad DESC;