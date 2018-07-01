#############
# LIBRARIES ####
#############

library(ggplot2)
library(reshape2)

#############
# FUNCTIONS ####
#############

### Aesthetics
theme_ita <- function (base_size = 15, base_family = "Times") {
  theme_grey(base_size = base_size, base_family = base_family) %+replace% 
    theme(axis.text = element_text(size = rel(0.8)), 
          axis.title.x = element_text(margin=margin(10,0,0,0)),
          axis.title.y = element_text(angle=90, margin=margin(0,10,0,0)),
          axis.ticks = element_line(colour = "black"), 
          axis.line = element_line(colour = NA, size = 0.5), 
          legend.key = element_rect(colour = "white"), 
          panel.background = element_rect(fill = "white", colour = NA), 
          panel.border = element_rect(fill = NA, colour = "gray", size = 1), 
          panel.spacing = unit(1.25, "lines"),
          panel.grid.major = element_line(colour = "gray88", size = 0.3, linetype = "dotted"), 
          panel.grid.minor = element_line(colour = "gray88", size = 0.3, linetype = "dotted"), 
          strip.background = element_blank(),
          strip.text = element_text(size = rel(1.2)),
          #strip.switch.pad.wrap = unit(c(1,1,1,1), "cm"), 
          plot.margin = unit(c(0.25,0,0.25,0), "cm"),
          plot.title = element_text(margin=margin(0,0,5,0))
    )
}

###############
# CREATE DATA ####
###############

d.eval <- data.frame(corpus=c(rep("CSJ",5), rep("KCSS",5)), 
                     model=rep(c(rep("mono", 4), "tri"), 2),
                     totgauss=rep(c(1, 3, 6, 15, 15), 2),
                     WER=c(c(47.24, 42.28, 40.14, 37.64, 29.94), c(81.39, 77.2, 75.59, 74.03, 65.48)),
                     PER=c(c(44.16, 40.92, 39.47, 38.07, 25.33), c(56.23, 53.05, 51.66, 50.70, 38.42)))
d.eval.melted <- melt(d.eval, id.vars = c("corpus", "model", "totgauss"))

########
# PLOT ####
########
pdf(file="figures/plot_hmm_evaluations.pdf", width = 6, height = 4)

ggplot(d.eval.melted, aes(x=totgauss, y=value, col=corpus, pch=model)) + 
  facet_wrap(~variable) +
  geom_point(size=2) + geom_line() +
  xlim(0,15) + ylim(0, 100) + 
  xlab("Number of Gaussians (x1000)") + ylab("Error rate (%)") +
  scale_color_manual(values=c("orange", "purple4")) +
  theme_ita() + theme(legend.position="bottom")

dev.off()