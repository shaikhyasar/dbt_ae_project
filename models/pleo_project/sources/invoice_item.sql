select * from {{ source("sales_data", "invoice_item") }}