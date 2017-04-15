explore: filtered_lookml_dt {}

view: filtered_lookml_dt {
  derived_table: {
    query: {
      query_explore: users
      column: age {field: users.age}
      column: number {field: users.count}
      filters: {
        field: users.created_date
        from: filtered_lookml_dt.filter_date
      }
    }
  }

  filter: filter_date {
    type: date
  }
  dimension: age {type: number}
  dimension: number {type: number}
}
