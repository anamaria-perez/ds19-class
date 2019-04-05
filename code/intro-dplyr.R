# Intro to dplyr
library(dplyr)

# load gapminder data as sample dataset
gapminder <- read.csv("data/gapminder_data.csv",
                      stringsAsFactors = F)

# for single column changes:
# gapminder#continent <- as.factor(gapminder$continent)
# gapminder$continent <- as.character(gapminder$continent)


mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

# This is a pipe: %>%
# Functions we will learn today from dplyr:
# 1. select()
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# what attributes in gapminder
colnames(gapminder)
# select three attributes from gapminder:
subset_1 <- gapminder %>%
  select(country, continent, lifeExp)

# select every attribute except 2:
subset_2 <- gapminder %>%
  select(-lifeExp, -pop)
str(subset_2)

# select some attributes but rename a few of them for clarity
subset_3 <- gapminder %>%
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str(subset_3)

# using filter()
africa <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(country, population = pop, lifeExp)
table(africa$country)

# did not use pipe
africa <- filter(gapminder, continent =="Africa")
africa <- select(africa, country, population = pop, lifeExp)

# select year, population, country, for Europe
Europe <- gapminder %>% 
  filter(continent == "Europe") %>%
  select(year, population = pop, country)
table(Europe$country)

