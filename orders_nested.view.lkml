include: "order_items.view.lkml"

include: "products.view.lkml"

include: "inventory_items.view.lkml"

explore: test {
  from:  order_items_extended
  view_name: order_items
}

view: order_items_extended {
  extends: [order_items]
  measure: nested_fields {
    type: string
    sql: array_agg(struct(id, inventory_item_id, sale_price, status)) ;;
  }
}


explore: orders_nested {
  join: order_items_nested {
    sql: LEFT JOIN UNNEST(${orders_nested.order_items}) as order_items_nested ;;
    relationship: one_to_many
  }

  join: inventory_items {relationship:many_to_one  sql_on: ${order_items_nested.inventory_item_id} = ${inventory_items.id} ;;}
  join: products {relationship:many_to_one  sql_on: ${inventory_items.product_id} = ${products.id} ;;}

}

view: orders_nested {
  derived_table: {
    explore_source: test {
      column: order_id {field:order_items.order_id}
      column: user_id {field:order_items.user_id}
      column: order_items {field: order_items.nested_fields }

    }
  }
  dimension: user_id {}
  dimension: order_id {}
  dimension: order_items {hidden:yes}

  dimension: order_sales_price {
    type: number
    sql: (select sum(sale_price) from UNNEST(${orders_nested.order_items}) );;
  }

  measure: count {
    type: count
  }

}

view: order_items_nested {

  dimension: id {}
  dimension: inventory_item_id {}
  dimension: sale_price {}
  dimension: status {}

  dimension: sale_contribution_to_order {
    type: number
    sql: ${sale_price} / ${orders_nested.order_sales_price} ;;

  }

  measure: average_contribution {
    type: average
    sql: ${sale_contribution_to_order} ;;
    value_format_name: percent_2
  }

}
