occ_search_parser = function(x) {
  taxonkey = stringr::str_match_all(x,"taxon_key=([0-9]*)")[[1]][,2]
  countrycodes = stringr::str_match_all(x,"country=([A-Z]{2})")[[1]][,2]
  geometries = stringr::str_match_all(x,"geometry=([^&]*)")[[1]][,2] %>% stringr::str_replace_all("%20", " ")
  continents = stringr::str_match_all(x,"continent=([^&]*)")[[1]][,2] %>% stringr::str_replace_all("_", " ") %>% tolower()
  return(list(taxonkey=taxonkey,countrycodes=countrycodes,geometries=geometries,continents=continents))
}






