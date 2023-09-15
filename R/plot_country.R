plot_country = function(d,countrycode) {

  sf::sf_use_s2(FALSE)

  focal_country = readRDS("R/eez_countries.rda")
  focal_country = focal_country[focal_country$iso2 == countrycode,]

  worldmap = rnaturalearth::ne_countries(scale = 'medium', type = 'map_units',returnclass = 'sf')

  buffer = 10
  bbox = sf::st_bbox(c(
    xmin = min(d$decimalLongitude) - buffer,
    xmax = max(d$decimalLongitude) + buffer,
    ymin = min(d$decimalLatitude) - buffer,
    ymax = max(d$decimalLatitude) + buffer
  ))

  cropped_map = sf::st_crop(worldmap,bbox)

  point_data = sf::st_as_sf(d, coords = c("decimalLongitude", "decimalLatitude"),crs = "+proj=longlat +datum=WGS84")

  p = ggplot2::ggplot() +
    ggplot2::geom_sf(data = cropped_map) +
    ggplot2::geom_sf(data = point_data) +
    ggplot2::geom_sf(data = focal_country,fill="red",alpha=0.3)

  p
}

