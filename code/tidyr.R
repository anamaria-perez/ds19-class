library(tidyr)
library(dplyr)
library(ggplot2)
library(readr)

bikenet <- read_csv("data/bikenet-change.csv")
summary(factor(bikenet$facility2013))

# gather facility columns into single year variable
colnames(bikenet)
bikenet_long <- bikenet %>%
  gather(key="year", value="facility",
         facility2008: facility2013, na.rm = T) %>%
  mutate(year = stringr::str_sub(year, start = -4))
head(bikenet_long)

# Danger below! fname can have multiple words
# collapse/unite street and suffix to one value
bikenet_long <- bikenet_long %>%
  unite(col="street", c("fname", "ftype"), sep = " ")
head(bikenet_long)

# separate street and suffix back to two values
bikenet_long <- bikenet_long %>%
  separate(street, c("name", "suffix"))
head(bikenet_long)

bikenet_long %>% filter(bikeid == 139730)

fac_lengths <- bikenet_long %>%
  filter(facility %in% c("BKE-LANE", "BKE-BLVD", "BKE-BUFF",
                         "BKE-TRAK", "PTH-REMU")) %>% #selecting facility types
  group_by(year, facility) %>%          # group by year and facility
  summarise(metres = sum(length_m)) %>% #summarize by length in meters
  mutate(miles = metres / 1609)
fac_lengths

p <- ggplot(fac_lengths, aes(year, miles, 
                             group = facility,
                             color = facility))

p + geom_line() # draw plot p as lines
p + geom_point() # draw plot p as dots
p + geom_line() + scale_y_log10() # draw plot p as lines with log10
p + geom_line() + labs(title = "Change in Bike Facilities in Portland",
                       subtitle = "2008 - 2013",
                       caption = "source: Portland Metro") + # add a title and subtitle
  xlab("Year") +
  ylab("Total Miles")

p2 <- ggplot(fac_lengths, aes(year, miles, 
                             group = facility)) # create a new plot, p2
p2 + geom_line(size = 1, color = "blue") + 
  facet_wrap(~ facility) # plot each facility type in individual figures


