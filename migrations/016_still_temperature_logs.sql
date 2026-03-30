-- Migration 016: still_temperature_logs
-- 28 rows ordered by log_id.
-- Batches 48 and 49 are control runs. Batch 50 is the iSTILL cooling failure incident run.
-- threshold_breached = true only for batch 50 rows where coolant_temp exceeded 50C.

INSERT INTO still_temperature_logs (
    log_id,
    batch_id,
    run_hour,
    coolant_temp_c,
    ambient_temp_c,
    threshold_breached,
    notes
) VALUES
(1, 48, 1, 31.00, 31.50, false, 'Run start.'),
(2, 48, 2, 32.20, 31.50, false, 'Tasted. Clean.'),
(3, 48, 3, 33.50, 31.50, false, NULL),
(4, 48, 4, 34.50, 31.50, false, NULL),
(5, 48, 5, 35.50, 31.50, false, NULL),
(6, 48, 6, 36.60, 31.50, false, NULL),
(7, 48, 7, 37.80, 31.50, false, 'Tasted. No issues.'),
(8, 48, 8, 38.50, 31.50, false, 'Run complete. QC pass.'),
(9, 49, 1, 30.80, 32.00, false, 'Run start.'),
(10, 49, 2, 32.00, 32.00, false, 'Tasted. Clean.'),
(11, 49, 3, 33.40, 32.00, false, NULL),
(12, 49, 4, 34.60, 32.00, false, 'Tasted. No issues.'),
(13, 49, 5, 35.80, 32.00, false, NULL),
(14, 49, 6, 37.00, 32.00, false, NULL),
(15, 49, 7, 38.20, 32.00, false, NULL),
(16, 49, 8, 39.10, 32.00, false, 'Run complete. QC pass.'),
(17, 50, 1, 31.00, 33.50, false, 'Run start.'),
(18, 50, 2, 32.25, 33.50, false, NULL),
(19, 50, 3, 33.60, 33.50, false, 'Tasted. Normal profile.'),
(20, 50, 4, 34.80, 33.50, false, NULL),
(21, 50, 5, 36.20, 33.50, false, 'Tasted. Clean.'),
(22, 50, 6, 37.80, 33.50, false, NULL),
(23, 50, 7, 40.00, 33.50, false, 'Running hotter than usual. Tasted. As expected.'),
(24, 50, 8, 43.00, 33.50, false, NULL),
(25, 50, 9, 46.20, 33.50, false, NULL),
(26, 50, 10, 49.00, 33.50, false, NULL),
(27, 50, 11, 51.50, 33.50, true, 'Tasted. Clean.'),
(28, 50, 12, 54.20, 33.50, true, 'Run complete. Output felt hot — 61.8°C noted from dashboard. Batch held pending QC.');

SELECT setval('still_temperature_logs_log_id_seq', (SELECT MAX(log_id) FROM still_temperature_logs));