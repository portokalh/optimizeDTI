
library(ggplot2)
myres<-c(43,86,172)

output.path<-'/Users/alex/AlexBadea_MyPapers/chrislong/alexfigs/'
output.path<-'/Users/alex/AlexBadea_MyPapers/ChrisLong/Figures/alex_fig2_temp/'


#######
extension<-'fibercounts'
myylim<- 0.8 # for gm dyad1 , 0.05 for wm in dyad1
myfibers=read.csv('/Users/alex/AlexBadea_MyPapers/ChrisLong/xlsheets/fiber_count_results/fibercounts_alex.csv')



#########


#myfibers<-myfibers[which(myfibers$hemi == 'left' & myfibers$fibers == 1),]
myfibers$directions <- as.factor(myfibers$directions)
myfibers$piefractions<-as.numeric(myfibers$piefractions)*100

#myfibers$fibers <- as.factor(myfibers$fibers)

#all graphs in one
ggplot(myfibers, aes(x=directions, y=piefractions, group=fibers, facet_grid(~resolution))) +
  geom_point(aes(shape=as.factor(resolution), size=as.factor(resolution), alpha = 1/4, color = myfibers$fibers))+
  ylim(0,myylim)+
  #stat_smooth(data=myfibers, method=lm, formula = y ~ poly(x,3), level=0.95,se = FALSE, aes(group=myfibers$ROI, color=myfibers$ROI))+
  stat_smooth(data=myfibers, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=myfibers$fibers, color=myfibers$fibers))+
  #geom_line(aes(linetype=ROI, color = ROI))+
  labs(title=paste("Resolution :", toString(myres),' um', sep=''))+
  theme_bw() +
   theme(axis.text.x = element_text(face="bold",  size=14, angle=0),
          axis.text.y = element_text(face="bold", size=14, angle=0),
         axis.line.x = element_line(colour = 'black', size=0.5),
         axis.line.y = element_line(colour = 'black', size=0.5),
        panel.grid.minor = element_blank(),
          panel.background = element_blank())
ggsave(paste(output.path,extension,toString(myres),'allinone1.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 10, height = 5, units = c("in"),dpi = 300)




ggplot(myfibers, aes(x=directions, y=piefractions, group=fibers, facet_grid(~resolution))) +
  geom_point(aes(shape=as.factor(resolution), size=as.factor(resolution), alpha = 1/4, color = myfibers$fibers))+
  ylim(0,myylim)+
  #stat_smooth(data=myfibers, method=lm, formula = y ~ poly(x,3), level=0.95,se = FALSE, aes(group=myfibers$ROI, color=myfibers$ROI))+
  stat_smooth(data=myfibers, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=as.factor(myfibers$resolution), color=as.factor(myfibers$fibers))) +
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
ggsave(paste(output.path,extension,toString(myres),toString(myylim),'allinone.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 10, height = 5, units = c("in"),dpi = 300)


#this is the one graph alex likes, the rest are maybes
ggplot(myfibers, aes(x=directions, y=piefractions,group=fibers),ylim(0,90)) +
  stat_smooth(data=myfibers, method = "gam", formula = y ~ s(x, k = 3), size = 1,level=0.95,se = FALSE, aes(group=as.factor(myfibers$fibers), color=as.factor(myfibers$fibers)))+
  scale_x_discrete(name="Directions",as.factor(myfibers$directions))+
  scale_y_continuous(name="Piefractions", breaks = seq(0, 90, by=10))+
  geom_point(aes(shape=as.factor(fibers), color = as.factor(fibers)))+
  #facet_wrap(~ as.factor(resolution), scales = "free") +
  facet_wrap(~ as.factor(resolution))+ 
  theme_bw()+
  theme(axis.text.x = element_text(face="bold",  size=14, angle=0),
        axis.text.y = element_text(face="bold", size=14, angle=0),
        axis.line.x = element_line(colour = 'black', size=0.5),
        axis.line.y = element_line(colour = 'black', size=0.5),
        #panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # panel.border = element_blank(),
        panel.background = element_blank())
  


ggsave(paste(output.path,extension,toString(myres),toString(myylim),'3panels.pdf',sep=''), plot = last_plot(), device = 'pdf',
       scale = 1, width = 12, height = 3, units = c("in"),dpi = 300)

  
    
