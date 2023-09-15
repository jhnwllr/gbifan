# run.R
# x = "https://www.gbif.org/occurrence/map?country=US&country=CR&taxon_key=9588263&geometry=POLYGON((-70.28315%20-19.15547,-55.73653%20-14.5618,-40.16907%20-4.35364,-44.76274%204.32331,-51.90844%2010.7034,-71.04875%2016.8283,-82.53291%208.66176,-80.74649%203.04729,-82.0225%20-9.20251,-79.98089%20-14.05137,-70.28315%20-19.15547))&geometry=POLYGON((-85.34017%2018.35951,-92.23067%2015.55228,-89.16821%2011.72421,-82.27773%2012.23461,-85.34017%2018.35951))&continent=AFRICA&continent=NORTH_AMERICA"

ann = function(x,
               dir="C:/Users/ftw712/Desktop/rule-based-ranges/example_maps/"
              ) {
  # dir_org = getwd()
  # setwd(dir)
  p = occ_search_parser(x)

  taxonkey = p$taxonkey

  d = get_point_data(taxonkey,path=dir)

  if(!is.null(p$geometries)) {
    gg = p$geometries %>%
      purrr::map(~
      annotate_geometry(d,taxonkey,.x) %>%
      annotation_writer()
      )
  }
  if(!is.null(p$countrycodes)) {
    ee = p$countrycodes %>%
      purrr::map(~
      annotate_country(d,taxonkey,.x) %>%
      annotation_writer()
      )
  }
  if(!is.null(p$countrycodes)) {
    cc = p$continents %>%
      purrr::map(~
      annotate_continent(d,taxonkey,.x) %>%
      annotation_writer()
      )
  }
  plot_ann(taxonkey)

}




