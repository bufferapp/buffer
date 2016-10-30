#' Write a data frame into Redshift
#'
#' \code{insert_batch(con, table_name, df)} writes the data frame into Redshift.
#' @param con Redshift connection.
#' @param table_name Name of Reshift table you want to write to.
#' @param df Data frame to write.
#' @return A new or updated RS table.
#' @keywords write, buffer, redshift
#' @export
#' @examples
#' con <- redshift_connect()
#' insert_batch(con, "mrr_forecast", forecast_df);
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.

## Define helper functions
create_empty_table <- function(con, tn, df) {

  sql <- paste0("create table \"",tn,"\" (",paste0(collapse=',','"',names(df),'" ',sapply(df[0,],postgresqlDataType)),");")

  dbSendQuery(con,sql)
  invisible()

}

insert_batch <- function(con, table_name, df,size=100L) {

  if (nrow(df)==0L) return(invisible());

  cnt <- (nrow(df)-1L)%/%size+1L;

  for (i in seq(0L,len=cnt)) {
    sql <- paste0("insert into \"",table_name,"\" values (",do.call(paste,c(sep=',',collapse='),(',lapply(df[seq(i*size+1L,min(nrow(df),(i+1L)*size)),],shQuote))),");");
    dbSendQuery(con,sql);
  };

  invisible();
}
