num.cores <- detectCores()

cluster <- makeCluster(num.cores - 2)

n1 <- seq(1,100)
n2 <- seq(1,100)
y1 <- seq(0,100)
y2 <- seq(0,100)

df <- expand.grid(y1, y2, n1, n2)
colnames(df) <- c("y1", "y2", "n1", "n2")

df <- subset(df, y1 <= n1 & y2 <= n2)
df <- df[which(df$y1 > 0 | df$y2 > 0),]
df <- df[which(df$y1 != df$n1 | df$y2 != df$n2),]

conflict.check <- function(vector.data){
  y1 <- vector.data[1]
  y2 <- vector.data[2]
  n1 <- vector.data[3]
  n2 <- vector.data[4]
  
  prop.info.correction <- prop.test(c(y1, y2), c(n1, n2), correct = TRUE)
  
  p.value.correction <- prop.info.correction$p.value
  conf.int.low.correction <- prop.info.correction$conf.int[1]
  conf.int.up.correction <- prop.info.correction$conf.int[2]
  
  if (conf.int.low.correction < 0 & 0 < conf.int.up.correction & p.value.correction < 0.05){
    conflict.correction <- TRUE
  } else if (conf.int.low.correction < 0 & conf.int.up.correction < 0 & p.value.correction > 0.05){
    conflict.correction <- TRUE
  } else if (conf.int.low.correction > 0 & conf.int.up.correction > 0 & p.value.correction > 0.05){
    conflict.correction <- TRUE
  } else {
    conflict.correction <- FALSE
  }
  
  prop.info.no <- prop.test(c(y1, y2), c(n1, n2), correct = FALSE)
  
  p.value.no <- prop.info.no$p.value
  conf.int.low.no <- prop.info.no$conf.int[1]
  conf.int.up.no <- prop.info.no$conf.int[2]
  
  if (conf.int.low.no < 0 & 0 < conf.int.up.no & p.value.no < 0.05){
    conflict.no <- TRUE
  } else if (conf.int.low.no < 0 & conf.int.up.no < 0 & p.value.no > 0.05){
    conflict.no <- TRUE
  } else if (conf.int.low.no > 0 & conf.int.up.no > 0 & p.value.no > 0.05){
    conflict.no <- TRUE
  } else {
    conflict.no <- FALSE
  }
  
  info.vector <- c(n1, n2, y1, y2, conflict.correction, conflict.no)
  
  return(info.vector)
  
}

object.export.names <- c("df", "conflict.check")
clusterExport(cluster, object.export.names)

output <- parApply(cl = cluster, X = df, 1, FUN = conflict.check)
output <- t(output)
conflict.output <- as.data.frame(output)
colnames(conflict.output) <- c("n1", "n2", "y1", "y2", "conflict.correction", "conflict.no.correction")

View(conflict.output)

stopCluster(cluster)

save(conflict.output, file = "conflictinfo.RData")


# let's count the number of conflicts

output.df <- as.data.frame(output)

# number of conflicts where there is correction
count.1 <- nrow(output.df[which(output.df$V5 == 1),])
count.1

# number of cnflicts where there is no correction
count.2 <- nrow(output.df[which(output.df$V6 == 1),])
count.2

# number of total conflicts for which they occur when there is a correction and no correction
count.3 <- nrow(output.df[which(output.df$V5 == 1 & output.df$V6 == 1),])
count.3

# number of total corrections
total <- count.1 + count.2 - count.3
total

# percetnage of conflicts when there is a correction
count.1/nrow(output.df)

# percetnage of conflicts when there is no correction
count.2/nrow(output.df)

# percetnage of conflicts for when there is conflicts with both corrections and no corrections
count.3/nrow(output.df)

# percetnage of conflicts in total
total/nrow(output.df)

nrow(output.df)
