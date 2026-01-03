{% macro calculate_net_revenue(quantity, list_price, discount) %}
    ( {{ quantity }} * {{ list_price }} * (1 - coalesce({{ discount }}, 0)) )
{% endmacro %}
