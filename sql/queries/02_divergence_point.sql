-- Query 2: Divergence Point
-- Operational question: At what hour did batch 50 first diverge from the control baseline,
-- and how quickly did that divergence increase?
-- Note: Comparison ends at hour 8 because control runs peaked at 7.5 hours.
-- Beyond this point no baseline exists and divergence can no longer be measured
-- against a known reference.

SELECT stl.batch_id, stl.run_hour, stl.coolant_temp_c,
    ROUND(AVG(ctrl.coolant_temp_c), 2) AS control_avg_temp,
    ROUND(stl.coolant_temp_c - AVG(ctrl.coolant_temp_c), 2) AS delta_from_baseline
FROM still_temperature_logs stl
JOIN still_temperature_logs ctrl
    ON ctrl.run_hour = stl.run_hour
    AND ctrl.batch_id IN (48, 49)
WHERE stl.batch_id = 50
GROUP BY stl.batch_id, stl.run_hour, stl.coolant_temp_c
ORDER BY stl.run_hour;
