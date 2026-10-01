# Power BI Dashboard Plan

## Executive Overview
KPI Cards:
- Total Orders Processed
- Productivity (Orders/Labor Hour)
- On-Time Rate
- Total Delays
- Error Rate

Charts:
- Productivity by Warehouse
- Productivity by Shift
- Monthly On-Time Rate
- Productivity by Process
- Delay Rate by Zone

Slicers:
- Warehouse
- Shift
- Process
- Zone
- Month

## Suggested DAX

Total Orders = SUM(warehouse_operations_data[Orders_Processed])

Labor Hours = SUM(warehouse_operations_data[Labor_Hours])

Productivity = DIVIDE([Total Orders], [Labor Hours])

Total Delays = SUM(warehouse_operations_data[Delay_Count])

On Time Orders = SUM(warehouse_operations_data[On_Time_Orders])

On Time Rate % = DIVIDE([On Time Orders], [Total Orders])

Total Errors = SUM(warehouse_operations_data[Error_Count])

Error Rate % = DIVIDE([Total Errors], [Total Orders])
