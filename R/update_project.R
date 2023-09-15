

update_project = function(id,name=NULL,description=NULL,members=NULL,deleted=NULL,createdBy=NULL) {
  tmp = tempdir()
  project = httr::GET(paste0(gbif_base(),"occurrence/annotation/project/",id)) %>%
    httr::content()

  if(!is.null(name)) project$name = name
  if(!is.null(description)) project$description = description
  if(!is.null(description)) project$description = description
  if(!is.null(members)) project$members = as.list(members)
  if(!is.null(deleted)) project$deleted = deleted
  if(!is.null(createdBy)) project$createdBy = createdBy
  project$modified = ""
  project$modifiedBy = ""
  project$deleted = ""
  project$deletedBy = ""

  jsonlite::toJSON(project,auto_unbox=TRUE) %>%
  writeLines(paste0(tmp,"/project.json"))

  httr::PUT(url =  paste0(gbif_base(),"occurrence/annotation/project/",id),
             config = httr::authenticate(Sys.getenv("GBIF_USER"), Sys.getenv("GBIF_PWD")),
             httr::add_headers("Content-Type: application/json"),
             body = httr::upload_file(paste0(tmp,"/project.json")),
             encode = 'raw') %>%
    httr::content(as = "text")
}
