/*
    Name: Sheriff Ajala
    DTSC660: Data and Database Managment with SQL
    Module 6
    Assignment 4- PART 1
*/

--------------------------------------------------------------------------------
/*				                 Banking DDL           		  		          */
--------------------------------------------------------------------------------

--- Create a table named branch
CREATE TABLE branch (
	branch_name varchar(40), 
	branch_city varchar(40),
	assets money,
	CONSTRAINT branch_key PRIMARY KEY (branch_name),
	CONSTRAINT check_city CHECK (branch_city IN ('Brooklyn', 'Bronx', 'Manhattan','Yonkers')),
	CONSTRAINT check_assets_not_negative CHECK (assets::numeric(15,0) >= 0)
);
-- DROP TABLE branch;
--- SELECT * FROM branch;

--- Create table named customer
CREATE TABLE customer(
	cust_ID varchar(40), 
	customer_name varchar(40) NOT NULL, 
	customer_street varchar(40) NOT NULL, 
	customer_city varchar(40) NOT NULL,
	CONSTRAINT cust_ID_key PRIMARY KEY (cust_ID)
);

--- DROP TABLE customer;
--- SELECT * FROM customer;

--- create loan table
CREATE TABLE loan (
	loan_number varchar(40),
	branch_name varchar(40) REFERENCES branch (branch_name) 
	ON UPDATE CASCADE
	ON DELETE CASCADE, 
	amount money DEFAULT 0.00,
	CONSTRAINT loan_no_key PRIMARY KEY (loan_number),
	CONSTRAINT check_amount_not_negative CHECK(amount::numeric(15,2) >= 0.00)
);

--- DROP TABLE loan;
--- SELECT * FROM loan;

--- Create borrower table
CREATE TABLE borrower( 
	cust_ID varchar(40) REFERENCES customer (cust_ID) 
	ON UPDATE CASCADE 
	ON DELETE CASCADE, 
	loan_number varchar(40) REFERENCES loan (loan_number)
	ON UPDATE CASCADE 
	ON DELETE CASCADE,
	CONSTRAINT cust_loan_key PRIMARY KEY (cust_ID, loan_number)
);

--- DROP TABLE borrower;
--- SELECT * FROM borrower;

--- Create account table
CREATE TABLE account ( 
	account_number varchar(40), 
	branch_name varchar(40) REFERENCES branch (branch_name) 
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	balance money DEFAULT 0.00,
	CONSTRAINT account_number_key PRIMARY KEY (account_number)
);

--- DROP TABLE account;
--- SELECT * FROM account;

--- Create depositor table
CREATE TABLE depositor ( 
	cust_ID varchar(40) REFERENCES customer(cust_ID) 
	ON UPDATE CASCADE
	ON DELETE CASCADE, 
	account_number varchar(40) REFERENCES account(account_number) 
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT cust_account_key PRIMARY KEY(cust_ID, account_number)
);

--- DROP TABLE account;
--- SELECT * FROM depositor;

