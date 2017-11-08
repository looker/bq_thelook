connection: "connection_name"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project
include: "jiro_test.model.lkml"

explore: testing {
  hidden: yes
  extends: [test]

}
