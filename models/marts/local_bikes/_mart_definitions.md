-- =====================
-- FACT TABLES
-- =====================

{% docs mart_fct_ventes %}
Fact table containing detailed sales transactions at order-item level.
Each row represents the sale of a product within a customer order,
including quantities sold and net revenue after discounts.
{% enddocs %}

{% docs mart_fct_vente_par_categorie %}
Aggregated sales fact table by product category and order date.
Used to analyze category-level performance such as revenue, units sold,
and number of orders.
{% enddocs %}

{% docs mart_fct_stock_magasin %}
Daily inventory and sales comparison by store.
Provides stock levels, cumulative sales, and stock coverage ratio.
{% enddocs %}

{% docs mart_fct_stock_magasin_produit_top %}
Top-performing products per store based on stock coverage.
Highlights products with the highest stock-to-sales ratios.
{% enddocs %}

{% docs mart_fct_stock_magasin_produit_flop %}
Lowest-performing products per store based on stock coverage.
Identifies products with weak sales relative to stock availability.
{% enddocs %}

{% docs mart_fct_performance_commercial_daily %}
Daily commercial performance metrics aggregated across all stores.
Includes revenue, orders, units sold, and average basket size.
{% enddocs %}

{% docs mart_fct_performance_commercial_magasin %}
Daily commercial performance metrics at store level.
Used to analyze store revenue, order volume, and sales efficiency.
{% enddocs %}

-- =====================
-- DIMENSIONS
-- =====================

{% docs mart_dim_products %}
Product dimension containing descriptive attributes such as brand,
category, model year, and list price.
{% enddocs %}

{% docs mart_dim_stores %}
Store dimension containing store identification and location attributes.
{% enddocs %}

{% docs mart_dim_staff %}
Staff dimension containing employee attributes and store assignment.
{% enddocs %}

{% docs mart_dim_customers %}
Customer dimension containing customer demographic and location attributes.
{% enddocs %}

{% docs mart_customer_summary %}
Customer-level aggregated metrics summarizing purchasing behavior over time,
including lifetime revenue, order frequency, and customer classification.
{% enddocs %}

-- =====================
-- COMMON COLUMN DEFINITIONS
-- =====================

{% docs order_id %}
Unique identifier of a customer order.
{% enddocs %}

{% docs product_id %}
Unique identifier of a product.
{% enddocs %}

{% docs customer_id %}
Unique identifier of a customer.
{% enddocs %}

{% docs store_id %}
Unique identifier of a store.
{% enddocs %}

{% docs staff_id %}
Unique identifier of a staff member.
{% enddocs %}

{% docs order_date %}
Date on which the order was placed.
{% enddocs %}

{% docs quantity %}
Number of product units involved in the transaction.
{% enddocs %}

{% docs net_revenue %}
Net revenue generated after applying discounts.
{% enddocs %}

{% docs total_orders %}
Total number of distinct orders.
{% enddocs %}

{% docs total_units %}
Total number of product units sold.
{% enddocs %}

{% docs avg_basket %}
Average revenue per order.
{% enddocs %}

{% docs total_stock %}
Total quantity of product available in stock.
{% enddocs %}

{% docs total_sold %}
Total quantity of product sold.
{% enddocs %}

{% docs couverture %}
Stock coverage ratio calculated as stock divided by sales.
{% enddocs %}

{% docs rank_best %}
Ranking position among top-performing products.
{% enddocs %}

{% docs rank_flop %}
Ranking position among lowest-performing products.
{% enddocs %}

{% docs first_name %}
First name of the person.
{% enddocs %}

{% docs last_name %}
Last name of the person.
{% enddocs %}

{% docs city %}
City associated with the entity.
{% enddocs %}

{% docs state %}
State or region associated with the entity.
{% enddocs %}

{% docs zip_code %}
Postal code associated with the address.
{% enddocs %}
