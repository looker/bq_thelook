view: user_order_facts {
  derived_table: {
    query: {
      query_explore: order_items
      column: user_id {field: order_items.user_id}
      column: lifetime_revenue {field: order_items.total_revenue}
      column: lifetime_number_of_orders {field: order_items.order_count}
    }
  }
  dimension: user_id {hidden: yes}
  dimension: lifetime_revenue {type: number}
  dimension: lifetime_number_of_orders {type: number}
}
