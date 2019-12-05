# install.packages("raster")
# install.packages("sf")
# install.packages("viridis")
# install.packages("rgeos")
# install.packages("lwgeom")
# install.packages("rgdal")
library(raster)
library(sf)
library(viridis)
library(rgeos)
library(lwgeom)
library(units)
library(rgdal)

setwd("/home/yige/Documents/CMEECoursework/WEEK5/code")

#### making vectors from coordinates
###  create a data frame 
pop_dens <- data.frame(n_km2 = c(260, 67, 151, 4500, 133),
                       country= c("England", "Scotland", "Wales", "London", "Northern Ireland"))
print(pop_dens)
## in pop_dens -n__km2 is area?  next make polygen多边形for each country,
## isolate london from the rest of the englannd

### create coordinate for each country

##coordinates form egde of ploygen
scotland <- rbind(c(-5, 58.6), c(-3, 58.6), c(-4, 57.6), 
                  c(-1.5, 57.6), c(-2, 55.8), c(-3, 55), 
                  c(-5, 55), c(-6, 56), c(-5, 58.6))
england <- rbind(c(-2,55.8),c(0.5, 52.8), c(1.6, 52.8), 
                 c(0.7, 50.7), c(-5.7,50), c(-2.7, 51.5), 
                 c(-3, 53.4),c(-3, 55), c(-2,55.8))
wales <- rbind(c(-2.5, 51.3), c(-5.3,51.8), c(-4.5, 53.4),
               c(-2.8, 53.4),  c(-2.5, 51.3))
ireland <- rbind(c(-10,51.5), c(-10, 54.2), c(-7.5, 55.3),
                 c(-5.9, 55.3), c(-5.9, 52.2), c(-10,51.5))
# vectors are combine by columns

scotland <- st_polygon(list(scotland))
england <- st_polygon(list(england))
wales <- st_polygon(list(wales))
ireland <- st_polygon(list(ireland))

# st_polygon create feature for polygon from the list


uk_eire <- st_sfc(wales, england, scotland, ireland, crs = 4326)
#st_sfc() create a feature geometry list column, crs set reference system(EPSG code or character with proj4string)
plot(uk_eire, aps=1)

uk_eire_capitals <- data.frame(long= c(-0.1, -3.2, -3.2, -6.0, -6.25),
                               lat=c(51.5, 51.5, 55.8, 54.6, 53.30),
                               name=c('London', 'Cardiff', 'Edinburgh', 'Belfast', 'Dublin'))

uk_eire_capitals <- st_as_sf(uk_eire_capitals, coords=c('long','lat'), crs=4326)

## set coordinate for st pauls
st_pauls <- st_point(x=c(-0.098056, 51.513611))
london <- st_buffer(st_pauls, 0.25)

england_no_london <- st_difference(england, london) 
lengths(scotland)
lengths(england_no_london)
wales <- st_difference(wales, england)
# st_difference() can take out common ground.

ni_area <- st_polygon(list(cbind(x=c(-8.1, -6, -5, -6, -8.1), y=c(54.4, 56, 55, 54, 54.4))))
northern_ireland <- st_intersection(ireland, ni_area)
eire <- st_difference(ireland, ni_area)

uk_eire <- st_sfc(wales, england_no_london, scotland, london, northern_ireland, eire, crs = 4326)

### feature and geometries
##  make the UK into a single feature

uk_country <- st_union(uk_eire[-6])
# st_union combine several geometries together

print(uk_eire)
print(uk_country)

par(mfrow = c(1,2), mar = c(3,3,1,1))
plot(uk_eire, asp =1, col = rainbow(6))
plot(st_geometry(uk_eire_capitals), add=T)
plot(uk_country, asp=1, col= "lightblue")


### Vector data and attributes
uk_eire <- st_sf(name=c('Wales', 'England','Scotland', 'London', 
                        'Northern Ireland', 'Eire'),
                 geometry=uk_eire)
# st_sf extend ea current data.frame like object with a simple feature list coluumn
plot(uk_eire, asp=1)

uk_eire$capital <- c('Cardiff', 'London','Edinburgh', NA,'Belfast', 'Dublin')
uk_eire <- merge(uk_eire, pop_dens, by.x='name', by.y='country', all.x=TRUE)
print(uk_eire)

### spatial attriibutrs
uk_eire_centroids <- st_centroid(uk_eire)
#st_centroid find the central point of a polygen
st_coordinates(uk_eire_centroids)

uk_eire$area <- st_area(uk_eire)
uk_eire$length <- st_length(uk_eire)
# st_area and st_length work out the area and length from the coordinate

print(uk_eire)

uk_eire$area <- set_units(uk_eire$area, 'km^2')
uk_eire$length <- set_units(uk_eire$length, 'km')

uk_eire$length <- as.numeric(uk_eire$length)
# as.numeric will remove the units
print(uk_eire)

st_distance(uk_eire)
# might be measuring the distance between edges.

st_distance(uk_eire_centroids)
# distance between centroids for sure.


### plotting sf objects
plot(uk_eire['n_km2'], asp=1)

## scale the legend 
# You could simply log the data:
uk_eire$log_n_km2 <- log10(uk_eire$n_km2)
plot(uk_eire['log_n_km2'], asp=1)
# Or you can have logarithimic labelling using logz
plot(uk_eire['n_km2'], asp=1, logz=TRUE)

### reprojecting vector data

# British National Grid (EPSG:27700)
uk_eire_BNG <- st_transform(uk_eire, 27700)
# The bounding box of the data shows the change in units
st_bbox(uk_eire)
##  xmin  ymin  xmax  ymax 
## -10.0  50.0   1.6  58.6

st_bbox(uk_eire_BNG)
##       xmin       ymin       xmax       ymax 
## -154811.97   17655.72  642773.71  971900.65

# UTM50N (EPSG:32650)
uk_eire_UTM50N <- st_transform(uk_eire, 32650)
# Plot the results
par(mfrow=c(1, 3), mar=c(3,3,1,1))
plot(st_geometry(uk_eire), asp=1, axes=TRUE, main='WGS 84')
plot(st_geometry(uk_eire_BNG), axes=TRUE, main='OSGB 1936 / BNG')
plot(st_geometry(uk_eire_UTM50N), axes=TRUE, main='UTM 50N')


# Set up some points separated by 1 degree latitude and longitude from St. Pauls
st_pauls <- st_sfc(st_pauls, crs=4326)
one_deg_west_pt <- st_sfc(st_pauls - c(1, 0), crs=4326) # near Goring
one_deg_north_pt <-  st_sfc(st_pauls + c(0, 1), crs=4326) # near Peterborough

# Calculate the distance between St Pauls and each point
st_distance(st_pauls, one_deg_west_pt)

st_distance(st_pauls, one_deg_north_pt)

st_distance(st_transform(st_pauls, 27700), st_transform(one_deg_west_pt, 27700))

# transform St Pauls to BNG and buffer using 25 km
london_bng <- st_buffer(st_transform(st_pauls, 27700), 25000)
# In one line, transform england to BNG and cut out London
england_not_london_bng <- st_difference(st_transform(st_sfc(england, crs=4326), 27700), london_bng)
# project the other features and combine everything together
others_bng <- st_transform(st_sfc(eire, northern_ireland, scotland, wales, crs=4326), 27700)
corrected <- c(others_bng, london_bng, england_not_london_bng)
# Plot that and marvel at the nice circular feature around London
par(mar=c(3,3,1,1))
plot(corrected, main='25km radius London', axes=TRUE)

# par(mar=c(1,1,1,1))
### raster光栅

## creating raster

uk_raster_WGS84 <- raster(xmn= -11, xmx= 2, ymn= 49.5, ymx = 59, resolution = 0.5, crs = "+init=epsg:4326")

#create a raster, with method for signiture, with max and min x,y coordinate, crs= reference system, res is resolution
hasValues(uk_raster_WGS84)
values(uk_raster_WGS84) <- seq(length(uk_raster_WGS84))


plot(uk_raster_WGS84)
plot(st_geometry(uk_eire), add = TRUE, border = 'black', lwd = 2, col = "#FFFFFF44")

## 4.2 changing raster resolution

m <- matrix(c(1, 1, 3, 3,
              1, 2, 4, 3,
              5, 5, 7, 8,
              6, 6, 7, 7), ncol=4, byrow=TRUE)
square <- raster(m)
# create a raster layer from the matrix
square_agg_mean <- aggregate(square, fact = 2, fun = mean)
#create  a new raster layer from the matrix, fact = 2 aggregate the values to a 2*2 block
#4*4 --> 2*2 首先将原来的数据分成4格， 各取平均数
values(square_agg_mean)

# Maximum values
square_agg_max <- aggregate(square, fact=2, fun=max)
values(square_agg_max)
## [1] 2 4 6 8
#同理各取最大值

# Modal values for categories
square_agg_modal <- aggregate(square, fact=2, fun=modal)
values(square_agg_modal)
#各取众数， 但当没有众数时如5566， 你可以定义用first or last, default is first?
## [1] 1 3 5 7

# Copy parents
square_disagg <- disaggregate(square, fact=2)
# Interpolate
square_disagg_interp <- disaggregate(square, fact=2, method='bilinear')

###4.2.3 resampling
###reprojecting a raster
## more diffcult than reproject vectors

uk_pts_WGS84 <- st_sfc(st_point(c(-11, 49.5)), st_point(c(2,59)),crs = 4326)
#确定左下lower left &右上top left 的坐标， 定义coordinate.
uk_pts_BNG <- st_sfc(st_point(c(-2e5, 0)), st_point(c(7e5, 1e6)), crs=27700)

uk_grid_WGS84 <- st_make_grid(uk_pts_WGS84, cellsize=0.5)
uk_grid_BNG <- st_make_grid(uk_pts_BNG, cellsize=1e5)
# create polygon grid based on the coordinate we just created,with the right grid size

uk_grid_BNG_as_WGS84 <- st_transform(uk_grid_BNG, 4326)
# reproject BNG to WGS84
plot(uk_grid_WGS84, asp=1, border='grey', xlim=c(-13,4))
plot(st_geometry(uk_eire), add=TRUE, border='darkgreen', lwd=2)
plot(uk_grid_BNG_as_WGS84, border='red', add=TRUE)
# plot the UK map on the WGS84 gird and put a layer of BNG as WGS84 grid on the top 
uk_raster_BNG <- raster(xmn=-200000, xmx=700000, ymn=0, ymx=1000000,
                        res=100000, crs='+init=epsg:27700')
# create the BNG raster grid
uk_raster_BNG_interp <- projectRaster(uk_raster_WGS84, uk_raster_BNG, method='bilinear')

# interpolating植入， project raster to raster

uk_raster_BNG_ngb <- projectRaster(uk_raster_WGS84, uk_raster_BNG, method='ngb')
# compare the values in the top row

round(values(uk_raster_BNG_interp)[1:9], 2)
## [1]    NA 31.36 30.02 29.87 30.91 33.14 36.56 41.17    NA

values(uk_raster_BNG_ngb)[1:9]
## [1] NA 29 33 36 39 43 46 50 NA
par(mfrow=c(1,3), mar=c(1,1,2,1))
plot(uk_raster_BNG_interp, main= "interpolated", axes= FALSE, legend = FALSE)
plot(uk_raster_BNG_ngb, main= "Nearest Neighbour", axes = FALSE, legend = FALSE)


#### 5. COnverting between vector and rasteer data type
### 5.1 vector to raster

uk_20km <- raster(xmn=-200000, xmx=650000, ymn=0, ymx=1000000, 
                  res=20000, crs='+init=epsg:27700')
#create a target raster,

uk_eire_poly_20km  <- rasterize(as(uk_eire_BNG, 'Spatial'), uk_20km, field='name')
#rasterlize the polygon

uk_eire_BNG_line <- st_cast(uk_eire_BNG, 'LINESTRING')
#rasterlize the line

st_agr(uk_eire_BNG) <- 'constant'
# tell the sf that sttribut are constant

uk_eire_BNG_line <- st_cast(uk_eire_BNG, "LINESTRING")
uk_eire_line_20km <- rasterize(as(uk_eire_BNG_line, 'Spatial'), uk_20km, fiels = "name")
# rerasterlize the lines


uk_eire_BNG_point <- st_cast(st_cast(uk_eire_BNG, 'MULTIPOINT'), 'POINT')
uk_eire_BNG_point $name <- as.numeric(uk_eire_BNG_point$name)
# the name as numeria, rather than factor(why? )
uk_eire_point_20km <- rasterize(as(uk_eire_BNG_point,'Spatial'), uk_20km, field= 'name')
#raterlize the point

par(mfrow=c(1,3), mar=c(1,1,1,1))
plot(uk_eire_poly_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)
#rasterlized polygon
plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')
#giva a boarder from initial geometry


plot(uk_eire_line_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)
#rasterlized lines
plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')
#giva a boarder from initial geometry

plot(uk_eire_point_20km, col=viridis(6, alpha=0.5), legend=FALSE, axes=FALSE)
# rasterlized points
plot(st_geometry(uk_eire_BNG), add=TRUE, border='grey')
  #giva a boarder from initial geometry
