library(tidyverse)

# how many rows and columns are in the data frame?

nrow(rm_df)

ncol(rm_df)

# what

glimpse(rm_df)

# group by count

species_count <- rm_df %>%
  group_by(species) %>%
  summarise(count=n())

# how many 'Cronenberg' characters exist?

# create a bar chart with geom_col and species as x and count as y

species_count %>%
  ggplot(aes(x = species, y = count)) +
  geom_col()

# 

species_count %>%
  mutate(species = factor(species)) %>%
  ggplot(aes(x = forcats::fct_reorder(species, count), y = count)) +
  geom_col()

# coord_flip

species_count %>%
  mutate(species = factor(species)) %>%
  ggplot(aes(x = forcats::fct_reorder(species, count), y = count)) +
  geom_col() +
  coord_flip()

species_count %>%
  mutate(species = factor(species)) %>%
  ggplot(aes(x = forcats::fct_reorder(species, count), y = count, fill = species)) +
  geom_col() +
  coord_flip() +
  ggthemes::theme_igray() +
  labs(x = "", y = "Number of Characters by Species")


###

## lookup what tidy is...

tidy_ep <- ep_cnt %>%
  gather("Species","CharacterCount",-id,-name,-air_date,-episode) %>%
  filter(CharacterCount != 0) %>%
  mutate(Species = case_when(
    Species %in% c("Alien","Human") ~ Species,
    TRUE ~ "Other"
  ))

tidy_ep %>%
  filter(Species %in% c("Alien","Human")) %>%
  ggplot(aes(x = id, y = CharacterCount, color = Species)) +
  geom_point() +
  geom_line()

tidy_ep %>%
  filter(Species %in% c("Alien","Human")) %>%
  mutate(Season = substr(episode, 1, 3)) %>%
  ggplot(aes(x = id, y = CharacterCount, fill = Season)) +
  geom_col() +
  facet_wrap(~Species) +
  theme(legend.position = "none")


# which do you think does better: bar chart or line chart?
# in what situations (question of interest) would the other be better?

#install.packages("ggsci"): https://nanx.me/ggsci/reference/pal_rickandmorty.html
# rick and morty 
# ggsci::pal_rickandmorty("schwifty")(3)


# how to get the data

library(mortyr)

rm_df <- mortyr::get_characters()

rm_df <- rm_df %>%
  select(id, name, status, species, type, gender, origin.name, location.name)

write_csv(rm_df, "./static/files/rickmorty_char.csv")

char <- mortyr::get_characters() %>%                      # [explain what this step does]
  unnest(episode) %>%                                     # ...
  count(species, name, episode) %>%                       # ...
  ungroup() %>%                                           # ...
  group_by(episode, species) %>%                          # ...
  summarise(count=n_distinct(name)) %>%                                # ...
  ungroup() %>%                                           # ...
  spread("species","count", fill = 0) %>%                 # ...
  mutate(id = as.integer(substr(episode, 41, 42))) %>%    # ...
  select(-episode)                                        # ...

ep_cnt <- episodes %>%                                    # ...
  inner_join(char, by = "id") %>%                         # ...
  select(-characters, -url, -created)                     # ...

write_csv(ep_cnt, "./static/files/episode_char.csv")    # ...

