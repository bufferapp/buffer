#' Create a connection to Redshift
#'
#' \code{redshift_connect} returns a PostgreSQL connection.
#' @param BUFFER_REDSHIFT_USER Your Buffer redshift user.
#' @param BUFFER_REDSHIFT_PWD Your Buffer redshift password.
#' @return The PostgreSQL connection.
#' @keywords connect, buffer, redshift
#' @examples
#' conn <- redshift_connect()
#' \dontrun{redshift_connect()} won't really help, because you need to assign it.
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.

redshift_connect <- function() {

  require(DBI)
  require(RPostgreSQL)

  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host="buffer-metrics.cgbexruym8z7.us-east-1.redshift.amazonaws.com",
                   port="5439",
                   dbname="buffermetrics",
                   user=Sys.getenv("BUFFER_REDSHIFT_USER"),
                   password=Sys.getenv("BUFFER_REDSHIFT_PWD"))

  con
}
