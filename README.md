# sql-data-warehouse-225
With SQL Server, ETL Process, Data Modeling, Analytics
![architecture](https://github.com/user-attachments/assets/fca6fa8a-590e-4a52-806a-16a11371585b)

# Mini Data Warehouse
**Bronze–Silver–Gold Architecture | SQL Server | PostgreSQL-Compatible | Python (Pandas)**

**TL;DR**  
A mini data warehouse built using the Bronze–Silver–Gold architecture.  
Raw CSV data is ingested into Bronze, extensively cleaned and integrated in Silver using SQL Server and Python (Pandas), and exposed as analytics-ready Gold views for customer, product, and sales reporting.

---

## Overview
This project implements a **Mini Data Warehouse** following the **Bronze–Silver–Gold (Medallion) architecture**, designed to simulate real-world data engineering workflows.

The core focus of the project is **data cleaning and transformation in the Silver layer**, where raw data is standardized, validated, and integrated before being consumed by analytical views in the Gold layer.

---

## Data Sources
- Imported CSV files
- Domains:
  - Customers
  - Products
  - Sales transactions

---

## Architecture & Data Flow

### 🥉 Bronze Layer — Raw Data
- Direct ingestion of CSV files
- No transformations applied
- Schema closely matches source data
- Serves as a historical and recovery layer

---

### 🥈 Silver Layer — Data Cleaning & Integration *(Core Focus)*
This layer contains the **majority of the engineering effort**.

**Key transformations:**
- Data type normalization
- Column renaming and standardization
- Handling missing and invalid values
- Removing duplicates
- Integrating customer, product, and sales data
- Enforcing referential consistency
- Column restructuring for clarity

**Tools used:**
- SQL Server (primary transformation engine)
- Python (Pandas) for validation, preprocessing, and data quality checks

---

### 🥇 Gold Layer — Analytics & Business Views
- Implemented entirely as SQL views
- Aggregated, business-friendly outputs
- No data duplication
- Always reflects the latest Silver-layer data

**Supports:**
- Sales analysis
- Customer insights
- Product performance reporting
- BI and dashboard consumption

---

## Cross-Database Compatibility
All SQL logic is written using standard SQL patterns and can be migrated from **SQL Server to PostgreSQL** with minimal changes.

---

## Skills Demonstrated
- Data warehouse design (Bronze–Silver–Gold)
- SQL-based data engineering
- Data cleaning and integration
- Python (Pandas) for data quality
- Aggregation and analytics modeling
- Cross-database SQL portability

---
```text
mini-data-warehouse/
│
├── data/
│   ├── bronze/                 # Raw CSV files ingested from source systems
│   ├── silver/                 # Cleaned, standardized, and integrated datasets
│   └── gold/                   # Logical analytical layer (business-ready views)
│
├── sql/
│   ├── bronze/                 # Raw data ingestion scripts
│   ├── silver/                 # Data cleaning, validation, and transformation logic
│   └── gold/                   # Aggregated business and analytical views
│
├── python/
│   ├── data_cleaning.ipynb     # Pandas-based data cleaning & validation
│   └── data_quality_checks.py  # Optional automated data quality checks
│
├── diagrams/
│   └── architecture.png        # Bronze–Silver–Gold architecture diagram
│
├── README.md                   # Project documentation
└── requirements.txt            # Python dependencies
