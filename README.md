# SQL Healthcare Dataset Analysis

---

## 1. Project Overview

This project demonstrates a comprehensive workflow for cleaning, transforming, and analyzing a simulated healthcare dataset using SQL. The primary goal was to showcase foundational and intermediate SQL skills crucial for data professionals, including data preparation, schema optimization, and exploratory data analysis.

## 2. Skills Demonstrated

This project showcases proficiency in the following SQL and data management concepts:

* **Data Manipulation Language (DML):** `SELECT`, `INSERT` (implied by `CREATE TABLE ... AS SELECT`), `DELETE` (implied by `DROP TABLE`).
* **Data Definition Language (DDL):** `CREATE TABLE`, `DROP TABLE`, `ALTER TABLE` (for renaming columns, modifying data types, and adding primary keys).
* **Data Cleaning & Standardization:** Applying consistent naming conventions (`snake_case`), handling column name irregularities (spaces, capitalization).
* **Data Type Conversion:** Converting columns to appropriate data types (`DATE`, `DECIMAL`) for accurate analysis.
* **Database Design Principles:** Adding a **Primary Key** (`AUTO_INCREMENT`) for unique record identification and relational integrity.
* **Database Optimization:** Implementing **Indexes** on frequently queried columns to improve performance on large datasets.
* **Data Quality Assurance:** Identifying missing values (`NULL`s) and outlining strategies for handling them.
* **Exploratory Data Analysis (EDA):**
    * Using `SELECT DISTINCT` to understand categorical distributions.
    * Employing aggregate functions (`COUNT`, `AVG`) for summarization.
    * Grouping data (`GROUP BY`) to derive insights across categories.
    * Ordering results (`ORDER BY`) for better readability and trend identification.
* **Date & Time Functions:** Utilizing `DATEDIFF()`, `YEAR()`, and `MONTH()` for temporal analysis.
* **Advanced SQL Constructs:** Leveraging **Common Table Expressions (CTEs)** and `CASE` statements for complex data categorization and multi-step analysis.

## 3. Dataset Information

The dataset used in this project is a simulated `healthcare_dataset` containing various patient and admission details.

* **Source:** The data was obtained from [Kaggle: Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data).
* **Nature of Data:** It's important to note that this dataset was synthetically generated. As a result, while it serves as an excellent medium for demonstrating SQL capabilities, deep analytical insights or strong statistical patterns commonly found in real-world healthcare data are limited. The project's value lies in the rigorous application of data cleaning and analysis techniques rather than groundbreaking findings.

## 4. Project Steps & Methodology

The analysis followed a structured approach:

1.  **Data Acquisition & Safety:**
    * A working copy of the original `healthcare_dataset` was created (`healthcare_dataset_copy`) to ensure the original source data remained untouched and to promote a safe, reproducible analytical environment.

2.  **Data Cleaning & Standardization:**
    * **Column Renaming:** All column names were systematically converted from `Capitalized With Spaces` to `snake_case` (e.g., `Blood Type` became `blood_type`, `Name` became `full_name`) for improved readability, adherence to SQL best practices, and easier programmatic access.
    * **Data Type Conversion:** Critical columns like `date_of_admission`, `discharge_date`, and `billing_amount` were converted to their appropriate `DATE` and `DECIMAL` data types, respectively, to enable accurate date calculations and numerical aggregations.

3.  **Database Design & Optimization:**
    * **Primary Key Addition:** A `patient_id` column was added as an `AUTO_INCREMENT` **Primary Key**. This ensures each record has a unique identifier, which is fundamental for database integrity and efficient data retrieval.
    * **Indexing:** Indexes were created on `doctor` and `hospital` columns. This significantly enhances the performance of queries involving `GROUP BY` and `ORDER BY` operations on these fields, demonstrating an understanding of database optimization techniques. A key length was specified for `VARCHAR`/`TEXT` columns to ensure compatibility.

4.  **Data Quality & Missing Values:**
    * A comprehensive query was run to check for `NULL` values across all columns. For this specific synthetic dataset, no `NULL`s were identified.
    * **Strategy for Missing Data (if present):** In a real-world scenario, if `NULL` values were found, a strategy would be implemented based on the column's nature and the extent of missingness (e.g., imputation with mean/median/mode, replacement with 'Unknown', or removal of affected rows if negligible). This step was included to highlight awareness of data quality challenges.

5.  **Exploratory Data Analysis (EDA):**
    * `SELECT DISTINCT` queries were used on various categorical columns (e.g., `gender`, `blood_type`, `medical_condition`, `doctor`, `hospital`) to understand the unique values and their distribution, serving as a preliminary data exploration step.

6.  **Analytical Queries:**
    * **Patient Counts per Doctor/Hospital:** Queries were executed to count the number of patients associated with each doctor and the number of admissions per hospital, providing basic insights into workload distribution. This also served to check for the prevalence of duplicate entries, which could inform further analysis.
    * **Average Length of Stay:** Calculated the average duration of patient hospital stays using `DATEDIFF()`.
    * **Monthly Admission Trends:** Analyzed admission patterns over time by grouping admissions by year and month.
    * **Billing Analysis by Age Group:** Utilized a CTE and `CASE` statements to categorize patients into specific age groups and then calculated the average `billing_amount` for each group, showcasing conditional aggregation.
    * **Billing Analysis by Medical Condition:** Determined the average `billing_amount` for each `medical_condition`, identifying potential cost variations.

## 5. Key Findings

While the synthetic nature of the dataset limited the depth of "real-world" insights, the analysis successfully demonstrated:

* The distribution of unique values across various categorical columns (e.g., `gender`, `medical_condition`, `blood_type`).
* The average length of stay for patients within this dataset.
* Admission counts per doctor and hospital, which, given the random data, showed a relatively even distribution rather than significant outliers.
* Basic temporal trends in admissions by month and year.
* Average billing amounts across different age groups and medical conditions.

The project primarily served to validate and strengthen the SQL skills necessary to conduct such analyses on more complex and insightful datasets.

## 6. Tools Used

* **SQL (MySQL dialect)**
* **MySQL Workbench**

---
