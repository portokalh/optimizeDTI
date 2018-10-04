
library(ggplot2)
myres<-c(43,86,172)

output.path<-'/Users/alex/AlexBadea_MyPapers/chrislong/alexfigs/'
output.path<-'/Users/alex/AlexBadea_MyPapers/ChrisLong/Figures/alex_fig2_temp/'


#######
extension<-'dyad2_wm'
myylim<- 0.05 # for gm dyad1 , 0.05 for wm in dyad1
mydyad1=read.csv('/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/dyad1dispersion.csv')

# extension<-'dyad1_wm'
# mydyad1=read.csv('/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/dyad2dispersion.csv')
# myylim<-0.6 # for gm dyad 2

#########


mydyad1<-mydyad1[which(mydyad1$hemi == 'left' & mydyad1$fibers == 1),]
mydyad1$directions <- as.factor(mydyad1$directions)


#all graphs in one
ggplot(mydyad1, aes(x=directions, y=dispersion, group=ROI, facet_grid(~resolution))) +
  geom_point(aes(shape=as.factor(resolution), size=as.factor(resolution), alpha = 1/4, color = ROI))+
  ylim(0,myylim)+
  #stat_smooth(data=mydyad1, method=lm, formula = y ~ poly(x,3), level=0.95,se = FALSE, aes(group=mydyad1$ROI, color=mydyad1$ROI))+
  stat_smooth(data=mydyad1, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=mydyad1$ROI, color=mydyad1$ROI))+
  #geom_line(aes(linetype=ROI, color = ROI))+
  labs(title=paste("Resolution :", toString(myres),' um', sep=''))+
  theme_bw() +
   theme(axis.text.x = element_text(face="bold",  size=14, angle=0),
          axis.text.y = element_text(face="bold", size=14, angle=0),
         axis.line.x = element_line(colour = 'black', size=0.5),
         axis.line.y = element_line(colour = 'black', size=0.5),
        # panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
       # panel.border = element_blank(),
        panel.background = element_blank())
ggsave(paste(output.path,extension,toString(myres),'allinone_wm.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 10, height = 5, units = c("in"),dpi = 300)




ggplot(mydyad1, aes(x=directions, y=dispersion, group=ROI, facet_grid(~resolution))) +
  geom_point(aes(shape=as.factor(resolution), size=as.factor(resolution), alpha = 1/4, color = ROI))+
  ylim(0,myylim)+
  #stat_smooth(data=mydyad1, method=lm, formula = y ~ poly(x,3), level=0.95,se = FALSE, aes(group=mydyad1$ROI, color=mydyad1$ROI))+
  stat_smooth(data=mydyad1, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=as.factor(mydyad1$resolution), color=as.factor(mydyad1$resolution))) +
  #geom_line(aes(linetype=ROI, color = ROI))+
  labs(title=paste("Resolution :", toString(myres),' um', sep=''))+
  theme_bw() +
  theme(axis.text.x = element_text(face="bold",  size=14, angle=0),
        axis.text.y = element_text(face="bold", size=14, angle=0),
        axis.line.x = element_line(colour = 'black', size=0.5),
        axis.line.y = element_line(colour = 'black', size=0.5),
        # panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # panel.border = element_blank(),
        panel.background = element_blank())
ggsave(paste(output.path,extension,toString(myres),'allinone.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 10, height = 5, units = c("in"),dpi = 300)





#ggplot() + stat_smooth(data=mydyad1, x=directions, y=dispersion, group=mydyad1$ROI, method=lm, formula = y ~ poly(x,2), level=0.95,se = TRUE, aes(group=mydyad1$ROI, color=mydyad1$ROI))
  

ggplot(mydyad1, aes(x=directions, y=dispersion,group=ROI)) +
  stat_smooth(data=mydyad1, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=as.factor(mydyad1$ROI), color=as.factor(mydyad1$ROI))) +
 # geom_line(aes(linetype='blank', color = ROI))+
  geom_point(aes(shape=ROI, color = ROI))+
  facet_wrap(~ resolution, scales = "free") +
  theme_bw()+
  ylim(0,myylim)
 
ggsave(paste(output.path,extension,toString(myres),'3panels.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 12, height = 3, units = c("in"),dpi = 300)

  
       #  scale_y_continuous(name="Dyad1 Dispersion", limits=c(0, 0.15), breaks=seq(0, 0.15, myylim))+
      #  scale_x_discrete(name="Directions",mydyad1$directions)
