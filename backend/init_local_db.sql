-- ==========================================
-- 1. Crear tabla de usuarios
-- ==========================================
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(80) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(30) NOT NULL,
    nombre VARCHAR(120)
);

-- ==========================================
-- 2. Crear tabla de productos
-- ==========================================
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(30) UNIQUE NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    precio INTEGER NOT NULL,
    categoria VARCHAR(40),
    activo BOOLEAN NOT NULL DEFAULT true
);

-- ==========================================
-- 3. Crear tabla de ventas
-- ==========================================
CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    fecha TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL,
    precio_unitario INTEGER NOT NULL,
    total INTEGER NOT NULL,
    vendedor_id INTEGER REFERENCES usuarios(id),
    estado VARCHAR(40) DEFAULT 'pendiente',
    pago VARCHAR(40) DEFAULT 'efectivo'
);

-- ==========================================
-- 4. Insertar usuarios por defecto
-- ==========================================
INSERT INTO usuarios (username, password, rol, nombre)
VALUES 
    ('admin', 'admin123', 'admin', 'Administrador'),
    ('vendedor1', 'vende123', 'vendedor', 'Vendedor 1'),
    ('vendedor2', 'vende456', 'vendedor', 'Vendedor 2')
ON CONFLICT (username) DO NOTHING;

-- ==========================================
-- 5. Insertar productos del menú
-- ==========================================
INSERT INTO productos (codigo, nombre, precio, categoria)
VALUES
    ('MINIH', 'Mini Hamburguesa', 5500, 'hamburguesa'),
    ('HSINT', 'Hamburguesa sin tomate', 10000, 'hamburguesa'),
    ('HCONT', 'Hamburguesa con tomate', 11000, 'hamburguesa'),
    ('HDOBLE', 'Hamburguesa doble', 18000, 'hamburguesa'),
    ('PSINT', 'Perro sin tomate', 8000, 'perro'),
    ('PCONT', 'Perro con tomate', 9000, 'perro'),
    ('COCA', 'Coca-Cola', 3000, 'bebida'),
    ('CUATRO', 'Cuatro', 3000, 'bebida'),
    ('JUGOS', 'Jugos', 2000, 'bebida'),
    ('TE', 'Té', 2000, 'bebida'),
    ('AGUA', 'Agua', 2000, 'bebida'),
    ('AQUESO', 'Adición de queso', 1000, 'adicional'),
    ('ATOCINO', 'Adición de tocino', 1000, 'adicional')
ON CONFLICT (codigo) DO UPDATE 
SET nombre = EXCLUDED.nombre, precio = EXCLUDED.precio, categoria = EXCLUDED.categoria;
