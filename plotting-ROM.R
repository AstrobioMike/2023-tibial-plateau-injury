library(tidyverse)
library(lubridate)

df <- read.table("knee-range-of-motion.tsv", sep = "\t", header = TRUE)

latest_date <- format(Sys.time(), "%d-%b-%Y")
date_vec <- df[1] %>% pull(Date)
latest_date <- date_vec[length(date_vec)]
latest_date <- format(dmy(latest_date), "%d-%b-%Y")

## plotting with days on X axis
max_day_for_plot <- ceiling(df[2] %>% max() / 7) * 7

### stopped making days plot after it became too crowded ###
# with ideal deadline vertical line
# plot_days <- ggplot(df, aes(x = Days.after.surgery, y = Degrees.bent)) + geom_point(color = "blue") +
#     labs(y = "Degrees bent", x = "Days after surgery", title = "Knee range-of-motion recovery!",
#          subtitle = paste0("(as of ", latest_date, ")")) +
#     ylim(45,150) +
#     scale_x_continuous(breaks=seq(0,max_day_for_plot,7), limits = c(0,max_day_for_plot), minor_breaks = NULL) +
#     geom_hline(yintercept = 130, linetype = "dashed", color = "darkblue") +
#     geom_text(x = 14, y = 125, label = "Nominal Goal", color = "darkblue") +
#     geom_hline(yintercept = 140, linetype = "dashed", color = "darkgreen") +
#     geom_text(x = 11, y = 145, label = "Better Goal", color = "darkgreen") +
#     geom_vline(xintercept = 84, linetype = "dashed", color = "red") +
#     geom_text(x = 63, y = 57.5, label = "Ideal deadline", color = "red") +
#     geom_text(x = 63, y = 52.5, label = "(12 weeks)", color = "red", size = 3) +
#     theme_bw() +
#     theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) +
#     theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

# plot_days <- ggplot(df, aes(x = Days.after.surgery, y = Degrees.bent)) + 
#     labs(y = "Degrees bent", x = "Days after surgery", title = "Knee range-of-motion recovery!",
#          subtitle = paste0("(as of ", latest_date, ")")) +
#     scale_y_continuous(breaks=seq(50, 150, 10), limits = c(45, 150), minor_breaks = NULL) +
#     scale_x_continuous(breaks=seq(0,max_day_for_plot,7), limits = c(0,max_day_for_plot), minor_breaks = NULL) +
#     geom_hline(yintercept = 130, linetype = "dashed", color = "darkgreen") +
#     geom_hline(yintercept = 120, linetype = "dashed", color = "darkgreen") +
#     geom_text(x = 14, y = 125, label = "Nominal Goal", color = "darkgreen") +
#     annotate("rect", xmin = -Inf, xmax = Inf, ymin = 120, ymax = 130, alpha = 0.15, fill = "darkgreen") +
#     annotate("rect", xmin = -Inf, xmax = Inf, ymin = 140, ymax = Inf, alpha = 0.07, fill = "darkblue") +
#     geom_hline(yintercept = 140, linetype = "dashed", color = "darkblue") +
#     geom_text(x = 11, y = 145, label = "Better Goal", color = "darkblue") +
#     geom_point(color = "blue") +
# #     geom_segment(aes(x = 31, y = 142, xend = 31, yend = 147), color = "darkblue", lineend = "round", linejoin = "mitre", size = 0.5, 
# #         arrow = arrow(length = unit(2, "mm"))) +
#     theme_bw() +
#     theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) +
#     theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))



## plotting with weeks on X axis
num_total_weeks <- ceiling(df[2] %>% max() / 7)

# with ideal deadline vertical line
# plot_weeks <- ggplot(df, aes(x = Days.after.surgery / 7, y = Degrees.bent)) + geom_point(color = "blue") +
#     labs(y = "Degrees bent", x = "Weeks after surgery", title = "Knee range-of-motion recovery!",
#          subtitle = paste0("(", latest_date, ")")) +
#     ylim(45,150) +
#     scale_x_continuous(breaks=seq(0, num_total_weeks, 1), limits = c(0, num_total_weeks), minor_breaks = NULL) +
#     geom_hline(yintercept = 130, linetype = "dashed", color = "darkblue") +
#     geom_text(x = 2, y = 135, label = "Nominal Goal", color = "darkblue") +
#     geom_hline(yintercept = 140, linetype = "dashed", color = "darkgreen") +
#     geom_text(x = 2, y = 145, label = "Better Goal", color = "darkgreen") +
#     geom_vline(xintercept = 12, linetype = "dashed", color = "red") +
#     geom_text(x = 9, y = 55, label = "Ideal deadline", color = "red") +
#     theme_bw() +
#     theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) +
#     theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

total_days_after_surgery_when_plot_made <- df[2] %>% max()
plot_weeks <- ggplot(df, aes(x = Days.after.surgery / 7, y = Degrees.bent)) + 
    labs(y = "Max degrees bent", x = "Weeks after surgery", title = "Knee range-of-motion recovery!",
        subtitle = paste0("(as of ", latest_date, "; ", total_days_after_surgery_when_plot_made, " days after surgery)")) +
    scale_y_continuous(breaks=seq(50, 160, 10), limits = c(45, 155), minor_breaks = NULL) +
    scale_x_continuous(breaks=seq(0, num_total_weeks, 4), limits = c(0, num_total_weeks), minor_breaks = NULL) +
    annotate("rect", xmin = -Inf, xmax = Inf, ymin = 120, ymax = 130, alpha = 0.10, fill = "darkgreen") +
    geom_hline(yintercept = 130, linetype = "dashed", color = "darkgreen") +
    geom_hline(yintercept = 120, linetype = "dashed", color = "darkgreen") +
    geom_text(x = 4, y = 125, label = "Nominal Goal", color = "darkgreen") +
    annotate("rect", xmin = -Inf, xmax = Inf, ymin = 140, ymax = Inf, alpha = 0.07, fill = "darkblue") +
    geom_hline(yintercept = 140, linetype = "dashed", color = "darkblue") +
    geom_text(x = 3, y = 151, label = "Better Goal", color = "darkblue") +
    geom_point(color = "blue") +
    geom_segment(aes(x = 8.5, y = 148, xend = 8.5, yend = 155), color = "darkblue", lineend = "round", linejoin = "mitre", linewidth = 0.5, 
        arrow = arrow(length = unit(2, "mm"))) +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5, size = 8)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))


# writing out pdfs
### stopped making days plot after it became too crowded ###
# pdf(paste0(latest_date, "-knee-ROM-progress-days.pdf"), width = 5, height = 4)
# plot_days
# dev.off()

pdf(paste0(latest_date, "-knee-ROM-progress-weeks.pdf"), width = 5, height = 4)
plot_weeks
dev.off()

# writing out latest as png for github readme
png(paste0("latest-knee-ROM-progress-weeks-plot.png"), units = "in", res = 144, width = 5, height = 4)
plot_weeks
dev.off()
