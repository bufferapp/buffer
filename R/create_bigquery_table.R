#' Create a new table in BigQuery if it does not exist.
#'
#' @param project_id The BigQuery project ID, e.g. 'buffer-data'
#' @param dataset_name The name of the dataset in which you wish to create the table, e.g. 'temp_google_sheets'
#' @param table_name The name of the table you wish to create in BigQuery.
#' @param df_to_upload A dataframe that is to be inserted into the new table in BigQuery.
#' @keywords bigquery
#' @export
#' @examples
#' create_bigquery_table(project_id = "buffer-data",
#'                       dataset_name = "temp_google_sheets",
#'                       table_name = "ig_profile_deprecation_list_c1_free",
#'                       df_to_upload = list_c1_free)


# write function to create table
create_bigquery_table <- function(project_id, dataset_name, table_name, df_to_upload) {

  # require libraries
  require(bigrquery)
  require(DBI)

  # create new bq table
  new_bq_table = bq_table(project = project_id,
                          dataset = dataset_name,
                          table = table_name)

  # create table in bigquery
  bq_table_create(x = new_bq_table, fields = as_bq_fields(df_to_upload))

  # upload data to table
  bq_table_upload(x = new_bq_table,
                  values = df_to_upload,
                  create_disposition = "CREATE_IF_NEEDED",
                  write_disposition = "WRITE_EMPTY")

}
