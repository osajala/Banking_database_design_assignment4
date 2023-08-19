/*
    Name: Sheriff Ajala
    DTSC660: Data and Database Managment with SQL
    Module 6
    Assignment 4- PART 2
*/

------------------------------------------------------------------------------------------------
/*				                 Query 1  
Write a query to find all customers who have at least one loan and one deposit account. Include
the cust_ID, account_number, and loan_number in your results. Note: Some customers may
appear multiple times due to having multiple loans or deposit accounts. Your solution must
include a JOIN.
*/
-------------------------------------------------------------------------------------------------

SELECT b.cust_ID, d.account_number, b.loan_number
FROM borrower AS b JOIN depositor AS d
USING(cust_ID);

--SELECT c.cust_ID, d.account_number, b.loan_number
--FROM customer AS c JOIN depositor AS d
--USING(cust_ID)
--JOIN borrower AS b USING(cust_ID);

-------------------------------------------------------------------------------------------------
/*				                  Query 2         
Write a query that identifies all customers who have a deposit account in the same city in which
they live. The results should include the cust_id, customer_city, branch_city, branch_name,
and account_number. Note: The city of a deposit account is the city where its branch is
located. Your solution must use a JOIN.
*/
--------------------------------------------------------------------------------------------------

SELECT c.cust_id, c.customer_city, b.branch_city, b.branch_name, a.account_number
FROM customer c JOIN depositor d USING(cust_ID) 
JOIN account a USING(account_number) 
JOIN branch b USING(branch_name)
WHERE c.customer_city = b.branch_city;

---------------------------------------------------------------------------------------------------
/*				                  Query 3   
Write a query that returns the cust_ID and customer_name of customers who hold at least one
loan with the bank, but do not have any deposit accounts. Your solution must use a subquery
and a SET operator.
*/
---------------------------------------------------------------------------------------------------
SELECT cust_ID, customer_name
FROM customer
WHERE cust_ID IN (SELECT b.cust_ID FROM borrower b JOIN loan l USING(loan_number))

INTERSECT

SELECT cust_ID, customer_name
FROM customer
WHERE (cust_ID NOT IN (SELECT cust_ID FROM depositor));
   
--------------------------------------------------------------------------------------------------
/*				                  Query 4  
Write a query to obtain the cust_ID and customer_name for all customers residing on the
same street and in the same city as customer '12345'. Include customer '12345' in the results.
Avoid hardcoding the address for customer '12345' as their information might change. Your
solution must include a subquery.
*/
--------------------------------------------------------------------------------------------------

SELECT cust_ID, customer_name
FROM customer
WHERE customer_street = (SELECT customer_street FROM customer WHERE cust_ID = '12345') AND
	customer_city = (SELECT customer_city FROM customer WHERE cust_ID = '12345');

--------------------------------------------------------------------------------------------------
/*				                  Query 5           		  	
Write a query to retrieve a list of branch_names for every branch that has at least one
customer living in 'Harrison' that has a deposit account with them. Branch names should not be
duplicated. Your solution must include a subquery and a JOIN.
*/
--------------------------------------------------------------------------------------------------

SELECT DISTINCT bra_acct.branch_name 
FROM (SELECT * FROM branch FULL JOIN account USING(branch_name)
		FULL JOIN depositor USING(account_number)) AS bra_acct
WHERE (SELECT cust_ID IN (SELECT cust_ID FROM customer WHERE customer_city = 'Harrison'));
    
---------------------------------------------------------------------------------------------------
/*				                  Query 6           		  		         
Write a query to return each cust_ID and customer_name who has a deposit account at every
branch located in Brooklyn. Do not hardcode the Brooklyn branch names directly into your query
as these may change over time. Your solution must include a subquery.
Hint: If you're finding this question challenging, think about using SET operators. If you are still
having difficulty, you may find it useful to wait until you have completed Module 7 and utilize
techniques learned there to complete the question.
*/
---------------------------------------------------------------------------------------------------

SELECT cus_acct.cust_ID, cus_acct.customer_name
FROM (SELECT * FROM customer c FULL JOIN depositor d USING(cust_ID)
	 JOIN account USING(account_number)) AS cus_acct
WHERE cust_ID IN (SELECT cust_ID FROM account FULL JOIN depositor USING(account_number)
				  FULL JOIN branch USING(branch_name) WHERE branch_city = 'Brooklyn');

--------------------------------------------------------------------------------------------------
/*				                  Query 7           		  		          
Write a query to retrieve the loan_number, customer_name, and branch_name of customers
who have a loan at the Yonkahs Bankahs branch and whose loan amount exceeds the average
loan amount for that branch. Your solution must include a JOIN and a subquery.
HINT: Remember, money data types do note perform well with aggregation. You will have to
CAST twice here- on both sides of the comparison.
*/
--------------------------------------------------------------------------------------------------

SELECT bran_lo.loan_number, bran_lo.customer_name, bran_lo.branch_name
FROM (SELECT * FROM branch b JOIN loan l USING(branch_name) 
	  JOIN borrower bo USING(loan_number) JOIN customer c USING(cust_ID)) AS bran_lo
WHERE amount::numeric > (SELECT AVG(amount::numeric) AS avg_amount FROM loan 
						 WHERE branch_name ='Yonkahs Bankahs') AND branch_name ='Yonkahs Bankahs';	


  