#' Return data from a Look
#'
#' \code{get_mrr_metrics(metric = "all", start_date = "2019-01-01", end_date = "2019-03-01")} returns a data frame with results.
#' @param metric The endpoint that specifies the type of metric, e.g. all, mrr, customer-count, ltv, customer-churn-rate, mrr-churn-rate
#' @param start_date The start date of the required period of data. An ISO-8601 formatted date, e.g. 2015-05-12.
#' @param end_date The end date of the required period of data. An ISO-8601 formatted date, e.g. 2015-05-12.
#' #' @param interval One of day, week, or month (default).
#' @return A dataframe containing data from ChartMogul.
#' @keywords chartmogul
#' @export
#' @examples
#' df <- get_mrr_metrics(metric = "all", start_date = "2019-01-01", end_date = "2019-03-01", interval = "day")


get_mrr_metrics <- function(metric = "all", start_date, end_date, interval) {

  require(httr)
  require(jsonlite)

  if(Sys.getenv("CHARTMOGUL_API_TOKEN") == "" | Sys.getenv("CHARTMOGUL_API_SECRET") == "") {

    token <- readline(prompt="Enter your ChartMogul API token: ")
    secret <- readline(prompt="Enter your ChartMogul API secret: ")
    Sys.setenv(CHARTMOGUL_API_TOKEN = token)
    Sys.setenv(CHARTMOGUL_API_SECRET = secret)

  } else {

  }

  token = Sys.getenv("CHARTMOGUL_API_TOKEN")
  secret = Sys.getenv("CHARTMOGUL_API_SECRET")

  base_url = paste0("https://api.chartmogul.com/v1/metrics/", metric)

  print(paste("Getting data from:", base_url))

  r <- GET(base_url,
           query = list(`start-date` = start_date, `end-date` = end_date, `interval` = interval),
           authenticate(token, secret))

  stop_for_status(r)

  res_txt <- content(r, type = "text", encoding = "UTF-8")
  results <- fromJSON(res_txt)
  results_df <- results$entries

  results_df
}

mrr <- get_mrr_metrics(metric = "mrr", start_date = "2019-01-01", end_date = "2019-06-01", interval = "day")
