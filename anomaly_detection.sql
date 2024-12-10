-- This Query will apply the ARIMA+ model that created to predict for anomaly.

CREATE OR REPLACE TABLE
 `droppoint_hr_result` AS (
 SELECT
   *
 FROM
   ML.DETECT_ANOMALIES (MODEL `hr_arima_plus`,
     STRUCT(0.90 AS anomaly_prob_threshold),
     (
     SELECT
       colo,
       tab_name,
       ts,
       cnt
     FROM
     `droppoint_ts_test`
     )) )
