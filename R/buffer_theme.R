#' Minimal ggplot2 theme using the Roboto Condensed font
#'
#' @param base_size base font size
#' @param strip_text_size,strip_text_margin plot strip text size and margin
#' @param subtitle_size,subtitle_margin plot subtitle size and margin
#' @param plot_title_size,plot_title_margin plot title size and margin
#' @param ... Other arguments passed to \code{theme_minimal}
#'
#' @details The Roboto Condensed and Roboto Bold fonts are both Google fonts;
#' they can be found at \url{https://fonts.google.com/specimen/Roboto+Condensed}
#' and \url{https://fonts.google.com/specimen/Roboto}. These fonts must be
#' installed locally on your computer for this theme to work.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#'
#' ggplot(mtcars, aes(wt, mpg)) +
#'     geom_point() +
#'     labs(title = "A Lovely Plot",
#'          subtitle = "What can the subtitle tell us?") +
#'     buffer_theme()
#'}
#'
#' @export
buffer_theme <- function() {

  # create theme
  theme_wsj(base_family = "Roboto Condensed", base_size = 8, color = "gray") +
    theme(axis.title = element_text(size = rel(.9)),
          plot.title = element_text(vjust = 3.5),
          plot.subtitle = element_text(vjust = 3.5))
}
