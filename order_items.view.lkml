view: order_items {
  sql_table_name: thelook_web_analytics.order_items ;;

  dimension: id {
    primary_key:yes
    type:number
    }

  dimension_group: created {
    type: time
    sql: TIMESTAMP(${TABLE}.created_at) ;;
    }

  dimension: delivered_at {}

  dimension: inventory_item_id {
    type:number
    }

  dimension: order_id {
    type:number
    }

  dimension: returned_at {
    type: date_time
    sql: CASE WHEN ${TABLE}.returned_at like '%N' THEN NULL ELSE CAST(${TABLE}.returned_at as timestamp)  end ;;
  }

  dimension: sale_price {
    type: number
    }

  dimension: shipped_at {
    type: date
    sql: CASE WHEN ${TABLE}.shipped_at like '%N' THEN NULL ELSE CAST(${TABLE}.shipped_at as timestamp)  end ;;


  }

  dimension: status {}

  dimension: user_id {
    type: number
    }

  measure: orders_per_capita {
    type:number
    sql: ${order_count}/NULLIF(${zip_demographics.total_population}, 0) ;;
    }

  measure: count {
    type:count
    drill_fields: [detail*]
    }

  measure: total_revenue {
    type:sum
    sql: ${sale_price} ;;
    }

  measure: return_rate {
    type: number
    sql: case (when ${status} = 'returned' then count(${returned_at})/${order_count});;
  }

  measure: order_count {
    type:count_distinct
    sql: ${order_id} ;;
    drill_fields: [order_id, count]
    }


  # ----- Sets of fields for drilling ------
  set: detail {fields: [id,
      users.last_name,
      users.first_name,
      inventory_items.product_name,
      sale_price
    ]
  }
}
