connection: "bigquery_publicdata_standard_sql"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: distribution_centers {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

# All the facts we've built around the users
explore: user_joins {
  extension: required
  join: user_order_facts {
    view_label: "Users"
    sql_on: ${user_order_facts.user_id} = ${user.id} ;;
    relationship: many_to_one
  }
  join: user_event_attribution {
    view_label: "Users"
    sql_on: ${user_event_attribution.user_id} = ${user.id} ;;
    relationship: many_to_one
  }
  join: lifetime_brand {
    view_label: "Users"
    sql: LEFT JOIN UNNEST(SPLIT(${user_order_facts.lifetime_brands},'|RECORD|')) as lifetime_brand ;;
    relationship: one_to_many
  }

  join: lifetime_product_category {
    view_label: "Users"
    sql: LEFT JOIN UNNEST(SPLIT(${user_order_facts.lifetime_product_categories},'|RECORD|')) as lifetime_product_category ;;
    relationship: one_to_many
  }
}

explore: order_items {
  extends: [user_joins]

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  join: user_order_sequence {
    view_label: "Order Items"
    sql_on: ${user_order_sequence.order_id} = ${order_items.order_id} ;;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

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
