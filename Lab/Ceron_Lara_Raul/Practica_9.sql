-- Función 1: fn_ejemplares_disponibles
DELIMITER //
CREATE FUNCTION fn_ejemplares_disponibles(isbn VARCHAR(50)) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_disponibles INT;
    
    SELECT COUNT(*) INTO total_disponibles
    FROM ejemplar
    WHERE ejemplar.isbn = isbn AND ejemplar.disponible = TRUE;
    
    RETURN total_disponibles;
END //
DELIMITER ;

-- Ejemplo de uso de fn_ejemplares_disponibles
SELECT fn_ejemplares_disponibles('978-0307474728') AS ejemplares_disponibles;

-- Función 2: fn_calcula_limite_tiempo
DELIMITER //
CREATE FUNCTION fn_calcula_limite_tiempo(isbn VARCHAR(50), dpi BIGINT) 
RETURNS DATE
BEGIN
    DECLARE total_ejemplares INT;
    DECLARE dias_prestamo INT;
    DECLARE media_retraso DECIMAL(10,2);
    DECLARE fecha_limite DATE;
    
    -- Obtener el total de ejemplares disponibles
    SELECT fn_ejemplares_disponibles(isbn) INTO total_ejemplares;
    
    -- Determinar días base según cantidad de ejemplares
    IF total_ejemplares <= 1 THEN
        RETURN NULL;
    ELSEIF total_ejemplares < 5 THEN
        SET dias_prestamo = 10;
    ELSE
        SET dias_prestamo = 15;
    END IF;
    
    -- Calcular media de retraso del usuario
    SELECT AVG(dias_atraso) INTO media_retraso
    FROM prestamo
    WHERE dpi_usuario = dpi AND dias_atraso > 0;
    
    -- Ajustar días si el usuario tiene historial de retrasos
    IF media_retraso > 2 THEN
        SET dias_prestamo = dias_prestamo - 5;
    END IF;
    
    -- Calcular fecha límite
    SET fecha_limite = DATE_ADD(CURRENT_DATE(), INTERVAL dias_prestamo DAY);
    
    RETURN fecha_limite;
END //
DELIMITER ;

-- Ejemplo de uso de fn_calcula_limite_tiempo
SELECT fn_calcula_limite_tiempo('978-8497592208', 1234567890101) AS fecha_limite;

-- Procedimiento 3: sp_registrar_devolucion
DELIMITER //
CREATE PROCEDURE sp_registrar_devolucion(
    IN usuario_dpi BIGINT,
    IN ejemplar_cod VARCHAR(50),
    IN fecha_prestamo DATETIME,
    OUT err BIT,
    OUT mensaje VARCHAR(255),
    OUT dias_atraso INT
)
BEGIN
    DECLARE prestamo_existe INT;
    DECLARE fecha_devolucion_actual DATETIME;
    DECLARE fecha_limite_devolucion DATETIME;
    
    -- Inicializar variables
    SET err = 0;
    SET dias_atraso = 0;
    SET fecha_devolucion_actual = CURRENT_TIMESTAMP();
    
    -- Verificar si el préstamo existe y no ha sido devuelto
    SELECT COUNT(*) INTO prestamo_existe
    FROM prestamo
    WHERE dpi_usuario = usuario_dpi 
      AND codigo_ejemplar = ejemplar_cod 
      AND fecha_prestamo = fecha_prestamo
      AND fecha_devolucion IS NULL;
    
    IF prestamo_existe = 0 THEN
        SET err = 1;
        SET mensaje = 'Error: No existe un préstamo activo con los datos proporcionados.';
        
    END IF;
    
    -- Calcular días de atraso
    SELECT DATE_ADD(fecha_prestamo, INTERVAL 15 DAY) INTO fecha_limite_devolucion;
    
    IF fecha_devolucion_actual > fecha_limite_devolucion THEN
        SET dias_atraso = DATEDIFF(fecha_devolucion_actual, fecha_limite_devolucion);
    END IF;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    -- Actualizar tabla préstamo
    UPDATE prestamo
    SET fecha_devolucion = fecha_devolucion_actual,
        dias_atraso = dias_atraso
    WHERE dpi_usuario = usuario_dpi 
      AND codigo_ejemplar = ejemplar_cod 
      AND fecha_prestamo = fecha_prestamo;
    
    -- Actualizar tabla ejemplar
    UPDATE ejemplar
    SET disponible = TRUE
    WHERE codigo_ejemplar = ejemplar_cod;
    
    -- Confirmar transacción
    COMMIT;
    
    SET mensaje = CONCAT('Devolución registrada exitosamente. Días de atraso: ', dias_atraso);
END //
DELIMITER ;

-- Primero creamos un préstamo de prueba
INSERT INTO prestamo (dpi_usuario, codigo_ejemplar, fecha_prestamo) 
VALUES (9876543210101, 'EJ-003', '2023-04-01 10:00:00');

-- Llamamos al procedimiento
CALL sp_registrar_devolucion(
    9876543210101, 
    'EJ-003', 
    '2023-04-01 10:00:00', 
    @err, 
    @mensaje, 
    @dias_atraso
);

-- Verificamos los resultados
SELECT @err AS error, @mensaje AS mensaje, @dias_atraso AS dias_atraso;
