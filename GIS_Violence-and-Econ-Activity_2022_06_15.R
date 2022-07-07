####################################################################
#       Violent conflict and night lights in Burkina Faso 
###################################################################


# Isabella Rego Monteiro, June 2022

# File loads nightlight raster data, a shapefile with Burkina Faso's administrative boundaries, and data on violent conflicts. 

# File generates following output: map showcasing nightlights in Burkina Faso in 2019 and the occurrence of violent conflicts (represented in red with the size of the circles indicating the number of casualties).

# Created with R version 3.6.1




### Loading the necessary packages

library(haven) # loads package necessary to import the violent conflict database from Stata
library(dplyr) # loads package necessary to use pipe operator
library(raster) # loads spatial data package necessary to deal with raster data
library(sf) # loads spatial data package necessary to deal with shapefile data




### Violent conflict Dataset 

ged211 <- read_dta("C:/Users/adevi/Downloads/ged211-dta/ged211.dta") # loads the violent conflict dataset from Stata
conflict_burkinafaso= ged211 %>% filter(country_id==439) %>% filter(year==2019) # Filters only data for Burkina Faso in the year of 2019




### Nightlight data

object1<-'Burkina_Faso_rade9lnmu_2019.tif'  # reads the nightlight data
imported_raster1=raster(object1) #converts the nightlight data to raster 
plot(imported_raster1) # plots the nightlight data




### Administrative Boundary
#### PS: Shapefile data needs to be unzipped, keeping all the original files in the same folder. If you only keep the shp file it will not work.

shapefile <- sf::st_read(paste0(getwd(), "/gadm40_BFA_shp/gadm40_BFA_0.shp")) # reads the shapefile data containing Burkina Faso's administrative boundary




### Cutting the raster satellite data according to the country's administrative boundary.

parameter1<-raster::extent(shapefile) # selects the boundaries of the shapefile

r2<-raster::crop(x= imported_raster1, y = parameter1) # modifies the extent of the raster data
rr <- raster::mask(x= r2, mask= shapefile) # transforms the area outside of the extent into NA using the cropped raster



### Plotting the final outcome

plot(shapefile$geometry, col = 'black', bg = 'black') # plots a black background 
plot(rr, col = grey.colors(800, start=0, end=1), main = "4x10 Raster", add=TRUE,  legend=FALSE) 
points(conflict_burkinafaso$longitude, conflict_burkinafaso$latitude, col = "red", cex = as.numeric(conflict_burkinafaso$best)/7, lwd=0.2) 
title(main = "Burkina Faso, Nightlight and Conflicts in 2019") # plots the nightlights and adds red circles that depict the number of deaths due to violent conflicts (the bigger the circle, the larger the number of deaths)



