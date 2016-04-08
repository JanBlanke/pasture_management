library(raster)
library(rgdal)
library(rasterVis)

eu.nuts <- readOGR("/home/jan/GIS_data", "NUTS2_wgs84_masked")
eu.nuts <- spTransform(eu.nuts, CRS("+proj=longlat +ellps=WGS84 +no_defs"))

#read CAPRI data
lala <- stack("/media/jan/AddData/Data/Pasture_fert_CAPRI/nfert/Eu_grassland_management_A_1901-2011.nc", varname="gras_minfer")

levelplot(lala[[111]])
plot(eu.nuts, add=T)
