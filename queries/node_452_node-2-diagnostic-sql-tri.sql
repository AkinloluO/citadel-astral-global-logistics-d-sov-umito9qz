SELECT HUB_ID,
       COUNT(*) AS dirty_hub_rows
FROM staging_raw_intake
WHERE TRIM(HUB_ID) != HUB_ID
   OR HUB_ID LIKE '% '
GROUP BY HUB_ID
ORDER BY dirty_hub_rows DESC;

SELECT WAYBILL_NUMBER,
       COUNT(*) AS collision_count
FROM staging_raw_intake
GROUP BY WAYBILL_NUMBER
HAVING COUNT(*) > 1
ORDER BY collision_count DESC;