library(ggplot2)
library(plotly)
library(scales)

charts_data <- read.csv("titanic.csv")
mean_survivability <- mean(charts_data$Survived)


get_survivability_chart <- function(survivability){
  surv_data <- data.frame(label=c("Your predicted survivability", "Mean survivability"), value = c(survivability, mean_survivability))
  surv_plot <- ggplot(surv_data, aes(label, value)) + 
    geom_col(aes(fill = label)) + 
    coord_cartesian(ylim=c(0,1)) + 
    scale_y_continuous(name="Survivability rate", labels = percent) +
    theme(legend.position="none", axis.title.x=element_blank())
  
  ggplotly(surv_plot)
}