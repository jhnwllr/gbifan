# save db
# save rules and comments
save_db = function(path = "C:/Users/ftw712/Desktop/",filename="ann_db") {
  jsonlite::fromJSON("http://labs.gbif.org:7013/v1/occurrence/annotation/rule/") %>%
    mutate(comments =
    purrr::map(id,~
    jsonlite::fromJSON(paste0("http://labs.gbif.org:7013/v1/occurrence/annotation/rule/",.x,"/comment"))
    )) %>%
    saveRDS(paste0(path,filename,".rda"))
}

