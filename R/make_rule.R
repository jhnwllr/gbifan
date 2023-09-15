# make rule
make_rule = function(projectId,taxonKey,geometry,annotation) {

  tmp = tempdir()

  jsonlite::toJSON(list(
    taxonKey=taxonKey,
    geometry=geometry,
    projectId=projectId,
    annotation=annotation),
    auto_unbox=TRUE) %>%
    writeLines(paste0(tmp,"/rule.json"))

  ruleId =
    httr::POST(url = "http://labs.gbif.org:7013/v1/occurrence/annotation/rule",
    config = httr::authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
    add_headers("Content-Type: application/json"),
    body = httr::upload_file(paste0(tmp,"/rule.json")),
    encode = 'raw') %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>%
    pluck("id")

return(ruleId)
}

