# Intermediate Models Documentation

This document describes the purpose, grain, and logic of the intermediate (`int_`) models.
These models combine staging data into reusable, business-ready transformations
that feed mart-level fact and dimension tables.

---

## int_stocks

### Description
Daily snapshot of product stock levels per store.

This model standardizes stock data and assigns a snapshot date using the current system date.
It serves as the base stock reference for stock vs sales analysis.

### Grain
One row per:
- product
- store
- snapshot_date

### Key Fields
- product_id
- store_id
- snapshot_date
- stock_quantity

### Notes
- Snapshot date is generated at runtime using `current_date()`
- Used as the base table for stock coverage and ranking calculations

---

## int_order_items_detailed

### Description
Order items enriched with order-level attributes and net revenue calculation.

This model joins order items with orders to add customer, store, staff, and order date
information and computes net revenue at item level.

### Grain
One row per:
- order
- order item

### Key Fields
- order_id
- item_id
- product_id
- store_id
- order_date
- net_revenue

---

## int_stock_vs_sales

### Description
Daily comparison of stock levels versus cumulative sales up to each snapshot date.

This model combines stock snapshots with historical sales to calculate how much stock
remains relative to what has been sold.

### Grain
One row per:
- product
- store
- snapshot_date

### Key Fields
- stock_quantity
- sold_quantity

### Notes
- Sales are cumulative (`order_date <= snapshot_date`)
- Missing sales or stock values are defaulted to 0

---

## int_stock_magasin_top_flop

### Description
Stock coverage analysis with top and flop product rankings per store and day.

This model calculates stock coverage (days of stock) and ranks products within each store
to identify best- and worst-performing stock situations.

### Grain
One row per:
- product
- store
- snapshot_date

### Key Fields
- couverture
- rank_best
- rank_flop

### Business Logic
- Coverage formula:
- `rank_best`: highest coverage per store
- `rank_flop`: lowest non-zero coverage per store

### Notes
- Products with zero sales are excluded from flop ranking
