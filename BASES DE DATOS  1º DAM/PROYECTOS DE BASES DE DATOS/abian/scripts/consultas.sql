
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
