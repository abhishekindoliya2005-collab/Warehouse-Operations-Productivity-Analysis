-- Warehouse Operations & Productivity Analysis
-- MySQL 8+

CREATE DATABASE IF NOT EXISTS warehouse_analytics;
USE warehouse_analytics;

DROP TABLE IF EXISTS warehouse_operations_data;

CREATE TABLE warehouse_operations_data (
    Record_ID VARCHAR(20) PRIMARY KEY,
    Date DATE,
    Warehouse VARCHAR(50),
    Shift VARCHAR(30),
    Process VARCHAR(30),
    Zone VARCHAR(10),
    Associate_ID VARCHAR(20),
    Orders_Processed INT,
    Avg_Cycle_Time_Min DECIMAL(10,2),
    Processing_Time_Min DECIMAL(12,2),
    Delay_Count INT,
    Delay_Time_Min DECIMAL(12,2),
    Error_Count INT,
    On_Time_Orders INT,
    Labor_Hours DECIMAL(10,2),
    Productivity DECIMAL(12,3),
    Error_Rate DECIMAL(10,5),
    On_Time_Rate DECIMAL(10,5),
    Month VARCHAR(7),
    Weekday VARCHAR(20)
);

-- Import warehouse_operations_data.csv using MySQL Workbench Import Wizard.

-- 1. Overall KPIs
SELECT
    SUM(Orders_Processed) AS Total_Orders,
    ROUND(SUM(Labor_Hours),2) AS Labor_Hours,
    ROUND(SUM(Orders_Processed)/SUM(Labor_Hours),2) AS Productivity,
    SUM(Delay_Count) AS Total_Delays,
    ROUND(SUM(On_Time_Orders)/SUM(Orders_Processed)*100,2) AS On_Time_Rate_Pct
FROM warehouse_operations_data;

-- 2. Warehouse performance
SELECT Warehouse,
       SUM(Orders_Processed) AS Orders_Processed,
       ROUND(SUM(Orders_Processed)/SUM(Labor_Hours),2) AS Productivity,
       SUM(Delay_Count) AS Delays,
       ROUND(SUM(On_Time_Orders)/SUM(Orders_Processed)*100,2) AS On_Time_Rate_Pct
FROM warehouse_operations_data
GROUP BY Warehouse
ORDER BY Productivity DESC;

-- 3. Shift performance
SELECT Shift,
       SUM(Orders_Processed) AS Orders_Processed,
       ROUND(SUM(Orders_Processed)/SUM(Labor_Hours),2) AS Productivity,
       SUM(Delay_Count) AS Delays,
       ROUND(SUM(On_Time_Orders)/SUM(Orders_Processed)*100,2) AS On_Time_Rate_Pct
FROM warehouse_operations_data
GROUP BY Shift
ORDER BY Productivity DESC;

-- 4. Process performance
SELECT Process,
       SUM(Orders_Processed) AS Orders_Processed,
       ROUND(SUM(Orders_Processed)/SUM(Labor_Hours),2) AS Productivity,
       SUM(Delay_Count) AS Delays,
       SUM(Error_Count) AS Errors
FROM warehouse_operations_data
GROUP BY Process
ORDER BY Productivity DESC;

-- 5. Associate productivity
SELECT Associate_ID,
       SUM(Orders_Processed) AS Orders_Processed,
       ROUND(SUM(Orders_Processed)/SUM(Labor_Hours),2) AS Productivity,
       SUM(Delay_Count) AS Delays
FROM warehouse_operations_data
GROUP BY Associate_ID
ORDER BY Productivity DESC;

-- 6. Monthly trend
SELECT Month,
       SUM(Orders_Processed) AS Orders_Processed,
       SUM(Delay_Count) AS Delays,
       ROUND(SUM(On_Time_Orders)/SUM(Orders_Processed)*100,2) AS On_Time_Rate_Pct
FROM warehouse_operations_data
GROUP BY Month
ORDER BY Month;

-- 7. Zone-level bottlenecks
SELECT Zone,
       SUM(Orders_Processed) AS Orders_Processed,
       SUM(Delay_Count) AS Delays,
       ROUND(SUM(Delay_Count)/SUM(Orders_Processed)*100,2) AS Delay_Rate_Pct
FROM warehouse_operations_data
GROUP BY Zone
ORDER BY Delay_Rate_Pct DESC;

-- 8. Window function: rank associates within warehouse
WITH associate_perf AS (
    SELECT Warehouse, Associate_ID,
           SUM(Orders_Processed) AS Orders_Processed,
           SUM(Labor_Hours) AS Labor_Hours
    FROM warehouse_operations_data
    GROUP BY Warehouse, Associate_ID
)
SELECT Warehouse, Associate_ID,
       Orders_Processed,
       ROUND(Orders_Processed/Labor_Hours,2) AS Productivity,
       DENSE_RANK() OVER (
           PARTITION BY Warehouse
           ORDER BY Orders_Processed/Labor_Hours DESC
       ) AS Productivity_Rank
FROM associate_perf
ORDER BY Warehouse, Productivity_Rank;

-- 9. Delay analysis by shift and process
SELECT Shift, Process,
       SUM(Delay_Count) AS Delays,
       ROUND(SUM(Delay_Time_Min),1) AS Delay_Minutes
FROM warehouse_operations_data
GROUP BY Shift, Process
ORDER BY Delay_Minutes DESC;
