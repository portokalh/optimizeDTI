
library(circlize)
library(chorddiag)
library(RColorBrewer)


# myfiles<-list.files(path="/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/csvsheets/conmats/")
# 
# newnames<-sub('csv', 'png', myfiles);
# newtitles<-sub('.csv','', newnames)
# newtitles2<-sub('conmat_','',newtitles)
#https://jokergoo.github.io/circlize_book/book/advanced-usage-of-chorddiagram.html
#https://jokergoo.github.io/circlize_book/book/the-chorddiagram-function.html

# df2 = data.frame(from = rep(rownames(mat), times = ncol(mat)),
#                 to = rep(colnames(mat), each = nrow(mat)),
#                 value = as.vector(mat),
#                 stringsAsFactors = FALSE)
# 
# 
# chordDiagram(df2)
#https://github.com/mattflor/chorddiag

#mycolors = c(brewer.pal(name="Spectral", n = 5),brewer.pal(name="Dark2", n = 4))
mycolors = c(brewer.pal(name="Set1", n = 5),brewer.pal(name="Set2", n = 4))

for (i in 1) {
  myinputfile<-paste("/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/csvsheets/conmats/", "connectome_connectivity.csv", sep = "",collapse = NULL)
  myoutputfile<-paste("/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/circos/outconmat/", "connectome_connectivity.png", sep = "",collapse = NULL)
  df=read.csv(myinputfile, header = TRUE, row.names = 1)
  mymat<-as.matrix(df)
png(myoutputfile,res=300, width = 5, height = 5, units = "in",bg = "white")
  
chordDiagram(mymat, annotationTrack = "grid", preAllocateTracks = 1, grid.col = mycolors)
#chordDiagram(mymat, annotationTrack = "grid", preAllocateTracks = 1, grid.col = mycolors,link.sort = FALSE, order = c(rownames(mymat)))
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(mean(xlim), ylim[1] + .5, sector.name, facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5), col = "black", cex=.5)
  circos.axis(h = "top", labels.cex = 0.5, major.tick.percentage = 0.2, sector.index = sector.name, track.index = 2)
}, bg.border = NA)
title('connectome connectivity - similarity')
dev.off()
}