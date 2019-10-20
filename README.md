# The Buffer R package
The `buffer` package is meant to help abstract away common operations like retreiving data from tools like Redshift and ChartMogul. It helps us do data better and more efficiently.

## Getting Started
To download the `buffer` package, you'll need to install the [devtools](https://www.rstudio.com/products/rpackages/devtools/) package.

```
install.packages("devtools")
```

Then, use the `install_github()` function to install the `buffer` package.

```
devtools::install_github("jwinternheimer/buffer")
```

## Querying Redshift
To query Redshift, you'll first need to make sure that you have your environment variables set in your .Renviron. Your .Renviron file might look something like this.

```
REDSHIFT_DB_NAME=xxxxxxxxxxxxxxxxxxx
REDSHIFT_USER=xxxxxxxxxxxxxxxxxxx
REDSHIFT_ENDPOINT=xxxxxxxxxxxxxxxxxxx.us-east-1.redshift.amazonaws.com
REDSHIFT_PASSWORD=xxxxxxxxxxxxxxxxxxx
REDSHIFT_DB_PORT=xxxxxxxxxxxxxxxxxxx
REDSHIFT_COPY_S3_ROOT=xxxxxxxxxxxxxxxxxxx
LOOKER_API3_CLIENT_ID=xxxxxxxxxxxxxxxxxxx
LOOKER_API3_CLIENT_SECRET=xxxxxxxxxxxxxxxxxxx
```

Once these are set, you can create a connection with the `redshift_connect()` function. To query the `users` table, you can run these lines.

```
# establish redshift connection
con <- redshift_connect()

# define query
users_query <- "select * from dbt.users limit 10"

# query redshift
users <- query_db(query = users_query, connection = con)
```

And voila!

## Getting data from Looker
You'll need your Looker credentials to be in your .Renviron. Then, you just need the number of a saved look.

```
# get mrr data
mrr_data <- get_look(4478)
```

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
