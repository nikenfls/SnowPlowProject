#snow plow project
#Zhihui Hong, Ziwei Pi, Haoxuan Shi, Feng Chen
#03/01/2018
#get geometry coordinates from hospital address
#original csv has 6 columns: "longitude" 
#"latitude"      "Hospital_Name" "Address"       "Telephone"     "Hours"  
#while first two columns are empty
hospitals<-read.csv("Syracuse_Hospitals.csv",stringsAsFactors = FALSE)
hospitals
colnames(hospitals)
#install.packages("ggmap")
library(ggmap)

#sample code
result<-geocode("90 Presidential Plaza, Syracuse, NY 13202", output="latlona",source="google")
#        lon      lat                                   address
#1 -76.13046 42.99739 211 lafayette rd, syracuse, ny 13205, usa
str(hospitals)
hospitals$longitude<-as.character(hospitals$longitude)
hospitals$latitude<- as.character(hospitals$latitude)
#result[1]
#-76.13046
dim(hospitals)
#hospitals[1,3]
str(result)
for(i in 1:dim(hospitals)[1]){
    result<-geocode(hospitals[i,4],output="latlona",source="google")
    hospitals[i,1]<-result[1]
    hospitals[i,2]<-result[2]
    hospitals[i,4]<-result[3]
  
}
write.csv(hospitals,file="hospitals.csv")
