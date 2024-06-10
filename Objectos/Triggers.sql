USE MERUSSI;
-- TRIGGERS

-- TABLA PARA REGISTRAR CAMBIOS EN EL PERSONAL DEL NEGOCIO
CREATE TABLE LOG_CAMBIOS (
	  ID_LOG          INT NOT NULL AUTO_INCREMENT PRIMARY KEY
    , TABLA_AFECTADA  VARCHAR (50)
    , ACCION          VARCHAR(50)
    , FECHA           DATETIME
    , ID_REGISTRO      INT
    , OBSERVACIONES   VARCHAR(100)
);

-- 1) Triggers para registrar cambios en la tabla PERSONA - Cuando se inserta una persona nueva al sistema, está acción se registra en el LOG_CAMBIOS.
DROP TRIGGER IF EXISTS after_insert_trigger;
DELIMITER //
CREATE TRIGGER after_insert_trigger
AFTER INSERT ON PERSONA
FOR EACH ROW
BEGIN
    INSERT INTO LOG_CAMBIOS (tabla_afectada, accion, fecha, id_registro, observaciones)
    VALUES ('PERSONA', 'INSERT', NOW() , NEW.ID_PERSONA, 'NUEVA PERSONA EN EL SISTEMA');
END //
DELIMITER ;

SELECT * FROM LOG_CAMBIOS;

-- 2) Este triggers verifica que hay  suficiente stock del producto antes de actualizarlo.
DROP TRIGGER IF EXISTS before_update_productoStock_trigger;
DELIMITER //
CREATE TRIGGER before_update_productoStock_trigger
BEFORE UPDATE ON PRODUCTO_STOCK
FOR EACH ROW
BEGIN
    DECLARE stock_disponible NUMERIC(5,0);

    -- Obtener el stock disponible del producto antes de la actualización
    SELECT CANTIDAD INTO stock_disponible
    FROM PRODUCTO_STOCK
    WHERE ID_PRODUCTO = OLD.ID_PRODUCTO;

    -- Verificar si hay suficiente stock disponible para el pedido
    IF stock_disponible < NEW.CANTIDAD  THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock disponible para el pedido';
    END IF;
END //
DELIMITER ;

-- 3)   Trigger para registrar que el producto se quedó sin stock luego de una actualización.
DROP TRIGGER IF EXISTS after_update_productoStock_trigger;
DELIMITER //
CREATE TRIGGER after_update_productoStock_trigger
AFTER UPDATE ON PRODUCTO_STOCK
FOR EACH ROW
BEGIN
    IF NEW.CANTIDAD = 0 THEN
        INSERT INTO LOG_CAMBIOS (tabla_afectada, accion, fecha, id_registro, observaciones)
        VALUES ('PRODUCTO_STOCK', 'UPDATE', NOW(), OLD.ID_STOCK, 'PRODUCTO SIN STOCK');
    END IF;
END //
DELIMITER ;
