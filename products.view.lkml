view: products {
  sql_table_name: thelook_web_analytics.products ;;

  dimension: id {primary_key:yes  type: number}
  dimension: brand {type:string  sql: ${TABLE}.brand ;;}
  dimension: category {}
  dimension: cost {type:number}
  dimension: department {}
  dimension: distribution_center_id {type:number}
  dimension: name {}
  dimension: retail_price {type: number}
  dimension: sku {}

  measure: brand_list {type:list  list_field: brand}
  measure: category_list {type:list  list_field: brand}
  measure: count {type:count
    drill_fields: [id, name, brand,category, inventory_items.count, order_items.count ]}
}
