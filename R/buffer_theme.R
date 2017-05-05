#' A function to apply a Buffer theme to a ggplot2 plot.
#'
#' This applies the Buffer theme to your plot.
#' @keywords ggplot, plot, theme
#' @export
#' @examples
#' ggplot(mtcars, aes(x = weight)) + geom_histogram() + buffer_theme()

buffer_theme <- function() {
  
  require(ggplot2)
  require(RColorBrewer)
  
  buffer_palette <- c("#3c5a72", "#547c9f", "#6295c0", "#72b0e3")
  
  # Generate the colors for the chart procedurally with RColorBrewer
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[6]
  color.axis.title = palette[7]
  color.title = palette[9]
  
  # Begin construction of chart
  theme_bw(base_size=9) +
    
  # Set the entire chart region to a light gray color
  theme(panel.background=element_rect(fill=NA, color=NA)) +
  theme(plot.background=element_rect(fill=NA, color=NA)) +
  theme(panel.border=element_rect(color=NA)) +
    
  # Format the grid
  theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
  theme(panel.grid.minor=element_blank()) +
  theme(axis.ticks=element_blank()) +
  theme(panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank()) +
  # theme(panel.border = element_blank(), axis.line = element_line(color=color.grid.major)) +
    
  # Format the legend, but hide by default
  theme(legend.background = element_rect(fill=NA)) +
  theme(legend.text = element_text(size=15,color=color.axis.title)) +
    
  # Set title and axis labels, and format these and tick marks
  theme(plot.title=element_text(color=color.title, size=20, vjust=1.25)) +
  theme(axis.text.x=element_text(size=10,color=color.axis.text)) +
  theme(axis.text.y=element_text(size=10,color=color.axis.text)) +
  theme(axis.title.x=element_text(size=15,color=color.axis.title, vjust=0)) +
  theme(axis.title.y=element_text(size=15,color=color.axis.title, vjust=1.25)) +
    
  # Plot margins
  #theme(plot.margin = unit(c(0.35, 0.2, 0.3, 0.35), "cm")) +
  theme(text = element_text(size=25))
}