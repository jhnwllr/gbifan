get_point_data = function(taxonkey,path="C:/Users/ftw712/Desktop/rule-based-ranges/example_maps/") {

  files = list.files(paste0(path,"data/point_data/")) %>% gsub(".tsv","",.)

  if(!taxonkey %in% files) {
    dd = rgbif::occ_download(rgbif::pred("taxonKey",taxonkey),
                             rgbif::pred("hasCoordinate", TRUE),
                             format="SIMPLE_CSV")
    rgbif::occ_download_wait(dd)

    rgbif::occ_download_get(dd) %>%
      rgbif::occ_download_import() %>%
      readr::write_tsv(paste0(path,"data/point_data/",taxonkey,".tsv"))
  }

  readr::read_tsv(paste0(path,"data/point_data/",taxonkey,".tsv"),col_types = readr::cols())
}
