## 5. Modelo conceptual

![Modelo conceptual](./capturas/modelo.conceptual.png)

## 6. Modelo relacional

![Modelo relacional](./capturas/modelo.relacional.png)

## 7. Implementación en MySQL

### 1. Creación de tablas

```sql
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CarRentalX
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CarRentalX
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CarRentalX` DEFAULT CHARACTER SET utf8 ;
USE `CarRentalX` ;

-- -----------------------------------------------------
-- Table `CarRentalX`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarRentalX`.`clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` INT(10) NOT NULL,
  `tipoCarnet` SET('A', 'B', 'C', 'D', 'E', 'AM', 'A1', 'A2', 'B1', 'C1', 'D1', 'BE', 'C1E', 'CE', 'D1E', 'DE') NOT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CarRentalX`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarRentalX`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` INT(10) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CarRentalX`.`vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarRentalX`.`vehiculos` (
  `idVehiculos` INT NOT NULL AUTO_INCREMENT,
  `matricula` VARCHAR(9) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `año` SMALLINT(4) NOT NULL,
  `color` VARCHAR(45) NULL,
  `tipoCombustible` SET("gasolina", "diesel", "electrico", "hibrido", "gas", "hidrogeno") NOT NULL,
  `precio` DOUBLE NOT NULL,
  `disponibilidad` ENUM("SI", "NO") NOT NULL,
  `idSucursal` INT NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  PRIMARY KEY (`idVehiculos`, `idSucursal`),
  INDEX `fk_vehiculos_sucursal1_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_vehiculos_sucursal1`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `CarRentalX`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CarRentalX`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarRentalX`.`reservas` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `costeTotal` DOUBLE NOT NULL,
  `fechaInicioReserva` DATETIME NOT NULL,
  `fechaFinReserva` DATETIME NOT NULL,
  `estado` ENUM("pendiente", "enCurso", "finalizado", "anulado") NOT NULL,
  `clientes_idClientes` INT NOT NULL,
  `vehiculos_idVehiculos` INT NOT NULL,
  `vehiculos_idSucursal` INT NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_reservas_clientes1_idx` (`clientes_idClientes` ASC),
  INDEX `fk_reservas_vehiculos1_idx` (`vehiculos_idVehiculos` ASC, `vehiculos_idSucursal` ASC),
  CONSTRAINT `fk_reservas_clientes1`
    FOREIGN KEY (`clientes_idClientes`)
    REFERENCES `CarRentalX`.`clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_vehiculos1`
    FOREIGN KEY (`vehiculos_idVehiculos` , `vehiculos_idSucursal`)
    REFERENCES `CarRentalX`.`vehiculos` (`idVehiculos` , `idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CarRentalX`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CarRentalX`.`empleados` (
  `idEmpleados` INT NOT NULL AUTO_INCREMENT,
  `cargo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` INT(10) NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  PRIMARY KEY (`idEmpleados`),
  INDEX `fk_empleados_sucursal1_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_empleados_sucursal1`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `CarRentalX`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
```

### 2. Inserción de datos de prueba

#### Primer paso, seleccionar la base de datos correspondiente
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

(DEFAULT, '1234ABC', 'Ford Fiesta', 2020, 'Rojo', 'gasolina', 100.5, 'SI', 1, 1), 

(DEFAULT, '5678DEF', 'BMW X5', 2019, 'Azul', 'diesel', 250.75, 'NO', 2, 2), 

(DEFAULT, '9101GHI', 'Tesla Model 3', 2021, 'Negro', 'electrico', 500.0, 'SI', 3, 3), 

(DEFAULT, '123ABC', 'Toyota Corolla', 2020, 'Rojo', 'gasolina', 35.99, 'SI', 1,1), 

(DEFAULT, '456DEF', 'Ford Focus', 2021, 'Azul', 'gasolina,diesel', 40.50, 'SI', 2,2); 
```
#### Insertar datos de reservas
``` sql
INSERT INTO reservas 

VALUES  

(DEFAULT, 150.0, '2025-03-10 10:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1, 1), 

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
