view: events {
  sql_table_name: thelook_web_analytics.events ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: event_type {
    type: string
    sql: ${TABLE}.event_type ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.sequence_number ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: user_id {
    type: number
    sql: CAST(REGEXP_EXTRACT(${TABLE}.user_id, r'\d+') AS INT64) ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name]
  }

  #
  #  Sessionization Fields.
  #
  measure: minimum_time {
    sql: MIN(${created_raw}) ;;
  }

  measure: max_time {
    sql: MAX(${created_raw}) ;;
  }

  measure: ip_addresses {
    sql: ARRAY_TO_STRING(ARRAY_AGG(DISTINCT ${ip_address}),'|') ;;
  }

  measure: event_types {
    sql: ARRAY_TO_STRING(ARRAY_AGG(DISTINCT ${event_type}),'|') ;;
  }

  # code defensivly.  Should only have one user_id on a session, but just
  # in case, we'll take the first one we see.
  measure: first_user_id {
    type: min
    sql: ${user_id} ;;
  }

  # parse the product_id out of the urls visited and return an array of them.
  measure: product_ids_visited {
    sql: ARRAY_AGG(DISTINCT
            CAST(REGEXP_EXTRACT(${uri}, r'/product/(\d+)') AS INT64)
          IGNORE NULLS) ;;
  }

}
