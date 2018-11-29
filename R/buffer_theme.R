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
  theme_minimal(base_family = "Roboto Condensed") +
    theme(plot.title = element_text(size = rel(1.5), face = "bold"),
          plot.subtitle = element_text(size = rel(1.1)),
          plot.caption = element_text(color = "#777777", vjust = 0),
          axis.title = element_text(size = rel(.9), hjust = 0.95, face = "italic"),
          panel.grid.major = element_line(size = rel(.1), color = "#000000"),
          panel.grid.minor = element_line(size = rel(.05), color = "#000000"),
          plot.background = element_rect(fill = '#F5F5F5', color = '#F5F5F5'),
          panel.background = element_rect(fill = '#F5F5F5', color = '#F5F5F5'))
}
