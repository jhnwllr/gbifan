plot_ann = function(taxonkey,
                    ann_type=c("does not occur","does occur","suspicious"),
                    des_type=c("wkt","continent","countrycode")) {

  sf::sf_use_s2(FALSE)

  path="C:/Users/ftw712/Desktop/rule-based-ranges/example_maps/"
  print(list.files(paste0(path,"annotations/")))

  anns = annotation_reader(taxonkey) %>%
  dplyr::select(taxonKey,annotation, designation,designationType) %>%
  dplyr::filter(annotation %in% ann_type) %>%
  dplyr::filter(designationType %in% des_type) %>%
  unique()

  d = get_point_data(taxonkey)
  point_data = sf::st_as_sf(d, coords = c("decimalLongitude", "decimalLatitude"),crs = "+proj=longlat +datum=WGS84")

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

  worldmap = rnaturalearth::ne_countries(scale = 'medium', type = 'map_units',returnclass = 'sf')

  p = ggplot2::ggplot() +
    ggplot2::geom_sf(data = worldmap) +
    ggplot2::geom_sf(data = point_data,color="orange",size=0.1,alpha=0.3) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::labs(title="",subtitle="",caption=taxonkey) +
    ggplot2::scale_fill_manual(values = c(
    "does not occur"="#F9766E",
    "does occur"="#01BA38",
    "suspicious"="#619DFF"))

  if(has_contient(anns)) {
   p = p + ggplot2::geom_sf(data = continents,ggplot2::aes(fill=annotation),alpha=0.3)
  }
  if(has_countrycode(anns)) {
    p = p + ggplot2::geom_sf(data = countrycodes,ggplot2::aes(fill=annotation),alpha=0.3)
  }
  if(has_wkt(anns)) {
    p = p + ggplot2::geom_sf(data = wkt,ggplot2::aes(fill=annotation),alpha=0.3)
  }


  ggplot2::ggsave(paste0(path,"plots/",taxonkey,".jpeg"),height=6,width=9,dpi=600)
  ggplot2::ggsave(paste0(path,"plots/",taxonkey,".png"),height=6,width=9,dpi=600)
  ggplot2::ggsave(paste0(path,"plots/",taxonkey,".pdf"),height=6,width=9)
  ggplot2::ggsave(paste0(path,"plots/",taxonkey,".svg"),height=6,width=9)
  p

}

has_contient <- function(x) nrow(dplyr::filter(x,designationType == "continent")) > 0
has_countrycode  <- function(x) nrow(dplyr::filter(x,designationType == "countrycode")) > 0
has_wkt  <- function(x) nrow(dplyr::filter(x,designationType == "wkt")) > 0

