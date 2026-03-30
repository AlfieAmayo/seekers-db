-- Query 1: Control Baseline
-- Operational question: What did normal iSTILL behaviour look like across a full run?
-- Batches 48 and 49 are Orange Liqueur runs completed in May 2023.
-- Both ran for 7.5 hours and passed QC.
-- These runs represent the only confirmed normal operating profile for this still prior to the incident.

SELECT
    stl.batch_id,
    b.product_name,
    b.batch_date,
    stl.run_hour,
    stl.coolant_temp_c,
    stl.ambient_temp_c,
    stl.notes
FROM still_temperature_logs stl
JOIN batches b ON stl.batch_id = b.batch_id
WHERE stl.batch_id IN (48, 49)
ORDER BY stl.batch_id, stl.run_hour;
