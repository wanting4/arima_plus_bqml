-- This query is an example of testing model deprecation. 
-- Run this query on each day to calculate the accuracy rate and false positive rate. 
-- Figure out the effective date range for the model until next retrain.

-- predict on each day data form 0905 to 0925, see the accuracy
WITH result_0905 AS (
SELECT
 *
FROM
 ML.DETECT_ANOMALIES (MODEL `hr_arima_plus`,
   STRUCT(0.94 AS anomaly_prob_threshold),
   (
   SELECT
     colo,
     tab_name,
     ts,
     cnt
   FROM
   `droppoint_ts_test`
   WHERE
     DATE(ts) = CAST('2024-09-05' AS DATE) ) 
)),




test as (
SELECT
re.cnt,
re.ts,
re.is_anomaly,
CASE WHEN t.is_added is NULL THEN 0 ELSE is_added END as is_added,
CASE WHEN is_added = 1 and is_anomaly = TRUE THEN 'both True'
WHEN is_added = 1 and is_anomaly = FALSE THEN 'not detected'
WHEN (is_added = 0 OR is_added is null) and is_anomaly = TRUE THEN 'False positive'
WHEN (is_added = 0 OR is_added is null) and is_anomaly = FALSE THEN 'both False'
END as accuracy
FROM result_0905 as re
)


select accuracy, count(cnt) as cnt
from test
group by accuracy
