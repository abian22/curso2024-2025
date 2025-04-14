# 1. Portada
![portada](./capturas/carrentalx.png)

# 2. Índice

3. Introduccion
4. Análisis del enunciado
5. Modelo conceptual
6. Modelo relacional
7. Implementación en MySQL
8. Consultas propuestas
9. Ampliación de base de datos
10. Vistas y triggers
11. Conclusión

## 3. Introducción
El presente informe tiene como objetivo analizar y diseñar un sistema de gestión para la empresa **CarRentalX**, dedicada al alquiler de coches. La empresa busca modernizar sus procesos, actualmente manuales, para optimizar la gestión de clientes, vehículos, reservas, sucursales y empleados. Este documento ofrece una visión estructurada del sistema requerido, identificando las entidades clave, sus relaciones y posibles mejoras mediante funcionalidades adicionales.

# 4. Análisis del Enunciado

## 🛠️ Problemas Detectados

### Ineficiencia en la gestión manual
La gestión actual provoca retrasos, errores humanos, falta de control sobre el estado de los vehículos y dificultad para tomar decisiones rápidas.

### Falta de centralización
La información se encuentra dispersa, dificultando la visibilidad global de la operación, duplicando esfuerzos y limitando el acceso en tiempo real a los datos.

## 🎯 Objetivo Principal

- Diseñar un sistema de gestión integral que unifique la información de:
  - Clientes
  - Vehículos
  - Reservas
  - Sucursales
  - Empleados

- Automatizar tareas repetitivas, como:
  - La actualización de disponibilidad de vehículos.
  - La generación de informes.

## 🧩 Entidades Principales

- **Clientes**  
  Datos personales, tipo de carnet y su historial de reservas.

- **Vehículos**  
  Información técnica (modelo, matrícula, color, combustible), estado (disponible/no disponible) y precio.

- **Reservas**  
  Registro de alquileres, incluyendo fechas, cliente asociado y estado (pendiente, en curso, finalizada).

- **Sucursales**  
  Ubicación y datos de contacto de cada sede.

- **Empleados**  
  Información personal, rol y asignación a sucursales.

## ⚙️ Requisitos Funcionales

- **Gestión integral de recursos**  
  Administración de clientes, vehículos, reservas, sucursales y empleados desde una única plataforma.

- **Gestión avanzada de reservas**  
  Crear, modificar y cancelar reservas con verificación de disponibilidad en tiempo real.

- **Generación de informes personalizados**, como:

  - 🚗 **Vehículos más alquilados**  
    Ayuda a optimizar el inventario.

  - 👤 **Clientes más frecuentes**  
    Facilita estrategias de fidelización.

  - 💰 **Ingresos mensuales por sucursal**  
    Información financiera clave para la toma de decisiones.

    
# 10. Vistas y triggers

## Vistas
```sql
## 1. Vista de reservas activas
CREATE VIEW reservas_activas AS
SELECT clientes.nombre, clientes.apellidos, reservas.estado
FROM reservas
JOIN clientes ON reservas.idCliente = clientes.idCliente
WHERE reservas.estado = 'enCurso' OR reservas.estado = 'pendiente';

## 2. Vista de vehiculos disponibles por sucursal
CREATE VIEW vehiculos_disponibles_por_sucursal AS
SELECT vehiculos.modelo, vehiculos.matricula, sucursales.nombre AS nombreSucursal
FROM vehiculos
JOIN sucursales ON vehiculos.idSucursal = sucursales.idSucursal
WHERE vehiculos.disponibilidad = 'SI';

## 3. Vista de pagos de cada reserva
CREATE VIEW pagos_por_reservas AS
SELECT reservas.idReserva, clientes.nombre, pagos.cantidad, pagos.metodoPago, pagos.estadoPago
FROM pagos
JOIN reservas ON pagos.idReserva = reservas.idReserva
JOIN clientes ON reservas.idCliente = clientes.idCliente;

## 4. Vista de mantenimiento de vehiculos
CREATE VIEW mantenimiento_vehiculos AS
SELECT 
  vehiculos.modelo,
  vehiculos.matricula,
  mantenimientos.tipo,
  mantenimientos.fecha,
  mantenimientos.descripcion
FROM mantenimientos
JOIN vehiculos ON mantenimientos.idVehiculo = vehiculos.idVehiculo;

## 5. Vista de empleados por sucursal
CREATE VIEW empleado_por_sucursal AS
SELECT 
  empleados.idEmpleado,
  empleados.nombre AS nombreEmpleado,
  empleados.cargo,
  sucursales.idSucursal,
  sucursales.nombre,
  sucursales.direccion
FROM empleados
JOIN sucursales ON empleados.idSucursal = sucursales.idSucursal;

## 6. Vista de vehiculos alquilados
CREATE VIEW vehiculos_actualmente_alquilados AS
SELECT 
  vehiculos.idVehiculo,
  vehiculos.modelo,
  vehiculos.matricula,
  reservas.idReserva,
  reservas.fechaInicioReserva,
  reservas.fechaFinReserva,
  clientes.nombre,
  clientes.apellidos
FROM vehiculos
JOIN reservas ON vehiculos.idVehiculo = reservas.idVehiculo
JOIN clientes ON reservas.idCliente = clientes.idCliente
WHERE reservas.estado = 'enCurso';

## 7. Vista de facturación total por cliente
CREATE VIEW facturacion_total_por_cliente AS
SELECT 
  clientes.idCliente,
  clientes.nombre,
  clientes.apellidos,
  SUM(pagos.cantidad) AS totalFacturado
FROM clientes
JOIN reservas ON clientes.idCliente = reservas.idCliente
JOIN pagos ON reservas.idReserva = pagos.idReserva
WHERE pagos.estadoPago = 'pagado'
GROUP BY clientes.idCliente, clientes.nombre, clientes.apellidos;

## 8. Vista de historial de reservas de clientes
CREATE VIEW historial_reservas_por_cliente AS
SELECT 
  clientes.idCliente,
  clientes.nombre,
  clientes.apellidos,
  reservas.idReserva,
  reservas.fechaInicioReserva,
  reservas.fechaFinReserva,
  reservas.estado,
  vehiculos.modelo,
  vehiculos.matricula
FROM clientes
JOIN reservas ON clientes.idCliente = reservas.idCliente
JOIN vehiculos ON reservas.idVehiculo = vehiculos.idVehiculo
ORDER BY clientes.idCliente, reservas.fechaInicioReserva;

## 9. Vista de vehículos más reservados
CREATE VIEW vehiculos_mas_reservados AS
SELECT 
  v.idVehiculo,
  v.modelo,
  v.matricula,
  COUNT(r.idReserva) AS totalReservas
FROM vehiculos v
JOIN reservas r ON v.idVehiculo = r.idVehiculo
GROUP BY v.idVehiculo, v.modelo, v.matricula
ORDER BY totalReservas DESC;

## 10. Vista de vehículos con más mantenimiento
CREATE VIEW vehiculos_mas_mantenidos AS
SELECT 
  v.idVehiculo,
  v.modelo,
  v.matricula,
  COUNT(m.idMantenimiento) AS totalMantenimientos
FROM vehiculos v
JOIN mantenimientos m ON v.idVehiculo = m.idVehiculo
GROUP BY v.idVehiculo, v.modelo, v.matricula
ORDER BY totalMantenimientos DESC;
```

## Triggers

```sql
DELIMITER $$
### 1. Trigger actualizar disponibilidad de un vehículo
CREATE TRIGGER actualizar_disponibilidad_reserva
AFTER INSERT ON reservas
FOR EACH ROW 
BEGIN
IF NEW.estado = "enCurso" OR NEW.estado = "pendiente" THEN
UPDATE vehiculos
SET disponibilidad = "NO"
WHERE idVehiculo = NEW.idVehiculo;
END IF;
END$$

### 2. Actualizar estado de reserva a anulado si la fecha ya expiró
CREATE TRIGGER reserva_anulada_si_fecha_expirada
BEFORE UPDATE ON reservas
FOR EACH ROW
BEGIN
    IF NEW.fechaFinReserva < NOW() AND NEW.estado != "finalizado" THEN
        SET NEW.estado = "anulado";
    END IF;
END$$

### 3. Actualizar un vehículo a no disponbile si está en mantenimiento
CREATE TRIGGER marcar_vehiculo_no_disponible_en_mantenimiento
AFTER INSERT ON mantenimientos
FOR EACH ROW
BEGIN
    UPDATE vehiculos
    SET disponibilidad = "NO"
    WHERE idVehiculo = NEW.idVehiculo;
END$$

### 4. Actualizar disponibilidad cuando se elimina una reserva
CREATE TRIGGER actualizar_disponibilidad_vehiculo_cancelado
AFTER DELETE ON reservas
FOR EACH ROW
BEGIN
    UPDATE vehiculos
    SET disponibilidad = "SI"
    WHERE idVehiculo = OLD.idVehiculo;
END$$

### 5. Cambiar disponibilidad cuando la reserva se finaliza
CREATE TRIGGER actualizar_estado_vehiculo_finalizado
AFTER UPDATE ON reservas
FOR EACH ROW
BEGIN
    IF NEW.estado = "finalizado" AND OLD.estado != "finalizado" THEN
        UPDATE vehiculos
        SET disponibilidad = "SI"
        WHERE idVehiculo = NEW.idVehiculo;
    END IF;
END$$

DELIMITER ;

```