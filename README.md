# sql-data-warehouse-225
With SQL Server, ETL Process, Data Modeling, Analytics
![architecture](https://github.com/user-attachments/assets/fca6fa8a-590e-4a52-806a-16a11371585b)

Mini Data Warehouse Project

Bronze–Silver–Gold Architecture | SQL Server | PostgreSQL-Compatible | Python (Pandas)

Project Overview

This project implements a Mini Data Warehouse using the Bronze–Silver–Gold (Medallion) architecture, designed to simulate a real-world analytical data platform.

The core focus of the project is extensive data cleaning and transformation in the Silver layer, converting raw CSV data into clean, reliable, and analytics-ready datasets.
The final Gold layer delivers aggregated, business-friendly views for reporting and analysis.

The project processes customer, product, and sales data, ingested from external CSV files and transformed using SQL Server and Python (Pandas). All SQL logic is written to be portable and compatible with PostgreSQL.

Data Sources

Imported CSV files

Domains covered:

Customers

Products

Sales transactions

Architecture Overview
🥉 Bronze Layer – Raw Data

Purpose: Store raw data exactly as received from source files.

Direct ingestion of CSV data

No transformations applied

Schema closely matches source structure

Serves as a historical and recovery layer

🥈 Silver Layer – Data Cleaning & Integration (Main Focus)

Purpose: Transform raw data into clean, standardized, and integrated tables.

This layer contains the majority of the engineering work in the project.

Key tasks performed:

Data type normalization (dates, numeric fields, identifiers)

Column renaming and standardization

Handling missing values and invalid records

Removing duplicate records

Integrating customer, product, and sales datasets

Ensuring referential consistency across entities

Reordering and restructuring columns for clarity and usability

Technologies used:

SQL Server for core transformations

Python (Pandas) for:

Additional data cleaning

Data validation and sanity checks

Preprocessing where Python was more efficient than SQL

🥇 Gold Layer – Business & Analytics Views

Purpose: Provide analytics-ready datasets optimized for reporting.

Implemented entirely as SQL views

Aggregated metrics and business-friendly outputs

No data duplication

Always reflects the latest Silver-layer data

Use cases:

Sales analysis

Customer insights

Product performance reporting

BI and dashboard consumption

Cross-Database Compatibility

Although implemented in SQL Server, the SQL logic:

Uses standard SQL syntax

Avoids vendor-specific features

Can be migrated to PostgreSQL with minimal changes

Skills Demonstrated

Data warehouse design (Bronze–Silver–Gold architecture)

Real-world data cleaning and transformation

SQL-based data engineering

Python (Pandas) for data quality processing

Aggregation and analytics modeling

Cross-database SQL portability

Why This Project Matters

This project reflects real production-style data engineering, where:

Raw data is messy

Data cleaning is the most critical step

Analytics quality depends on upstream transformations

SQL and Python are used together pragmatically
