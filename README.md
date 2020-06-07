# Mini Projects and Worksheets

**Status: Ongoing**

## Introduction
This repository is where I keep any projects/worksheets that aren't really large enough to deserve their own repo. Some of the projects here were made during my own free time or for classes.

### Projects

- Applications of Linear Models in Linear Algebra
- A Simple Guide to the Parallel Package in R
- Conflicting Outputs in Base R's prop.test() function
- Game Theory in the Board Game Risk

### Quick-View of Skills Used

- R
- Linear Algebra
- Game Theory
- Parallel Computing
- Shiny

## Descriptions

### Applications of Linear Models in Linear Algebra

This is the ﬁnal project for the Spring 2020 linear algebra course. This document contains an overview of the use of linear algebra in linear models. First, the matrix form of a multiple linear regression equation is given, followed by the derivation and application of the OLS estimator.

### A Simple Guide to the Parallel Package in R

This short "guide" was made to demonstrate the use of parallel processing using the parallel package in R. It goes over the basics, such as how to set things up, utilize functions, and an example.

### Conflicting Outputs in Base R's prop.test() function

This short project was done to see if there are any conﬂicting outputs with the conﬁdence intervals and p-values in the prop.test function in R. This is because the function uses Wald Conﬁdence Interval, whereas a Score test is used to ﬁnd the p-value. Parallel processing was used to do all the computations. Out of the 26,502,500 combinations, there were 571,288 conﬂicts (2.1556%) when there was a correction and 575,266 conﬂicts (2.17061%) when there was no correction. There were also 133,240 (0.0503%) combinations that had conﬂicts with both a correction and not a correction. In total, there were 1,013,314 conﬂicts (3.823466%).

### Game Theory in the Board Game Risk

Risk is a game of strategic conquest where players go against each other to eliminate the enemy armies in all territories. Each player takes turns gaining reinforcement armies, attacking adjacent enemy territories, and moving armies. Games can become quite lengthy, lasting hours to days, but having a solid strategy can help one conquer their foes. While the rules may be simple, the game theory and strategy behind the game tend to get complicated. The focus of this project is to look at the single-move “attack” and “defense” strategies players take when they decide on the number of dice to roll. For this independent study project, the game theory of risk was studied, probabilities of success for different moves, and a shiny web app were created.
