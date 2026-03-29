-- =============================================================================
-- 005_skus.sql
-- Seekers Spirits — SKU reference data
-- 18 SKUs across 6 products (3 bottle sizes each: 50ml, 200ml, 700ml)
-- =============================================================================

INSERT INTO skus (sku, product_id, bottle_size_ml) VALUES
('JKBG050', 1, 50),
('JKBG200', 1, 200),
('JKBG700', 1, 700),
('SMCL050', 2, 50),
('SMCL200', 2, 200),
('SMCL700', 2, 700),
('SMDG050', 3, 50),
('SMDG200', 3, 200),
('SMDG700', 3, 700),
('SMGG050', 4, 50),
('SMGG200', 4, 200),
('SMGG700', 4, 700),
('SMOL050', 6, 50),
('SMOL200', 6, 200),
('SMOL700', 6, 700),
('SMVO050', 5, 50),
('SMVO200', 5, 200),
('SMVO700', 5, 700);
