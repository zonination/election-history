# Some cool tutorials on heatmaps like this:
# http://stackoverflow.com/questions/13016022/ggplot2-heatmaps-using-different-gradients-for-categories
# http://stackoverflow.com/questions/10232525/geom-tile-heatmap-with-different-high-fill-colours-based-on-factor

# General tutorial on R:
# http://swirlstats.com/students.html

# Sources:
# This data comes from the following sources:
# * 1824 and After: http://www.presidency.ucsb.edu/showelection.php?year=1824
# * 1821 and Before: http://www.archives.gov/federal-register/electoral-college/votes/1789_1821.html
# * Regions of US: http://www.census.gov/econ/census/help/geography/regions_and_divisions.html

# Location, Libraries, and Data
# setwd("~/Dropbox/R/Election History")
elec <- read.csv("elec.csv", stringsAsFactors=F)
library(ggplot2)
library(gridExtra)

# Create NA blocks for new columns to avoid R screwing up the data
elec$Margin<-NA
elec$Region<-NA
elec$BEA<-NA
elec$Admission<-NA
elec$State.yr<-NA

# Create a loop to invididually assess rows
for(n in 1:nrow(elec)){
  # Find Margins of Victory (as a %)
  col<-sort(c(
    as.numeric(as.character(elec[n,c(4,7,10,13)][1,1])),
    as.numeric(as.character(elec[n,c(4,7,10,13)][1,2])),
    as.numeric(as.character(elec[n,c(4,7,10,13)][1,3])),
    as.numeric(as.character(elec[n,c(4,7,10,13)][1,4]))
    ),decreasing=T)
  elec$Margin[n]<- (col[1]-col[2])/sum(col)
  
  # For elections determined by State Council or Electoral College only,
  # Let's fade our margin by about 50%
  if(elec$Notes[n]!=""){elec$Margin[n]<-elec$Margin[n]*.5}
  
  # Sort states into regions. Note that yr.admitted the decimal point is used to determine the order admitted that year.
  #                  State             |           Region         |           BEADivision              |    Yr. Admitted
  # Northeast
  if(elec$State[n]=="Connecticut"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1788.2}
  if(elec$State[n]=="Maine"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1820}
  if(elec$State[n]=="Massachusetts"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1788.3}
  if(elec$State[n]=="New Hampshire"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1788.6}
  if(elec$State[n]=="Rhode Island"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1790}
  if(elec$State[n]=="Vermont"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"New England";elec$Admission[n]=1791}
  if(elec$State[n]=="New Jersey"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"Mideast";elec$Admission[n]=1787.3}
  if(elec$State[n]=="New York"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"Mideast";elec$Admission[n]=1788.8}
  if(elec$State[n]=="Pennsylvania"){elec$Region[n]<-"Northeast";elec$BEA[n]<-"Mideast";elec$Admission[n]=1787.2}
  # Midwest
  if(elec$State[n]=="Illinois"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Great Lakes";elec$Admission[n]=1818}
  if(elec$State[n]=="Indiana"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Great Lakes";elec$Admission[n]=1816}
  if(elec$State[n]=="Michigan"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Great Lakes";elec$Admission[n]=1837}
  if(elec$State[n]=="Ohio"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Great Lakes";elec$Admission[n]=1803}
  if(elec$State[n]=="Wisconsin"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Great Lakes";elec$Admission[n]=1848}
  if(elec$State[n]=="Iowa"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1846}
  if(elec$State[n]=="Kansas"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1861}
  if(elec$State[n]=="Minnesota"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1858}
  if(elec$State[n]=="Missouri"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1821}
  if(elec$State[n]=="Nebraska"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1867}
  if(elec$State[n]=="North Dakota"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1889.1}
  if(elec$State[n]=="South Dakota"){elec$Region[n]<-"Midwest";elec$BEA[n]<-"Plains";elec$Admission[n]=1889.2}
  # South
  if(elec$State[n]=="Delaware"){elec$Region[n]<-"South";elec$BEA[n]<-"Mideast";elec$Admission[n]=1787.1}
  if(elec$State[n]=="Dist. of Col."){elec$Region[n]<-"South";elec$BEA[n]<-"Mideast";elec$Admission[n]=1961} # Admission based on 23rd Amendment
  if(elec$State[n]=="Florida"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1845.1}
  if(elec$State[n]=="Georgia"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1788.1}
  if(elec$State[n]=="Maryland"){elec$Region[n]<-"South";elec$BEA[n]<-"Mideast";elec$Admission[n]=1788.4}
  if(elec$State[n]=="North Carolina"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1789}
  if(elec$State[n]=="South Carolina"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1788.5}
  if(elec$State[n]=="Virginia"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1788.7}
  if(elec$State[n]=="West Virginia"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1863}
  if(elec$State[n]=="Alabama"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1819}
  if(elec$State[n]=="Kentucky"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1792}
  if(elec$State[n]=="Mississippi"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1817}
  if(elec$State[n]=="Tennessee"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1796}
  if(elec$State[n]=="Arkansas"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1836}
  if(elec$State[n]=="Louisiana"){elec$Region[n]<-"South";elec$BEA[n]<-"Southeast";elec$Admission[n]=1812}
  if(elec$State[n]=="Oklahoma"){elec$Region[n]<-"South";elec$BEA[n]<-"Southwest";elec$Admission[n]=1907}
  if(elec$State[n]=="Texas"){elec$Region[n]<-"South";elec$BEA[n]<-"Southwest";elec$Admission[n]=1845.2}
  # West
  if(elec$State[n]=="Arizona"){elec$Region[n]<-"West";elec$BEA[n]<-"Southwest";elec$Admission[n]=1912.2}
  if(elec$State[n]=="Colorado"){elec$Region[n]<-"West";elec$BEA[n]<-"Mountain";elec$Admission[n]=1876}
  if(elec$State[n]=="Idaho"){elec$Region[n]<-"West";elec$BEA[n]<-"Mountain";elec$Admission[n]=1890.1}
  if(elec$State[n]=="Montana"){elec$Region[n]<-"West";elec$BEA[n]<-"Mountain";elec$Admission[n]=1889.3}
  if(elec$State[n]=="Nevada"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1864}
  if(elec$State[n]=="New Mexico"){elec$Region[n]<-"West";elec$BEA[n]<-"Southwest";elec$Admission[n]=1912.1}
  if(elec$State[n]=="Utah"){elec$Region[n]<-"West";elec$BEA[n]<-"Mountain";elec$Admission[n]=1896}
  if(elec$State[n]=="Wyoming"){elec$Region[n]<-"West";elec$BEA[n]<-"Mountain";elec$Admission[n]=1890.2}
  if(elec$State[n]=="Alaska"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1959.1}
  if(elec$State[n]=="California"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1850}
  if(elec$State[n]=="Hawaii"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1959.2}
  if(elec$State[n]=="Oregon"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1859}
  if(elec$State[n]=="Washington"){elec$Region[n]<-"West";elec$BEA[n]<-"Far West";elec$Admission[n]=1889.4}
  
  # Convert our year of Inception into a string
  elec$State.yr[n]<-paste("(",elec$Admission[n],") ",elec$State[n],sep="")
}

# Sort state data into Alphabetical order (starts out as reverse-ABC)
elec$State <- factor(elec$State, rev(as.character(elec$State)))

# Plot, Alphabetical
# For all following plots, recommend 1600x900 Resolution
ggplot(elec,aes(x=Year, y=State))+
  geom_tile(aes(fill=Party,color=Party,alpha=Margin),na.rm=T)+
  # geom_point(aes(color=Party),size=1)+
  # For fill and colors, I picked some from ColorBrewer2.org's 6-class "Set1"
  scale_fill_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  scale_color_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  geom_text(aes(label=paste(substring(Party,1,1),substring(Party,12,12),sep=""),color=Party),fontface="bold",size=2)+
  # Hopefully we don't need to describe the Transparency (alpha).
  guides(alpha="none")+
  labs(title="Election Results by State",
       subtitle="States ordered Alphabetically",
       x="Election Year",
       y="",
       caption="created by /u/zonination")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1,vjust=.5))+
  theme(strip.text.y = element_text(size = 8))+
  # theme(legend.position="bottom")+
  # Annotating the plot for some major/minor notes
  geom_vline(xintercept = 9.5, linetype=4)+ # Just a concept for annotated events
  annotate("text",x=9.5,y=1,label="(Margin by Electoral College)",angle=90,hjust=0,vjust=-.5,size=3)+
  annotate("text",x=9.5,y=1,label="(Margin by Popular Vote)",angle=90,hjust=0,vjust=1.5,size=3)
ggsave("Election-Alpha.png",width=16,height=9,units="in",dpi=100)

elec$State<-reorder(elec$State,-elec$Admission)

# Alternate plot, Ordered by admission to Union
ggplot(elec,aes(x=Year, y=State))+
  geom_tile(aes(fill=Party,color=Party,alpha=Margin),na.rm=T)+
  # geom_point(aes(color=Party),size=1)+
  # For fill and colors, I picked some from ColorBrewer2.org's 6-class "Set1"
  scale_fill_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  scale_color_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  geom_text(aes(label=paste(substring(Party,1,1),substring(Party,12,12),sep=""),color=Party),fontface="bold",size=2)+
  # Hopefully we don't need to describe the Transparency (alpha).
  guides(alpha="none")+
  guides(alpha="none")+
  labs(title="Election Results by State",
       subtitle="States ordered by Admission into Union",
       x="Election Year",
       y="",
       caption="created by /u/zonination")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1,vjust=.5))+
  theme(strip.text.y = element_text(size = 8))+
  # theme(legend.position="bottom")+
  # Annotating the plot for some major/minor notes
  geom_vline(xintercept = 9.5, linetype=4)+ # Just a concept for annotated events
  annotate("text",x=9.5,y=1,label="(Margin by Electoral College)",angle=90,hjust=0,vjust=-.5,size=3)+
  annotate("text",x=9.5,y=1,label="(Margin by Popular Vote)",angle=90,hjust=0,vjust=1.5,size=3)
ggsave("Election-Order.png",width=16,height=9,units="in",dpi=100)

# Alternate plot, Ordered by region, then by Admission
ggplot(elec,aes(x=Year, y=State))+
  geom_tile(aes(fill=Party,color=Party,alpha=Margin),na.rm=T)+
  # geom_point(aes(color=Party),size=1)+
  # For fill and colors, I picked some from ColorBrewer2.org's 6-class "Set1"
  scale_fill_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  scale_color_manual(values = c("#377eb8","#984ea3","#ff7f00","#4daf4a","#e41a1c","#e6ab02"))+
  geom_text(aes(label=paste(substring(Party,1,1),substring(Party,12,12),sep=""),color=Party),fontface="bold",size=2)+
  # Hopefully we don't need to describe the Transparency (alpha).
  guides(alpha="none")+
  labs(title="Election Results by State",
       subtitle="States ordered by BEA Region, then by Admission into Union",
       x="Election Year",
       y="",
       caption="created by /u/zonination")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1,vjust=.5))+
  theme(strip.text.y = element_text(size = 8))+
  facet_grid(BEA~.,scales="free_y",space="free_y")+
  # theme(legend.position="bottom")+
  # Annotating the plot for some major/minor notes
  geom_vline(xintercept = 9.5, linetype=4) # Just a concept for annotated events
ggsave("Election-Region.png",width=16,height=9,units="in",dpi=100)