-- =============================================================================
-- 006_ingredients.sql
-- Seekers Spirits — ingredient catalogue
-- 38 ingredients
-- Note: ingredient_ids are not fully sequential (36, 38, 40 — gaps at 37, 39)
-- =============================================================================

INSERT INTO ingredients (ingredient_id, ingredient_name, category, unit_of_measure, unit_price, supplier_id, is_active, notes, ingredient_type, default_unit) VALUES
(1,  'Neutral Grain Spirit',            'base_spirit',        'litres', NULL, 4,  TRUE, 'NGS 96% ABV from Seng Kea',                                                    'alcohol',            'litres'),
(2,  'RO Water',                        'water',              'litres', NULL, 9,  TRUE, 'Internally processed reverse osmosis water',                                    'water',              'litres'),
(3,  'Rose Wine',                       'wine',               'litres', NULL, 6,  TRUE, 'Rose wine for liqueurs from Celliers d Asie',                                   'alcohol',            'litres'),
(4,  'Sugar',                           'sweetener',          'kg',     NULL, 4,  TRUE, 'White sugar from Seng Kea',                                                     'sugar',              'kg'),
(5,  'Lychee Essence',                  'essence',            'litres', NULL, 4,  TRUE, 'Lychee flavouring from Seng Kea',                                               'essence',            'litres'),
(6,  'Lychee Juice',                    'juice',              'litres', NULL, 5,  TRUE, 'Fresh lychee juice from Vimean Tip',                                            'juice',              'litres'),
(7,  'Juniper Berries',                 'botanical',          'kg',     NULL, 10, TRUE, 'Primary gin botanical - Macedonian juniper from Poivres D Indochine',           'botanical',          'kg'),
(8,  'Coriander Seed',                  'botanical',          'kg',     NULL, 10, TRUE, 'From Poivres D Indochine',                                                      'botanical',          'kg'),
(9,  'Angelica Root',                   'botanical',          'kg',     NULL, 10, TRUE, 'From Poivres D Indochine',                                                      'botanical',          'kg'),
(10, 'Cassia Bark',                     'botanical',          'kg',     NULL, 10, TRUE, 'From Poivres D Indochine',                                                      'botanical',          'kg'),
(11, 'Liquorice Root',                  'botanical',          'kg',     NULL, 10, TRUE, 'Powdered liquorice root from Poivres D Indochine',                              'botanical',          'kg'),
(12, 'Pomelo Peel',                     'botanical',          'kg',     NULL, 10, TRUE, 'Dried pomelo peel from Poivres D Indochine',                                    'botanical',          'kg'),
(13, 'Hibiscus',                        'botanical',          'kg',     NULL, 10, TRUE, 'Dried hibiscus flowers from Poivres D Indochine',                               'botanical',          'kg'),
(14, 'Buddhas Hand',                    'botanical',          'kg',     NULL, 10, TRUE, 'Dried Buddha s Hand citron from Poivres D Indochine',                           'botanical',          'kg'),
(15, 'Kumquat',                         'botanical',          'kg',     NULL, 10, TRUE, 'Dried kumquat from Poivres D Indochine',                                        'botanical',          'kg'),
(16, 'Vietnamese Dried Orange Peel',    'botanical',          'kg',     NULL, 10, TRUE, 'Dried Vietnamese orange peel from Poivres D Indochine',                         'botanical',          'kg'),
(17, 'Butterfly Pea Flower',            'botanical',          'kg',     NULL, 10, TRUE, 'Dried butterfly pea blossom from Poivres D Indochine',                          'botanical',          'kg'),
(18, 'Khaffir Lime Leaf',               'botanical',          'kg',     NULL, 11, TRUE, 'Fresh kaffir lime leaves from local market',                                    'botanical',          'kg'),
(19, 'Pandan Leaf - Dried',             'botanical',          'kg',     NULL, 11, TRUE, 'Dried pandan from local market',                                                'botanical',          'kg'),
(20, 'Vietnamese Green Orange (dry)',   'botanical',          'kg',     NULL, 11, TRUE, 'Dried Vietnamese green orange from local market',                               'botanical',          'kg'),
(21, 'Lemongrass',                      'botanical',          'kg',     NULL, 11, TRUE, 'Dried lemongrass from local market',                                            'botanical',          'kg'),
(22, 'Khmer Basil',                     'botanical',          'kg',     NULL, 11, TRUE, 'Dried Khmer basil from local market',                                           'botanical',          'kg'),
(23, 'Jasmine Flower',                  'botanical',          'kg',     NULL, 11, TRUE, 'Dried jasmine flowers from local market',                                       'botanical',          'kg'),
(24, 'Galangal',                        'botanical',          'kg',     NULL, 11, TRUE, 'Dried galangal from local market',                                              'botanical',          'kg'),
(25, 'Fresh Lime Peel',                 'botanical',          'kg',     NULL, 11, TRUE, 'Fresh lime peel from local market',                                             'botanical',          'kg'),
(26, 'Rose Apple',                      'botanical',          'kg',     NULL, 11, TRUE, 'Fresh rose apple from local market',                                            'botanical',          'kg'),
(27, 'Cambodian Fresh Orange Peel',     'botanical',          'kg',     NULL, 11, TRUE, 'Fresh Cambodian orange peel from local market',                                 'botanical',          'kg'),
(28, 'Chinese Orange Dry Peel',         'botanical',          'kg',     NULL, 11, TRUE, 'Dried Chinese orange peel from local market',                                   'botanical',          'kg'),
(29, 'Thai Orange Dry Peel',            'botanical',          'kg',     NULL, 11, TRUE, 'Dried Thai orange peel from local market',                                      'botanical',          'kg'),
(30, 'Laos Coffee',                     'coffee',             'kg',     NULL, 2,  TRUE, 'Laos origin coffee from Espresso Kampot',                                       'botanical',          'kg'),
(31, 'Cambodian Coffee',                'coffee',             'kg',     NULL, 1,  TRUE, 'Cambodian origin coffee from 3 Corners',                                        'botanical',          'kg'),
(32, 'Thai Coffee',                     'coffee',             'kg',     NULL, 3,  TRUE, 'Thai origin coffee from Feel Good Coffee',                                      'botanical',          'kg'),
(33, 'Amburana Wood Spiral',            'maturation',         'kg',     NULL, 7,  TRUE, 'OIS Spiral - light toast amburana for Gold Gin maturation',                     'wood',               'kg'),
(34, 'Sugar Maple Wood Spiral',         'maturation',         'kg',     NULL, 7,  TRUE, 'OIS Spiral - medium toast sugar maple for Gold Gin maturation',                 'wood',               'kg'),
(35, 'Cassia Bark Distillate',          'internal_distillate','litres', NULL, 9,  TRUE, 'Internally produced cassia bark distillate for Jason Kong',                     'distillate',         'litres'),
(36, 'Seekers Mekong Vodka',            'internal_spirit',    'litres', NULL, 9,  TRUE, 'Internally produced vodka used as base for Coffee Liqueur',                     'alcohol',            'litres'),
(38, 'Pandan Leaf - Fresh',             NULL,                 'kg',     NULL, 11, TRUE, NULL,                                                                            'botanical',          'kg'),
(40, 'Cardamom',                        NULL,                 'kg',     NULL, 10, TRUE, NULL,                                                                            'botanical',          'kg');

SELECT setval('ingredients_ingredient_id_seq', (SELECT MAX(ingredient_id) FROM ingredients));
