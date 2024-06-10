USE MERUSSI;

-- CREACION DE VISTAS:

-- 1) VISTA SOBRE LAS FACTURAS EMITIDAS EN EL MES DE ABRIL CON EL TOTAL POR CADA FACTURA
CREATE OR REPLACE VIEW vw_ventas_de_abril AS (
	SELECT 
    f.ID_FACTURA AS NRO_FACTURA,
    emp.NOMBRE AS NOMBRE_EMPLEADO, 
    cli.NOMBRE as NOMBRE_CLIENTE, 
    f.FEC_EMISION AS FECHA_EMISION, 
    SUM(fdet.TOTAL) as TOTAL_COMPRA 
    FROM FACTURA f 
    INNER JOIN 
		PERSONA emp ON f.COD_EMPLEADO = emp.ID_PERSONA
    INNER JOIN 
        PERSONA cli ON f.COD_CLIENTE = cli.ID_PERSONA
    INNER JOIN 
		FACTURA_DETALLE fdet ON fdet.ID_FACTURA = f.ID_FACTURA 
    WHERE 
		FEC_EMISION between '2024-04-01' AND '2024-04-30'
    GROUP BY 
		f.ID_FACTURA
);

SELECT * FROM vw_ventas_de_abril;


-- 2) VISTA DE LAS FACTURAS QUE FUERON FACTURADAS CON 100% EFECTIVO

CREATE OR REPLACE VIEW vw_facturas_en_efectivo AS (
    SELECT 
        f.ID_FACTURA AS NRO_FACTURA, 
        emp.NOMBRE AS NOMBRE_EMPLEADO, 
        cli.NOMBRE AS NOMBRE_CLIENTE, 
        f.FEC_EMISION AS FECHA_EMISION, 
        fpag.TOTAL
    FROM 
        FACTURA f
    INNER JOIN 
        PERSONA emp ON f.COD_EMPLEADO = emp.ID_PERSONA
    INNER JOIN 
        PERSONA cli ON f.COD_CLIENTE = cli.ID_PERSONA
    INNER JOIN 
        (
		SELECT 
           ID_FACTURA, 
           SUM(TOTAL) AS TOTAL
        FROM 
           factura_pago
        GROUP BY 
           ID_FACTURA
        HAVING 
            COUNT(ID_FPAGO) = 1  -- Solo pagos al 100% en efectivo
            AND MAX(ID_FPAGO) = 1 -- Asegurar que el único pago sea en efectivo (ID_FPAGO = 1)
        ) fpag ON f.ID_FACTURA = fpag.ID_FACTURA
);

SELECT * FROM vw_factura_en_efectivo;

-- 3) VISTA DE LOS PRODUCTOS QUE TIENEN UN STOCK MENOR A 10 UNIDADES
CREATE OR REPLACE VIEW vw_productos_a_reponer AS (
	SELECT 
    p.ID_PRODUCTO,
    p.NOMBRE,
    s.cantidad as CANTIDAD_STOCK
    FROM PRODUCTO p
    INNER JOIN
		PRODUCTO_STOCK s ON p.ID_PRODUCTO = s.ID_PRODUCTO
    WHERE 
		s.CANTIDAD < 10
	ORDER BY 
		s.cantidad
);

SELECT * FROM vw_productos_a_reponer;







