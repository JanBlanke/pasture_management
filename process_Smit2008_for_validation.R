library(raster)
library(rgdal)

eu.nuts.2010 <- readOGR("/home/jan/Dropbox/Data/NUTS_2010_60M_SH/Data", "NUTS_RG_60M_2010")


### check netcdf files
smit.regions <- stack("/home/jan/Dropbox/Data/Smit_2008/map_nuts2_vector_new.nc", varname="nuts")
# 280 regions/layer, indexed as 0s
smit.ids <- stack("/home/jan/Dropbox/Data/Smit_2008/map_nuts2_vector_new.nc", varname="id")
smit.ids[[100]][]


### read Smit data
library(gdata)
df = read.xls ("/home/jan/Dropbox/Data/Smit_2008/PROD_area_smit_nuts2.xlsx", sheet = 1, header = TRUE)
idx <- which(df$productivity_smit == -9999)
df[idx, 3] <- NA

## read NUTS2 shape files
eu.nuts <- readOGR("/home/jan/Dropbox/Paper_2_nitro/Data/", "NUTS_WGS84")
eu.nuts <- eu.nuts[!is.na(eu.nuts$CAPRI_NUTS), ]
names(eu.nuts)[1] <- "NUTS2_id" 

eu.nuts.2010 <- spTransform(eu.nuts.2010, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
names(eu.nuts.2010)[1] <- "NUTS2" 
eu.nuts.2010$NUTS2_id <- eu.nuts.2010$NUTS2

## merge
eu.new <- merge(eu.nuts.2010, df, by = "NUTS2_id") 

class(eu.new)
spplot(eu.new["productivity_smit"], xlim = bbox(eu.new)[1, ] + c(30, 4), ylim = bbox(eu.new)[2, ] + c(40, 5))

