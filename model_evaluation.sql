-- This query calculates the accuracy and False Postive rate for model evaluation.

WITH test as (
SELECT
re.cnt,
re.ts,
re.is_anomaly,
CASE WHEN t.is_added is NULL THEN 0 ELSE is_added END as is_added,
CASE WHEN is_added = 1 and is_anomaly = TRUE THEN 'Anomaly detected'
WHEN is_added = 1 and is_anomaly = FALSE THEN 'not detected'
WHEN (is_added = 0 OR is_added is null) and is_anomaly = TRUE THEN 'False positive'
WHEN (is_added = 0 OR is_added is null) and is_anomaly = FALSE THEN 'both False'
END as accuracy
FROM droppoint_hr_result as re
)


select accuracy, count(cnt) as cnt
from test
group by accuracy
