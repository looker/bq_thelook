include: "users.view"

explore: user_day_stats {
  view_name: events
  from: user_day_events
  join: orders {
    from: user_day_orders
    sql_on: ${orders.user_id} = ${events.user_id}
        AND ${orders.created_date} = ${events.created_date};;
    relationship: one_to_one
  }
  join: users {
    sql_on:  ${users.id} = COALESCE(${events.user_id}, ${orders.user_id}) ;;
    relationship: many_to_one
  }
}


view: user_day_events {
  derived_table: {
    query: {
      query_explore: events
      column: user_id { field: events.user_id }
      column: events { field: events.count }
      column: created_date { field: events.created_date }
      filters: {
        field: events.user_id
        value: "NOT NULL"
      }
    }
  }
  dimension: user_id {}
  dimension: created_date {}
  measure: event_count {
    type: sum
    sql: ${TABLE}.events ;;
  }
}


view: user_day_orders {
  derived_table: {
    query: {
      query_explore: order_items
      column: user_id { field: order_items.user_id }
      column: created_date { field: order_items.created_date }
      column: revenue { field: order_items.total_revenue }
      column: orders { field: order_items.order_count }
    }
  }
  dimension: created_date {}
  dimension: user_id {}
  measure: total_revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }
  measure: order_count {
    type: sum
    sql: ${TABLE}.orders ;;
  }
}
