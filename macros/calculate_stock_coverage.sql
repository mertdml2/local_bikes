{% macro calculate_stock_coverage(stock_qty, sold_qty, decimals=2) %}
    round(
        {{ stock_qty }} / nullif({{ sold_qty }}, 0),
        {{ decimals }}
    )
{% endmacro %}
