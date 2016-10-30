#' Return lower case formatted column names
#'
#' \code{colnames(df) <- safe_names(colnames(df))} sets columns names to nice format.
#' @param names The column names that you wish to transform.
#' @return A list of nicely formatted names.
#' @keywords columns, format, safe
#' @export
#' @examples
#' colnames(df) <- safe_names(colnames(df))
#' @section Warning:
#' Do not operate heavy machinery within 8 hours of using this function.

safe_names = function(names) {
  names = gsub('[^a-z0-9]+','_',tolower(names))
  names = make.names(names, unique=TRUE, allow_=TRUE)
  names = gsub('.','_',names, fixed=TRUE)
  names
}
