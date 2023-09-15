plot_ann_leaflet <- function(taxonkey) {

  anns = annotation_reader(taxonkey) %>%
    dplyr::select(taxonKey,annotation, designation,designationType) %>%
    mutate(fill_color = case_when(
      annotation == "does not occur" ~ "#F9766E",
      annotation == "does occur" ~ "#01BA38",
      annotation == "suspicious" ~ "#619DFF"
    )) %>%
    unique()

  if(has_countrycode(anns)) {
    countrycodes = anns %>%
      dplyr::filter(designationType == "countrycode") %>%
      mutate(iso2 = designation) %>%
      merge(readRDS("R/eez_countries.rda"),by="iso2") %>%
      sf::st_as_sf()
  }

  if(has_contient(anns)) {
    continents = anns %>%
      dplyr::filter(designationType == "continent") %>%
      mutate(continent = designation) %>%
      merge(readRDS("R/continents.rda"),by="continent") %>%
      sf::st_as_sf()
  }

  if(has_wkt(anns)) {
    wkt = anns %>%
      dplyr::filter(designationType == "wkt") %>%
      sf::st_as_sf(wkt="designation",crs = "+proj=longlat +datum=WGS84")
  }


  # GBIF tiles
  base_url = "https://api.gbif.org/v2/map/occurrence/density/{z}/{x}/{y}@2x.png?"
  tile_taxon_key = paste0("taxonKey=",taxonkey,"&","bin=square&squareSize=128&style=classic.poly")
  gbif_tiles = paste0(base_url,tile_taxon_key)
  print(gbif_tiles)
  m <- leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addTiles(gbif_tiles) %>%
    leaflet::addPolygons(data=wkt,fillColor = ~fill_color,fillOpacity = 0.4,stroke=FALSE) %>%
    leaflet::addPolygons(data=continents,fillColor = ~fill_color,fillOpacity = 0.4,stroke=FALSE) %>%
    leaflet::addPolygons(data=countrycodes,fillColor = ~fill_color,fillOpacity = 0.4,stroke=FALSE)

  # %>%
    # leaflet::addPolygons(data=readRDS("R/eez_countries.rda"))
  m
}

# bin=square&squareSize=128&style=purpleYellow-noborder.poly

