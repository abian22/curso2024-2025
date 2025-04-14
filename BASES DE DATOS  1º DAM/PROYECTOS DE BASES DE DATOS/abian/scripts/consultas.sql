## 1. Listar todos los clientes con su información personal.
SELECT * 
FROM clientes;

## 2. Buscar un cliente por su DNI, nombre o email.
SELECT * 
FROM clientes
WHERE email = "juan.perez@gmail.com";

## 3. Contar cuántos clientes hay registrados.
SELECT COUNT(*) AS cantidad_clientes
FROM clientes;

## 4. Obtener los clientes que han realizado al menos una reserva.
SELECT DISTINCT clientes.idCliente , clientes.nombre
FROM clientes
JOIN reservas 
ON clientes.idCliente = reservas.idCliente;

## 5. Listar los clientes de mayor a menor reservas realizadas
SELECT clientes.idCliente, clientes.nombre, COUNT(reservas.idReserva) AS cantidad_reservas
FROM clientes
JOIN reservas ON clientes.idCliente = reservas.idCliente
GROUP BY clientes.idCliente, clientes.nombre
ORDER BY cantidad_reservas DESC;

## 6. Listar todos los vehículos con sus detalles técnicos.
SELECT * FROM vehiculos;

## 7. Buscar un vehículo cuya matrícula empiece por 1.
 SELECT * FROM vehiculos
 WHERE matricula 
 LIKE ("1%");
 
## 8. Vehículos más alquilados (se cuentan los estados finalizados o en curso de las reservas)
SELECT vehiculos.idVehiculo, vehiculos.modelo, COUNT(reservas.idReserva) AS cantidad_alquileres
FROM reservas
JOIN vehiculos ON reservas.idVehiculo = vehiculos.idVehiculo
WHERE reservas.estado IN ('enCurso', 'finalizado')
GROUP BY vehiculos.idVehiculo
ORDER BY cantidad_alquileres DESC;
    
## 9. Obtener los vehículos disponibles en una sucursal específica.
SELECT * 
FROM vehiculos 
WHERE disponibilidad = "SI";

## 10. Contar cuántos vehículos hay de cada tipo de combustible.
SELECT tipoCombustible, COUNT(tipoCombustible) 
FROM vehiculos 
GROUP BY tipoCombustible;

## 11. Obtener todas las reservas realizadas con fechas de inicio y fin.
SELECT *
FROM reservas
WHERE fechaInicioReserva != "" 
AND fechaFinReserva != "";

## 12. Contar cuántas reservas hay en cada estado (pendiente, en curso, finalizado, anulado).
SELECT idReserva, estado, COUNT(estado) 
FROM reservas 
GROUP BY estado;

## 13. Obtener las reservas pendientes en este momento.
SELECT *
FROM reservas 
WHERE estado = "pendiente";

## 14. Contar el número de vehículos reservados en estado "enCurso"
SELECT DISTINCT vehiculos.idVehiculo, vehiculos.modelo
FROM reservas 
JOIN vehiculos ON reservas.idVehiculo = vehiculos.idVehiculo
WHERE reservas.estado = 'enCurso';

## 15. Contar cuántas reservas se han realizado por mes/año.
SELECT DAY(fechaInicioReserva) AS dia,  
COUNT(*) AS num_reservas
FROM reservas
GROUP BY dia;

## 16. Listar todas las sucursales con su información.
SELECT * FROM sucursales;

## 17. Contar cuántos vehículos hay en cada sucursal.
SELECT sucursales.idSucursal, sucursales.nombre, COUNT(vehiculos.idVehiculo) 
FROM sucursales
LEFT JOIN vehiculos ON sucursales.idSucursal = vehiculos.idSucursal
GROUP BY sucursales.idSucursal, sucursales.nombre;

## 18. Determinar qué sucursal ha generado más ingresos en reservas.
SELECT sucursales.idSucursal, sucursales.nombre, SUM(vehiculos.precio) AS total_ingresos
FROM sucursales
JOIN vehiculos ON sucursales.idSucursal = vehiculos.idSucursal
JOIN reservas ON vehiculos.idVehiculo = reservas.idVehiculo
WHERE reservas.estado IN ('enCurso', 'finalizado')
GROUP BY sucursales.idSucursal;

## 19. Listar los empleados asignados a cada sucursal.
SELECT empleados.idEmpleado, empleados.nombre, empleados.apellidos, sucursales.nombre AS nombre_sucursal
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal;

## 20. Identificar sucursales con reservas registradas para el 10 de marzo de 2025.
SELECT * FROM reservas 
WHERE fechaInicioReserva
LIKE ("%2025-03-10%");

## 21. Lista todos los empleados.
SELECT * 
FROM empleados;

## 22. Listar todos los empleados con su cargo y sucursal asignada.
SELECT empleados.nombre, empleados.cargo, sucursales.nombre AS nombre_sucursal
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal;

## 23. Buscar empleados por nombre.
SELECT * 
FROM empleados
WHERE nombre = "Pedro";

## 24. Contar cuántos empleados hay en cada sucursal.
SELECT sucursales.nombre AS nombre_sucursal, COUNT(empleados.idEmpleado) AS empleados_por_sucursal
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal
GROUP BY sucursales.idSucursal;

## 25. Identificar la dirección de la sucursal a la que pertenece un empleado.
SELECT empleados.nombre, sucursales.nombre 
FROM sucursales
JOIN empleados ON sucursales.idSucursal = empleados.idSucursal
WHERE empleados.idEmpleado = 2;