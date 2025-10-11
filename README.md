# NBA-Data-2010-2024 🏀

This repository contains CSV files containing comprehensive NBA data spanning from the year 2010 to 2024.

This data set was created by [@NocturneBear](https://github.com/NocturneBear) and then edited by [@rpcaraher](https://github.com/rpcaraher).

## Usage

Each of the **nba_player_stats** files contains data at the player-game level, organized by season. The **team_stats** file contains data on game outcomes at the team-game level.
The **nba_team_stats** data can be linked to unique rows in the **player_stats** data using the key variables `season_year`, `game_id`, and `team_id`.

## Dimensions

### NBA Player Stats Datafiles

- **season_year**: The season of the basketball season.
- **year**: The year of the start of the basketball season.
- **game_date**: The date of the game.
- **game_id**: Unique identifier for the game.
- **matchup**: The teams playing in the game.
- **team_id**: Unique identifier for the team.
- **team_city**: The city where the team is based.
- **team_name**: The name of the team.
- **team_abb**: A three-letter code representing the team.
- **player_id**: Unique identifier for the person (player).
- **player_name**: The name of the person (player).
- **position**: The position of the player.
- **mins**: The number of minutes played by the player.
- **fieldGoalsMade**: The number of field goals made by the player.
- **fieldGoalsAttempted**: The number of field goals attempted by the player.
- **freeThrowsMade**: The number of free throws made by the player.
- **freeThrowsAttempted**: The number of free throws attempted by the player.
- **threePointersMade**: The number of three-pointers made by the player.
- **threePointersAttempted**: The number of three-pointers attempted by the player.
- **reboundsTotal**: The total number of rebounds by the player.
- **assists**: The number of assists by the player.
- **steals**: The number of steals by the player.
- **blocks**: The number of blocks by the player.
- **turnovers**: The number of turnovers by the player.
- **foulsPersonal**: The number of personal fouls committed by the player.
- **points**: The total number of points scored by the player.

### NBA Team Stats Datafiles

- **season_year**: The year of the basketball season.
- **game_id**: Unique identifier for the game.
- **team_id**: Unique identifier for the team.
- **team_name**: The name of the team.
- **wl**: Takes a value of `W` if the team won the game, and `L` if they lost.
- **total_mins**: Total length of the game in minutes.
- **total_points**: The total number of points scored by the team in the game.


## License

[MIT](https://github.com/NocturneBear/NBA-Data-2010-2024/blob/main/LICENSE)
