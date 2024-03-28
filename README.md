# This documentation disucss about handling MRR record of a pleo company!

Table of Contents
1. [Model Structure](#model_structure)
2. [Data Quality](#data_quality)

## Model Structure
Once, completing initial setup, We wil start working on the building dbt model.
Our requirements are, build a dbt model 
1. which can able to provide detail insight of MRR* per day, per week, per month, per quarter and per year
2. model which display MRR per month per company
3. a model where a user look into specific day, he/she will able to view the transactions along with customer and invoice type information

MRR - Monthly Recurring Revenue

The folder structure will have 
- sources - which contains model of source table. Each model represent each table
- Intermediate - The model in this folder used to do some standard conversion and transformations. Here, I have create one model which handle currency conversion and calculate days difference value and join the table
- Analytics - There are totally four models reside which conatins final tables.
  - **mrr_analyisis** - This model will have able to recollect a transaction(s) happened on a specific date.
  - **mrr_over_customer** - This model will provide detail information of each company transactions in monthly basis
  - **mrr_over_time** - This is overview of the transactions where you can do a standard conversion to obtain transcations per day, week, month, year manner
  - **tracking_mrr_over_time** - This model is more detailed view of mrr_over_time, where you can able to transactions in day, week, month, year part.

  ## Data Quality
  To ensure correctness and integrity, I have undertaken some tests where i use generic dbt tests and custom tests
  ### Generic Tests
  - not_null - Ensure amount column doesn't have null values. There can be negative value, but null is not acceptable.
  - Aceepted_values - Ensure whether only required values reside in the columns. This is remove unwanted discrepency.
  - relationships - Ensuring whether we have use correct relationship column in our join table.
  
  ### Custom Tests:
  - test_freshness.sql - I have create a test which check transaction is not from yesterday
  - test_amount_positive.sql - we may recieved record which will having negative amount because there may be transactions of refund, cashback, cancellation. To get negative transactions on yesterday