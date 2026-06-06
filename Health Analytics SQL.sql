WITH Data AS(


SELECT

Gender,

COUNT(`Patient ID`) AS  patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score

FROM

ocd_health.ocd_patient_dataset

GROUP BY 1
)

SELECT

SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) as count_female,
SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) as count_male,

-- Percentage female

ROUND(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) / 
(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END))*100, 2) AS pct_female,

-- Percentage male
ROUND(SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)/
(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END))*100, 2) AS pct_male


FROM

Data;


-- Count and Average Obsession Score by Ethnicity
-- Among everyone diagnosed with OCD, how are patients distributed across different ethnicities, and what is the average obsession score for each ethnicity?

SELECT

Ethnicity,

COUNT(`Patient ID`) AS patient_count,
AVG(`Y-BOCS Score (Obsessions)`) AS obs_score 

FROM

ocd_health.ocd_patient_dataset

GROUP BY 1
ORDER BY 2;


-- How many people were diagnosed with OCD each month?

-- Changed the  Date colum from text  for Date data type
-- ALTER TABLE ocd_health.ocd_patient_dataset
-- MODIFY `OCD Diagnosis Date` DATE;

-- Grouping Diagnosis by month Using the dateformat function

SELECT
DATE_FORMAT(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
-- `OCD Diagnosis Date`
COUNT(`Patient ID`) as patient_count
FROM ocd_health.ocd_patient_dataset
GROUP BY 1
ORDER BY 1;
