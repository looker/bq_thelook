explore: users_facts {}

view: users_facts {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        id as user_id,
        created_at as created_at
        , COUNT(*) as lifetime_orders
        , MAX(users.created_at) as most_recent_purchase_at
      FROM thelook_web_analytics.users
      GROUP BY 1, 2
      ;;

   sql_trigger_value: SELECT count(*) FROM orders ;;
   partition_keys: [created_at]
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: most_recent_purchase {
    description: "The date when each user last ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.most_recent_purchase_at ;;
  }

  measure: total_lifetime_orders {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${lifetime_orders} ;;
  }
}
