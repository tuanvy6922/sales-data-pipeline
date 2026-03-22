Sales Data Pipeline & Analytics (Data Engineer Project)
Project Overview

This project demonstrates an end-to-end data engineering pipeline, where raw sales data is processed, transformed, and stored in a structured data warehouse for analytics.

The pipeline includes:

Extracting raw data from CSV files
Transforming data using Python (ETL process)
Loading data into PostgreSQL
Designing a star schema (fact & dimension tables)
Building interactive dashboards using Power BI

The goal is to analyze sales performance by product, country, age group, and time.

--Highlights
Built an ETL pipeline using Python to process raw data
Loaded transformed data into PostgreSQL
Designed a star schema (fact & dimension tables)
Applied SQL techniques: JOIN, GROUP BY, WINDOW FUNCTIONS
Created interactive dashboards in Power BI
Simulated a real-world data engineering workflow(basic level)

--Data Architecture
CSV Files → PostgreSQL → Data Modeling (Fact & Dimension) → Power BI Dashboard

--Project Structure
project
data             # Raw dataset (CSV files)
etl               # Python scripts for ETL process
notebooks        # Jupyter notebooks for data exploration & ETL
sql               # SQL scripts (schema, transformations)
powerbi           # Power BI report (.pbix)
README.md           # Project documentation


--Dataset
Source: Internal sales dataset (CSV format)
Main Tables:
fact_sales – Stores transaction data
dim_product – Product information
dim_country – Country information
dim_age – Customer age groups
dim_date – Date dimension for time analysis
dim_location – state information

--Technologies Used
Python – ETL pipeline (data cleaning & transformation)
Jupyter Notebook (Anaconda)– Data exploration & development 
PostgreSQL – Data storage & transformation
SQL – Data modeling and querying
Power BI – Data visualization & dashboard

--Setup & Installation
1. Install dependencies
PostgreSQL
Power BI
Python 3.x

Install Python libraries:
pip install -r requirements.txt

2. Run ETL pipeline
python etl/main.py

This step will:
Read CSV files
Clean & transform data
Load data into PostgreSQL

3. Run SQL scripts (if needed)
/sql/

4. Open Power BI
Open .pbix file in /powerbi/
Connect to PostgreSQL
Refresh data

--Usage
Open the .pbix file in Power BI
Connect to your PostgreSQL database
Explore dashboards with filters: Product, Country, Age, group Time, Results

The project provides: Sales analysis by product, country, age, and time Interactive dashboards for easy exploration Structured data model for scalable analytics

Results
Clean and structured dataset ready for analysis
Sales insights across multiple dimensions
Interactive dashboards for decision-making

--What I Learned ?
Building an ETL pipeline using Python
Designing a data warehouse schema (star schema)
Working with PostgreSQL for data storage
Writing optimized SQL queries
Connecting PostgreSQL with to power BI tools

Future Improvements
Automate pipeline scheduling (e.g., Airflow)
Handle larger datasets
Improve data validation & logging
Deploy pipeline to cloud environment

Author
Name: Lê Tuấn Dĩ
Role: Data Engineer Intern