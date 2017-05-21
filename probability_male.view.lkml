include: "/name_game2/name_game.explore"

# https://master.dev.looker.com/explore/name_game2/name_game?qid=0Moo3wsmchrFsLofrNPPrS

view: probability_male {
  derived_table: {
    explore_source: name_game {
      column: name {}
      column: male_percentage {}
    }
  }
  dimension: name {}
  dimension: male_percentage {type:number}
}
