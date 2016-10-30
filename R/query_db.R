#' A function to query Redshift
#'
#' This function connects you to buffermetrics
#' @param BUFFER_REDSHIFT_USER Your Buffer redshift user.
#' @param BUFFER_REDSHIFT_PWD Your Buffer redshift password.
#' @keywords connect, buffer, redshift, query
#' @export
#' @examples
#' conn <- redshift_connect()
#' query <- "select count(*) from users"
#' plans <- query_db(query=query, connection = conn)

# Function to query database
query_db <- function(query, connection) {
  results <- dbGetQuery(connection, query)
  results
}

