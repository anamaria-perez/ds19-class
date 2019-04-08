# Functions to fetch public biketown trip data
# http://www.biketownpdx.com/system-data

# pacman allows checking for and installing missing pacakages

remove.packages("pacman")

if (!require("pacman")) {install.packages("pacman")}; library(pacman)
pacman::p_load("lubridate")
