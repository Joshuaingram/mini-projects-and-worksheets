# making grid of all possible outcomes for all dice combinations up to 3A x 2D

dice1.a <- seq(0,6)
dice2.a <- seq(0,6)
dice3.a <- seq(0,6)
dice1.d <- seq(0,6)
dice2.d <- seq(0,6)

game.combs <- expand.grid(dice1.a, dice2.a, dice3.a, dice1.d, dice2.d)

colnames(game.combs) <- c("dice1.a", "dice2.a", "dice3.a", "dice1.d", "dice2.d")
game.combs <- game.combs[which(game.combs$dice1.a != 0 | game.combs$dice2.a != 0 | game.combs$dice3.a != 0 |
                                 game.combs$dice1.d != 0 | game.combs$dice2.d != 0),]

# 1A x 1D game probabilities
game.combs.1.1 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a == 0 & game.combs$dice3.a == 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d == 0),]

p.win.d.1.1 <- nrow(game.combs.1.1[which(game.combs.1.1$dice1.d >= game.combs.1.1$dice1.a),]) / nrow(game.combs.1.1)
p.win.a.1.1 <- 1 - p.win.d.1.1

# 2A x 1D game probabilities
game.combs.2.1 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a != 0 & game.combs$dice3.a == 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d == 0),]

p.win.a.2.1 <- nrow(game.combs.2.1[which(game.combs.2.1$dice1.a > game.combs.2.1$dice1.d | game.combs.2.1$dice2.a > game.combs.2.1$dice1.d),]) / nrow(game.combs.2.1)
p.win.d.2.1 <- 1 - p.win.a.2.1

# 3A X 1D game probabilities
game.combs.3.1 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a != 0 & game.combs$dice3.a != 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d == 0),]

p.win.a.3.1 <- nrow(game.combs.3.1[which(game.combs.3.1$dice1.a > game.combs.3.1$dice1.d | game.combs.3.1$dice2.a > game.combs.3.1$dice1.d
                                         | game.combs.3.1$dice3.a > game.combs.3.1$dice1.d),]) / nrow(game.combs.3.1)
p.win.d.3.1 <- 1 - p.win.a.3.1

# 1A x 2D game probabilities
game.combs.1.2 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a == 0 & game.combs$dice3.a == 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d != 0),]

p.win.d.1.2 <- nrow(game.combs.1.2[which(game.combs.1.2$dice1.d >= game.combs.2.1$dice1.a | game.combs.1.2$dice2.d >= game.combs.1.2$dice1.a),]) / nrow(game.combs.1.2)
p.win.a.1.2 <- 1 - p.win.d.1.2

# 2A x 2D game probabilities
game.combs.2.2 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a != 0 & game.combs$dice3.a == 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d != 0),]

game.combs.win.2.2.d.both <- game.combs.2.2[which(game.combs.2.2$dice1.d >= game.combs.2.2$dice1.a & game.combs.2.2$dice2.d >= game.combs.2.2$dice2.a |
                                                            game.combs.2.2$dice1.d >= game.combs.2.2$dice2.a & game.combs.2.2$dice2.d >= game.combs.2.2$dice1.a),]

game.combs.win.2.2.a.both <- game.combs.2.2[which(game.combs.2.2$dice1.a > game.combs.2.2$dice1.d & game.combs.2.2$dice2.a > game.combs.2.2$dice2.d |
                                                                     game.combs.2.2$dice1.a > game.combs.2.2$dice2.d & game.combs.2.2$dice2.a > game.combs.2.2$dice1.d),]

n.wins.tie.2.2 <- nrow(game.combs.2.2) - (nrow(game.combs.win.2.2.a.both) + nrow(game.combs.win.2.2.d.both))

nrow.2.2 <- nrow(game.combs.2.2)

p.both.a.2.2 <- nrow(game.combs.win.2.2.a.both) / nrow.2.2
  
p.both.d.2.2 <- nrow(game.combs.win.2.2.d.both) / nrow.2.2
  
p.tie.2.2 <- n.wins.tie.2.2 / nrow.2.2

# 3A x 2D game probabilities
game.combs.3.2 <- game.combs[which(game.combs$dice1.a != 0 & game.combs$dice2.a != 0 & game.combs$dice3.a != 0 &
                                     game.combs$dice1.d != 0 & game.combs$dice2.d != 0),]


roll.outcome <- function(row){
  
  dice1.a <- row[[1]]
  dice2.a <- row[[2]]
  dice3.a <- row[[3]]
  dice1.d <- row[[4]]
  dice2.d <- row[[5]]
  
  a.vec <- c(dice1.a, dice2.a, dice3.a)
  d.vec <- c(dice1.d, dice2.d)
  
  # if indicator is 2 - attacker loses 2 armies, 0 - both attacker and defender loses 1 army, -2 - defender loses 2 armies
  indicator <- 0
  
  max1.a <- max(a.vec)
  max1.d <- max(d.vec)
  
  if (max1.d >= max1.a){
    indicator <- indicator + 1
  } else {
    indicator <- indicator - 1
  }
  
  max2.a <- max(a.vec[-which.max(a.vec)])
  max2.d <- max(d.vec[-which.max(d.vec)])
  
  if (max2.d >= max2.a){
    indicator <- indicator + 1
  } else{
    indicator <- indicator - 1
  }
  
  row.new <- append(row, indicator)
  row.new <- as.data.frame(t(row.new))

}

game.combs.3.2 <- do.call(rbind.data.frame,apply(X = game.combs.3.2, MARGIN = 1, FUN = roll.outcome))

colnames(game.combs.3.2) <- c("dice1.a", "dice2.a", "dice3.a", "dice1.d", "dice2.d", "outcome")

game.combs.3.2 <- game.combs.3.2[-nrow(game.combs.3.2),]

game.combs.win.3.2.a.both <- nrow(game.combs.3.2[which(game.combs.3.2$outcome == 2),])

game.combs.win.3.2.d.both <- nrow(game.combs.3.2[which(game.combs.3.2$outcome == -2),])

game.combs.3.2.tie <- nrow(game.combs.3.2[which(game.combs.3.2$outcome == 0),])

nrow.3.2 <- nrow(game.combs.3.2)

p.both.a.3.2 <- game.combs.win.3.2.a.both / nrow.3.2

p.both.d.3.2 <- game.combs.win.3.2.d.both / nrow.3.2
  
p.tie.3.2 <- game.combs.3.2.tie / nrow.3.2

p.both.d.3.2 + p.both.a.3.2 + p.tie.3.2

# final probabilities by game

# 1 x 1 game
p.win.d.1.1

p.win.a.1.1

# 2 x 1 game
p.win.d.2.1

p.win.a.2.1

# 3 x 1 game
p.win.d.3.1

p.win.a.3.1

# 1 x 2 game
p.win.d.1.2

p.win.a.1.2

# 2 x 2 game
p.both.d.2.2

p.both.a.2.2

p.tie.2.2

# 3 x 2 game
p.both.d.3.2

p.both.a.3.2

p.tie.3.2

probs.matrix <- matrix(data = c(p.win.d.1.1, p.win.a.1.1, p.win.d.2.1, p.win.a.2.1, p.win.d.3.1, p.win.a.3.1, p.win.d.1.2, p.win.a.1.2, p.both.d.2.2, p.both.a.2.2, p.tie.2.2, p.both.d.3.2, p.both.a.3.2, p.tie.3.2), nrow = 1)

probs.df <- as.data.frame(probs.matrix)

colnames(probs.df) <- c("p.win.d.1.1", "p.win.a.1.1", "p.win.d.2.1", "p.win.a.2.1", "p.win.d.3.1", "p.win.a.3.1", "p.win.d.1.2", "p.win.a.1.2", "p.both.d.2.2", "p.both.a.2.2", "p.tie.2.2", "p.both.d.3.2", "p.both.a.3.2", "p.tie.3.2")

save(probs.df, file = "probdf.RData")

# expected loss 1x1 game
e.loss.a.1.1 <- 1 * probs.df[,1]
e.loss.d.1.1 <- 1 - e.loss.a.1.1

# expected loss 2x1 game
e.loss.a.2.1 <- 1 * probs.df[,3]
e.loss.d.2.1 <- 1 - e.loss.a.2.1

# expected loss 3x1 game
e.loss.a.3.1 <- 1 * probs.df[,5]
e.loss.d.3.1 <- 1 - e.loss.a.3.1

# expected loss 1 x 2 game
e.loss.a.1.2 <- 1 * probs.df[,7]
e.loss.d.1.2 <- 1 - e.loss.a.1.2

# expected loss 2 x 2 game
e.loss.a.2.2 <- (2 * probs.df[,9]) + (1 * probs.df[,11])
e.loss.d.2.2 <- (2 * probs.df[,10]) + (1 * probs.df[,11])

# expected loss 3 x 2 game
e.loss.a.3.2 <- (2 * probs.df[,12]) + (1 * probs.df[,14])
e.loss.d.3.2 <- (2 * probs.df[,13]) + (1 * probs.df[,14])

exp.loss.df <- matrix(data = c(e.loss.a.1.1, e.loss.d.1.1, e.loss.a.2.1, e.loss.d.2.1, e.loss.a.3.1, e.loss.d.3.1, e.loss.a.1.2, e.loss.d.1.2, e.loss.a.2.2, e.loss.d.2.2, e.loss.a.3.2, e.loss.d.3.2), nrow = 1)
exp.loss.df <- as.data.frame(exp.loss.df)
colnames(exp.loss.df) <- c("e.loss.a.1.1", "e.loss.d.1.1", "e.loss.a.2.1", "e.loss.d.2.1", "e.loss.a.3.1", "e.loss.d.3.1", "e.loss.a.1.2", "e.loss.d.1.2", "e.loss.a.2.2", "e.loss.d.2.2", "e.loss.a.3.2", "e.loss.d.3.2")

for(i in 1:length(exp.loss.df)){
  exp.loss.df[,i] <- round(exp.loss.df[,i], 3)
}

save(exp.loss.df, file = "explossdf.RData")


# data storage for app
# list of payoff matrices. It will be the payoff matrices for all possible game combinations with their corresponding expected loss

pair <- function(x,y) sprintf("(%1.3f,%1.3f)", x,y)

# 1 x 1 matrix
exp.1.1 <- c(pair(exp.loss.df[,1], exp.loss.df[,2]))
pay.1.1 <- as.data.frame(matrix(exp.1.1, nrow=1))
dimnames(pay.1.1) <- list(c("1 Die"), c("1 Die"))

# 2 x 1 matrix
exp.2.1 <- c(pair(exp.loss.df[,1], exp.loss.df[,2]), pair(exp.loss.df[,3],exp.loss.df[,4]))
pay.2.1 <- as.data.frame(matrix(exp.2.1, nrow = 2))
dimnames(pay.2.1) <- list(c("1 Die", "2 Dice"), c("1 Die"))

# 3 x 1 matrix
exp.3.1 <- c(pair(exp.loss.df[,1], exp.loss.df[,2]), pair(exp.loss.df[,3],exp.loss.df[,4]), pair(exp.loss.df[,5],exp.loss.df[,6]))
pay.3.1 <- as.data.frame(matrix(exp.3.1, nrow = 3))
dimnames(pay.3.1) <- list(c("1 Die", "2 Dice", "3 Dice"), c("1 Die"))

# 1 x 2 matrix
exp.1.2 <- c(pair(exp.loss.df[,1], exp.loss.df[,2]), pair(exp.loss.df[,7],exp.loss.df[,8]))
pay.1.2 <- as.data.frame(matrix(exp.1.2, nrow = 1))
dimnames(pay.1.2) <- list(c("1 Die"), c("1 Die", "2 Dice"))

# 2 x 2 matrix
exp.2.2 <- c(pair(exp.loss.df[,1], exp.loss.df[,2]), pair(exp.loss.df[,3],exp.loss.df[,4]), pair(exp.loss.df[,7],exp.loss.df[,8]), pair(exp.loss.df[,9],exp.loss.df[,10]))
pay.2.2 <- as.data.frame(matrix(exp.2.2, nrow = 2))
dimnames(pay.2.2) <- list(c("1 Die", "2 Dice"), c("1 Die", "2 Dice"))

# 3 x 2 matrix
exp.3.2 <- c(pair(exp.loss.df[,1],exp.loss.df[,2]), pair(exp.loss.df[,3],exp.loss.df[,4]), pair(exp.loss.df[,5],exp.loss.df[,6]), pair(exp.loss.df[,7],exp.loss.df[,8]), pair(exp.loss.df[,9],exp.loss.df[,10]), pair(exp.loss.df[,11],exp.loss.df[,12]))
pay.3.2 <- as.data.frame(matrix(exp.3.2, nrow=3))
dimnames(pay.3.2) <- list(c("1 Die", "2 Dice", "3 Dice"), c("1 Die", "2 Dice"))

payoff.list <- list(pay.1.1, pay.2.1, pay.3.1, pay.1.2, pay.2.2, pay.3.2)

save(payoff.list, file = "payofflist.RData")

# index list and dataframe for serverside matrix access
index.df.attack <- as.data.frame(matrix(c(1, 2, 3, 4, 5, 6, 4, 5, 6), nrow = 3))
index.df.defend <- as.data.frame(matrix(c(1, 4, 4, 2, 5, 6, 3, 6, 6), nrow = 3))
index.list <- list(index.df.attack, index.df.defend)

save(index.list, file = "indexlist.RData")
