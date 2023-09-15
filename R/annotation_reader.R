annotation_reader <- function(taxonkey,path="C:/Users/ftw712/Desktop/rule-based-ranges/example_maps/") {

list.files(paste0(path,"annotations/",taxonkey,"/"),full.names=TRUE) %>%
purrr::map(~jsonlite::read_json(.x) %>% as_tibble()) %>%
dplyr::bind_rows()

}
