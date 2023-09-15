# restore the parts of the db you created

restore_db = function(path = "C:/Users/ftw712/Desktop/", filename = "ann_db") {

  d = readRDS(paste0(path,filename,".rda")) %>%
    glimpse()

  tmp = tempdir()

d %>%
  purrr::transpose() %>%
  map(~ {
  jsonlite::toJSON(list(
  taxonKey=.x$taxonKey,
  geometry=.x$geometry,
  projectId=.x$projectId,
  annotation=.x$annotation),
  auto_unbox=TRUE) %>%
  writeLines(paste0(tmp,"/rule.json"))

  rule_id =
  POST(url = "http://labs.gbif.org:7013/v1/occurrence/annotation/rule",
  config = authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
  add_headers("Content-Type: application/json"),
  body = upload_file(paste0(tmp,"/rule.json")),
  encode = 'raw') %>%
  content(as = "text") %>%
  jsonlite::fromJSON() %>%
  pluck("id")

  .x$comment %>%
  purrr::transpose() %>%
  map(~ {
  jsonlite::toJSON(list(comment=.x$comment),auto_unbox=TRUE) %>%
  writeLines(paste0(tmp,"/comment.json"))

  POST(url = paste0("http://labs.gbif.org:7013/v1/occurrence/annotation/rule/",rule_id,"/comment"),
  config = authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
  add_headers("Content-Type: application/json"),
  body = upload_file(paste0(tmp,"/comment.json")),
  encode = 'raw') %>%
  content(as = "text")
})

})

}



