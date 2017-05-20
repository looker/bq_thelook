connection: "bigquery_publicdata_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

include: "*.explore"

explore: users {
  extends: [user_joins]
}


explore: event_sessions {
  extends: [user_joins]
  join: users {
    sql_on: ${users.id} = ${event_sessions.user_id} ;;
    relationship: many_to_one
  }
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
