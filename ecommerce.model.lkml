connection: "bigquery_publicdata_standard_sql"

include: "users.view.lkml"
include: "order_items.view.lkml"
include: "inventory_items.view.lkml"
include: "products.view.lkml"



explore: users {}

explore: order_items {
  join: users {
    sql_on: ${users.id} = ${order_items.user_id} ;;
    type: left_outer
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
}
