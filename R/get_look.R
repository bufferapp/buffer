#' Return data from a Look
#'
#' \code{get_look(look_id)} returns a PostgreSQL connection.
#' @param look_id The numeric id of a Look found in its URL.
#' @return A dataframe containing data from a Look.
#' @keywords looker
#' @export
#' @examples
#' df <- get_look(3161)


get_look <- function(look_id) {

  require(httr)

  if(Sys.getenv("LOOKER_API3_CLIENT_ID") == "" | Sys.getenv("LOOKER_API3_CLIENT_SECRET") == "") {
    client_id <- readline(prompt="Enter your Looker client id: ")
    client_secret <- readline(prompt="Enter your Looker client secret: ")
    Sys.setenv(LOOKER_API3_CLIENT_ID = client_id)
    Sys.setenv(LOOKER_API3_CLIENT_SECRET = client_secret)
  } else {
    print("Your Looker credentials are set in your .Renviron file. You're all good.")
  }

  client_id = Sys.getenv("LOOKER_API3_CLIENT_ID")
  secret = Sys.getenv("LOOKER_API3_CLIENT_SECRET")
  base_url = "https://looker.buffer.com:19999"

  looker <- POST(modify_url(base_url, path='login', query =list(client_id=client_id, client_secret=secret)))
  token <- content(looker)$access_token

  look <- GET(modify_url("https://looker.buffer.com:19999",
                         path = paste('api', '3.0', 'looks', look_id, 'run','csv', sep = '/')) ,
              add_headers(Authorization = paste('token', token), Accept = 'text'))


  con <- textConnection(content(look))
  df <- read.csv(con, header = T)

  df
}
