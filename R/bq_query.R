#' Run a SQL query in BigQuery
#'
#' @param con The BigQuery connection object
#' @param sql The SQL statement that is to be executed
#' @keywords bigquery
#' @export
#' @examples
#' bq_query(con, sql = "select * from users limit 1000")


# write function to query bigquery
bq_query <- function(con, sql) {

  # require libraries
  require(DBI)

  # check if connection exists
  if (missing(con)) {
    con <- bq_connect()
  }

  # run query
  dbGetQuery(con, sql)
}
