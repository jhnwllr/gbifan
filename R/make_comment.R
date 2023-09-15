
make_comment = function(ruleId,comment) {

  tmp = tempdir()

    jsonlite::toJSON(list(comment=comment),auto_unbox=TRUE) %>%
    writeLines(paste0(tmp,"/comment.json"))

    httr::POST(url = paste0("http://labs.gbif.org:7013/v1/occurrence/annotation/rule/",ruleId,"/comment"),
    config = httr::authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
    httr::add_headers("Content-Type: application/json"),
    body = upload_file(paste0(tmp,"/comment.json")),
    encode = 'raw') %>%
    httr::content(as = "text")
  }
