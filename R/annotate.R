annotate_geometry = function(d,taxonkey,geometry) {
  print(plot_wkt(geometry,d))
  annotation = read_input()


  return(list(
    taxonkey=taxonkey,
    designation=geometry,
    designationType="wkt",
    annotation=annotation
    ))
}


annotate_country = function(d,taxonkey,countrycode) {
  print(plot_country(d,countrycode))
  annotation = read_input()

  return(list(
    taxonkey=taxonkey,
    designation=countrycode,
    designationType="countrycode",
    annotation=annotation
  ))
}

annotate_continent = function(d,taxonkey,continent) {
  print(plot_continent(d,continent))
  annotation = read_input()

  return(list(
    taxonkey=taxonkey,
    designation=continent,
    designationType="continent",
    annotation=annotation
  ))
}

