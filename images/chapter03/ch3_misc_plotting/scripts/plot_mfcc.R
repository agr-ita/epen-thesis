#############
# LIBRARIES ####
#############

library(rhdf5)
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


################################
# IMPORT MFCC + PITCH + DELTAS ####
################################

h5ls("../cutedog/features/feats.h5f")

f.mfcc <- h5read(file = "../cutedog/features/feats.h5f", "features/features")
View(f.mfcc)

### No CMVN
melted_mfcc <- melt(f.mfcc)
head(melted_mfcc)

### CMVN
f.mfcc.mean <- apply(X = f.mfcc, MARGIN = 1, FUN=mean)
f.mfcc.sd <- apply(X = f.mfcc, MARGIN = 1, FUN=sd)
f.mfcc.stand <- sweep(x = f.mfcc, MARGIN = 1, f.mfcc.mean) / f.mfcc.sd
melted_mfcc.stand <- melt(f.mfcc.stand)
head(melted_mfcc.stand)

############
# PLOTTING ####
############
p.mfcc <- ggplot(data = melted_mfcc, aes(x=Var2, y=-Var1, fill=value)) + 
  geom_tile() +
  scale_fill_gradient2(high="#8F0037", mid = "#717DD7", low="#FFD873", midpoint = 50) + #magenta colour for poster +
  xlab("Time") + ylab("Coefficient") +
  theme_ita()

p.mfcc.stand <- ggplot(data = melted_mfcc.stand, aes(x=Var2, y=-Var1, fill=value)) + 
  geom_tile() +
  scale_fill_gradient2(high="#8F0037", mid = "#717DD7", low="#FFD873", midpoint = 1) + #magenta colour for poster +
  xlab("Time") + ylab("Coefficient") +
  theme_ita()

##########
# OUTPUT ####
##########

pdf(file="figures/cutedog_mfcc.pdf", width = 10, height = 1)
p.mfcc
p.mfcc.stand
dev.off()
