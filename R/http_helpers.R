gbifan_post <- function(url,body) {
  httr2::request(url) |>
    httr2::req_method("POST") |>
    httr2::req_auth_basic(Sys.getenv("GBIF_USER", ""),
                          Sys.getenv("GBIF_PWD", "")) |>
    httr2::req_body_json(body) |>
    httr2::req_perform() |>
    httr2::resp_body_json() 
}


gbifan_delete <- function(url) {
 httr2::request(url) |>
  httr2::req_method("DELETE") |>
  httr2::req_auth_basic(Sys.getenv("GBIF_USER", ""),
                        Sys.getenv("GBIF_PWD", "")) |>
  httr2::req_perform() |>
  httr2::resp_body_json() 
}

gbifan_get <- function(url,query) {  

httr2::request(url) |>
  httr2::req_url_query(!!!query) |>
  httr2::req_perform() |>
  httr2::resp_body_json() |> 
  purrr::map(~
   .x |>             
   tibble::enframe() |> 
   tidyr::pivot_wider(names_from="name",values_from="value")
   ) |>
   dplyr::bind_rows()   
}

gbifan_put <- function(url,body) {
  httr2::request(url) |>
    httr2::req_method("PUT") |>
    httr2::req_auth_basic(Sys.getenv("GBIF_USER", ""),
                          Sys.getenv("GBIF_PWD", "")) |>
    httr2::req_body_json(body) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

# get with no post processing
gbifan_get_ <- function(url,query) {  
  
  httr2::request(url) |>
    httr2::req_url_query(!!!query) |>
    httr2::req_perform() |>
    httr2::resp_body_json() 
}

gbifan_get_id <- function(url) {  
  
  httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json() |>
    tibble::enframe() |>
    tidyr::pivot_wider(names_from="name",values_from = "value") 
}

gbifan_get_id_ <- function(url) {  
  
  httr2::request(url) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  
}



gbif_base = function() {
  # overide with environmental vairable for local development 
  if(Sys.getenv("GBIFAN_URL") == "") {
    
    url = "http://labs.gbif.org:7013/v1/occurrence/annotation/"
    # "http://localhost:8080/v1/"
  } else {
    url <- Sys.getenv("GBIFAN_URL")
  }
  url
}

gbifan_body <- function(...) list(...) |> purrr::compact() |> purrr::flatten()

gbifan_url <- function(x) paste0(gbif_base(),x)
