library(tidyverse)

df <- read.table("knee-range-of-motion.tsv", sep = "\t", header = TRUE)

curr_date <- format(Sys.time(), "%d-%b-%Y")

plot <- ggplot(df, aes(x = Days.after.surgery, y = Degrees.bent)) + geom_point(color = "blue") +
    labs(y = "Degrees bent", x = "Days after surgery", title = "Knee range-of-motion recovery!",
         subtitle = paste0("(", curr_date, ")")) +
    ylim(45,140) +
    scale_x_continuous(breaks=seq(0,90,7), limits = c(0,86), minor_breaks = NULL) +
    geom_hline(yintercept = 130, linetype = "dashed", color = "darkblue") +
    geom_text(x = 6.6, y = 135, label = "GOAL", color = "darkblue") +
    geom_vline(xintercept = 84, linetype = "dashed", color = "red") +
    geom_text(x = 73.3, y = 57.5, label = "Ideal deadline", color = "red") +
    geom_text(x = 73.3, y = 52.5, label = "(12 weeks)", color = "red", size = 3) +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

pdf(paste0(curr_date, "-knee-ROM-progress.pdf"), width = 5, height = 4)
plot
dev.off()
