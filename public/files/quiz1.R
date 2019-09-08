library(tidyverse)

south <- c("FL","GA","SC","NC","TN","AL","MS","VA","DC")

carData::Anscombe %>%
  rownames_to_column(var = "state") %>%
  filter(state %in% south) %>%
  mutate(urban = urban / 1000) %>%
  ggplot(aes(x = state, y = urban)) +
  geom_col(width = .7) + 
  cowplot::theme_minimal_hgrid(font_size = 10) +
  labs(x = " ", y = " ", title = "Urban Population as Percent of State Population", subtitle = "Southern States + District of Columbia") + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))
  #ggsave("quiz-1.png", height = "500", width = "300")
  
carData::Anscombe %>%
  rownames_to_column(var = "state") %>%
  mutate(urban = urban / 1000, young = young / 1000) %>%
  mutate(label = if_else(state %in% c("AK","NM","UT","WV","VT","DC","NC","CA"),state,"")) %>%
  mutate(income_bin = ntile(income, 5)) %>%
  mutate(income_bin = as.factor(income_bin)) %>%
  ggplot(aes(x = young, y = urban, color = income_bin)) +
  geom_point(size = 2) + 
  cowplot::theme_minimal_grid(font_size = 10) +
  ggrepel::geom_label_repel(
    aes(label = label),
    color = "black",
    size = 9/.pt, # font size 9 pt
    point.padding = 0.1, 
    box.padding = .6,
    min.segment.length = 0,
    seed = 7654
  ) +
  colorblindr::scale_color_OkabeIto() +
  labs(
    x = "Youth Population Rate", 
    y = "Urban Population Rate", 
    title = "Youth vs. Urban Population Rates by U.S. State",
    caption = "Youth = 18 Years old or younger"
  ) + 
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  scale_x_continuous(labels = scales::percent_format(accuracy = 1))
  #ggsave("quiz-1.png", height = "500", width = "300")

carData::Anscombe %>%
  rownames_to_column(var = "state") %>%
  mutate(urban = urban / 1000, young = young / 1000) %>% 
  head()

