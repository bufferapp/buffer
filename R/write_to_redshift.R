#' Replace a table in Redshift.
#'
#' \code{write_to_redshift(df, table_name, bucket_name, option, keys)} writes an R dataframe to Redshift.
#' @param df The R dataframe you want to write to Redshift
#' @param bucket_name The name of the s3 bucket.
#' @param table_name The name of the Redshift table.
#' @param option Determine whehter you want to replace or append table.
#' @param keys Keys to search for matching rows when upserting data.
#' @return Doesn't return anything. Writes data to Redshift
#' @keywords buffer, redshift, write.
#' @export
#' @examples
#' write_to_redshift(my_data, "redshift_table_name", "new_bucket_name", "replace")
#' write_to_redshift(my_data, "redshift_table_name", "new_bucket_name", "upsert", keys = c('id', 'date'))
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.

write_to_redshift <- function(df, table_name, bucket_name, option = "replace", keys = NULL) {

  library(DBI)
  library(RPostgres)
  library(aws.s3)
  library(redshiftTools)

  if(Sys.getenv("REDSHIFT_USER") == "" | Sys.getenv("REDSHIFT_PASSWORD") == "") {

    user <- readline(prompt="Enter your Redshift user: ")
    pwd <- readline(prompt="Enter your Redshift password: ")
    Sys.setenv(REDSHIFT_USER = user)
    Sys.setenv(REDSHIFT_PASSWORD = pwd)

  }

  if(Sys.getenv("AWS_ACCESS_KEY_ID") == "" | Sys.getenv("AWS_SECRET_ACCESS_KEY") == "") {

    key_id <- readline(prompt = "Enter your AWS access key: ")
    secret_key <- readline(prompt = "Enter your AWS secret access key: ")
    Sys.setenv(AWS_ACCESS_KEY_ID = key_id)
    Sys.setenv(AWS_SECRET_ACCESS_KEY = secret_keu)

  }

  con <- dbConnect(RPostgres::Postgres(),
                   host=Sys.getenv("REDSHIFT_ENDPOINT"),
                   port=Sys.getenv("REDSHIFT_DB_PORT"),
                   dbname=Sys.getenv("REDSHIFT_DB_NAME"),
                   user=Sys.getenv("REDSHIFT_USER"),
                   password=Sys.getenv("REDSHIFT_PASSWORD"))

  # check if bucket exists and create if not
  tryCatch(
    {
      bucket_exists(bucket_name)[1]
    },
    error = function(cond) {
      message(paste("Bucket", bucket_name, "does not exist."))
      message(paste("Creating bucket", bucket_name, "."))
      b <- put_bucket(bucket_name, region = "us-east-2")
      return(NA)
    },
    finally = {
      message("We did it.")
    }
  )

  # if we want to replace the table in Redshift
  if(option == "replace") {

    # replace Redshift table
    r <- rs_replace_table(df,
                          dbcon = con,
                          table_name = table_name,
                          bucket = bucket_name,
                          region = "us-east-2",
                          split_files = 1)

  } else if(option == "upsert") {

    # upsert
    c = rs_upsert_table(df,
                        dbcon = con,
                        table_name = table_name,
                        bucket = bucket_name,
                        region = "us-east-2",
                        split_files = 1,
                        keys = keys)
  }
}
