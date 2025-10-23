## Data Cleaning NBA DAta for EC 325

library(tidyverse)

rm(list = ls())

options(scipen = 999)

## Read in original data and combine

part1 <- read_csv("original_data/regular_season_box_scores_2010_2024_part_1.csv")

part2 <- read_csv("original_data/regular_season_box_scores_2010_2024_part_2.csv")

part3 <- read_csv("original_data/regular_season_box_scores_2010_2024_part_3.csv")

nba_comb <- bind_rows(part1, part2, part3)

colnames(nba_comb)

## Clean columns

nba_comb <- nba_comb |> 
  mutate(year = as.integer(substr(season_year, 1, 4)))

nba_comb <- nba_comb |> 
  mutate(game_id = str_pad(gameId, 10, side = "left", pad = "0"),
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
    game_id, game_date, matchup, position,
    points, mins,
    fieldGoalsAttempted, fieldGoalsMade,
    threePointersAttempted, threePointersMade,
    freeThrowsAttempted, freeThrowsMade,
    reboundsTotal, assists, steals, blocks,
    turnovers, foulsPersonal
  )

colnames(nba_comb)

## Export as smaller files

count(nba_comb, year)

nba_comb |> 
  filter(year >= 2010 & year <= 2015) |> 
  write_csv("nba_player_stats_pt1.csv")

nba_comb |> 
  filter(year >= 2016 & year <= 2020) |> 
  write_csv("nba_player_stats_pt2.csv")

nba_comb |> 
  filter(year >= 2021 & year <= 2024) |> 
  write_csv("nba_player_stats_pt3.csv")

## Import raw teams data

nba_teams <- read_csv("original_data/regular_season_totals_2010_2024.csv")

colnames(nba_teams)

## Clean data

nba_teams <- janitor::clean_names(nba_teams)

colnames(nba_teams)

nba_teams <- nba_teams |> 
  select(season_year, team_id, team_name, game_id, wl, min, pts)

nba_teams <- nba_teams |> 
  rename(total_mins = min,
    total_points = pts)

nba_teams <- nba_teams |> 
  mutate(team_id = as.character(team_id))

glimpse(nba_teams)

## Export file

nba_teams |> 
  write_csv("nba_team_stats.csv")


## Run Test Regressions

nba_comb <- nba_comb |> 
  left_join(nba_teams, by = c("season_year", "game_id", "team_id"))

nba_comb <- nba_comb |> 
  filter(points > 1)

nba_comb <- nba_comb |> 
  mutate(position_center = case_when(position == "C" ~ 1,
    is.na(position) ~ NA_real_,
  TRUE ~ 0),
position_guard = case_when(position == "G" ~ 1,
  is.na(position) ~ NA_real_,
  TRUE ~ 0))


reg1 <- lm(points ~ threePointersAttempted + fieldGoalsAttempted + 
    mins + freeThrowsMade + reboundsTotal + assists + steals + blocks + 
    turnovers + foulsPersonal + position_center + position_guard,
    data = nba_comb)

summary(reg1)

nba_comb <- nba_comb |> 
  mutate(season_year.f = factor(season_year),
    team_id.f = factor(team_id),
  player_id.f = factor(player_id))


reg_fe <- lm(points ~ threePointersAttempted + fieldGoalsAttempted + 
    mins + freeThrowsMade + reboundsTotal + assists + steals + blocks + 
    turnovers + foulsPersonal + position_center + position_guard +
  season_year.f + team_id.f,
  data = nba_comb)

summary(reg_fe)

## LPM

nba_comb <- nba_comb |> 
  mutate(won = case_when(wl == "W"~ 1,
  TRUE ~ 0))

lpm_reg1 <- lm(won ~ threePointersAttempted + fieldGoalsAttempted + 
    mins + freeThrowsMade + reboundsTotal + assists + steals + blocks + 
    turnovers + foulsPersonal + position_center + position_guard,
    data = nba_comb)

summary(lpm_reg1)

lpm_reg2 <- lm(won ~ threePointersAttempted + fieldGoalsAttempted + 
    mins + freeThrowsMade + reboundsTotal + assists + steals + blocks + 
    turnovers + foulsPersonal + position_center + position_guard +
    season_year.f + team_id.f,
    data = nba_comb)

summary(lpm_reg2)
