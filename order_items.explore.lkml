include: "users.view"
include: "inventory_items.view"
include: "products.view"
include: "distribution_centers.view"
#include: "user_order_sequence.view"
include: "order_items.view"
include: "user_joins.explore"

explore: order_items_ignore_errors {
  extension: required
  join: user_order_sequence {
    view_label: "Order Items"
    sql_on: ${user_order_sequence.order_id} = ${order_items.order_id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  extends: [user_joins, order_items_ignore_errors]

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
}
