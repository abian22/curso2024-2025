## Datos clientes

INSERT INTO clientes 

VALUES   

(DEFAULT, 'Juan', 'Pérez', '12345678A', 'juan.perez@gmail.com', 612345678, 'A'),  

(DEFAULT, 'Ana', 'García', '87654321B', 'ana.garcia@gmail.com', 623456789, 'B'),  

(DEFAULT, 'Carlos', 'López', '11223344C', 'carlos.lopez@gmail.com', 634567890, 'C'), 

(DEFAULT, 'Manuel', 'Jiménez', '3215678A', 'manuel.jimenez@gmail.com', 652145423, 'A,B');

## Datos sucursales

INSERT INTO sucursales 

VALUES  

(DEFAULT, 'Sucursal Central', 'Calle Mayor 123', 912345678, 'central@gmail.com'), 

(DEFAULT, 'Sucursal Norte', 'Calle Norte 456', 923456789, 'norte@gmail.com'), 

(DEFAULT, 'Sucursal Sur', 'Calle Sur 789', 934567890, 'sur@gmail.com'); 

## Datos vehñiculos

INSERT INTO vehiculos 

VALUES  

(DEFAULT, '1234ABC', 'Ford Fiesta', 2020, 'Rojo', 'gasolina', 100.5, 'SI', 1), 

(DEFAULT, '5678DEF', 'BMW X5', 2019, 'Azul', 'diesel', 250.75, 'NO', 2), 

(DEFAULT, '9101GHI', 'Tesla Model 3', 2021, 'Negro', 'electrico', 500.0, 'SI', 3), 

(DEFAULT, '123ABC', 'Toyota Corolla', 2020, 'Rojo', 'gasolina', 35.99, 'SI', 1), 

(DEFAULT, '456DEF', 'Ford Focus', 2021, 'Azul', 'gasolina,diesel', 40.50, 'SI', 2);

## Datos reservas

INSERT INTO reservas 

VALUES  

(DEFAULT, '2025-03-10 10:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1), 

(DEFAULT, '2025-03-10 12:00:00', '2025-03-12 10:00:00', 'pendiente', 1, 1), 

(DEFAULT, '2025-03-15 12:00:00', '2025-03-18 12:00:00', 'enCurso', 2, 2), 

(DEFAULT, '2025-03-20 09:00:00', '2025-03-22 09:00:00', 'finalizado', 3, 3), 

(DEFAULT,'2025-03-24 19:00:00', '2025-03-28 09:00:00', 'anulado', 3, 3);
