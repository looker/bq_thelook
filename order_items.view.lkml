view: order_items {
  sql_table_name: thelook_web_analytics.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    sql: TIMESTAMP(${TABLE}.created_at) ;;
  }

  dimension: delivered_at {
    type: string
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  measure: order_count {
    type: count_distinct
    sql: ${order_id} ;;
  }

  dimension: returned_at {
    type: string
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${sale_price} ;;
  }

  dimension: shipped_at {
    type: string
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
