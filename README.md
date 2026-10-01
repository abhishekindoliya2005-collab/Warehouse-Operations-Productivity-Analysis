# Warehouse Operations & Productivity Analysis

![Warehouse Operations Dashboard](dashboard/warehouse_operations_dashboard.png)

## 📌 Project Overview

This project analyzes warehouse operational data to understand **order throughput, associate productivity, processing delays, on-time performance, shift performance, and process-level bottlenecks**.

The project demonstrates an end-to-end data analytics workflow using **SQL, Excel, Python, and Power BI**.

The objective is to convert operational data into measurable KPIs and business insights that can support **workforce planning, process improvement, and operational decision-making**.

---

## 🎯 Business Problem

A warehouse operation needs to monitor productivity and identify areas where orders are being delayed or processed less efficiently.

The analysis focuses on:

- How many orders are processed?
- What is the productivity per labor hour?
- Which warehouses perform differently?
- Which shifts have higher or lower productivity?
- Which processes create more delays?
- How does on-time performance change over time?
- Which zones experience more delays?
- How can operational bottlenecks be identified using data?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL / MySQL** | Data extraction, aggregation, ranking and KPI analysis |
| **Excel** | Data validation and operational summaries |
| **Python** | Dataset generation and exploratory analysis |
| **Power BI** | Interactive operational dashboard |
| **GitHub** | Project documentation and version control |

---

# 📊 Dataset

The project uses a **synthetic warehouse dataset containing 2,400 operational records across 2025**.

The dataset represents activity across:

- 4 warehouses
- 3 shifts
- 4 warehouse processes
- 5 operational zones
- 80 synthetic associates

### Main Fields

| Field | Description |
|---|---|
| `Record_ID` | Unique operational record |
| `Date` | Date of operation |
| `Warehouse` | Warehouse location |
| `Shift` | Morning, Afternoon or Night |
| `Process` | Picking, Packing, Sorting or Dispatch |
| `Zone` | Warehouse zone |
| `Associate_ID` | Synthetic associate identifier |
| `Orders_Processed` | Number of orders processed |
| `Avg_Cycle_Time_Min` | Average processing cycle time |
| `Processing_Time_Min` | Total processing time |
| `Delay_Count` | Number of delays |
| `Delay_Time_Min` | Total delay time |
| `Error_Count` | Number of processing errors |
| `On_Time_Orders` | Orders completed on time |
| `Labor_Hours` | Labor hours |
| `Productivity` | Orders processed per labor hour |
| `Error_Rate` | Processing error rate |
| `On_Time_Rate` | On-time processing rate |

> **Note:** The dataset is synthetic and was created for portfolio and interview practice. It does not represent a real company's warehouse data.

---

# 🔄 Project Workflow

```text
Raw Operational Data
        ↓
Data Cleaning & Validation
        ↓
KPI Calculation
        ↓
Warehouse / Shift / Process Analysis
        ↓
Associate Productivity Analysis
        ↓
Delay & On-Time Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights
        ↓
Process Improvement Recommendations
```

---

# 📐 Key KPIs

### 1. Productivity

Measures how many orders are processed per labor hour.

```text
Productivity = Orders Processed / Labor Hours
```

### 2. On-Time Rate

Measures the percentage of orders completed on time.

```text
On-Time Rate = On-Time Orders / Total Orders
```

### 3. Error Rate

Measures the percentage of processed orders containing errors.

```text
Error Rate = Error Count / Orders Processed
```

### 4. Delay Rate

Measures the number of delays relative to processed orders.

```text
Delay Rate = Delay Count / Orders Processed
```

---

# 📈 Dashboard

The project includes a Power BI-style dashboard preview:

<img width="3579" height="1970" alt="warehouse_operations_deep_dive_dashboard" src="https://github.com/user-attachments/assets/205d14ea-69d1-4b49-b7e6-c12f9b3dc679" />


### Dashboard KPIs

- **Orders Processed**
- **Productivity**
- **On-Time Rate**
- **Total Delays**

### Dashboard Views

#### Warehouse Performance
Compares productivity across warehouse locations.

#### Shift Performance
Compares productivity between Morning, Afternoon and Night shifts.

#### Monthly On-Time Rate
Shows how on-time performance changes throughout the year.

#### Process Productivity
Compares productivity across Picking, Packing, Sorting and Dispatch.

The Power BI dashboard structure and DAX measures are available in:

```text
dashboard/powerbi_dashboard_plan.md
```

---

# 🗄️ SQL Analysis

The SQL script includes:

1. Overall operational KPIs
2. Warehouse performance
3. Shift performance
4. Process performance
5. Associate productivity
6. Monthly trends
7. Zone-level bottleneck analysis
8. Associate ranking using window functions
9. Delay analysis by shift and process

### Example Query

```sql
SELECT
    Warehouse,
    SUM(Orders_Processed) AS Orders_Processed,
    ROUND(
        SUM(Orders_Processed) / SUM(Labor_Hours),
        2
    ) AS Productivity,
    SUM(Delay_Count) AS Delays,
    ROUND(
        SUM(On_Time_Orders) /
        SUM(Orders_Processed) * 100,
        2
    ) AS On_Time_Rate_Pct
FROM warehouse_operations_data
GROUP BY Warehouse
ORDER BY Productivity DESC;
```

This query compares warehouse productivity, delays and on-time performance.

---

# 📊 Power BI Measures

### Total Orders

```DAX
Total Orders =
SUM(warehouse_operations_data[Orders_Processed])
```

### Labor Hours

```DAX
Labor Hours =
SUM(warehouse_operations_data[Labor_Hours])
```

### Productivity

```DAX
Productivity =
DIVIDE([Total Orders], [Labor Hours])
```

### Total Delays

```DAX
Total Delays =
SUM(warehouse_operations_data[Delay_Count])
```

### On-Time Orders

```DAX
On Time Orders =
SUM(warehouse_operations_data[On_Time_Orders])
```

### On-Time Rate

```DAX
On Time Rate % =
DIVIDE([On Time Orders], [Total Orders])
```

### Error Rate

```DAX
Error Rate % =
DIVIDE(
    SUM(warehouse_operations_data[Error_Count]),
    [Total Orders]
)
```

---

# 🔍 Key Insights

The analysis helps identify:

- Differences in productivity across warehouses.
- Shift-level productivity patterns.
- Processes with higher operational delays.
- Changes in on-time performance over time.
- Associates with relatively higher or lower productivity.
- Zones where delays occur more frequently.
- Relationships between workload, labor hours and operational performance.

These insights can help operations teams identify **where further investigation or process improvement may be required**.

---

# 💡 Business Recommendations

### 1. Monitor Warehouse Productivity

Compare productivity across locations while considering workload and operational complexity.

### 2. Investigate Shift-Level Differences

Analyze staffing, workload and process mix when one shift shows different performance.

### 3. Identify Process Bottlenecks

Use delay and cycle-time metrics to identify processes that may require improvement.

### 4. Improve Workforce Planning

Use historical order volumes and productivity metrics to support staffing and shift planning.

### 5. Monitor On-Time Performance

Track on-time rates regularly to identify operational deterioration early.

### 6. Use Associate-Level Metrics Carefully

Productivity metrics can identify areas for coaching or process investigation, but should be interpreted alongside workload and process conditions.

---

# 📁 Repository Structure

```text
Warehouse_Operations_Productivity_Analysis/
│
├── README.md
│
├── data/
│   ├── warehouse_operations_data.csv
│   ├── associate_productivity.csv
│   ├── warehouse_summary.csv
│   ├── shift_summary.csv
│   ├── process_summary.csv
│   └── monthly_summary.csv
│
├── excel/
│   └── warehouse_operations_analysis.xlsx
│
├── sql/
│   └── warehouse_operations_analysis.sql
│
├── dashboard/
│   ├── warehouse_operations_dashboard.png
│   └── powerbi_dashboard_plan.md
│
└── docs/
    └── project_report.md
```

---

# 🚀 How to Run the Project

### Step 1 — Load the Dataset

Use:

```text
data/warehouse_operations_data.csv
```

### Step 2 — Run SQL Analysis

Open:

```text
sql/warehouse_operations_analysis.sql
```

Import the data into MySQL and execute the queries.

### Step 3 — Review Excel Analysis

Open:

```text
excel/warehouse_operations_analysis.xlsx
```

The workbook contains:

- Operations Data
- Associate Productivity
- Warehouse Summary
- Shift Summary
- Process Summary
- Monthly Trend

### Step 4 — Build Power BI Dashboard

Import the data into Power BI and use:

```text
dashboard/powerbi_dashboard_plan.md
```

for the recommended dashboard layout and DAX measures.

---

# 📚 Skills Demonstrated

## Technical Skills

- SQL
- MySQL
- Excel
- Power BI
- DAX
- Python
- Data Cleaning
- Data Aggregation
- Window Functions
- KPI Development
- Data Visualization

## Analytical Skills

- Operations Analytics
- Productivity Analysis
- Bottleneck Analysis
- Workforce Analysis
- Trend Analysis
- KPI Monitoring
- Business Problem Solving
- Data-Driven Decision Making

---

# 🎤 Interview Explanation

> **"I worked on a warehouse operations and productivity analysis project where I analyzed 2,400 operational records across different warehouses, shifts and processes. I used SQL to calculate productivity, delays and on-time performance, and used Excel for validation and summary analysis. I also used SQL window functions to rank associates within each warehouse. Finally, I created a Power BI dashboard to monitor throughput, productivity, delays and shift-level performance. The objective was to identify operational bottlenecks and provide data-driven inputs for workforce and process improvement."**

---

# ⚠️ Limitations

- The dataset is synthetic.
- Productivity differences do not prove that one warehouse or shift caused the observed performance.
- Operational complexity and order difficulty are not fully modeled.
- Cost and financial impact are not included.
- Real warehouse systems would require additional data such as SKU complexity, equipment downtime, staffing levels and order priority.

---

# 🔮 Future Improvements

The project can be extended with:

- Real-time warehouse dashboards
- Labor cost analysis
- SKU-level productivity
- SLA breach prediction
- Demand forecasting
- Workforce requirement forecasting
- Associate performance benchmarking
- Bottleneck prediction
- Inventory integration

---

# 👤 Author

**Abhishek Indoliya**

B.Tech – Metallurgical & Materials Engineering  
**IIT Patna**

**Skills:** SQL | Excel | Power BI | Python | Data Analysis

---

## ⭐ Project Summary

```text
Operational Data
      ↓
KPI Analysis
      ↓
Productivity Measurement
      ↓
Bottleneck Identification
      ↓
Power BI Dashboard
      ↓
Data-Driven Operational Improvement
```
