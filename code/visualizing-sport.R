# ------------------------------------
# 
# R script to call to College Football Data API and visualize play-by-play data.
# Workshop: Gathering Data from the Web Using APIs
# Dan Johnson + Summer Mengarelli, Spring 2026
#
# ------------------------------------

# Libraries
## installing cfbfastR from the sportsdataverse:
# if (!requireNamespace('remotes', quietly = TRUE)){
#   install.packages('remotes', repos = "https://cloud.r-project.org")
# }
# remotes::install_github("sportsdataverse/cfbfastR")

library(cfbfastR)
library(sportyR)
library(tidyverse)
library(scales)
library(gganimate)

# ------------------------------------

# API KEY
## I requested a key here: https://collegefootballdata.com/key
Sys.setenv(CFBD_API_KEY = " ")

# ------------------------------------

# Make API request for play-by-play data of 2025 season and fter to ND vs Navy game (could have done this multiple ways)
game <- cfbfastR::load_cfb_pbp(seasons = 2015) %>%
   filter(home == "Notre Dame" & away == "Massachusetts")

# ------------------------------------

game_clean <- game %>%
  mutate(
    # Convert clock to total seconds remaining in game
    game_seconds = (4 - period) * 15 * 60 + clock_minutes * 60 + clock_seconds,
    game_seconds = max(game_seconds) - game_seconds,
  ) %>%
  mutate(play_type_clean = case_when( 
    str_detect(play_type, "Passing") ~ "Touchdown",
    str_detect(play_type, "Rushing") ~ "Touchdown",
    play_type == "Rush" ~ "Rush",
    (play_type == "Pass Reception" | play_type == "Pass Incompletion") ~ "Pass",
    str_detect(play_type, "Field Goal") ~ "Field Goal",
    str_detect(play_type, "Punt") ~ "Punt",
    play_type == "Sack" ~ "Sack",
    TRUE ~ "Other")) %>%
  mutate(play_type_clean = as.factor(play_type_clean)) %>%
  arrange(game_seconds)

p <- ggplot(game_clean, aes(
  x = game_seconds,
  y = yards_gained,
  color = play_type_clean
)) +
  geom_point(size = 8, alpha = 0.9) +
  
  labs(
    title = paste("Plays:", game_clean$home, "v", game_clean$away),
    subtitle = "Game time: {round(frame_time/60, 1)} minutes",
    x = "Game Time (seconds elapsed)",
    y = "Yards Gained",
    color = "Play Type"
  ) +
  ylim(-20, 75) +
  theme_minimal() +
  scale_color_brewer(palette = "Set2") +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

anim <- p +
  transition_time(game_seconds) +
  ease_aes() +
  shadow_mark(alpha = 0.6, size = 2)

animate(anim, fps = 5, width = 800, height = 500)



anim_save("umass.gif")















# ------------------------------------ OLD

# Prepare data to plot plays
## Create X/Y coordinates, where X maps to final location of play and Y is (for now) at center
nd_navy_plot <- nd_navy %>%
  filter(!is.na(yards_to_goal)) %>%
  mutate(
    end_x = (50 - yards_to_goal + yards_gained),
    y = 0,  
    ### Clean up play types to limit colors needed:
    play_type_clean = case_when( 
      str_detect(play_type, "Passing") ~ "Touchdown",
      str_detect(play_type, "Rushing") ~ "Touchdown",
      play_type == "Rush" ~ "Rush",
      (play_type == "Pass Reception" | play_type == "Pass Incompletion") ~ "Pass",
      str_detect(play_type, "Field Goal") ~ "Field Goal",
      str_detect(play_type, "Punt") ~ "Punt",
      play_type == "Sack" ~ "Sack",
      TRUE ~ "Other"
    )
  )

## Remove Jeremiyah Love TD so we can plot it individually later
nd_navy_plot <- nd_navy_plot %>% filter(yards_gained != 48)

## Find Love play
love_td_play <- nd_navy %>%
  filter(str_detect(play_text, regex("Love", ignore_case = TRUE)),
         play_type == "Rushing Touchdown",
         str_detect(play_text, "48"))

## Create dataframe of specific start/end X/Y coordinates of Love rush
love_td_plot <- data.frame(
  start_x = 50 - love_td_play$yards_to_goal,
  end_x = 50 - love_td_play$yards_to_goal + love_td_play$yards_gained,
  start_y = 0,
  end_y = 0
)

# ------------------------------------ OLD VIZ

# Visualize ND plays!
gg_field <- geom_football(league = "ncaa", display_range = "full") +
  geom_point(
    data = nd_navy_plot,
    aes(x = end_x, y = y, color = play_type_clean),
    size = 3, alpha = 0.7,
    position = position_jitter(width = 0, height = 20)
  ) +
  
  scale_color_manual(
    values = c(
      "Rush" = "#0C2340",        
      "Pass" = "#b3dac5",        
      "Field Goal" = "white",
      "Punt" = "gray50",
      "Sack" = "black",
      "Touchdown" = "#C99700",
      "Other" = "lightblue"
    )
  ) +
  geom_point(data = love_td_plot, aes(x = end_x, y = end_y), color = "#FFC72C", size = 5, shape = 19) +
  geom_segment(data = love_td_plot, aes(x = start_x, y = start_y, xend = end_x, yend = end_y),
               arrow = arrow(length = unit(0.2,"cm")), color = "#FFC72C", size = 1, alpha = .7) +
  geom_point(data = love_td_plot, aes(x = start_x, y = start_y), color = "#0C2340", size = 4) +
  geom_text(
    data = love_td_plot,
    aes(x = end_x - 20, y = end_y+4, label = "Love 48-yard TD"),
    color = "#FFC72C", fontface = "bold", hjust = 0
  ) +
  labs(
    title = "Notre Dame Plays Against Navy | November 8, 2025",
    color = "Play Type",
    caption = "Data: cfbfastR + CollegeFootballData API | Visualization: sportyR + ggplot2"
  ) +
  theme_void(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

gg_field




library(gganimate)

nd_clean <- nd_navy %>%
  arrange(game_play_number) %>%
  mutate(play_type = as.factor(play_type)) %>%
  group_by(play_type) %>%
  mutate(cum_epa = cumsum(EPA)) %>%
  ungroup()

p <- ggplot(nd_clean, aes(
  x = game_play_number,
  y = cum_epa,
  color = play_type,
  group = play_type
)) +
  geom_line(size = 1.2) +
  labs(
    title = "Cumulative EPA by Play Type",
    subtitle = "Play: {closest_state}",
    x = "Play Number",
    y = "Cumulative EPA",
    color = "Play Type"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

anim <- p +
  transition_reveal(game_play_number)

animate(anim, nframes = 120, fps = 10, width = 800, height = 500)
 
