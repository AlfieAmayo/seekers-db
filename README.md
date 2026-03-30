# Seekers Spirits — Operations Database

A PostgreSQL database modelling production operations at Seekers Spirits, a craft distillery based in Phnom Penh, Cambodia.

The database was built retrospectively to model real operational events, with two embedded failure scenarios anchoring reliability engineering investigations. The schema, data, and investigation queries are designed to demonstrate how structured data supports failure diagnosis, blast radius scoping, and post-incident reconstruction.

## What the database models

- Production batches across two stills — a 300L legacy still and a 2000L iSTILL
- Supplier ingredient receipts with lot-level traceability
- Batch ingredients linking production runs to specific supplier lots
- Quality control records including multi-assessment batches and retrospective findings
- Finished bottle outputs by SKU across three bottle formats
- Weekly inventory snapshots and pre-shipment counts
- Hourly coolant temperature logs for iSTILL production runs

## Two embedded failure scenarios

**Juniper Contamination — July 2022:** A contaminated supplier lot affecting four consecutive batches across three products. The investigation traces lot PDI-JNP-220620 through the traceability chain to 715 quarantined bottles.

**iSTILL Cooling System Failure — June 2023:** Thermal drift accumulation during a 12-hour gin run, with no coolant temperature data retained during production. The investigation reconstructs what the data would have shown.

## Navigation

- `migrations/` — 16 ordered migration files covering schema creation and full data population
- `sql/queries/` — five investigation queries for the iSTILL cooling system failure

Each query file is self-contained and can be run directly against the database. Comments at the top of each file explain the operational question it answers.

## Running the database

The database runs on PostgreSQL 16. Execute the migration files in order from 001 to 016 to recreate the full database from scratch.
