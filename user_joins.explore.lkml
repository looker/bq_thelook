# All the facts we've built around the users
explore: user_joins {
  extension: required
  join: user_order_facts {
    #view_label: "Users"
    sql_on: ${user_order_facts.user_id} = ${users.id} ;;
    relationship: many_to_one
   }

  join: user_event_attribution {
    view_label: "Users"
    sql_on: ${user_event_attribution.user_id} = ${users.id} ;;
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

  join: zip_demographics {
    sql_on: ${users.zip} =  ${zip_demographics.zip};;
    relationship: many_to_one
  }
}
