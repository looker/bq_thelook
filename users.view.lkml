view: users {
  sql_table_name: thelook_web_analytics.users ;;

  # What is this?
  filter: event_name {default_value:"Ride"  label:"Event Name"
    suggestions: ["Reservation", "Ride"]}

  dimension: id {primary_key:yes}
  dimension: age {type:number}
  dimension: city {}
  dimension: country {}
  dimension_group: created {type:time  sql:${TABLE}.created_at ;;}
  dimension: email {}
  dimension: first_name {}
  dimension: gender {}
  dimension: last_name {}
  dimension: latitude {type:number}
  dimension: longitude {type:number}
  dimension: state {}
  dimension: traffic_source {}
  dimension: zip {}

  measure: average_home_value {type:average  value_format_name: decimal_0
    sql: ${zip_demographics.median_home_value} ;;}
  measure: probability_hispanic {type:average  value_format_name: percent_2
    sql: ${zip_demographics.probability_hispanic} ;;}
  measure: probability_male {type:average  value_format_name: percent_2
    sql: ${probability_male.male_percentage} ;;}
  measure: count {type:count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]}
}
