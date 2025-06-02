-- SQL Portfolio Project: Healthcare Dataset Analysis

-- Objective:
-- This script demonstrates fundamental SQL skills for data cleaning, transformation,
-- and basic exploratory data analysis using a simulated healthcare dataset.
-- The process focuses on preparing the data for further analysis and
-- extracting initial insights.

-- Step 1: Initial Data Inspection (Optional, for understanding the original structure)
-- SELECT *
-- FROM healthcare_dataset;

-- Step 2: Create a Working Copy of the Dataset
-- It's best practice to work on a copy of the original data to prevent 
-- accidental modification of the source and ensure reproducibility.
DROP TABLE IF EXISTS healthcare_dataset_copy;
CREATE TABLE healthcare_dataset_copy
SELECT *
FROM healthcare_dataset;

-- Step 3: Verify the Creation of the Copy
-- SELECT *
-- FROM healthcare_dataset_copy;

-- Step 4: Data Cleaning - Rename Columns and Apply SQL Naming Conventions
-- Renaming columns to 'snake_case' (e.g., 'full_name') and removing spaces
-- improves readability, ensures compatibility with SQL queries (avoiding quoted identifiers),
-- and adheres to common professional naming standards.
ALTER TABLE healthcare_dataset_copy
RENAME COLUMN `Name` TO full_name,
RENAME COLUMN Age TO age,
RENAME COLUMN Gender TO gender,
RENAME COLUMN `Blood Type` TO blood_type,
RENAME COLUMN `Medical Condition` TO medical_condition,
RENAME COLUMN `Date of Admission` TO date_of_admission,
RENAME COLUMN `Doctor` TO doctor,
RENAME COLUMN `Hospital` TO hospital,
RENAME COLUMN `Insurance Provider` TO insurance_provider,
RENAME COLUMN `Billing Amount` TO billing_amount,
RENAME COLUMN `Room Number` TO room_number,
RENAME COLUMN `Admission Type` TO admission_type,
RENAME COLUMN `Discharge Date` TO discharge_date,
RENAME COLUMN Medication TO medication,
RENAME COLUMN `Test Results` TO test_results;

-- Step 5: Data Type Conversion
-- Converting columns to appropriate data types (DATE, DECIMAL) ensures data integrity,
-- allows for correct date arithmetic, and prevents issues with aggregation functions.
ALTER TABLE healthcare_dataset_copy
MODIFY COLUMN date_of_admission DATE,
MODIFY COLUMN discharge_date DATE,
MODIFY COLUMN billing_amount DECIMAL(10, 2); -- DECIMAL(Precision, Scale) for monetary values

-- Step 6: Add a Primary Key
-- Adding an auto-incrementing primary key (`patient_id`) provides a unique identifier
-- for each record, which is crucial for relational database design, data integrity,
-- and efficient record retrieval.
ALTER TABLE healthcare_dataset_copy
ADD COLUMN patient_id INT PRIMARY KEY AUTO_INCREMENT; -- Use SERIAL PRIMARY KEY for PostgreSQL

-- Step 7: Performance Optimization - Create Indexes
-- Creating indexes on frequently queried columns (especially those used in WHERE,
-- GROUP BY, or ORDER BY clauses) significantly improves query performance by
-- allowing the database to quickly locate relevant data without full table scans.
CREATE INDEX idx_healthcare_doctor
ON healthcare_dataset_copy (doctor(255));
CREATE INDEX idx_healthcare_hospital
ON healthcare_dataset_copy (hospital(255));
-- Additional indexes can be added for other columns used in filtering or grouping,
-- such as medical_condition or date_of_admission, depending on query patterns.
-- CREATE INDEX idx_healthcare_medical_condition ON healthcare_dataset_copy (medical_condition);
-- CREATE INDEX idx_healthcare_date_of_admission ON healthcare_dataset_copy (date_of_admission);


-- Step 8: Data Quality Check - Identify Rows with Missing Values (NULLs)
-- This query helps to identify if any critical data is missing after initial loading.
-- (Note: For this specific synthetic dataset, no NULLs were found, but this step
-- is crucial in real-world scenarios for understanding data completeness.)
SELECT *
FROM healthcare_dataset_copy
WHERE full_name IS NULL
OR age IS NULL
OR gender IS NULL
OR blood_type IS NULL
OR medical_condition IS NULL
OR date_of_admission IS NULL
OR doctor IS NULL
OR hospital IS NULL
OR insurance_provider IS NULL
OR billing_amount IS NULL
OR room_number IS NULL
OR admission_type IS NULL
OR discharge_date IS NULL
OR medication IS NULL
OR test_results IS NULL;

-- Step 9: Exploratory Data Analysis (EDA) - Understand Unique Values
-- These queries help to understand the distinct categories present in key
-- categorical columns, which is important for data validation and identifying
-- potential inconsistencies.
SELECT DISTINCT gender
FROM healthcare_dataset_copy;

SELECT DISTINCT blood_type
FROM healthcare_dataset_copy;

SELECT DISTINCT medical_condition
FROM healthcare_dataset_copy;

SELECT DISTINCT doctor
FROM healthcare_dataset_copy;

SELECT DISTINCT hospital
FROM healthcare_dataset_copy;

SELECT DISTINCT insurance_provider
FROM healthcare_dataset_copy;

SELECT DISTINCT admission_type
FROM healthcare_dataset_copy;

SELECT DISTINCT medication
FROM healthcare_dataset_copy;

SELECT DISTINCT test_results
FROM healthcare_dataset_copy;

-- Step 10: Basic Analytical Queries

-- Count of Patients per Doctor:
-- Groups records by doctor and counts the number of patients for each,
-- ordered from most to least patients. Did this to understand how many 
-- duplicate doctors there were to see if it might be a useful column for
-- analysis
SELECT doctor, COUNT(*) AS patient_count
FROM healthcare_dataset_copy
GROUP BY doctor
ORDER BY patient_count DESC;

-- Count of Admissions per Hospital:
-- Groups records by hospital and counts the total admissions for each.
SELECT hospital, COUNT(*) AS admission_count
FROM healthcare_dataset_copy
GROUP BY hospital
ORDER BY admission_count DESC;

-- Average Length of Stay:
-- Calculates the average duration of a patient's stay in the hospital
-- using the DATEDIFF function between admission and discharge dates.
SELECT AVG(DATEDIFF(discharge_date, date_of_admission)) AS average_length_of_stay
FROM healthcare_dataset_copy;

-- Monthly Admission Trends:
-- Extracts the year and month from the admission date to count admissions
-- per month, providing insight into temporal patterns.
SELECT YEAR(date_of_admission) AS `Year`, MONTH(date_of_admission) AS `Month`, COUNT(*) AS admission_by_month
FROM healthcare_dataset_copy
GROUP BY YEAR(date_of_admission), MONTH(date_of_admission)
ORDER BY YEAR(date_of_admission), MONTH(date_of_admission);

-- Verify Date Ordering (for exploration) since the data seems to be short 
-- patients in the first and last months of the dataset. 
SELECT date_of_admission
FROM healthcare_dataset_copy
ORDER BY date_of_admission;

SELECT date_of_admission
FROM healthcare_dataset_copy
ORDER BY date_of_admission DESC;

-- Average Billing Amount by Age Group (using Common Table Expression - CTE)
-- This query categorizes patients into custom age groups using a CASE statement
-- within a CTE, then calculates the average billing amount for each group.
WITH healthcare_dataset_age_groups AS
(
SELECT *,
CASE
	WHEN age <= 29 THEN '18-29'
    WHEN age >= 30 AND age <= 39 THEN '30-39'
    WHEN age >= 40 AND age <= 49 THEN '40-49'
	WHEN age >= 50 AND age <= 64 THEN '50-64'
    WHEN age >= 65 THEN '65+'
END AS age_group
FROM healthcare_dataset_copy
)
SELECT age_group, AVG(billing_amount) AS average_billing_amount
FROM healthcare_dataset_age_groups
GROUP BY age_group
ORDER BY age_group; -- Added ORDER BY for consistent output ordering

-- Average Billing Amount by Medical Condition
-- Calculates the average billing amount associated with each medical condition,
-- helping to identify conditions that may incur higher or lower costs.
SELECT medical_condition, AVG(billing_amount) AS average_billing_amount
FROM healthcare_dataset_copy
GROUP BY medical_condition
ORDER BY average_billing_amount DESC;