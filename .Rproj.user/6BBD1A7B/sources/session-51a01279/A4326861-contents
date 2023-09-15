

add_user = function(id,user=NULL) {

  project = httr::GET(paste0(gbif_base(),"occurrence/annotation/project/",id)) %>%
    httr::content()

  members = c(unlist(project$members),user)

  update_project(id,members=members)

}
