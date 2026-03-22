CREATE TABLE dim_product AS
SELECT
    ROW_NUMBER() OVER () AS product_id,
    product,
    product_category,
    sub_category
FROM (
    SELECT DISTINCT product, product_category, sub_category
    FROM sales_raw
) t;

ALTER TABLE dim_product ADD PRIMARY KEY (product_id);

ALTER TABLE dim_product
ADD CONSTRAINT unique_product_combo 
UNIQUE (product, product_category, sub_category);

DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_customer AS
SELECT
    ROW_NUMBER() OVER () AS customer_id,
    customer_age,
    age_group,
    customer_gender
FROM (
    SELECT DISTINCT customer_age, age_group, customer_gender
    FROM sales_raw
) t;

ALTER TABLE dim_customer ADD PRIMARY KEY (customer_id);

CREATE TABLE dim_location AS
SELECT
    ROW_NUMBER() OVER () AS location_id,
    country,
    state
FROM (
    SELECT DISTINCT country, state
    FROM sales_raw
) t;

ALTER TABLE dim_location ADD PRIMARY KEY (location_id);

CREATE TABLE dim_date AS
SELECT
    ROW_NUMBER() OVER () AS date_id,
    CAST(date AS DATE) AS full_date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day
FROM (
    SELECT DISTINCT date
    FROM sales_raw
) t;

ALTER TABLE dim_date ADD PRIMARY KEY (date_id);
ALTER TABLE dim_date ADD UNIQUE (full_date);

ALTER TABLE sales_raw ADD COLUMN product_id INT;
ALTER TABLE sales_raw ADD COLUMN customer_id INT;
ALTER TABLE sales_raw ADD COLUMN location_id INT;
ALTER TABLE sales_raw ADD COLUMN date_id INT;

UPDATE sales_raw s
SET product_id = p.product_id
FROM dim_product p
WHERE s.product = p.product
  AND s.product_category = p.product_category
  AND s.sub_category = p.sub_category;

UPDATE sales_raw s
SET customer_id = c.customer_id
FROM dim_customer c
WHERE s.customer_age = c.customer_age
  AND s.customer_gender = c.customer_gender
  AND s.age_group = c.age_group;

UPDATE sales_raw s
SET location_id = l.location_id
FROM dim_location l
WHERE s.country = l.country
  AND s.state = l.state;

UPDATE sales_raw s
SET date_id = d.date_id
FROM dim_date d
WHERE CAST(s.date AS DATE) = d.full_date;

SELECT * FROM sales_raw
WHERE product_id IS NULL
   OR customer_id IS NULL
   OR location_id IS NULL
   OR date_id IS NULL;

CREATE TABLE fact_sales AS
SELECT
    product_id,
    customer_id,
    location_id,
    date_id,
    revenue,
    profit,
    order_quantity
FROM sales_raw;
ALTER TABLE fact_sales
ADD FOREIGN KEY (product_id) REFERENCES dim_product(product_id);

ALTER TABLE fact_sales
ADD FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id);

ALTER TABLE fact_sales
ADD FOREIGN KEY (location_id) REFERENCES dim_location(location_id);

ALTER TABLE fact_sales
ADD FOREIGN KEY (date_id) REFERENCES dim_date(date_id);

CREATE INDEX idx_fact_product ON fact_sales(product_id);
CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_location ON fact_sales(location_id);
CREATE INDEX idx_fact_date ON fact_sales(date_id);