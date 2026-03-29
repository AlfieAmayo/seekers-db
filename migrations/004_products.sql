-- =============================================================================
-- 004_products.sql
-- Seekers Spirits — product reference data
-- 6 products
-- =============================================================================

INSERT INTO products (product_id, product_name, abv, is_active) VALUES
(1, 'Jason Kong Butterfly Pea Gin', 41.30, TRUE),
(2, 'Seekers Coffee Liqueur',       25.00, TRUE),
(3, 'Seekers Mekong Dry Gin',       41.30, TRUE),
(4, 'Seekers Mekong Gold Gin',      41.30, TRUE),
(5, 'Seekers Mekong Vodka',         40.00, TRUE),
(6, 'Seekers Orange Liqueur',       35.00, TRUE);

SELECT setval('products_product_id_seq', (SELECT MAX(product_id) FROM products));
