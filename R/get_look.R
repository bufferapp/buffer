#' Return data from a Look
#'
#' \code{get_look(look_id)} returns a PostgreSQL connection.
#' @param look_id The numeric id of a Look found in its URL.
#' @return A dataframe containing data from a Look.
#' @keywords looker
#' @examples
#' df <- get_look(3161)
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.


run_look <- function(look_id, format = 'csv', token) {

  require(httr)

  GET(modify_url("https://looker.buffer.com:19999",
                 path = paste('api', '3.0', 'looks', look_id, 'run','csv', sep = '/')) ,
      add_headers(Authorization = paste('token', token), Accept = 'text'))
}

looker_connect <- function() {

  client_id = Sys.getenv("LOOKER_API3_CLIENT_ID")
  secret = Sys.getenv("LOOKER_API3_CLIENT_SECRET")
  base_url = "https://looker.buffer.com:19999"

  POST(modify_url(base_url, path='login', query =list(client_id=client_id, client_secret=secret)))

}

get_look <- function(look_id) {

  looker <- looker_connect()
  token <- content(looker)$access_token

  look <- run_look(look_id, 'csv', token)
  con <- textConnection(content(look))
  df <- read.csv(con, header = T)

  df
}
