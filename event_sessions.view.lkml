include: "products.view"

explore: event_sessions {
  join: product_id {
    from: id
    sql: LEFT JOIN UNNEST(${event_sessions.product_ids_visited}) as product_id ;;
    relationship: one_to_many
  }
  join: products {
    sql_on: ${product_id.id} = ${products.id} ;;
    relationship: many_to_one
  }
}

view: event_sessions {
  derived_table: {
    persist_for: "2 hours"
    query: {
      query_explore: events
      column: session_id { field: events.session_id }
      column: event_types { field: events.event_types }
      column: session_time { field: events.minimum_time }
      column: ip_addresses {field: events.ip_addresses }
      column: user_ids {field: events.user_ids }
      column: product_ids_visited {field: events.product_ids_visited}
    }
  }
  dimension: session_id {primary_key: yes}
  dimension: event_types {}
  dimension_group: session {
    type: time
    sql: ${TABLE}.session_time ;;
  }
  dimension: ip_addresses {}
  dimension: user_ids {}
  dimension: product_ids_visited {}

  measure: count_sessions {
    type: count
    drill_fields: [session*]
  }

  measure: count_sessions_with_purchases {
    type: count
    drill_fields: [session*]
    filters: {
      field: event_types
      value: "%Purchase%"
    }
  }

  set: session{ fields:[session_time, session_id, user_ids, event_types]}
}

view: id {
  dimension: id {
    #hidden: yes
    sql: ${TABLE} ;;
  }
}
