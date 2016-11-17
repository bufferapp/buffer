#' Forecast time series data
#'
#' \code{get_forecast(df, days, seasonality)} returns a dataframe with the forecast means and bounds.
#' @param df A time series data frame with a date and value column.
#' @param days The number of days you want to forecast out to.
#' @param seasonality The seasonality frequency (eg 7 for weekly seasonality).
#' @return A new dataframe containing the forecasts.
#' @keywords forecast, time series
#' @export
#' @examples
#' forecasts <- get_forecast(df, days = 30, seasonality = 7)

get_forecast <- function(df, days, seasonality) {

  require(forecast)

  if (ncol(df) != 2) {
    print("Please make sure your dataframe only has two columns, a date and value.")
  } else if (class(df[,1]) != "Date") {
    print("Make sure that the first column in your data frame is of class 'Date'.")
  } else if (class(df[,2]) != "numeric" & class(df[,2]) != "integer") {
    print("Make sure your value column is of type numeric.")
  } else {
    colnames(df) <- c('date', 'value')

    # Remove rows with NAs
    df <- df[complete.cases(df),]

    # Remove rows with random values
    df <- df %>% filter(value > 10) %>% arrange(date)

    # Create time series object
    ts <- ts(df$value,frequency = seasonality)
    etsfit <- ets(ts)

    # Create forecast object
    fcast <- forecast(etsfit, h = days, frequency = seasonality)

    # Get data frame from forecast object
    fcast_df <- as.data.frame(fcast)

    row.names(fcast_df) <- NULL
    names(fcast_df) <- c('forecast','lo_80','hi_80','lo_95','hi_95')

    fcast_df$date <- min(df$date) + as.numeric(time(fcast$mean) * seasonality) - seasonality
    fcast_df$forecast_date <- max(df$date)

    # For data frames that go into the future
    if (max(df$date) > Sys.Date()) {
      future_df <- df %>% filter(date > Sys.Date())
      colnames(future_df) <- c('date','forecast')

      fcast_df <- bind_rows(filter(fcast_df, !(date %in% future_df$date)), future_df)
    }

    fcast_df
  }
}
