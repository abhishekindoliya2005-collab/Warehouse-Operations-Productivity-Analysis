# Project Report — Warehouse Operations & Productivity Analysis

## Objective
Analyze warehouse operational data to measure productivity, order throughput, delays, on-time processing and process-level performance.

## Dataset
2,400 synthetic operational records covering 2025, four warehouses, three shifts and four major warehouse processes.

## Main Metrics
- Total orders processed: 43,137
- Labor hours: 18,629.9
- Productivity: 2.32 orders/hour
- On-time rate: 97.01%
- Total delays: 2,948
- Error rate: 2.05%

## Analytical Approach
1. Clean and validate operational records.
2. Aggregate performance by warehouse, shift and process.
3. Calculate productivity using orders processed per labor hour.
4. Analyze delays and on-time performance.
5. Rank associates using SQL window functions.
6. Build a Power BI dashboard for operational monitoring.

## Business Use
The analysis can support staffing decisions, shift planning, bottleneck identification and process improvement.

## Limitations
The dataset is synthetic. Productivity differences do not by themselves prove that a specific shift, warehouse or associate caused operational outcomes.
