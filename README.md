# The unofficial Buffer R package
The `buffer` package is meant to help abstract away common operations like reading and writing data to Redshift. It helps us do data better and more efficiently.

## Getting Started
To download the `buffer` package, you'll need to install the [devtools](https://www.rstudio.com/products/rpackages/devtools/) package.

```
install.packages("devtools")
```

Then, use the `install_github()` function to install the `buffer` package.

```
install_github("jwinternheimer/buffer")
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

## Writing to Redshift
Description coming soon...
