-- =============================================================================
-- 002_suppliers.sql
-- Seekers Spirits — supplier reference data
-- 11 suppliers
-- =============================================================================

INSERT INTO suppliers (supplier_id, supplier_name, country, contact_name, contact_email, payment_terms, lead_time_days, is_active, notes, supplier_type) VALUES
(1,  '3 Corners',                    'Cambodia',      NULL, NULL, 'Cash on delivery', 3,  TRUE, 'Cambodian coffee supplier',                                          'coffee'),
(2,  'Espresso Kampot',              'Cambodia',      NULL, NULL, 'Cash on delivery', 3,  TRUE, 'Kampot coffee supplier',                                             'coffee'),
(3,  'Feel Good Coffee',             'Thailand',      NULL, NULL, 'Net 30',           14, TRUE, 'Thai and Vietnamese coffee supplier',                                 'coffee'),
(4,  'Seng Kea Food Additive',       'Cambodia',      NULL, NULL, 'Cash on delivery', 5,  TRUE, 'NGS and lychee essence supplier',                                    'alcohol'),
(5,  'Vimean Tip',                   'Cambodia',      NULL, NULL, 'Cash on delivery', 3,  TRUE, 'Lychee juice supplier',                                              'juice'),
(6,  'Celliers d Asie',              'Cambodia',      NULL, NULL, 'Net 30',           7,  TRUE, 'Rose wine supplier for liqueurs',                                    'wine'),
(7,  'OIS Spiral',                   'International', NULL, NULL, 'Prepayment',       30, TRUE, 'Wood spiral supplier for barrel ageing',                             'maturation'),
(8,  'Aus Khmer',                    'Cambodia',      NULL, NULL, 'Net 30',           7,  TRUE, 'Rose wine supplier',                                                 'wine'),
(9,  'Seekers Independent Spirits',  'Cambodia',      NULL, NULL, 'Internal',         0,  TRUE, 'Internal production - house made ingredients',                       'internal'),
(10, 'Poivres D Indochine',          'Vietnam',       NULL, NULL, 'Net 30',           21, TRUE, 'Primary botanical supplier - juniper, spices, citrus, flowers',      'botanical'),
(11, 'Local Market',                 'Cambodia',      NULL, NULL, 'Cash on delivery', 1,  TRUE, 'Fresh local botanicals and herbs',                                   'botanical');

SELECT setval('suppliers_supplier_id_seq', (SELECT MAX(supplier_id) FROM suppliers));
