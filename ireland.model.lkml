connection: "bigquery_publicdata_standard_sql"

# include all the views
include: "team.view"

explore: county {}

map_layer: irish_counties {
  file: "irish_counties.topojson"
  property_key: "name"
}

view: county {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: select "Antrim" as team union all
      select "Armagh" as team union all
      select "Carlow" as team union all
      select "Cavan" as team union all
      select "Clare" as team union all
      select "Cork" as team union all
      select "Derry" as team union all
      select "Donegal" as team union all
      select "Down" as team union all
      select "Dublin" as team union all
      select "Fermanagh" as team union all
      select "Galway" as team union all
      select "Kerry" as team union all
      select "Kildare" as team union all
      select "Kilkenny" as team union all
      select "Laois" as team union all
      select "Leitrim" as team union all
      select "Limerick" as team union all
      select "London" as team union all
      select "Longford" as team union all
      select "Louth" as team union all
      select "Mayo" as team union all
      select "Meath" as team union all
      select "Monaghan" as team union all
      select "New York" as team union all
      select "Offaly" as team union all
      select "Roscommon" as team union all
      select "Sligo" as team union all
      select "Tipperary" as team union all
      select "Tyrone" as team union all
      select "Waterford" as team union all
      select "Westmeath" as team union all
      select "Wexford" as team union all
      select "Wicklow" as team ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: county {
    type: string
    sql: ${TABLE}.team ;;
    primary_key: yes
    map_layer_name: irish_counties
  }

  measure: count {
    type: count
  }

}
