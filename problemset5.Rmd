---
title: 'INFX 573: Problem Set 5 - Learning from Data'
author: "Aakash Bang"
date: 'Due: Tuesday, November 8, 2016'
output: pdf_document
header-includes:
- \newcommand{\benum}{\begin{enumerate}}
- \newcommand{\eenum}{\end{enumerate}}
- \newcommand{\bitem}{\begin{itemize}}
- \newcommand{\eitem}{\end{itemize}}
---

<!-- This syntax can be used to add comments that are ignored during knitting process. -->

##### Collaborators: 

##### Instructions: #####

Before beginning this assignment, please ensure you have access to R and RStudio. 

1. Download the `problemset5.Rmd` file from Canvas. Open `problemset5.Rmd` in RStudio and supply your solutions to the assignment by editing `problemset5.Rmd`. 

2. Replace the "Insert Your Name Here" text in the `author:` field with your own full name. Any collaborators must be listed on the top of your assignment. 

3. Be sure to include well-documented (e.g. commented) code chucks, figures and clearly written text chunk explanations as necessary. Any figures should be clearly labeled and appropriately referenced within the text. 

4. Collaboration on problem sets is acceptable, and even encouraged, but each student must turn in an individual write-up in his or her own words and his or her own work. The names of all collaborators must be listed on each assignment. Do not copy-and-paste from other students' responses or code.

5. When you have completed the assignment and have **checked** that your code both runs in the Console and knits correctly when you click `Knit PDF`, rename the R Markdown file to `YourLastName_YourFirstName_ps5.Rmd`, knit a PDF and submit the PDF file on Canvas.

##### Setup: #####

In this problem set you will need, at minimum, the following R packages.

```{r Setup, message=FALSE, warning=FALSE}
# Load standard libraries
library(tidyverse)
library(Sleuth3) # Contains data for problemset
library(UsingR) # Contains data for problemset
library(MASS) # Modern applied statistics functions
```


```{r}
Male_Births <- Sleuth3::ex0724
```
\benum
\item Davis et al. (1998) collected data on the proportion of births that were male in Denmark, the Netherlands, Canada, and the United States for selected years. Davis et al. argue that the proportion of male births is declining in these countries. We will explore this hypothesis. You can obtain this data as follows:

\bitem
\item[(a)] Use the \texttt{lm} function in \textbf{R} to fit four (one per country) simple linear regression models of the yearly proportion of males births as a function of the year and obtain the least squares fits. Write down the estimated linear model for each country.

```{r}
# Regression Line for Denmark
fit_denmark <- lm(formula = Denmark ~ Year, data = Male_Births)
fit_denmark
plot(Male_Births$Denmark ~ Male_Births$Year, xlab = "Year", ylab = "Birth Rate")
abline(fit_denmark)
```

birthrateDenmark = -4.289e-05*year + 5.987e-01

```{r}
# Regression Line for Netherlands
fit_Netherlands <- lm(formula = Netherlands ~ Year, data = Male_Births)
fit_Netherlands
plot(Male_Births$Netherlands ~ Male_Births$Year, xlab = "Year", ylab = "Birth Rate")
abline(fit_Netherlands)
```

birthrateNetherlands = -8.084e-05*year + 6.724e-01

```{r}
# Regression Line for Canada
fit_Canada <- lm(formula = Canada ~ Year, data = Male_Births)
fit_Canada
plot(Male_Births$Canada ~ Male_Births$Year, xlab = "Year", ylab = "Birth Rate")
abline(fit_Canada)
```


birthrateCanada = -0.0001112*year + 0.7337857


```{r}
# Regression Line for USA
fit_USA <- lm(formula = USA ~ Year, data = Male_Births)
fit_USA
plot(Male_Births$USA ~ Male_Births$Year, xlab = "Year", ylab = "Birth Rate")
abline(fit_USA)
```

birthrateUSA = -5.429e-05*year + 6.201e-01

\item[(b)] Obtain the $t$-statistic for the test that the slopes of the regression lines are zero, for each of the four countries. Is there evidence that the proportion of births that are male is truly declining over this period?

\eitem
```{r}
#t-statistic for Denmark
summary(fit_denmark)
#t-value = -2.073, p-value = 0.0442
```

```{r}
#t-statistic for Netherlands
summary(fit_Netherlands)
#t-value = -5.71, p-value = 9.64e-07
```

```{r}
#t-statistic for Canada
summary(fit_Canada)
#t-value = -4.017, p-value = 0.000738
```

```{r}
#t-statistic for USA
summary(fit_USA)
#t-value = -5.779, p-value = 1.44e-05
```

The t-statistic are more extreme than  -2 and +2, and p-values are less than 0.05,  suggesting that we can reject the null hypothesis (male births are not declining). In other words, male birth is declining over this period.

\item Regression was originally used by Francis Galton to study the relationship between parents and children. One relationship he considered was height. Can we predict a man's height based on the height of his father? This is the question we will explore in this problem. You can obtain data similar to that used by Galton as follows:

```{r}
# Import and look at the height data
heightData <- tbl_df(get("father.son"))
```

\bitem
\item[(a)] Perform an exploratory analysis of the dataset. Describe what you find. At a minimum you should produce statistical summaries of the variables, a visualization of the relationship of interest in this problem, and a statistical summary of that relationship. 

```{r}
#statistical summary of the variables
summary(heightData)  
```

```{r}
#visualization
ggplot(heightData, aes(fheight, sheight))+geom_point() +
labs(x = "Father's Height (inches)", y = "Son's Height (inches)")
```

It is interesting to see that as the father's height goes up, the son's height has a higher tendency to go up too. 

\item[(b)] Use the \texttt{lm} function in R to fit a simple linear regression model to predict son's height as a function of father's height.  Write down the model, $$\hat{y}_{\mbox{\texttt{sheight}}} = \hat{\beta}_0 + \hat{\beta_i} \times \mbox{\texttt{fheight}}$$ filling in estimated coefficient values and interpret the coefficient estimates. 

```{r}
#Fit a simple linear regression model
fit_sonHeight = lm(formula = sheight ~ fheight, data = heightData)
summary(fit_sonHeight)
```

```{R}
fit_sonHeight
```

As per the summary, we can write the equation for the linear model as:
sheight = 0.5141*fheight + 33.8866

For this model, the regression coefficient beta_i indicates the change in the response variable (sheight) for one unit change in the predictor variable (fheight). Thus, for an increase of 1 inch to the father's height we can expect an increase of 0.5141 inch in the son's height.
It is important to note that this equation holds for only the range of values of the data has been collected.

\item[(c)] Find the 95\% confidence intervals for the estimates. You may find the \texttt{confint()} command useful.

```{r}
#Find the 95% confidence interval

confint(fit_sonHeight, level = 0.95)
```

We can say with 95% confidence that beta_a lies between 0.4610188 and 0.5671673

\item[(d)] Produce a visualization of the data and the least squares regression line.

```{r}
# visualize relationship between fheight and sheight
plot(heightData$fheight, heightData$sheight, 
xlab = "Father's Height (inch)", ylab = "Son's Height (inch)" )   

# draw the least squares regression line
abline(fit_sonHeight)        
```

\item[(e)] Produce a visualization of the residuals versus the fitted values. (You can inspect the elements of the linear model object in R using \texttt{names()}). Discuss what you see. Do you have any concerns about the linear model?  

```{r}
names(fit_sonHeight)

residuals(fit_sonHeight)
```

```{r}
ft = lm(fit_sonHeight$residuals ~ fit_sonHeight$fitted.values)

#Visualization of the residuals
plot(fit_sonHeight$fitted.values, fit_sonHeight$residuals, 
xlab = "Fitted Values", ylab = "Residuals")  

abline(ft)
```

From the plot we can observe the plot of the fitted values and the residuals is similar to the plot between father's height and son's height. The outliers in the father's height vs son's height plot (eg. at point 68) have corresponding residual values in the above plot. Also, there is no pattern in the fitted values vs residuals plot, they roughly form a horizontal line around the 0 line which suggests the variances of the error terms are equal and no one residual stands out. Hence we can say this linear regression has highly appropriate.

My concern would be how this model will behave when the height values are outside the range of the data which was used to build this model. For example - what if the father's height is 55 inches. How accurately can we predict the son's height in this case? This model may not be ideal for this dataset

\item[(f)] Using the model you fit in part (b) predict the height was 5 males whose father are 50, 55, 70, 75, and 90 inches respectively. You may find the \texttt{predict()} function helpful.

```{r}
#Create data frame with father's heights
predict_son_height = data.frame(fheight = c(50, 55, 70, 75, 90))

#Predict son's heights
predict(fit_sonHeight, predict_son_height, interval = "predict")
```

From the fitted values we can see that the son's heights are 59.59126, 62.16172, 69.87312, 72.44358, 80.15498 when their father's heights are 50, 55, 70, 75, 90 respectively.

\eitem

\item \textbf{Extra Credit:}


![Scatterplot for Extra Credit (d).](C:\Users\AB\Desktop\INFX 573\Problem Set 5/scatterplot.png)



\bitem
\item[(a)] What assumptions are made about the distribution of the explanatory variable in the normal simple linear regression model?

There are no assumptions made about the distribution of the explanatory variable in the normal simple linear regression model. The assumptions made in linear regression are as follows:

1. All values of the dependent variable (y variable) are independent of each other.
2. For each value of X, the distribution of possible Y values is normal.
3. Linear regression needs the relationship between the independent and dependent variables to be linear.
4. Linear regression assumes that there is little or no multicollinearity in the data.  Multicollinearity occurs when the independent variables are not independent from each other. Also the error of the mean has to be independent from the independent variables.
5. Linear regression analysis requires that there is little or no autocorrelation in the data.  Autocorrelation occurs when the residuals are not independent from each other.
6. Homoscedasticity  - The error is uniform across all values of the independent variables.

\item[(b)] Why can an $R^2$ close to one not be used as evidence that the simple linear regression model is appropriate?

If an R-squared value is close to one, then the model is over-fitting the data, which means it cannot be used as evidence that the simple linear regression model is appropriate.
R squared explains what proportion of variability in the response has been explained by the regression. R squared close to 1 may indicate most of the variability in the regression has been explained whereas we might expect it to be otherwise i.e. in cases where residual errors might be large due to unmeasured factors, a R squared value closer to 0 might be closer to the truth.

\item[(c)] Consider a regression of weight on height for a sample of adult males. Suppose the intercept is 5 kg. Does this imply that males of height 0 weigh 5 kg, on average? Would this imply that the simple linear regression model is meaningless?

A regression of weight and height for a sample is for us to understand the approximate relationship between weight and height for adult males. But it only makes sense within the range of normal weight and height of adult males. Linear regression is simply a modeling frame-work. The truth is almost always much more complex than our simple line. For example, we do not know how the data outside of our limited window will behave. By applying linear regression outside of the realm of the original data is extrapolation and if we extrapolate it to a male with height 0, we are making an unreliable bet that the approximate linear relationship will be valid in places where it has not been analyzed.
However, this doesn't make the linear regression model meaningless. It holds meaning with the range of data for which it was designed but may not be extrapolated outside of that range.

\item[(d)] Suppose you had data on pairs $(X,Y)$ which gave the scatterplot been below. How would you approach the analysis?

I would take a look at the original data and try to make sense of the variables. I will try to identify what the predictor and response variables should be and whether they have been plotted accordingly. It may happen that reversing the axes might make a significant difference. 
Since we can observe 2 different fitted lines, I will try to find a grouping of the explanatory variable and consider splitting it into two separate groups to make the statistical inference more accurate.

\eitem

\eenum
