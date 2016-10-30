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

check_redshift_credentials <- function() {

  if(Sys.getenv("BUFFER_REDSHIFT_USER") == "" | Sys.getenv("BUFFER_REDSHIFT_PWD") == "") {
    user <- readline(prompt="Enter your Redshift user: ")
    pwd <- readline(prompt="Enter your Redshift password: ")
    Sys.setenv(BUFFER_REDSHIFT_USER = user)
    Sys.setenv(BUFFER_REDSHIFT_PWD = pwd)
  } else {
    print("Your Redshift credentials are set in your .Renviron file. You're all good.")
  }
}

redshift_connect <- function() {

  require(DBI)
  require(RPostgreSQL)

  check_redshift_credentials()

  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host="buffer-metrics.cgbexruym8z7.us-east-1.redshift.amazonaws.com",
                   port="5439",
                   dbname="buffermetrics",
                   user=Sys.getenv("BUFFER_REDSHIFT_USER"),
                   password=Sys.getenv("BUFFER_REDSHIFT_PWD"))

  con
}
