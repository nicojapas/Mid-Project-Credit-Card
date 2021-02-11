-- # SQL Questions - Classification
-- (Use sub queries or views wherever necessary)
-- 1. Create a database called `credit_card_classification`.
-- 2. Create a table `credit_card_data` with the same columns as given in the csv file. Please make sure you use the correct data types for each of the columns.
-- 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:
-- 4.  Select all the data from table `credit_card_data` to check if the data was imported correctly.
select * from creditcard.data;

-- 5.  Use the _alter table_ command to drop the column `q4_balance` from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
alter table creditcard.data
drop column q4_balance;

-- 6.  Use sql query to find how many rows of data you have.
select count(*) as nof_rows from creditcard.data;

-- 7.  Now we will try to find the unique values in some of the categorical columns:

--     - What are the unique values in the column `Offer_accepted`?
select distinct offer_accepted from creditcard.data;

--     - What are the unique values in the column `Reward`?
select distinct reward from creditcard.data;

--     - What are the unique values in the column `mailer_type`?
select distinct mailer_type from creditcard.data;

--     - What are the unique values in the column `credit_cards_held`?
select distinct n_credit_cards_held from creditcard.data
order by n_credit_cards_held;

--     - What are the unique values in the column `household_size`?
select distinct household_size from creditcard.data
order by household_size;

-- 8.  Arrange the data in a decreasing order by the `average_balance` of the house. Return only the `customer_number` of the top 10 customers with the highest `average_balances` in your data.
select customer_number from creditcard.data
order by average_balance desc
limit 10;

-- 9.  What is the average balance of all the customers in your data?
select round(avg(average_balance),2) as total_average_balance from creditcard.data;

-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. Note wherever `average_balance` is asked, please take the average of the column `average_balance`: <!-- 🚨🚨🚨 @himanshu - can we rephrase this? -->

--     - What is the average balance of the customers grouped by `Income Level`? The returned result should have only two columns, income level and `Average balance` of the customers. Use an alias to change the name of the second column.
select income_level, round(avg(average_balance),2) as average_balance from creditcard.data
group by income_level;

--     - What is the average balance of the customers grouped by `number_of_bank_accounts_open`? The returned result should have only two columns, `number_of_bank_accounts_open` and `Average balance` of the customers. Use an alias to change the name of the second column.
select n_bank_accounts_open, round(avg(average_balance),2) as average_balance from creditcard.data
group by n_bank_accounts_open;

--     - What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.
select credit_rating, round(avg(n_credit_cards_held),2) as average_nof_credit_cards from creditcard.data
group by credit_rating;

--     - Is there any correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select n_credit_cards_held, avg(n_bank_accounts_open) as average_nof_accounts from creditcard.data
group by n_credit_cards_held
order by n_credit_cards_held;
-- No correlation

-- 11. Your managers are only interested in the customers with the following properties:

--     - Credit rating medium or high
--     - Credit cards held 2 or less
--     - Owns their own home
--     - Household size 3 or more

--     For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them? Can you filter the customers who accepted the offers here?
select * from creditcard.data
having credit_rating in ('Medium', 'High')
and n_credit_cards_held <= 2
and own_your_home = 'Yes'
and household_size >= 3
and offer_accepted = 'Yes';

-- 12.  Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database.
-- Write a query to show them the list of such customers. You might need to use a subquery for this problem.
select *
from creditcard.data as sq1
join (
	select
	avg(average_balance) as total_average
	from creditcard.data
    ) as sq2
where sq1.average_balance < sq2.total_average
order by sq1.average_balance desc;

-- 13.  Since this is something that the senior management is regularly interested in, create a view of the same query.
create view small_average_balance as
select *
from creditcard.data as sq1
join (
	select
	avg(average_balance) as total_average
	from creditcard.data
    ) as sq2
where sq1.average_balance < sq2.total_average
order by sq1.average_balance desc;

-- 14.  What is the number of people who accepted the offer vs number of people who did not?
select count(*) as nof_clients, offer_accepted
from creditcard.data
group by offer_accepted;
    
-- 15.  Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances
-- of the customers with high credit card rating and low credit card rating?
select * from (
	select credit_rating, avg(average_balance) as total_average_balance
	from creditcard.data
	where credit_rating in ('High', 'Low')
	group by credit_rating
) as sq1
cross join
(
select max(total_average_balance) - min(total_average_balance) as difference from (
	select credit_rating, avg(average_balance) as total_average_balance
	from creditcard.data
	where credit_rating in ('High', 'Low')
	group by credit_rating
	) as sq2
) as sq3;

-- 16.  In the database, which all types of communication (`mailer_type`) were used and with how many customers?
select count(*) as nof_customers, mailer_type
from creditcard.data
group by mailer_type;

-- 17.  Provide the details of the customer that is the 11th least `Q1_balance` in your database.
select * from (
	select *,
	dense_rank () over (order by q1_balance desc) as rankedby_q1_balance
	from creditcard.data
	order by q1_balance desc
    ) as sq1
where (sq1.rankedby_q1_balance = 11);