#' Create a connection to Redshift
#'
#' \code{redshift_connect} returns a PostgreSQL connection.
#' @param BUFFER_REDSHIFT_USER Your Buffer redshift user.
#' @param BUFFER_REDSHIFT_PWD Your Buffer redshift password.
#' @return The PostgreSQL connection.
#' @keywords connect, buffer, redshift
#' @export
#' @examples
#' conn <- redshift_connect()
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.

redshift_connect <- function() {

  require(DBI)
  require(RPostgreSQL)

  if(Sys.getenv("REDSHIFT_USER") == "" | Sys.getenv("REDSHIFT_PASSWORD") == "") {
    user <- readline(prompt="Enter your Redshift user: ")
    pwd <- readline(prompt="Enter your Redshift password: ")
    Sys.setenv(REDSHIFT_USER = user)
    Sys.setenv(REDSHIFT_PASSWORD = pwd)
  }

  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv,
                   host=Sys.getenv("REDSHIFT_ENDPOINT"),
                   port=Sys.getenv("REDSHIFT_DB_PORT"),
                   dbname=Sys.getenv("REDSHIFT_DB_NAME"),
                   user=Sys.getenv("REDSHIFT_USER"),
                   password=Sys.getenv("REDSHIFT_PASSWORD"))

  con
}
