

make_project = function(name = "", description = "") {
  tmp = tempdir()

  jsonlite::toJSON(list(name = name, description = description),auto_unbox=TRUE) %>%
    writeLines(paste0(tmp,"/project.json"))

  httr::POST(url =  "http://labs.gbif.org:7013/v1/occurrence/annotation/project",
             config = httr::authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
             httr::add_headers("Content-Type: application/json"),
             body = httr::upload_file(paste0(tmp,"/project.json")),
             encode = 'raw') %>%
    httr::content(as = "text")

}
