## 5. Modelo conceptual

![Modelo conceptual](./capturas/modelo.conceptual.png)

## 6. Modelo relacional

![Modelo relacional](./capturas/modelo.relacional.png)

## 7. Implementación en MySQL

### 1. Creación de tablas

```sql
-- MySQL Workbench Synchronization
-- Generated: 2025-04-11 11:37
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Yo

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS CarRentalX DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS CarRentalX.clientes (
  idCliente INT(11) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellidos VARCHAR(45) NOT NULL,
  dni VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  telefono INT(10) NOT NULL,
  tipoCarnet SET('A', 'B', 'C', 'D', 'E', 'AM', 'A1', 'A2', 'B1', 'C1', 'D1', 'BE', 'C1E', 'CE', 'D1E', 'DE') NOT NULL,
  PRIMARY KEY (idCliente))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS CarRentalX.reservas (
  idReserva INT(11) NOT NULL AUTO_INCREMENT,
  costeTotal DOUBLE NOT NULL,
  fechaInicioReserva DATETIME NOT NULL,
  fechaFinReserva DATETIME NOT NULL,
  estado ENUM("pendiente", "enCurso", "finalizado", "anulado") NOT NULL,
  idCliente INT(11) NOT NULL,
  idVehiculo INT(11) NOT NULL,
  PRIMARY KEY (idReserva),
  INDEX fk_reservas_clientes_idx (idCliente ASC),
  INDEX fk_reservas_vehiculos1_idx (idVehiculo ASC),
  CONSTRAINT fk_reservas_clientes
    FOREIGN KEY (idCliente)
    REFERENCES CarRentalX.clientes (idCliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_reservas_vehiculos1
    FOREIGN KEY (idVehiculo)
    REFERENCES CarRentalX.vehiculos (idVehiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS CarRentalX.vehiculos (
  idVehiculo INT(11) NOT NULL AUTO_INCREMENT,
  matricula VARCHAR(9) NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  año SMALLINT(4) NOT NULL,
  color VARCHAR(45) NULL DEFAULT NULL,
  tipoCombustible SET("gasolina", "diesel", "electrico", "hibrido", "gas", "hidrogeno") NOT NULL,
  precio DOUBLE NOT NULL DEFAULT 150.00,
  disponibilidad ENUM("SI", "NO") NOT NULL,
  idSucursal INT(11) NOT NULL,
  PRIMARY KEY (idVehiculo),
  INDEX fk_vehiculos_sucursales1_idx (idSucursal ASC),
  CONSTRAINT fk_vehiculos_sucursales1
    FOREIGN KEY (idSucursal)
    REFERENCES CarRentalX.sucursales (idSucursal)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS CarRentalX.sucursales (
  idSucursal INT(11) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  direccion VARCHAR(45) NOT NULL,
  telefono INT(10) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (idSucursal))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS CarRentalX.empleados (
  idEmpleado INT(11) NOT NULL AUTO_INCREMENT,
  cargo VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellidos VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  telefono INT(10) NOT NULL,
  idSucursal INT(11) NOT NULL,
  PRIMARY KEY (idEmpleado),
  INDEX fk_empleados_sucursales1_idx (idSucursal ASC),
  CONSTRAINT fk_empleados_sucursales1
    FOREIGN KEY (idSucursal)
    REFERENCES CarRentalX.sucursales (idSucursal)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



### 2. Inserción de datos de prueba

#### Seleccionar la base de datos correspondiente

``` sql
Use carrentalx;
```
#### Insertar datos de clientes
``` sql
INSERT INTO clientes 

VALUES   

(DEFAULT, 'Juan', 'Pérez', '12345678A', 'juan.perez@gmail.com', 612345678, 'A'),  

(DEFAULT, 'Ana', 'García', '87654321B', 'ana.garcia@gmail.com', 623456789, 'B'),  

(DEFAULT, 'Carlos', 'López', '11223344C', 'carlos.lopez@gmail.com', 634567890, 'C'), 

(DEFAULT, 'Manuel', 'Jiménez', '3215678A', 'manuel.jimenez@gmail.com', 652145423, 'A,B'); 
```
#### Insertar datos de sucursal
``` sql
INSERT INTO sucursal 

VALUES  

(DEFAULT, 'Sucursal Central', 'Calle Mayor 123', 912345678, 'central@gmail.com'), 

(DEFAULT, 'Sucursal Norte', 'Calle Norte 456', 923456789, 'norte@gmail.com'), 

(DEFAULT, 'Sucursal Sur', 'Calle Sur 789', 934567890, 'sur@gmail.com'); 
```
#### Insertar datos de vehículos
``` sql
INSERT INTO vehiculos 

VALUES  

(DEFAULT, '1234ABC', 'Ford Fiesta', 2020, 'Rojo', 'gasolina', 100.5, 'SI', 1), 

(DEFAULT, '5678DEF', 'BMW X5', 2019, 'Azul', 'diesel', 250.75, 'NO', 2), 

(DEFAULT, '9101GHI', 'Tesla Model 3', 2021, 'Negro', 'electrico', 500.0, 'SI', 3), 

(DEFAULT, '123ABC', 'Toyota Corolla', 2020, 'Rojo', 'gasolina', 35.99, 'SI', 1), 

(DEFAULT, '456DEF', 'Ford Focus', 2021, 'Azul', 'gasolina,diesel', 40.50, 'SI', 2); 
```
#### Insertar datos de reservas
``` sql
INSERT INTO reservas 

VALUES  

(DEFAULT, 150.0, '2025-03-10 10:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1, 1),

(DEFAULT, 220.0, '2025-03-10 12:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1, 1),

(DEFAULT, 220.0, '2025-03-10 12:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1, 1), 

(DEFAULT, 200.5, '2025-03-15 12:00:00', '2025-03-18 12:00:00', 'enCurso', 2, 2, 2), 

(DEFAULT, 350.0, '2025-03-20 09:00:00', '2025-03-22 09:00:00', 'finalizado', 3, 3, 3), 

(DEFAULT, 350.0, '2025-03-24 19:00:00', '2025-03-28 09:00:00', 'anulado', 3, 3, 3); 
```
#### Insertar datos de empleados
``` sql
INSERT INTO empleados 

VALUES  

(DEFAULT, 'Gerente', 'María', 'Martínez', 'maria.martinez@gmail.com', 611223344, 1), 

(DEFAULT, 'Asesor', 'Pedro', 'Gómez', 'pedro.gomez@gmail.com', 622334455, 2), 

(DEFAULT, 'Recepcionista', 'Lucía', 'Sánchez', 'lucia.sanchez@gmail.com', 633445566, 3) 
```

## 8. Consultas propuestas

```sql
USE carrentalx;

### 1. Listar todos los clientes con su información personal.
SELECT * 
FROM clientes;

### 2. Buscar un cliente por su email.
SELECT * 
FROM clientes
WHERE email = "juan.perez@gmail.com";


### 3. Contar cuántos clientes hay registrados.
SELECT COUNT(*) 
FROM clientes;

### 4. Obtener los clientes que han realizado al menos una reserva.
SELECT DISTINCT clientes.idCliente 
FROM clientes
JOIN reservas 
ON clientes.idCliente = reservas.idCliente;

### 5. Listar los clientes con más reservas realizadas.
SELECT clientes.idCliente, nombre, COUNT(reservas.idReserva) AS cantidadReserva
FROM clientes
JOIN reservas ON clientes.idCliente = reservas.idCliente
GROUP BY clientes.idCliente, nombre
ORDER BY cantidadReserva DESC;

### 6. Listar todos los vehículos.
SELECT * FROM vehiculos;

### 7. Buscar un vehículo cuya matrícula empiece por 1.
 SELECT * FROM vehiculos
 WHERE matricula 
 LIKE ("1%");
 
 ### 8. Contar cuántos vehículos hay de cada tipo de combustible.
SELECT tipoCombustible, COUNT(tipoCombustible) 
FROM vehiculos 
GROUP BY tipoCombustible;

### 9. Obtener los vehículos disponibles.
SELECT * 
FROM vehiculos 
WHERE disponibilidad = "SI";

### 10. Obtener los precios de los vehiculos ordenados de manera descendente.
SELECT idVehiculo, modelo, precio 
FROM vehiculos 
ORDER BY precio DESC;

### 11. Obtener todas las reservas realizadas con fechas de inicio entre 2025-03-10 y 2025-03-18.
SELECT *
FROM reservas
WHERE fechaInicioReserva BETWEEN '2025-03-10' AND '2025-03-18';


### 12. Contar cuántas reservas hay en cada estado (pendiente, en curso, finalizado, anulado).
SELECT estado, COUNT(estado)  as cantidad
FROM reservas 
GROUP BY estado;

### 13. Obtener las reservas pendientes en este momento.
SELECT *
FROM reservas 
WHERE estado = "pendiente";

### 14. Obtener el número de reservas por cliente.
SELECT idCliente, COUNT(*) AS numReservas
FROM reservas
GROUP BY idCliente;

### 15. Contar cuántas reservas se han realizado por día.
SELECT DATE(fechaInicioReserva) AS dia,  
COUNT(*) AS num_reservas
FROM reservas
GROUP BY dia;

### 16. Listar todas las sucursales con su información.
SELECT * FROM sucursales;

### 17. Contar cuántos vehículos hay en cada sucursal.
SELECT sucursales.idSucursal, sucursales.nombre, COUNT(vehiculos.idVehiculo)  as vehiculoPorSucursal
FROM sucursales
LEFT JOIN vehiculos ON sucursales.idSucursal = vehiculos.idSucursal
GROUP BY sucursales.idSucursal, sucursales.nombre;

### 18. Determinar la cantidad de vehiculos disponibles por sucursal.
SELECT sucursales.idSucursal, sucursales.nombre, COUNT(vehiculos.idVehiculo) AS vehiculosDisponibles
FROM sucursales
JOIN vehiculos ON sucursales.idSucursal = vehiculos.idSucursal
WHERE vehiculos.disponibilidad = 'SI'
GROUP BY sucursales.idSucursal, sucursales.nombre;

### 19. Listar los empleados asignados a cada sucursal.
SELECT empleados.idEmpleado, empleados.nombre, sucursales.nombre AS Sucursal
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal;

### 20. Identificar sucursales cuyo teléfono empiece por 912
SELECT * 
FROM sucursales 
WHERE telefono LIKE '912%';

### 21. Lista todos los empleados.
SELECT * 
FROM empleados;

### 22. Listar todos los empleados con su cargo y sucursal asignada.
SELECT empleados.nombre, empleados.cargo, sucursales.nombre AS sucursal
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal;

### 23. Buscar empleados por nombre.
SELECT * 
FROM empleados
WHERE nombre = "Pedro";

### 24. Contar cuántos empleados hay en cada sucursal.
SELECT sucursales.nombre, COUNT(empleados.idEmpleado) AS cantidadEmpleados
FROM empleados 
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal
GROUP BY sucursales.nombre;

### 25. Identificar la dirección de la sucursal a la que pertenece un empleado.
SELECT empleados.nombre, sucursales.nombre 
FROM sucursales
JOIN empleados ON sucursales.idSucursal = empleados.idSucursal
WHERE empleados.idEmpleado = 2;



```
## 9. Ampliación de la base de datos

### 1. Creación de tabla de pagos

```sql
### Tabla de pagos

CREATE TABLE pagos (
  idPago INT PRIMARY KEY AUTO_INCREMENT,
  idReserva INT NOT NULL,
  fechaPago DATE NOT NULL,
  metodoPago VARCHAR(50),         
  cantidad DECIMAL(10, 2) NOT NULL,
  estadoPago VARCHAR(20),        
  FOREIGN KEY (idReserva) REFERENCES reservas(idReserva)
);
```

### 2. Creación de tabla de mantenimientos

```sql
CREATE TABLE mantenimientos (
  idMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
  idVehiculo INT NOT NULL,
  fecha DATE NOT NULL,
  tipo VARCHAR(100),               
  costo DECIMAL(10, 2),
  descripcion TEXT,
  FOREIGN KEY (idVehiculo) REFERENCES vehiculos(idVehiculo)
);

```

### 3. Inserción de datos en la tabla de pagos

```sql
INSERT INTO pagos VALUES
(DEFAULT, 1, '2025-04-01', 'tarjeta', 100.50, 'pagado'),
(DEFAULT, 2, '2025-04-02', 'efectivo', 150.00, 'pagado'),
(DEFAULT, 3, '2025-04-03', 'transferencia', 200.75, 'pendiente'),
(DEFAULT, 4, '2025-04-04', 'tarjeta', 120.00, 'pagado');
```

### 4. Inserción de datos en la tabla de mantenimientos

```sql
INSERT INTO mantenimientos  VALUES
(DEFAULT, 1, '2025-04-01', 'cambio aceite', 30.00, 'Cambio de aceite y filtros'),
(DEFAULT, 2, '2025-04-02', 'revisión frenos', 50.00, 'Revisión de frenos y pastillas'),
(DEFAULT, 3, '2025-04-03', 'reemplazo llanta', 80.00, 'Reemplazo de llanta dañada'),
(DEFAULT, 4, '2025-04-04', 'alineación ruedas', 40.00, 'Alineación y balanceo de ruedas');
```