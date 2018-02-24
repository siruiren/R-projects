#Name: [Sirui Ren]


#Question 1 Vectors (Total 10 points)
#A)1 Point: Create a vector `x` that has the numbers 5,2,6,2,1,7
x<-c(5,2,6,2,1,7)




#B)1 Point: Create a vector `y` that has the numbers 2,3
y<-c(2,3)




#C)1 Point: Create a vector `z` by adding (not combining, but adding) `x` and `y` (note the recycling!)
z<-x+y




#D)1 Point: Create a vector `first.three` that has the first three elements of `z` in it
first.three<-z[1:3]




#E)1 Point: Create a vector `small` that has the values of `z` that are less than 5
small<-z[z<5]



#F) 1 Point: Replace the values in `z` that are larger than 5 with the number 5
z[z>5]<-5


#G) 1 Point: Replace every other value in `z` with the number 0
z[z<5]<-0


#H) 1 Point: Convert the vector c(2,0.5,1,2,0.5,1,2,0.5,1) 
#to a vector of only 1s, using a vector of length 3.
vector_1<-c(2,0.5,1,2,0.5,1,2,0.5,1)
length3 <- c(0.5,2,1)
vector_2<-vector_1*length3

#I) 1 Point: The conversion from a temperature measurement in degrees Fahrenheit F to Celsius C
#is performed using the following equation:Use vector-oriented behavior in R 
#to convert the temperatures 45, 77, 20, 19, 101, 120, and 212 in degrees Fahrenheit to degrees Celsius.
temp_in_F<-c(45,77,20,19,101,120,212)
temp_in_C<-(5/9)*(temp_in_F-32)



#J) 1 Point: Use the vector c(2,4,6) and the vector c(1,2) in conjunction 
#with rep and * to produce the vector c(2,4,6,4,8,12).
a<-c(2,4,6)
b<-c(1,2)
vec<-rep(a,times=2)*rep(b,times=3)



#Question 2 Matrices (Total 10 Points)

#A) 2 Points: Arrange 1:6 into a 2 by 3 matrix (2 rows and 3 columns), then call it m_1.
m_1<-matrix(1:6,ncol=3)
#B) 2 Points: Arrange 7:18 into a 4 by 3 matrix (4 rows and 3 columns), then call it m_2.
m_2<-matrix(7:18,ncol=3)
#C) 3 Points: Stack m_1 on the top of m_2, then call it my_mat. You should end up with a 6 by 3 matrix.
my_mat<-rbind(m_1,m_2)
#D) 3 Points: Create my_mat2 to be matrix(1:9, 3, 3, byrow=T):
#Compute the elementwise product of the first row and the second column of my_mat2.
my_mat2<-matrix(1:9, 3, 3, byrow=T)
my_mat2[1,]*my_mat2[,2]

#Question 3 Factors (Total 10 Points)

#The New Zealand government consists of the political parties National, Labour, Greens, and Maori, with several smaller parties labeled as Other. Suppose you asked 20 New Zealanders which of these they identified most with and obtained the following data:
#. There were 12 males and 8 females; the individuals numbered 1, 5-7, 12, and 14-16 were females.
#. The individuals numbered 1, 4, 12, 15, 16, and 19 identified with Labour; no one identified with Maori; the individuals numbered 6, 9, and 11 identified with Greens; 10 and 20 identified with Other; and the rest identified with National.

#A) 2 Points: Use your knowledge of vectors (for example, subsetting and overwriting) to create two character vectors: sex with entries "M" (male) and "F" (female) and party with entries "National", "Labour", "Greens", "Maori", and "Other". Make sure the entries are placed in the correct positions as outlined earlier.
sex<-c("F","M","M","M","F","F","F","M","M","M","M","F","M","F","F","F","M","M","M","M")
party<-c("Labour","National","National","Labour","National","Greens","National","National","Greens","Other","Greens","Labour","National","National","Labour","Labour","National","National","Labour","Other")

#B) 2 Points: Create two different factor vectors based on sex and party.
factor_sex<-factor(sex)
factor_party<-factor(party)
#C) 2 Points: Use factor subsetting to do the following:
  
  #Return the factor vector of chosen parties for only the male participants.
male_party<-subset(party,sex=="M")
  #Return the factor vector of genders for those who chose National.
National_gender<-subset(sex,party=="National")
#E) 2 Points: Another six people joined the survey, with the results c("National","Maori","Maori","Labour","Greens","Labour") for the preferred party and c("M","M","F","F","F","M") as their gender. 
#Combine these results with the original factors from (b).

sex2<-factor(c(as.character(sex),c("M","M","F","F","F","M")))
party2<-factor(c(as.character(party),c("National","Maori","Maori","Labour","Greens","Labour")))

#F 2 Points:  Suppose you also asked all individuals to state how confident they were that Labour will win more seats in Parliament than National in the next election and to attach a subjective percentage to that confidence. The following 26 results were obtained: 93, 55, 29, 100, 52, 84, 56, 0, 33, 52, 35, 53, 55, 46, 40, 40, 56, 45, 64, 31, 10, 29, 40, 95, 18, 61.
#Create a factor with levels of confidence as follows: Low for percentages [0,30];
#Moderate for percentages (30,70]; and High for percentages (70,100].
confidence<-c(93, 55, 29, 100, 52, 84, 56, 0, 33, 52, 35, 53, 55, 46, 40, 40, 56, 45, 64, 31, 10, 29, 40, 95, 18, 61)
confidence[confidence>70 & confidence <= 100] = 'High'
confidence[confidence>30 & confidence <=70] = 'Moderate' 
confidence[confidence>=0 & confidence <= 30] ='Low'
factor(confidence,levels = c("High","Moderate","Low"))


#Question 4 Data Frames (Total 20 Points)


#A) 2 Points: Read data from gates_money.csv into a variable called `grants` using the `read.csv` function
# Use the View function to look at your data
grants<- read.csv(file="/Users/siruiren/Documents/Rstudio/quiz-1-siruiren-master/gates_money.csv",header=TRUE,sep = ",")

#B) 2 Points: Create a variable `spending` as the `total_amount` column of the dataset
spending<-grants[,4]

#C) 2 Points: Confirm that your `spending` variable is a vector using the `is.vector` function
is.vector(spending)

#D) 2 Points: Create a variable `org` as the `organization` column of the dataset.
# Unfortunately, it will not be a vector by default, 
#so you must transform it using the as.vector function
org<-grants[,3]
as.vector(org)

#E) 2 Points: What was the mean grant value?
mean(spending)

#F) 2 Points: What was the dollar amount of the largest grant?
max(spending)

#G) 2 Points: What was the dollar amount of the smallest grant?
min(spending)

#H) 2 Points: Which organization received the largest grant?
org[spending==max(spending)]

#I) 2 Points: Which organization received the smallest grant?
org[spending==min(spending)]

#J) 2 Points: How many grants were awarded in 2010?
length(org[grants$grant_title[grants$start_year=="2010"]])


#Question 5 Lists (Total 10 Points)

#A) 1 Point: Create a vector of everything you ate for breakfast
breakfast<-c("fruit","noodle","milk","bread")




#B) 1 Point: Create a vector of everything you ate for lunch
lunch<-c("meat","rice","vegetable")




#C) 2 Points: Create a list `meals` that has contains your breakfast and lunch
meals<-list(breakfast,lunch)




#D) 2 Points: Add a `dinner` index to your `meals` list that has what you plan to eat for dinner

meals<-list(breakfast=meals[[1]],lunch=meals[[2]],dinner=c("fish","porridge","dessert"))



#E) 2 Points: Extract your 'dinner' element from your list and save it in a vector called 'dinner'
dinner<-meals$dinner




#F) 2 Points: Create a list that has the number of items you ate for each meal
number<-list(length(breakfast),length(lunch),length(dinner))
number

#Question 6 Conditionals (Total 10 Points)
#Create the following two vectors:
vec1 <- c(2,1,1,3,2,1,0)
vec2 <- c(3,8,2,2,0,0,0)

#A) 5 points: Using vec1 and vec2 from (a), write and execute a line of code that multiplies
#the corresponding elements of the two vectors together if their sum is greater than 3.
#Otherwise, the code should simply sum the two elements.
vec3 <- rep(0,length(vec1))
for(i in 1:length(vec1))
{
  if(vec1[i]+vec2[i]>3){
    vec3[i]<-vec1[i]*vec2[i]
  }
  else{
    vec3[i]<-vec1[i]+vec2[i]
  }
}
vec3 


#B)5 Points: Write a conditional function that takes a square character matrix and checks if any of
#the character strings on the diagonal (top left to bottom right) begin with the letter g, 
#lowercase or uppercase. If satisfied, these specific entries should be overwritten with
#the string "HERE". Otherwise, the entire matrix should be replaced with an identity matrix
#of the same dimensions. Then, try your code on the following matrices, checking the result each time:

mymat <- matrix(as.character(1:16),4,4)
mymat <- matrix(c("DANDELION","Hyacinthus","Gerbera","MARIGOLD","geranium","ligularia","Pachysandra","SNAPDRAGON","GLADIOLUS"),3,3)
mymat <- matrix(c("GREAT","exercises","right","here"),2,2,byrow=T)

test=T
for (i in 1:nrow(mymat)){
  if (substr(mymat[i,i],1,1)=="g"|substr(mymat[i,i],1,1)=="G"){
    mymat[i,i]="HERE"
    test=F
  }
}

if(test){
  for(i in 1:nrow(mymat)){
    for(j in i:ncol(mymat)){
      if(i==j){
        mymat[i,j]=1
      } else{
        mymat[i,j]=0
      }
    }
  }
}
print(mymat)
#Question 7 Loops (Total 10 Points)
# Use a for loop to estimate the average of squaring the result of a roll of a die.

nsides = 6
ntrials = 1000
trials = rep(0,ntrials) #Create your For Loop Below
for(j in 1:ntrials){
  trials[j]=sample(1:nsides,1)
}
mean(trials^2)

#Question 8 dplyr (Total 20 Points)
#A) 1 Point: Read in the NBA player data into a variable called `team.data` using `read.csv`
# The data.frame team.data should now be accessible to you. 
# View it, and get some basic information about the number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" 
# following the names of teams that made it to the playoffs that year.
team.data<- read.csv(file="/Users/siruiren/Documents/Rstudio/quiz-1-siruiren-master/teams.csv",header=TRUE,sep = ",")
View(team.data)
dim(team.data)


#B) 2 Points: Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
team.data_1<-mutate(team.data,tov_to_stl=TOV / STL)



#C) 2 Points: Sort the teams from lowest turnover/steal ratio to highest
arrange(team.data_1,tov_to_stl=TOV / STL)


#D) 2 Points:  Which team has the lowest ratio?
min(team.data_1$tov_to_stl)


#E) 3 Points: Using the pipe operator, create a new column of assists per game (AST / G) AND
# sort the data.frame by this new column in DESCENDING order.
team.data %>%
  mutate(AST/G) %>%
  arrange(desc(AST/G))


#F) 2 Points: Create a data.frame called `good.offense` of teams that scored more than 8700 points (PTS)
good.offense<-filter(team.data,PTS>8700)
good.offense

#G) 2 Points: Create a data.frame called `good.defense` of teams that had more than 470 blocks (BLK)
good.defense<-filter(team.data,BLK>470)
good.defense

#H) 3 Points: Create a data.frame called `defense.stats` that only shows defensive rebounds (DRB), steals (STL),

# and blocks (BLK) along with the team name.
defense.stats<-select(team.data,Team,DRB,STL,BLK)
defense.stats

#I) 3 Points Create a data.frame called `offense.stats` that only shows offensive rebounds (ORB), 

# field-goal % (FG.), and assists (AST) along with the team name.
offense.stats<-select(team.data,Team,ORB,FG.,AST)
offense.stats


