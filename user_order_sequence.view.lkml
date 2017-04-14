view: user_order_sequence {
  derived_table: {
    persist_for: "2 hours"
    query: {
      query_explore: order_items
      column: user_id { field: order_items.user_id}
      column: order_id {field: order_items.order_id}
      column: created_time {field: order_items.created_time}
      window: user_sequence {
        sql: ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_time) ;;
      }
    }
  }
  dimension: order_id {hidden: yes}
  dimension: user_sequence {type: number}
}
