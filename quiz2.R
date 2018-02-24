# Name: [Sirui Ren]
library(ggplot2)
library(dplyr)
#1.	Using the mpg dataset
#a.	Create a histogram showing the counts of each car class, grouped by year (10 points)
ggplot(mpg,aes(factor(year),group=class))+geom_bar(position="dodge")
#b.	Color the bars by their class (5 points)
ggplot(mpg,aes(factor(year),group=class))+geom_bar(position="dodge",aes(fill=class))
#c.	Labels all Axes and Title Graph (5 points)
ggplot(mpg,aes(factor(year),group=class))+geom_bar(position="dodge",aes(fill=class))+labs(title="Counts of each car by class",x="year",y="counts")
#d.	Facet the graph on class (5 points)
ggplot(mpg,aes(factor(year),group=class))+geom_bar(position="dodge",aes(fill=class))+labs(title="Counts of each car by class",x="year",y="counts")+facet_grid((.~class))

#2.	Using the diamonds dataset
#a.	Create a geom_jitter graph showing the relationship between carat and price (10 points)
ggplot(diamonds,aes(x=carat,y=price))+geom_jitter()
#b.	Set the shape of each point based on the diamond’s color property (5 points)
ggplot(diamonds,aes(x=carat,y=price))+geom_jitter(aes(shape=color))
#c.	Labels all Axes and Title Graph (5 points)
ggplot(diamonds,aes(x=carat,y=price))+geom_jitter(aes(shape=color))+labs(title="Diamonds",x="Carat", y="Price")
#d.	Facet the graph on cut type of the diamond (5 points)
ggplot(diamonds,aes(x=carat,y=price))+geom_jitter(aes(shape=color))+labs(title="Diamonds",x="Carat", y="Price")+facet_grid(.~cut)

#3.	Using the txhousing dataset
#a.	Create a scatterplot of the total # of sales by year (10 points)
hsyr<-txhousing %>% group_by(year) %>% summarise(totalsales=sum(sales,na.rm=TRUE))
ggplot(hsyr,aes(x=year,y=totalsales))+geom_point()
#b.	Set the color of the points by year (5 points)
ggplot(hsyr,aes(x=year,y=totalsales))+geom_point(aes(color=year))
#c.	Labels all Axes and Title Graph (5 points)
ggplot(hsyr,aes(x=year,y=totalsales))+geom_point(aes(color=year))+labs(title="TXhousing for total sales",x="year",y="totalsales")
#d.	Facet the graph by city (5 points)   
hsyr<-txhousing %>% group_by(year,city) %>% summarise(totalsales=sum(sales,na.rm=TRUE)) %>% ggplot(.,aes(x=year,y=totalsales))+geom_point(aes(color=year))+facet_wrap(~city)

#4.	Using the economics dataset
#a.	Create a scatterplot of population vs unemployment (10 points)
ggplot(economics,aes(x=pop,y=unemploy))+geom_point()
#b.	Color the points based on their year (5 points)
economics %>% mutate(year=substr(economics$date,1,4)) %>% ggplot(.,aes(x=pop,y=unemploy,col=year))+geom_point()
#c.	Labels all Axes and Title Graph (5 points)
economics %>% mutate(year=substr(economics$date,1,4)) %>% ggplot(.,aes(x=pop,y=unemploy,col=year))+geom_point()+labs(title="Economics for population vs unemployement",x="population",y="unemployement")
#d.	Facet the graph by month (end result should be 12 graphs 1/month) (5 points)
economics %>% mutate(year=substr(economics$date,1,4)) %>% mutate(month=substr(economics$date,6,7)) %>% ggplot(.,aes(x=pop,y=unemploy,col=year))+geom_point()+labs(title="Economics for population vs unemployement",x="population",y="unemployement")+facet_wrap(~month)
