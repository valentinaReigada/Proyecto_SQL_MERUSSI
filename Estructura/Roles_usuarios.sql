USE mysql;

-- Creación de roles: dueño, empleado_nuevo, empleado_experto.
CREATE ROLE 'rol_dueno';
CREATE ROLE 'rol_empleado_nuevo';
CREATE ROLE 'rol_empleado_experto';

-- Creación de usuarios con su correspondiente contraseña.
CREATE USER 'dueno'@'localhost' IDENTIFIED BY 'dueno_pass';
CREATE USER 'read_empleado_nuevo'@'localhost' IDENTIFIED BY 'read_empleado_nuevo_pass';
CREATE USER 'rw_empleado_experto'@'localhost' IDENTIFIED BY 'rw_empleado_experto_pass';

-- Asignación de permisos a los roles sobre la base de datos MERUSSI.
GRANT ALL PRIVILEGES ON `MERUSSI`.* TO 'rol_dueno';
GRANT SELECT ON `MERUSSI`.* TO 'rol_empleado_nuevo';
GRANT INSERT, UPDATE, DELETE ON `MERUSSI`.* TO 'rol_empleado_experto';

-- Vincular los roles con los usuarios.
GRANT 'rol_dueno' TO 'dueno'@'localhost';
GRANT 'rol_empleado_nuevo' TO 'read_empleado_nuevo'@'localhost';
GRANT 'rol_empleado_experto' TO 'rw_empleado_experto'@'localhost';

-- Esto es para asegur que los usuarios hereden los privilegios del rol.
SET DEFAULT ROLE 'rol_dueno' TO 'dueno'@'localhost';
SET DEFAULT ROLE 'rol_empleado_nuevo' TO 'read_empleado_nuevo'@'localhost';
SET DEFAULT ROLE 'rol_empleado_experto' TO 'rw_empleado_experto'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;
