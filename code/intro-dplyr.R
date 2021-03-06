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

# working with group_by() & summarize()
str(gapminder %>% group_by(continent))

# summarize mean gdp per continent
gdp_continent <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdp = mean(gdpPercap),
            mean_lifeExp = mean(lifeExp))
View(gdp_continent)

library(ggplot2)
summary_plot <- gdp_continent %>%
  ggplot(aes(x = mean_gdp, y = mean_lifeExp)) +
  geom_point(stat = "Identity") + 
  theme_bw()
summary_plot

# calculate mean population for all the continents
pop_continent <- gapminder %>%
  group_by(continent) %>% 
  summarize(mean_pop  = mean(pop))
mean_pop
View(pop_continent)

# count() and n()
gapminder %>% 
  filter(year == 2002) %>%
  count(continent, sort = TRUE)

gapminder %>% 
  group_by(continent) %>%
  summarize(se = sd(lifeExp)/sqrt(n()))

# mutate() is my friend 
xy <- data.frame(x = rnorm(100),
                 y = rnorm(100))
head(xy)
xyz <- xy %>%
  mutate(z = x*y)
head(xyz)

# add a column for total gdp per country
total_gdp_country <- gapminder %>%
  mutate(total_gdp = pop*gdpPercap)
head(total_gdp_country)

# add a column that gives full gdp per continent
gdp_per_continent <- gapminder %>%
  mutate(total_gdp = pop*gdpPercap) %>%
  group_by(continent) %>%
  summarise(cont_gdp = sum(total_gdp))
gdp_per_continent




