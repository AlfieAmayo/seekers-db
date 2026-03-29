-- =============================================================================
-- 001_create_schema.sql
-- Seekers Spirits — complete database schema
-- Tables in dependency order: no foreign key dependencies first,
-- dependent tables after.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- Reference / lookup tables
-- -----------------------------------------------------------------------------

CREATE TABLE customer_types (
    customer_type VARCHAR(20) PRIMARY KEY
);

CREATE TABLE suppliers (
    supplier_id     SERIAL PRIMARY KEY,
    supplier_name   VARCHAR(100) NOT NULL,
    country         VARCHAR(50),
    contact_name    VARCHAR(100),
    contact_email   VARCHAR(100),
    payment_terms   VARCHAR(100),
    lead_time_days  INTEGER,
    is_active       BOOLEAN DEFAULT TRUE,
    notes           TEXT,
    supplier_type   VARCHAR(50)
);

CREATE TABLE products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    abv          NUMERIC(5,2) NOT NULL,
    is_active    BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE skus (
    sku            VARCHAR(20) PRIMARY KEY,
    product_id     INTEGER NOT NULL REFERENCES products(product_id),
    bottle_size_ml INTEGER NOT NULL
);


-- -----------------------------------------------------------------------------
-- Ingredient and recipe tables
-- -----------------------------------------------------------------------------

CREATE TABLE ingredients (
    ingredient_id   SERIAL PRIMARY KEY,
    ingredient_name VARCHAR(100) NOT NULL UNIQUE,
    category        VARCHAR(50),
    unit_of_measure VARCHAR(20) NOT NULL,
    unit_price      NUMERIC(10,2),
    supplier_id     INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    is_active       BOOLEAN DEFAULT TRUE,
    notes           TEXT,
    ingredient_type TEXT,
    default_unit    TEXT NOT NULL
);

CREATE TABLE recipes (
    id                SERIAL PRIMARY KEY,
    recipe_id         INTEGER NOT NULL,
    product_id        INTEGER NOT NULL REFERENCES products(product_id),
    ingredient_id     INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
    quantity_required NUMERIC(10,3) NOT NULL,
    unit_of_measure   VARCHAR(20) NOT NULL,
    notes             TEXT,
    recipe_version    INTEGER DEFAULT 1 NOT NULL,
    valid_from        DATE DEFAULT '2021-06-01' NOT NULL,
    change_reason     TEXT
);


-- -----------------------------------------------------------------------------
-- Customers
-- -----------------------------------------------------------------------------

CREATE TABLE customers (
    customer_id       SERIAL PRIMARY KEY,
    customer_name     VARCHAR(100) NOT NULL,
    customer_type     VARCHAR(20) NOT NULL REFERENCES customer_types(customer_type),
    country           VARCHAR(50) DEFAULT 'Cambodia',
    contact_name      VARCHAR(100),
    contact_email     VARCHAR(100),
    is_active         BOOLEAN DEFAULT TRUE,
    notes             TEXT,
    payment_terms_days INTEGER DEFAULT 30,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at        TIMESTAMP,
    CONSTRAINT valid_payment_terms_days CHECK (payment_terms_days >= 0),
    CONSTRAINT valid_customer_type CHECK (
        customer_type IN ('bar','restaurant','hotel','retailer','distributor','event')
    )
);


-- -----------------------------------------------------------------------------
-- Stock receipts
-- -----------------------------------------------------------------------------

CREATE TABLE stock_receipts (
    receipt_id             SERIAL PRIMARY KEY,
    ingredient_id          INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
    supplier_id            INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    supplier_lot_reference VARCHAR(50),
    quantity_received      NUMERIC(10,3) NOT NULL,
    unit_of_measure        VARCHAR(20) NOT NULL,
    received_date          DATE NOT NULL,
    received_by            VARCHAR(100),
    condition              VARCHAR(20) DEFAULT 'good',
    notes                  TEXT
);


-- -----------------------------------------------------------------------------
-- Batches
-- -----------------------------------------------------------------------------

CREATE TABLE batches (
    batch_id             SERIAL PRIMARY KEY,
    upi                  VARCHAR(50) NOT NULL UNIQUE,
    product_name         VARCHAR(100) NOT NULL,
    still_used           VARCHAR(20) NOT NULL,
    stage                VARCHAR(20) NOT NULL,
    batch_date           DATE NOT NULL,
    batch_type           CHAR(1) DEFAULT 'P',
    status               VARCHAR(20) DEFAULT 'completed',
    notes                TEXT,
    still_output_litres  NUMERIC(6,2),
    water_added_litres   NUMERIC(6,2),
    actual_batch_cost    NUMERIC(10,2),
    distillate_abv       NUMERIC(5,2),
    target_abv           NUMERIC(5,2),
    expected_yield_litres NUMERIC(8,2),
    actual_yield_litres  NUMERIC(8,2),
    process_loss_litres  NUMERIC(8,2),
    recipe_id            INTEGER,
    CONSTRAINT chk_batches_actual_batch_cost CHECK (actual_batch_cost IS NULL OR actual_batch_cost >= 0),
    CONSTRAINT chk_batches_actual_yield_litres CHECK (actual_yield_litres IS NULL OR actual_yield_litres >= 0),
    CONSTRAINT chk_batches_distillate_abv CHECK (distillate_abv IS NULL OR (distillate_abv > 0 AND distillate_abv <= 100)),
    CONSTRAINT chk_batches_expected_yield_litres CHECK (expected_yield_litres IS NULL OR expected_yield_litres >= 0),
    CONSTRAINT chk_batches_process_loss_litres CHECK (process_loss_litres IS NULL OR process_loss_litres >= 0),
    CONSTRAINT chk_batches_still_output_litres CHECK (still_output_litres IS NULL OR still_output_litres >= 0),
    CONSTRAINT chk_batches_target_abv CHECK (target_abv IS NULL OR (target_abv > 0 AND target_abv <= 100)),
    CONSTRAINT chk_batches_water_added_litres CHECK (water_added_litres IS NULL OR water_added_litres >= 0)
);


-- -----------------------------------------------------------------------------
-- Batch junction and output tables
-- -----------------------------------------------------------------------------

CREATE TABLE batch_ingredients (
    batch_ingredient_id SERIAL PRIMARY KEY,
    batch_id            INTEGER NOT NULL REFERENCES batches(batch_id),
    ingredient_id       INTEGER NOT NULL REFERENCES ingredients(ingredient_id),
    quantity_used       NUMERIC(10,3) NOT NULL,
    unit_of_measure     VARCHAR(20) NOT NULL,
    notes               TEXT,
    receipt_id          INTEGER NOT NULL REFERENCES stock_receipts(receipt_id)
);

CREATE TABLE batch_outputs (
    output_id             SERIAL PRIMARY KEY,
    batch_id              INTEGER NOT NULL REFERENCES batches(batch_id),
    sku                   VARCHAR(20) REFERENCES skus(sku),
    bottles_filled        INTEGER NOT NULL,
    unaccounted_volume_ml NUMERIC(10,2),
    notes                 TEXT
);

CREATE INDEX idx_batch_outputs_sku ON batch_outputs(sku);


-- -----------------------------------------------------------------------------
-- Orders
-- -----------------------------------------------------------------------------

CREATE TABLE orders (
    order_id       SERIAL PRIMARY KEY,
    customer_id    INTEGER NOT NULL REFERENCES customers(customer_id),
    batch_id       INTEGER REFERENCES batches(batch_id),
    product_name   VARCHAR(100) NOT NULL,
    bottles_ordered INTEGER NOT NULL,
    order_date     DATE NOT NULL,
    shipped_date   DATE,
    payment_status VARCHAR(20) DEFAULT 'pending',
    order_value    NUMERIC(10,2),
    channel        VARCHAR(20),
    notes          TEXT,
    bottle_size_ml INTEGER,
    order_status   VARCHAR(20) DEFAULT 'fulfilled'
);


-- -----------------------------------------------------------------------------
-- QC records
-- -----------------------------------------------------------------------------

CREATE TABLE qc_records (
    qc_id               SERIAL PRIMARY KEY,
    batch_id            INTEGER NOT NULL REFERENCES batches(batch_id),
    qc_reference        VARCHAR(50) NOT NULL,
    qc_date             DATE NOT NULL,
    assessed_by         VARCHAR(100) NOT NULL,
    abv_measured        NUMERIC(5,2),
    clarity             VARCHAR(20),
    nose_condition      VARCHAR(20),
    nose_intensity      VARCHAR(20),
    palate_condition    VARCHAR(20),
    flavour_intensity   VARCHAR(20),
    finish              VARCHAR(20),
    quality_level       VARCHAR(20),
    comparison_to_base  VARCHAR(20),
    notes               TEXT,
    approved            BOOLEAN DEFAULT FALSE,
    qc_stage            VARCHAR(30),
    still_used          VARCHAR(20),
    temperature_c       NUMERIC(5,2),
    deviation_detected  BOOLEAN
);


-- -----------------------------------------------------------------------------
-- Inventory snapshots
-- -----------------------------------------------------------------------------

CREATE TABLE inventory_snapshots (
    snapshot_id    SERIAL PRIMARY KEY,
    product_name   VARCHAR(100) NOT NULL,
    bottle_size_ml INTEGER NOT NULL,
    snapshot_date  DATE NOT NULL,
    counted_by     VARCHAR(100),
    bottles_counted INTEGER NOT NULL,
    notes          TEXT,
    status         VARCHAR(20) DEFAULT 'available',
    batch_id       INTEGER REFERENCES batches(batch_id),
    snapshot_type  VARCHAR(30) DEFAULT 'weekly'
);


-- -----------------------------------------------------------------------------
-- Still temperature logs
-- -----------------------------------------------------------------------------

CREATE TABLE still_temperature_logs (
    log_id           SERIAL PRIMARY KEY,
    batch_id         INTEGER NOT NULL REFERENCES batches(batch_id),
    run_hour         INTEGER NOT NULL CHECK (run_hour >= 1),
    coolant_temp_c   NUMERIC(5,2) NOT NULL,
    ambient_temp_c   NUMERIC(5,2),
    threshold_breached BOOLEAN DEFAULT FALSE NOT NULL,
    notes            TEXT,
    CONSTRAINT uq_still_temp_batch_hour UNIQUE (batch_id, run_hour)
);
