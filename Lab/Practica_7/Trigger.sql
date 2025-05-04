use adventure;

DELIMITER //
CREATE TRIGGER Before_Insert_SalesOrderDetail
BEFORE INSERT ON SalesOrderDetail
FOR EACH ROW
BEGIN
    DECLARE product_price DECIMAL(10,2);
    DECLARE product_exists INT;
    
    IF NEW.SpecialOfferID = 1 THEN
        -- Verificar si el producto existe primero
        SELECT COUNT(*), ListPrice INTO product_exists, product_price
        FROM Product 
        WHERE ProductID = NEW.ProductID;
        
        IF product_exists = 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El ProductID no existe en la tabla Product';
        ELSE
            -- Asignar valores solo si el producto existe
            SET NEW.UnitPrice = product_price;
            SET NEW.UnitPriceDiscount = 0;
            SET NEW.LineTotal = NEW.OrderQty * product_price;
            
            -- Opcional: Registrar la operación en una tabla de logs
            INSERT INTO TriggerLogs (TriggerName, TableAffected, Action, RecordID, Timestamp)
            VALUES ('Before_Insert_SalesOrderDetail', 'SalesOrderDetail', 'INSERT', NEW.SalesOrderDetailID, NOW());
        END IF;
    END IF;
END;//
DELIMITER ;

-- Pruebas mejoradas del trigger
-- Caso 1: Producto con descuento (SpecialOfferID <> 1)
INSERT INTO SalesOrderDetail (SalesOrderID, ProductID, OrderQty, SpecialOfferID, UnitPrice, UnitPriceDiscount)
VALUES (101, 5, 2, 2, 50.00, 0.10);

-- Caso 2: Producto sin descuento (SpecialOfferID = 1) - el trigger debe actualizar los campos
INSERT INTO SalesOrderDetail (SalesOrderID, ProductID, OrderQty, SpecialOfferID)
VALUES (101, 5, 3, 1);

-- Caso 3: Producto inexistente - debería fallar
INSERT INTO SalesOrderDetail (SalesOrderID, ProductID, OrderQty, SpecialOfferID)
VALUES (101, 99999, 1, 1);

-- Verificación de resultados
SELECT * FROM SalesOrderDetail WHERE SalesOrderID = 101;