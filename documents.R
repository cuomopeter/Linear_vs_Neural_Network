## Assignment 8 - Peter Cuomo

# Question 1

* R^2 for this model is **.626**


```{r}
result <- regress(
  Nba2017_1_, 
  rvar = "Salary", 
  evar = c(
    "Pos", "Ht", "Wt", "Exp", "Age", "G", "GS", "MP", "FG", 
    "FGA", "ThrP", "ThrPA", "FT", "FTA", "ORB", "DRB", "AST", 
    "STL", "BLK", "TOV", "PF", "PER", "WS"
  ), 
  data_filter = "Train==1"
)
summary(result)
```

# Question 2 
* R^2 for this model is **1**

# Question 3 

* **pred_reg_int** produces a lower MAE on the training set 
* **pred_reg** produces a lower MAE on the testing set

* The large difference in pred_reg_int is due to overfitting of the model.

```{r}
result <- evalreg(
  Nba2017_1_, 
  pred = c("pred_reg", "pred_reg_int"), 
  rvar = "Salary", 
  train = "Both", 
  data_filter = "Train==1"
)
summary(result)
```
# Question 4 
* There are **26** weights between the inputs and the hidden neuron. 
* There is **1** weight between the hidden neuron and the output.

```{r}
result <- nn(
  Nba2017_1_, 
  rvar = "Salary", 
  evar = c(
    "Pos", "Ht", "Wt", "Exp", "Age", "G", "GS", "MP", "FG", 
    "FGA", "ThrP", "ThrPA", "FT", "FTA", "ORB", "DRB", "AST", 
    "STL", "BLK", "TOV", "PF", "PER", "WS"
  ), 
  type = "regression", 
  decay = 0.1, 
  seed = 1234, 
  data_filter = "Train==1"
)
summary(result, prn = TRUE)
```
# Question 5

* This model estimates **78** weights between the inputs and hidden neurons.
* This model estimates **3** weights between the hidden neurons and output.

# Question 6 
* This model estimates **130** weights between the inputs and hidden neurons.
* This model estimates **5** weights between the hidden neurons and output.

# Question 7 

* pred_nn5_point1 produces the lowest MAE on the training set
* pred_nn3_point1 produces the lowest MAE on the testing set

```{r}
result <- evalreg(
  Nba2017_1_, 
  pred = c("pred_nn1_point1", "pred_nn3_point1", "pred_nn5_point1"), 
  rvar = "Salary", 
  train = "Both", 
  data_filter = "Train==1"
)
summary(result)
```
# Question 8 




```{r}
size=c()
decay=c()
rmse=c()
mae=c()
decay=c()
for (i in 1:6)
{ i=i
for (j in 1:4)
{
j=1/10^j

result <- nn(
  Nba2017_1_, 
  rvar = "Salary", 
  evar = c(
    "Pos", "Ht", "Wt", "Exp", "Age", "G", "GS", "MP", "FG", 
    "FGA", "ThrP", "ThrPA", "FT", "FTA", "ORB", "DRB", "AST", 
    "STL", "BLK", "TOV", "PF", "PER", "WS"
  ), 
  type = "regression",
  size = i,
  decay = j, 
  seed = 1234, 
  data_filter = "Train==1"
)

pred <- predict(result, pred_data = Nba2017_1_)

Nba2017_1_ <- store(Nba2017_1_, pred, name = "pred_nn5_point1")


result <- evalreg(
  Nba2017_1_, 
  pred = "pred_nn5_point1", 
  rvar = "Salary", 
  train = "Test", 
  data_filter = "Train==1"
)
summary(result)

size=c(size,i)
decay=c(decay,j)
rmse=c(rmse,as.numeric(gsub(",","",summary(result)[5])))
mae=c(mae,as.numeric(gsub(",","",summary(result)[6])))
}

}
cbind(size,decay,rmse,mae)
```

