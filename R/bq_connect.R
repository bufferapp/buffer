#' Create BigQuery Connection
#'
#' @keywords bigquery
#' @export
#' @examples
#' con <- bq_connect()

# write function to create table
bq_connect <- function() {

  # require libraries
  require(bigrquery)
  require(DBI)

  # connect to bigquery
  con <- dbConnect(
    bigrquery::bigquery(),
    project = "buffer-data"
  )

  # scientific notation so query works
  options(scipen = 20)

  # return connection
  con

}
