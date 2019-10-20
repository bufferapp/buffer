#' Return customer activities from ChartMogul
#'
#' \code{get_customer_mrr_events(uuid = "cus_123")} returns a data frame with custoemr activites
#' @param uuid The ChartMogul UUID of the customer.
#' @return A dataframe containing data from ChartMogul.
#' @keywords chartmogul
#' @export
#' @examples
#' activites <- get_customer_mrr_events("cus_123")


get_customer_mrr_events <- function(uuid) {

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

  base_url = paste0("https://api.chartmogul.com/v1/customers/", uuid, "/activities")

  print(paste("Getting data from:", base_url))

  r <- GET(base_url, authenticate(token, secret))

  stop_for_status(r)

  res_txt <- content(r, type = "text", encoding = "UTF-8")
  results <- fromJSON(res_txt)
  results_df <- results$entries

  results_df
}

