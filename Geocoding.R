install.packages("shiny")
install.packages("devtools")

##

install.packages("gapminder")
install.packages("sf", configure.args = "--with-proj-lib=/usr/local/lib/")
install.packages("stars")
install.packages("gstat")
install.packages("maps")
install.packages("mapview")
install.packages("rnaturalearth")
install.packages("spatstat")
install.packages("spatialreg")
install.packages("gmodels")
library(gapminder)
library(sf)
library(stars)
library(gstat)
library(maps)
library(mapview)
library(rnaturalearth)
library(spatstat)
library(units)
library(spatialreg)
library(gmodels)

##Linestrings are formed by sequences of points, where straight lines are thought of as connecting them. Polygons are formed of non self-intersecting linestrings that form closed rings (first coordinate equals last coordinate).

##An example:
(nc = read_sf(system.file("gpkg/nc.gpkg", package="sf")))
library(ggplot2)
ggplot() + geom_sf(data = nc, aes(fill = SID74))

##
library(readxl)
library(tidyverse)

addresses<- c('Yosemite National Park, California', '1600 Pennsylvania Ave NW, Washington DC 20500', '2975 Kincaide St Eugene, Oregon, 97405')

gio_batch_geocode(addresses)
addresses1 <-("Friedrichstrasse 180, Berlin 10117, Germany" )
gio_batch_geocode(addresses1)

##old US elections data
library(tidyverse)
install.packages("USAboundaries")
library(USAboundaries)
library(ggplot2)
library(sf)
install.packages("scales")
library(scales)
install.packages("leaflet")
library(leaflet)

##load data

library(readr)
md1_candidates <- read_csv("Documents/GitHub/elections-data/congressional-candidate-counties-by-state/congressional-candidate-counties-meae.congressional.congress01.md.county.csv")
md1_parties <- read_csv("Documents/GitHub/elections-data/congressional-parties-by-state/congressional-parties-meae.congressional.congress01.md.county.csv")


md1_single_candidate <- md1_candidates %>%
  filter(candidate_id == "SJ0183")

install.packages("USAboundariesData", repos = "https://ropensci.r-universe.dev", type = "source")
library(USAboundariesData)
md1_counties <- us_counties(map_date = "1789-01-01",
                            resolution = "high", states = "MD")

plot(md1_counties$geometry,axes=TRUE)

md1_counties_parties <- left_join(md1_counties, md1_parties,
                                  by=c("id" = "county_ahcb"))

##Joining Candidate Data to Spatial Data
md1_counties_single_candidate <- left_join(md1_counties,
                                           md1_single_candidate, by=c("id" = "county_ahcb"))

##Visualizing: Maps
ggplot(md1_counties_parties) +
  geom_sf(aes(fill = federalist_percentage)) + 
  scale_fill_distiller(name = "Percent of Vote", 
                       palette = "Greens", 
                       na.value = "white", 
                       direction = 1, 
                       labels = scales::percent) + 
  labs(title ="Federalist Vote Percentage - MD1") + 
  theme(plot.title = element_text(size=14, hjust = 0.7),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

##Going Further with Party Percentages - ggplot2
