USE MERUSSI;
-- STORED PROCEDURES

-- 1) CREAR PERSONA
DROP PROCEDURE IF EXISTS crear_persona;

DELIMITER //
CREATE PROCEDURE crear_persona(
	IN p_rol INT,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_tpo_doc INT,
    IN p_nro_doc VARCHAR(20),
    IN p_fec_nac DATE,
    IN p_dir_nro NUMERIC(4,0),
    IN p_dir_calle VARCHAR(30),
    IN p_id_postal INT,
    IN p_id_prov INT
)
BEGIN
    DECLARE CANT_ROL INT;
    DECLARE CANT_TPO_DOC INT;
    DECLARE CANT_POSTAL INT;
    DECLARE CANT_PROV INT;
    
    -- Verificar si existe rol, tipo documento, postal y provincia
    SELECT COUNT(*) INTO CANT_ROL
    FROM ROL
    WHERE ID_ROL  = p_rol;
    
	SELECT COUNT(*) INTO CANT_TPO_DOC
    FROM TIPO_DOCUMENTO
    WHERE ID_TIPODOC  = p_tpo_doc; 

	SELECT COUNT(*) INTO CANT_POSTAL
    FROM POSTAL
    WHERE ID_POSTAL  = p_id_postal; 
   
   	SELECT COUNT(*) INTO CANT_PROV
    FROM PROVINCIA
    WHERE ID_PROVINCIA  = p_id_prov; 
    
    -- Valida que existan esos códigos para poder crear el registro.
    IF (CANT_ROL > 0 AND  CANT_TPO_DOC > 0 AND CANT_POSTAL > 0 AND CANT_PROV > 0) THEN
		-- Crea el registro en la tabla PERSONA
		INSERT INTO PERSONA (ID_ROL, NOMBRE, APELLIDO, ID_TIPODOC, NRO_DOCUMENTO, FEC_NACIMIENTO, DIRECCION_NRO, DIRECCION_CALLE, ID_POSTAL, ID_PROVINCIA) VALUES
        (p_rol, p_nombre, p_apellido, p_tpo_doc, p_nro_doc, p_fec_nac, p_dir_nro, p_dir_calle, p_id_postal, p_id_prov) ;
        SELECT 'La Persona fue creada de forma éxitosa.' AS MENSAJE;
    ELSE
        SELECT 'Rol, Tipo Documento, Cod. Postal o Cod.Provincia incorrecto o no existe.' as MENSAJE;
    END IF;
END //

DELIMITER ;

CALL crear_persona(1, 'VALENTINA', 'COBACHO', 1, '1233211', '1999-10-01', 122, 'VALENCIA', 1, 1);

SELECT * FROM PERSONA WHERE NOMBRE LIKE 'GUSTAVO';

-- 2) CREAR PRODUCTO
DROP PROCEDURE IF EXISTS crear_productoYSuStock;
DELIMITER //
CREATE PROCEDURE crear_productoYSuStock(
	IN p_categoria INT,
	IN p_nombre VARCHAR(30), 
	IN p_fecha DATE, 
	IN p_precio DECIMAL(18,2),
    IN p_stock NUMERIC(5,0)
)
BEGIN
	DECLARE CANT_CATE INT;
    DECLARE v_producto_id INT; -- Variable para almacenar el nuevo ID_PRODUCTO
    
    -- Verificar si existe rol, tipo documento, postal y provincia
    SELECT COUNT(*) INTO CANT_CATE
    FROM CATEGORIA
    WHERE ID_CATEGORIA  = p_categoria;
    
    IF CANT_CATE = 0 THEN 
		SELECT 'La categoria dada no existe.';
    ELSE IF (p_stock < 1) THEN
			SELECT 'El stock debe ser mayor a 0';
		ELSE
			-- Insertar en la tabla PRODUCTO
            INSERT INTO PRODUCTO (ID_CATEGORIA, NOMBRE, FEC_VENCIMIENTO, PRECIO) 
            VALUES (p_categoria, p_nombre, p_fecha, p_precio);
            -- Obtiene el último id generado.
            SET v_producto_id = LAST_INSERT_ID();
            -- Insertar en la tabla PRODUCTO_STOCK
            INSERT INTO PRODUCTO_STOCK (ID_PRODUCTO, CANTIDAD) 
            VALUES (v_producto_id, p_stock);
            
			SELECT CONCAT('El Producto se creó éxitosamente. Nro Producto:', v_producto_id) AS MENSAJE;
		END IF;
    END IF;
END //
DELIMITER ;

CALL crear_productoYSuStock(8, 'IBUPROFENO', '2030-01-01', 350.00, 10);
SELECT * FROM PRODUCTO where ID_PRODUCTO = 35;


-- 3) ACTUALIZAR STOCK - RECIBE UNA FACTURA Y ACTUALIZA EL STOCK DE LOS PRODUCTOS VENDIDOS EN LA MISMA.
DROP PROCEDURE IF EXISTS actualizarStockDesdeFactura;
DELIMITER //
CREATE PROCEDURE actualizarStockDesdeFactura(
	IN p_factura INT
)
BEGIN
	DECLARE CANT_FACTURA INT;
	
    -- Busco en la tabla Factura el Id dado.
    SELECT COUNT(1) INTO CANT_FACTURA
    FROM FACTURA 
    WHERE ID_FACTURA = p_factura;
	-- Verifico que exista la factura para poder seguir.
    IF CANT_FACTURA = 0 THEN
		SELECT 'La factura dada no existe.' AS Mensaje;
	ELSE
    
        -- Actualizar el stock de los productos vendidos en la factura
        UPDATE PRODUCTO_STOCK ps
        JOIN FACTURA_DETALLE fd ON ps.ID_PRODUCTO = fd.ID_PRODUCTO
        SET ps.CANTIDAD = ps.CANTIDAD - fd.CANTIDAD
        WHERE fd.ID_FACTURA = p_factura;

        SELECT 'Se actualizó el stock de los productos exitosamente!' AS Mensaje;
	END IF;
END//
DELIMITER ;

CALL actualizarStockDesdeFactura(2);




