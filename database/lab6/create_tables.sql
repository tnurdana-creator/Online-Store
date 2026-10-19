CREATE TABLE order_items (
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE payments (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE error_checks (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    error_type VARCHAR(100),
    warning_text TEXT,
    client_confirmed BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE consolidation_points (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE delivery_plans (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL UNIQUE,
    status VARCHAR(50) NOT NULL DEFAULT 'planned',
    consolidation_point_id INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (consolidation_point_id)
        REFERENCES consolidation_points(id)
);

CREATE TABLE warehouses (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE warehouse_stock (
    warehouse_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (warehouse_id, product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE delivery_plan_warehouses (
    plan_id INTEGER NOT NULL,
    warehouse_id INTEGER NOT NULL,
    PRIMARY KEY (plan_id, warehouse_id),
    FOREIGN KEY (plan_id) REFERENCES delivery_plans(id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
);

CREATE TABLE couriers (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE deliveries (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INTEGER NOT NULL,
    courier_id INTEGER NOT NULL,
    consolidation_point_id INTEGER,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (courier_id) REFERENCES couriers(id),
    FOREIGN KEY (consolidation_point_id)
        REFERENCES consolidation_points(id)
);





