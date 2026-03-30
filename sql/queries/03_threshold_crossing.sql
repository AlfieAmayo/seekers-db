-- Query 3: Threshold Crossing
-- Operational question: At what hour did batch 50 cross 50°C, and when did the run
-- enter conditions where flavour integrity was compromised?
-- Note: The 50°C threshold is taken from the upper bound of the legacy still's
-- steady-state range. It is the only defensible threshold available.
-- Once distillation begins the batch cannot be corrected or adjusted.
-- Intervention is only possible before the still is turned on.

SELECT 
    stl.run_hour, 
    stl.coolant_temp_c, 
    stl.threshold_breached, 
    stl.notes,
    CASE
        WHEN stl.coolant_temp_c < 50.0 THEN 'Running — no thermal alert'
        WHEN stl.coolant_temp_c >= 50.0 THEN 'Above threshold — flavour integrity compromised'
    END AS status
FROM still_temperature_logs stl
WHERE stl.batch_id = 50
ORDER BY stl.run_hour;
