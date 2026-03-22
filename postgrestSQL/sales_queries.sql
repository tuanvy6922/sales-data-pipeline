
SELECT * FROM fact_sales LIMIT 10;
--:Tổng số đơn hàng
SELECT SUM(total_quantity) as total_orders
FROM fact_sales;
--:Số quốc gia
SELECT COUNT(*) FROM dim_country;
--:Doanh thu theo quốc gia
SELECT l.country, SUM(f.revenue) as total_revenue
FROM fact_sales as f
JOIN dim_location as l ON f.location_id = l.location_id
GROUP BY l.country
ORDER BY total_revenue DESC;
--:Top 10 sản phẩm bán nhiều
SELECT p.product, SUM(f.order_quantity) as total_quantity
FROM fact_sales as f
JOIN dim_product as p ON f.product_id = p.product_id
GROUP BY p.product
ORDER BY total_quantity DESC
LIMIT 10;
--:Doanh thu theo nhóm tuổi
SELECT c.age_group, SUM(f.revenue) as total_revenue
FROM fact_sales as f
JOIN dim_customer as c ON f.customer_id = c.customer_id
GROUP BY c.age_group;
--:Doanh thu từ một năm cụ thể đến hiện tại
SELECT d.year, SUM(f.revenue) AS total_revenue
FROM fact_sales as f
JOIN dim_date as d ON f.date_id = d.date_id
WHERE d.year >= 2015
GROUP BY d.year
ORDER BY d.year;
--:Top 5 sản phẩm có profit cao nhất
SELECT p.product, SUM(f.profit) as total_profit
FROM fact_sales as f
JOIN dim_product as p ON f.product_id = p.product_id
GROUP BY p.product
ORDER BY total_profit DESC
LIMIT 5;
--:Xếp hạng sản phẩm và doanh thu
SELECT p.product,SUM(f.revenue) as revenue,
RANK() OVER (ORDER BY SUM(f.revenue) DESC) as rank
FROM fact_sales as f
JOIN dim_product as p ON f.product_id = p.product_id
GROUP BY p.product;
--:Quốc gia có Profit > Profit trung bình 
WITH country_profit AS (
    SELECT l.country, SUM(f.profit) AS profit
    FROM fact_sales f
    JOIN dim_location l ON f.location_id = l.location_id
    GROUP BY l.country
)
SELECT *
FROM country_profit
WHERE profit > (SELECT AVG(profit) FROM country_profit);
--:So sánh doanh thu các năm với nhau
SELECT d.year, SUM(f.revenue) AS revenue,
LAG(SUM(f.revenue)) OVER (ORDER BY d.year) AS prev_year
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;
--:Tổng revenue
SELECT SUM(total_revenue) FROM fact_sales;
--:Tổng profit
SELECT SUM(total_profit) FROM fact_sales;

