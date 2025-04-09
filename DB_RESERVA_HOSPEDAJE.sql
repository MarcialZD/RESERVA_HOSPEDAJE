CREATE DATABASE DB_RESERVA_HOSPEDAJE;
GO

USE DB_RESERVA_HOSPEDAJE;
GO

CREATE TABLE roles (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL UNIQUE -- admin, gerente, usuario
);
GO

CREATE TABLE usuarios (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);
GO

CREATE TABLE hospedajes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    descripcion TEXT,
    gerente_id INT,
    FOREIGN KEY (gerente_id) REFERENCES usuarios(id)
);
GO

CREATE TABLE habitaciones (
    id INT PRIMARY KEY IDENTITY(1,1),
    hospedaje_id INT,
    numero VARCHAR(20),
    tipo VARCHAR(50), -- simple, doble, suite
    precio DECIMAL(10,2),
    capacidad INT,
    estado VARCHAR(20) DEFAULT 'disponible', -- disponible, reservada, mantenimiento
    FOREIGN KEY (hospedaje_id) REFERENCES hospedajes(id)
);
GO

CREATE TABLE reservas (
    id INT PRIMARY KEY IDENTITY(1,1),
    usuario_id INT,
    habitacion_id INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20) DEFAULT 'pendiente', -- pendiente, confirmada, cancelada
    fecha_reserva DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id)
);
GO

CREATE TABLE pagos (
    id INT PRIMARY KEY IDENTITY(1,1),
    reserva_id INT,
    monto DECIMAL(10,2),
    metodo_pago VARCHAR(50), -- tarjeta, efectivo, etc.
    fecha_pago DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (reserva_id) REFERENCES reservas(id)
);
GO
