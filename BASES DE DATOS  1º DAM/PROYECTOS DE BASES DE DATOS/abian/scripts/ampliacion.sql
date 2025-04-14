## 1. Creación de nuevas tablas

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

### Tabla de mantenimientos

CREATE TABLE mantenimientos (
  idMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
  idVehiculo INT NOT NULL,
  fecha DATE NOT NULL,
  tipo VARCHAR(100),               
  costo DECIMAL(10, 2),
  descripcion TEXT,
  FOREIGN KEY (idVehiculo) REFERENCES vehiculos(idVehiculo)
);

## 2. Inserción de datos

### datos de tabla de pagos

INSERT INTO pagos VALUES
(DEFAULT, 1, '2025-04-01', 'tarjeta', 100.50, 'pagado'),
(DEFAULT, 2, '2025-04-02', 'efectivo', 150.00, 'pagado'),
(DEFAULT, 3, '2025-04-03', 'transferencia', 200.75, 'pendiente'),
(DEFAULT, 4, '2025-04-04', 'tarjeta', 120.00, 'pagado');

### datos de tabla de mantenimientos

INSERT INTO mantenimientos  VALUES
(DEFAULT, 1, '2025-04-01', 'cambio aceite', 30.00, 'Cambio de aceite y filtros'),
(DEFAULT, 2, '2025-04-02', 'revisión frenos', 50.00, 'Revisión de frenos y pastillas'),
(DEFAULT, 3, '2025-04-03', 'reemplazo llanta', 80.00, 'Reemplazo de llanta dañada'),
(DEFAULT, 4, '2025-04-04', 'alineación ruedas', 40.00, 'Alineación y balanceo de ruedas');