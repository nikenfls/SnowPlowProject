#snow plow project
#Zhihui Hong, Ziwei Pi, Haoxuan Shi, Feng Chen
#03/01/2018
#filter csv data by time range and find the latest location of trucks

library(sp)
library(rgdal)
selectfile<-file.choose()
dataset<-read.csv(selectfile,stringsAsFactors = FALSE)
#basename and dirname
fileName<-basename(selectfile)
fileName<-strsplit(fileName,".",fix=TRUE)[[1]][1]
fileName

onetime<-as.POSIXct(strptime(dataset$date_fixed[1], "%Y-%m-%d %H:%M:%S.000"))
dateStamp<-format(onetime,format="%Y_%m_%d")

dataset$date_fixed<-as.POSIXct(strptime(dataset$date_fixed, "%Y-%m-%d %H:%M:%S.000"))
dataset$date_fixed<-format(dataset$date_fixed,format="%H:%M:%S")

#filter the dataset by startTime and endTime, format Hour:Minute:second
filterDataset<-function(startTime,endTime){
  return(dataset[dataset$date_fixed>startTime&dataset$date_fixed<endTime,])
  
}
  
#filtered<-dataset[dataset$date_fixed<"09:00:40"&dataset$date_fixed>"06:00:00",]
  
filtered<-filterDataset("06:00:00","09:00:00")
  
tapply(filtered$date_fixed,filtered$truck_name,max)
IDs<-unique(filtered$truck_name)
latestLocation<-data.frame()
for (i in 1:length(IDs)){ 
  temp <- filtered[filtered$truck_name==IDs[i],]
  
  temp <- filtered[filtered$truck_name==IDs[i],]
  maxtimeRecord<-temp[temp$date_fixed==max(temp$date_fixed),]
  maxtimeRecord
  latestLocation<-rbind(latestLocation,maxtimeRecord)
}

#  temp <- filtered[filtered$truck_name==IDs[1],]
#  maxtimeRecord<-temp[temp$date_fixed==max(temp$date_fixed),]
#  maxtimeRecord
write.csv(filtered,"filtered.csv")
write.csv(latestLocation,"latestLocation.csv")





# library(rgdal)
# library(rgeos)
# snowplow<-readOGR(dsn="SnoWplow_Data_March_16_2017","Snowplow_Data_March_16_2017")
# streetdata<-readOGR(dsn="street_shapefile","streets")
# DefaultCrs<-crs(snowplow)
# # lists<-list(x1,x2)
# ln<-spLines(lists,crs=DefaultCrs)
# shapefile(ln,"test.shp",overwrite=TRUE)
# plot(ln, col = "blue",
#      pch = 8,
#      main = "SJER Plot Locations\nMadera County, CA")
# IDs<-unique(dataset$truck_name)
# lists<-list()
# #install.packages("rlist")
# library(rlist)
# for (i in 1:length(IDs)){ 
#   temp <- dataset[dataset$truck_name==IDs[i],]
#   print(dim(temp))
#   lon<-temp$longitude
#   lat<-temp$latitude
#   line<-cbind(lon,lat)
#   #more things to do with temp
#   lists[i]<-line
# }
# IDs[1]
# temp <- dataset[dataset$truck_name==IDs[31],]
# dim(temp)
# lon<-temp$longitude
# lat<-temp$latitude
# line<-cbind(lon,lat)