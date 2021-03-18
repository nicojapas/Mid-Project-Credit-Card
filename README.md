# Project: Credit Cards

**Background**: We work as a risk analyst with a bank. Apart from the other banking and loan services, the bank also provides credit card services which is a very important source of revenue for the bank. The bank wants to understand the demographics and other characteristics of its customers that accept a credit card offer and that do not accept a credit card.
Usually the observational data for these kinds of problems is somewhat limited in that often the company sees only those who respond to an offer. To get around this, the bank designs a focused marketing study, with 18,000 current bank customers. This focused approach allows the bank to know who does and does not respond to the offer, and to use existing demographic data that is already available on each customer.

**Objective**: The tasks are building a model that will provide insight into why some bank customers accept credit card offers, and identifying other potential areas of opportunities that the bank wants to understand from the data.

## Tools Used

* Python, i.e. Jupyter Notebook for general analysis and coding
* Scikit-learn library for Machine Learning
* Tableau for visualization and exploration of the data
* MySQL Workbench for further data analysis

## Steps of the Process

**1. Loading Data and basic editing**

1.1 Import .csv file into a dataframe using pandas
1.2 Make column names compliant with the **underscore_separated** naming convention
1.3 SQL Queries Section

**2. Data Cleaning**

2.1 Check dataframe dtypes
2.2 Fix wrong dtypes
2.3 Deal with null values
2.4 Saving the clean dataframe into a new .csv file to use with Tableau and other software.

**3. Separate the variables into numerical and categorical**

**4. Data wrangling**

4.1 Numerical variables 
4.2 Categorical variables

**5. Standardize and encode**

5.1 Standardize numerical variables
5.2 Encode categorical variables
5.3 Put all the features together

**6. Deal with data imbalance**

**7. Test-train split**

**8. Training Predictive Models**

8.1 Logistic Regression Model
8.2 KNN Classifier
8.3 Decision Tree Classifier
8.4 Random Forest Classifier

**9. Validation of the model**

9.1 Evaluate with Confusion Matrix
9.2 Evaluate with ROC and AUC

**10. Identify Overfitting**

