plot_continent = function(d=NULL,continent) {

  sf::sf_use_s2(FALSE)
  focal_continent = readRDS("R/continents.rda")
  focal_continent$continent = tolower(focal_continent$continent)
  focal_continent = focal_continent[focal_continent$continent == continent,]

  worldmap = rnaturalearth::ne_countries(scale = 'medium', type = 'map_units',returnclass = 'sf')

  # buffer = 10
  # bbox = sf::st_bbox(c(
    # xmin = min(d$decimalLongitude) - buffer,
    # xmax = max(d$decimalLongitude) + buffer,
    # ymin = min(d$decimalLatitude) - buffer,
    # ymax = max(d$decimalLatitude) + buffer
  # ))

  # cropped_map = sf::st_crop(worldmap,bbox)

  point_data = sf::st_as_sf(d, coords = c("decimalLongitude", "decimalLatitude"),crs = "+proj=longlat +datum=WGS84")

  p = ggplot2::ggplot() +
    ggplot2::geom_sf(data = worldmap) +
    ggplot2::geom_sf(data = point_data) +
    ggplot2::geom_sf(data = focal_continent,fill="blue",alpha=0.3)


  p
}

