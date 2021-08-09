#load reference data
data <- read.delim("~/Desktop/1000g.phase3.100k.b38.vcf.gz.dat.V", header=FALSE)
population <- read.delim("~/Desktop/integrated_call_samples_v3.20130502.ALL.panel", header=FALSE)

#Assign ancestry to samples
data['Super_POP'] <- population$V3[match(data$V1, population$V1)]
colnames(data) = c("ID", "PC1", "PC2", "PC3", "PC4", "Super_POP")
reference=data[,2:5]
colnames(population) = c("sample", "POP", "Super_POP", "gender")

#load target sample
Targetsample <- read.delim("~/Desktop/PC_Coordinates.txt", header=FALSE)
colnames(Targetsample) = c("ID", "PC1", "PC2", "PC3", "PC4", "Super_POP")
target = Targetsample[,2:5]


#Converting to matrix
ref = as.matrix(reference)
tar = as.matrix(target)

#Function to calculate Euclidean distance
euclidean_distance <- function(p,q)
 {
sqrt(sum((p - q)^2))
 }

#Calculating distance matrix for ref vs tar
distance <- matrix(nrow = nrow(reference), ncol=nrow(target))
temp <- matrix(nrow = nrow(ref), ncol=2)

for(i in 1:nrow(tar)) 
 {
  for(j in 1:nrow(ref)) 
   {
    a1 = tar[i,1]
    a2 = tar[i,2]
    a3 = tar[i,3]
    a4 = tar[i,4]
    b1 = ref[j,1]
    b2 = ref[j,2]
    b3 = ref[j,3]
    b4 = ref[j,4]
    
    distance [j,i] <- (euclidean_distance(c(a1,a2,a3,a4),c(b1,b2,b3,b4)))
  }
 
}

output <- matrix(nrow = nrow(tar), ncol=7)
colnames(output) = c("Sample", "AFR", "EUR", "EAS","SAS" ,"AMR", "Ancestry")
rownames(output) = c(1:nrow(tar))

for(i in 1:nrow(tar)) 
{
temp[,1] <- distance [,i]
temp[,2] <- data[,6]
colnames(temp) = c("Distances", "Ancestry")
temp <- temp[order(temp[,1]),]
temp_new <- temp[1:10,]

output[i,1] <- Targetsample[i,1]
output[i,2] <- length(grep("AFR", temp_new[,2]))
output[i,3] <- length(grep("EUR", temp_new[,2]))
output[i,4] <- length(grep("EAS", temp_new[,2]))
output[i,5] <- length(grep("SAS", temp_new[,2]))
output[i,6] <- length(grep("AMR", temp_new[,2]))
}

library(plyr)

#temp2 = as.data.frame((temp))
#selected <- temp2[1:10,] %>% count(Ancestry) 
#selected <- as.matrix(selected)

#output <- as.table(output)
#output <- rbind(output, "1" = c())

output <- as.data.frame(output)
#output[, c(2,3,4,5,6)] <- sapply(output[, c(2,3,4,5,6)], as.numeric)

output$AFR <- as.numeric(as.character(output$AFR))
output$EUR <- as.numeric(as.character(output$EUR))
output$EAS <- as.numeric(as.character(output$EAS))
output$SAS <- as.numeric(as.character(output$SAS))
output$AMR <- as.numeric(as.character(output$AMR))

# Assign Ancestry according to cutoff 8
for(i in 1:nrow(output)) 
{
  for (x in 2:6)
{
  if (output[i,x] >= 8)
  {
    #print ("YES")
    output[i,7] <- colnames(output)[x]
  }
  else
  {
    #print ("NO")
    #print (colnames(output)[x])
  }
}
}
Ancestry_cutoff8 <- output %>% count(Ancestry)

#Creating PCA plot for cutoff 8
target$Super_POP <- output$Ancestry[match(Targetsample$ID, output$Sample)]
reference_forplot = data[,2:6]
library (ggplot2)
library(scales)
#set color scale
color_scale = scale_color_manual(values=c('AFR'='#FFCD33','AMR'='#FF3D3D','EAS'='#ADFF33','EUR'='#64EBFF','SAS'='#FF30FF'),
                                 breaks=c('AFR','AMR','EAS','EUR','SAS'))
#set shape scale
shape_scale = scale_shape_manual(values = c('Reference' = 16, 'UserSample' = 17), 
                                 breaks = c('Reference','UserSample'))

#to segregate reference and target samples on the PCA plot
reference_forplot = data.frame(append(reference_forplot, c(TypeOfSample='Reference'), after=6))
target = data.frame(append(target, c(TypeOfSample = 'UserSample'), after=6))

#plots
Final_data = rbind(reference_forplot,target)
pc1VSpc2_new = ggplot(Final_data, aes(x = PC1, y = PC2, color=Super_POP, shape=TypeOfSample)) + geom_point() +color_scale + shape_scale
pc1VSpc2_new

pc2VSpc3_new = ggplot(Final_data, aes(x = PC2, y = PC3, color=Super_POP, shape=TypeOfSample)) + geom_point() +color_scale + shape_scale
pc2VSpc3_new


# Assign Ancestry according to cutoff 7
for(i in 1:nrow(output)) 
{
  for (x in 2:6)
  {
    if (output[i,x] >= 7)
    {
      #print ("YES")
      output[i,7] <- colnames(output)[x]
    }
    else
    {
      #print ("NO")
      #print (colnames(output)[x])
    }
  }
}
Ancestry_cutoff7 <- output %>% count(Ancestry)
Targetsample$Super_POP <- output$Ancestry[match(Targetsample$ID, output$Sample)]


# Assign Ancestry according to cutoff 6
for(i in 1:nrow(output)) 
{
  for (x in 2:6)
  {
    if (output[i,x] >= 6)
    {
      #print ("YES")
      output[i,7] <- colnames(output)[x]
    }
    else
    {
      #print ("NO")
      #print (colnames(output)[x])
    }
  }
}
Ancestry_cutoff6 <- output %>% count(Ancestry)
Targetsample$Super_POP <- output$Ancestry[match(Targetsample$ID, output$Sample)]