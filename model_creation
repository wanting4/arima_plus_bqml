-- This query create the ARIMA+ model. 
-- feed category columns to time_series_id_col

CREATE OR REPLACE MODEL
`hr_arima_plus` OPTIONS ( model_type = 'ARIMA_PLUS',
 time_series_timestamp_col = 'ts',
 time_series_data_col = 'cnt',
 time_series_id_col = ['colo_region','mail_table'],
 auto_arima = TRUE,
 Data_frequency = 'HOURLY'
) AS
SELECT
colo,
tab_name,
ts,
cnt
FROM
`droppoint_ts`
;
