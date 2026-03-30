-- Query 4: Thermal Record vs Quality Control (QC) Record
-- Operational question: What is the relationship between the temperature log
-- and the formal QC record for batch 50?
-- Note: The query uses UNION ALL to combine the 12 hourly temperature log entries
-- with the single QC record into one ordered output. The QC record is assigned
-- sequence 13 so that it sorts after the final temperature log entry, allowing
-- the run to be read chronologically from process conditions through to assessed outcome.

SELECT * FROM (
    SELECT 
        stl.run_hour AS sequence,
        stl.coolant_temp_c::text AS temp_or_outcome,
        stl.threshold_breached::text AS threshold_breached,
        stl.notes AS notes,
        'temperature_log' AS source
    FROM still_temperature_logs stl
    WHERE stl.batch_id = 50
    UNION ALL
    SELECT
        13 AS sequence,
        qc.approved::text AS temp_or_outcome,
        NULL AS threshold_breached,
        qc.notes AS notes,
        'qc_record' AS source
    FROM qc_records qc
    WHERE qc.batch_id = 50
) combined
ORDER BY sequence;
