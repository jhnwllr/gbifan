
delete_project = function(id) {

httr::DELETE(url =  paste0(gbif_base(),"occurrence/annotation/project/",id),
          config = httr::authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
          httr::add_headers("Content-Type: application/json"),
          encode = 'raw') %>%
  httr::content(as = "text")

}
