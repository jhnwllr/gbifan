# annotation writer

annotation_writer = function(x,path="C:/Users/ftw712/Desktop/rule-based-ranges/example_maps/") {

dir.create(paste0(path,"annotations/",x$taxonkey),showWarnings=FALSE)
uuid = uuid::UUIDgenerate()
file_name = paste0(path,"annotations/",x$taxonkey,"/",uuid)

out = list(
  id=uuid,
  user="jwaller",
  taxonKey=x$taxonkey,
  annotation=x$annotation,
  designation=x$designation,
  designationType=x$designationType
  )

json_out = jsonlite::toJSON(out,auto_unbox=TRUE,pretty=TRUE)
con=file(file_name)
writeLines(json_out, con)
close(con)
}



