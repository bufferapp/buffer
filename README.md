# The Buffer R package
The `buffer` package is an internal R package whose purpose is to abstract common operations like reading and writing data from Buffer's data warehouses. 

## Getting Started
To download the `buffer` package, you'll need to install the [devtools](https://www.rstudio.com/products/rpackages/devtools/) package.

```
install.packages("devtools")
```

Then, use the `install_github()` function to install the `buffer` package.

```
devtools::install_github("bufferapp/buffer")
```

## Querying BigQuery
To query Redshift, you'll first need to make sure that you have your environment variables set in your .Renviron. Your .Renviron file might look something like this.

```
CHARTMOGUL_API_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CHARTMOGUL_API_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
MIXPANEL_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
MIXPANEL_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
MIXPANEL_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

To set an environment variable, use the `Sys.setenv()` function.

```
Sys.setenv(MIXPANEL_KEY = "examplekeythatyoulluse"
```

Once these are set, you can connect to BigQuery with the `bq_connect()` function. It may prompt you to authenticate with your Google account.

```
# create connection
con <- bq_connect()
```

You'll then be able to run SQL queries from R, like so:

```
# define query
sql <- "select * from dbt_buffer.buffer_users limit 10"

# run query
users <- bq_query(con, sql)
```

Et voila!


## Getting data from ChartMogul
The `get_mrr_metrics` function grabs data from [ChartMogul's metrics API](https://dev.chartmogul.com/reference#introduction-metrics-api). You will need to add your ChartMogul API token and secret to your .Renviron file to use this function.

```
# add API credentials
Sys.setenv(CHARTMOGUL_API_TOKEN = token)
Sys.setenv(CHARTMOGUL_API_SECRET = secret)
```

There are several useful metrics we can collect from this API. We can retrieve [all key MRR metrics](https://dev.chartmogul.com/reference#retrieve-all-key-metrics) by setting `metric = "all"`. These include MRR, ARR, average revenue per account (ARPA), number of customers, LTV, the MRR churn rate, and the customer churn rate for each date. Here is an example.

```
# get key metrics
all <- get_mrr_metrics(metric = "all", start_date = "2019-01-01", end_date = "2019-06-01", interval = "day")
```

The MRR metrics include all of the MRR movements (new, reactivation, expansion, contraction, and churn).

```{r}
# get mrr metrics
mrr <- get_mrr_metrics(metric = "mrr", start_date = "2019-01-01", end_date = "2019-06-01", interval = "day")
```

## Get Customer MRR Events
The `get_customer_mrr_events` function returns a dataframe of activities for a given customer. It only returns the events of a single customer, and the ChartMogul UUID must be used.

```{r}
# get mrr events
activities <- get_customer_mrr_events("cus_b8eb4d54-687a-11e9-a881-17e8291a772a")
```

## Plotting with `buffplot()`
The `buffplot()` function is a wrapper around the `ggplot()` function that does a couple things. It sets the plot's theme to `buffer_theme` and makes the default color palette colorblind-friendly.

```
data(mtcars)

# plot
buffplot(mtcars, aes(x = wt, y = mpg, color = as.factor(gear))) + 
    geom_point() + 
    labs(x = "Weight", y = "MPG", color = "Gear")
```
![](https://i.imgur.com/zfGmB3Y.png)
