## Data Cleaning for EC 325

library(tidyverse)


rm(list = ls())

options(scipen = 999)


## Read in original data

part1 <- read_csv("regular_season_box_scores_2010_2024_part_1.csv")

part2 <- read_csv("regular_season_box_scores_2010_2024_part_2.csv")

part3 <- read_csv("regular_season_box_scores_2010_2024_part_3.csv")


nba_comb <- bind_rows(part1, part2, part3)


colnames(nba_comb)

## Clean columns

nba_comb <- nba_comb |> 
  mutate(year = as.integer(substr(season_year, 1, 4)))

nba_comb <- nba_comb |> 
  mutate(game_id = as.character(gameId),
  team_id = as.character(teamId),
  player_id = as.character(personId))

nba_comb <- nba_comb |> 
  mutate(mins = minute(minutes))

nba_comb <- nba_comb |> 
  mutate(player_name = personName,
    team_name = teamName,
    team_city = teamCity,
    team_abb = teamTricode
    )

nba_comb <- nba_comb |> 
  select(
    season_year, year,
    player_id, player_name, 
    team_id, team_name, team_abb, team_city,
    game_id, game_date, matchup,
    points,
    fieldGoalsAttempted, fieldGoalsMade,
    threePointersAttempted, threePointersMade,
    freeThrowsAttempted, threePointersMade,
    reboundsTotal, assists, steals, blocks,
    turnovers, foulsPersonal
  )

colnames(nba_comb)

colnames(nba_data_teams)

## Merge in team data

nba_comb <- nba_comb |> 
    mutate(gameId = as.character(gameId))

nba_full <- nba_comb |>
    left_join(nba_data_teams,
    by = c(
        "game_date" = "GAME_DATE",
        "matchup" = "MATCHUP",
        "teamTricode" = "TEAM_ABBREVIATION"))

count(nba_full, WL)

## Clean the data

nba_full <- nba_full |> 
    mutate(year = as.numeric(substr(season_year, 1, 4)))

## Find average 3 point shots

wl_tab <- nba_full |> 
    group_by(year, WL) |> 
    filter(minutes > 1) |> 
    summarize(avg_3point = mean(threePointersAttempted, na.rm = T))


wl_tab_w <- wl_tab |> 
    pivot_wider(
        names_from = "WL",
        values_from = "avg_3point")
wl_tab_w

## Plot average 3 point attempts per player

p1 <- ggplot(data = wl_tab) +
    geom_line(aes(x = year, y = avg_3point, color = WL))

print(p1)
