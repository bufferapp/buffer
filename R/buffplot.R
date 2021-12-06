#' Create a buffer plot with default colorblind-friendly color palette
#'
#' @param ... Other arguments passed to \code{theme_minimal}
#'
#' @details This is a wrapper around ggplot2::ggplot() that adds default colors
#'
#' @examples
#' \dontrun{
#' buffplot(mtcars, aes(x = wt, y = mpg, color = gear)) +
#'     geom_point() +
#'     labs(title = "A Lovely Plot",
#'          subtitle = "What can the subtitle tell us?")
#'}
#'
#' @export
buffplot <- function(...) {

  # require ggthemes package
  require(ggthemes)

  # plotting function
  ggplot(...) +
    scale_colour_colorblind() +
    scale_fill_colorblind() +
    buffer_theme()

}
