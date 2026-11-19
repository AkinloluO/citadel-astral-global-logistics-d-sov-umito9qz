-- =========================================================================
-- EXECUTIVE RATIONALE:
-- Negative package counts corrupt hub capacity modeling and downstream inventory 
-- reconciliation, directly causing the ₦420M ledger variance. Isolating them into 
-- a quarantine layer protects financial balance sheets from unverified shrinkage.
-- =========================================================================

-- 1. Create the quarantined exceptions dataset (with uniform TRIM formatting)
CREATE TABLE IF NOT EXISTS quarantine_exceptions AS
SELECT 
    order_id,
    TRIM(customer_id) AS customer_id,
    TRIM(origin_hub_id) AS origin_hub_id,
    TRIM(destination_hub_id) AS destination_hub_id,
    order_date,
    package_count,
    total_weight_kg,
    declared_value_usd,
    UPPER(TRIM(order_status)) AS order_status
FROM orders
WHERE package_count < 0;

-- 2. Create the sanitized clean orders view (with matching uniform sanitization)
CREATE OR REPLACE VIEW clean_orders AS
SELECT 
    order_id,
    TRIM(customer_id) AS customer_id,
    TRIM(origin_hub_id) AS origin_hub_id,
    TRIM(destination_hub_id) AS destination_hub_id,
    order_date,
    package_count,
    total_weight_kg,
    declared_value_usd,
    UPPER(TRIM(order_status)) AS order_status
FROM orders
WHERE package_count >= 0;

-- 3. Calculate quarantined row count and total negative package variance 
-- (Expected Outliers: ORD-8007 (-12), ORD-8022 (-63), ORD-8065 (-81), ORD-8114 (-70) = -226 Total Variance)
SELECT 
    COUNT(*) AS quarantined_row_count,
    SUM(package_count) AS total_negative_package_variance
FROM quarantine_exceptions;