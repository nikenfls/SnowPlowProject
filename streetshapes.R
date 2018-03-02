#snow plow project
#Zhihui Hong, Ziwei Pi, Haoxuan Shi, Feng Chen
#03/01/2018
#create points shape files using specific Street_IDs

library(sp)
library(rgdal)
streetdata<-readOGR(dsn="street_shapefile","streets")
#list the Street_IDs that require plowing
specificID<-c(12573100,12577668)

newdata<-streetdata[streetdata$STREET_ID %in% specificID,]
#DefaultCrs<-crs(streetdata)
#create shapefile
shapefile(newdata,"test.shp",overwrite=TRUE)
