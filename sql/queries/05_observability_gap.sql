-- Query 5: The Observability Gap
-- Operational question: Without still_temperature_logs, what could the database
-- tell you about batch 50?
-- This query represents the system as it existed at the time of the incident.
-- With the reconstructed temperature data removed, the database contains a single
-- record for batch 50: a quality control entry indicating failure.
-- The signals did exist during the run but none of it was retained.
-- Detection is not retention.

SELECT
    b.batch_id,
    b.product_name,
    b.batch_date,
    qc.qc_reference,
    qc.qc_date,
    qc.approved,
    qc.notes AS qc_notes
FROM batches b
JOIN qc_records qc ON b.batch_id = qc.batch_id
WHERE b.batch_id = 50;
