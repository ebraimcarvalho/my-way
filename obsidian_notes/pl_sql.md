#### Examples of PL/SQL Statements

```sql
DECLARE
	in_books_count number;

BEGIN
	SELECT COUNT(*)
	INTO in_books_count
	FROM books
	WHERE author LIKE '%FEURSTEIN, STEVEN%';
	
	DBMS_OUTPUT.PUT_LINE(
		'Steven has written (or co-written)' ||
		in_books_count || ' books.'
	);
	
	-- Oh, and i changed my name, so...
	
	UPDATE books
		SET author = REPLACE(author, 'STEVEN', 'STEPHEN')
		WHERE author LIKE '%FEURSTEIN, STEVEN%';		
END;

-- Example of Procedure

PROCEDURE pay_out_balance (
	account_id_in IN accounts.id%TYPE)
IS
	l_balance_remaining NUMBER;
BEGIN
	LOOP
		l_balance_remaining := account_balance (account_id_in);

 		IF l_balance_remaining < 1000
 		THEN
 			EXIT;
 		ELSE
 			apply_balance (account_id_in, l_balance_remaining);
 		END IF;
 	END LOOP;
 END pay_out_balance;
 
 
-- Procedure with raise and handling errors
 
PROCEDURE check_account (
	account_id_in IN accounts.id%TYPE)
IS
	l_balance_remaining NUMBER;
	l_balance_below_minimum EXCEPTION;
	l_account_name accounts.name%TYPE;
BEGIN
	SELECT name
	INTO l_account_name
	FROM accounts
	WHERE id = account_id_in;

	l_balance_remaining := account_balance (account_id_in);

	DBMS_OUTPUT.PUT_LINE (
		'Balance for ' || l_account_name ||
		' = ' || l_balance_remaining
	);

	IF l_balance_remaining < 1000
	THEN
		RAISE l_balance_below_minimum;
	END IF;

EXCEPTION
	WHEN NO_DATA_FOUND
	THEN
		-- No account found for this ID
		log_error (...);
		RAISE;
	WHEN l_balance_below_minimum
	THEN
		log_error (...);
		RAISE VALUE_ERROR;
END;
	
```

#### Advices

- Construct test cases and test scripts before you write your code;
- Establish clear rules for how developers will write the SQL statements in application;
- Data encapsulation for be easily optimized, tested and maintained;
- Establish clear rules for hoe developers will handle exceptions in the application (Single error-handling package)
- Use top-down design (a.k.a stepwise refinement) to limit the complexity of the requirements you must deal with at any given time;
- Reward admissions of ignorance, develop a culture tha welcomes questions and requests for help;
- If you cannot figure out the source of a bug in 30 minutes, ask for help;
- Set up a formal peer code review process, don't let any code go to QA or production without being read and critiqued (in a positive, constructive manner);
- Take a creative approach, don't complain about your project/stack, be a solver problem person;


```sql
-- Example of word Count

CREATE OR REPLACE FUNCTION wordcount (str IN VARCHAR2)
	RETURN PLS_INTEGER
AS
	declare local variables here
BEGIN
	implement algorithm here
END;
/ -- runnin from SQL*PLUS, requires / at the end

SHOW ERRORS


/* 
You can also invoke many PL/SQL functions inside SQL statements. 
Here are several examples of how you can use the wordcount function: 

Apply the function in a select list to compute the number of words in a table column: 
*/

SELECT isbn, wordcount(description) FROM books;

/* 
Use the ANSI-compliant CALL statement, binding the function output to a
SQL*Plus variable, and display the result: 
*/

VARIABLE words NUMBER
CALL wordcount('some text') INTO :words;
PRINT :words

/* 
Same as above, but execute the function from a remote 
database as defined in the database link test.newyork.ora.com. 
*/

CALL wordcount@test.newyork.ora.com('some text') INTO :words;

/* 
Execute the function, owned by schema bob, while logged in to any schema that
has appropriate authorization: 
*/

SELECT bob.wordcount(description) FROM books WHERE id = 10007;

/* 
For example, to see a complete list of your programs 
(and tables, indexes, etc.), query the USER_OBJECTS view, as in: 
*/

SELECT * FROM USER_OBJECTS;

-- To give another user the authority to execute your program, issue a GRANT statement:

GRANT EXECUTE ON wordcount TO scott;

-- To remove the privilege, use REVOKE:

REVOKE EXECUTE ON wordcount FROM scott;

-- You could also grant the EXECUTE privilege to a role:

GRANT EXECUTE ON wordcount TO all_mis;

-- Or, if appropriate, you could allow any user on the current database to run the program:

GRANT EXECUTE ON wordcount TO PUBLIC;

/*
To view a list of privileges you have granted to other 
users and roles, you can query the USER_TAB_PRIVS_MADE data dictionary view.
Somewhat counterintuitively, PL/SQL program names appear in the table_name column:
*/

SELECT table_name, grantee, privilege
FROM USER_TAB_PRIVS_MADE
WHERE table_name = 'WORDCOUNT';
```
![Block PL/SQL](block_plsql.png "Block PL/SQL")

```sql
PROCEDURE remove_order (order_id IN NUMBER)
IS
BEGIN
	DELETE orders WHERE order_id = remove_order.order_id;
END;

DECLARE
	"pi" CONSTANT NUMBER := 3.141592654;
	"PI" CONSTANT NUMBER := 3.14159265358979323846;
	"2 pi" CONSTANT NUMBER := 2 * "pi";
BEGIN
	DBMS_OUTPUT.PUT_LINE('pi: ' || "pi");
	DBMS_OUTPUT.PUT_LINE('PI: ' || pi);
	DBMS_OUTPUT.PUT_LINE('2 pi: ' || "2 pi");
END;
/
/*
pi: 3.141592654
PI: 3.14159265358979323846
2 pi: 6.283185308
*/


<<outerblock>>
DECLARE
	counter INTEGER := 0;
BEGIN
	...
	DECLARE
		counter INTEGER := 1;
	BEGIN
		IF counter = outerblock.counter
		THEN
			...
		END IF;
	END;
END;


BEGIN
	<<outer_loop>>
	LOOP
		LOOP
			EXIT outer_loop;
		END LOOP;
		some_statement;
	END LOOP;
END;
```

#### Conditional and Sequential Control

```sql
IF condition
THEN
	... sequence of executable statements ...
END IF;


IF salary > 40000 OR salary IS NULL
THEN
	give_bonus (employee_id,500);
END IF;
```

Using operators such as IS NULL and IS NOT NULL or functions such as COALESCE and NVL2 are good ways to detect and deal with potentially NULL values. For every variable that you reference in every Boolean expression that you write, be sure to think carefully about the consequences if that variable is NULL.

```sql
IF salary > 40000
THEN
	INSERT INTO employee_bonus
		(eb_employee_id, eb_bonus_amt)
		VALUES (employee_id, 500);
	UPDATE emp_employee
	SET emp_bonus_given=1
	WHERE emp_employee_id=employee_id;
END IF;


IF NVL(salary,0) <= 40000
THEN
	give_bonus (employee_id, 0);
ELSE
	give_bonus (employee_id, 500);
END IF;
```

The NVL function will return zero any time salary is NULL, ensuring that any employees with a NULL salary also get a zero bonus (those poor employees).

```sql
order_exceeds_balance
	:= :customer.order_total > max_allowable_order;

/* 
Now, whenever you need to test whether an
order’s total exceeds the maximum, you can
write the following easily understandable IF statement:
*/

IF order_exceeds_balance
THEN
...


IF salary BETWEEN 10000 AND 20000
THEN
	give_bonus(employee_id, 1500);
ELSIF salary BETWEEN 20000 AND 40000
THEN
	give_bonus(employee_id, 1000);
ELSIF salary > 40000
THEN
	give_bonus(employee_id, 500);
ELSE
	give_bonus(employee_id, 0);
END IF;

-- a better way to do:

IF salary >= 10000 AND salary <= 20000
THEN
	give_bonus(employee_id, 1500);
ELSIF salary > 20000 AND salary <= 40000
THEN
	give_bonus(employee_id, 1000);
ELSIF salary > 40000
THEN
	give_bonus(employee_id, 400);
END IF;
```

#### Case statements

```sql
CASE employee_type
WHEN 'S' THEN
	award_salary_bonus(employee_id);
WHEN 'H' THEN
	award_hourly_bonus(employee_id);
WHEN 'C' THEN
	award_commissioned_bonus(employee_id);
ELSE
	RAISE invalid_employee_type;
END CASE;

/*
This CASE statement has an explicit ELSE clause; however, the ELSE is optional. When
you do not explicitly specify an ELSE clause of your own, PL/SQL implicitly uses the
following:
*/
ELSE
	RAISE CASE_NOT_FOUND;
	
/*
A searched CASE statement is a perfect fit for the problem of implementing the bonus
logic. For example:
*/

CASE
WHEN salary >= 10000 AND salary <=20000 THEN
	give_bonus(employee_id, 1500);
WHEN salary > 20000 AND salary <= 40000 THEN
	give_bonus(employee_id, 1000);
WHEN salary > 40000 THEN
	give_bonus(employee_id, 500);
ELSE
	give_bonus(employee_id, 0);
END CASE;

```

#### Case Expressions

CASE expressions take the following two forms:

```sql
Simple_Case_Expression :=
	CASE expression
	WHEN result1 THEN
		result_expression1
	WHEN result2 THEN
		result_expression2
	...
	ELSE
		result_expression_else
	END;
	
Searched_Case_Expression :=
	CASE
	WHEN expression1 THEN
		result_expression1
	WHEN expression2 THEN
		result_expression2
	...
	ELSE
		result_expression_else
	END;

```

Following is an example of a simple CASE expression being used with the DBMS_OUTPUT
package to output the value of a Boolean variable. (Recall that the PUT_LINE
program is not overloaded to handle Boolean types.) In this example, the CASE expression
converts the Boolean value into a character string, which PUT_LINE can then
handle:

```sql
DECLARE
	boolean_true BOOLEAN := TRUE;
	boolean_false BOOLEAN := FALSE;
	boolean_null BOOLEAN;
	FUNCTION boolean_to_varchar2 (flag IN BOOLEAN) RETURN VARCHAR2 IS
	BEGIN
		RETURN
			CASE flag
				WHEN TRUE THEN 'True'
				WHEN FALSE THEN 'False'
				ELSE 'NULL'
			END;
	END;
BEGIN
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_true));
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_false));
	DBMS_OUTPUT.PUT_LINE(boolean_to_varchar2(boolean_null));
END;

```

A searched CASE expression can be used to implement my bonus logic, returning the
proper bonus value for any given salary:

```sql
DECLARE
	salary NUMBER := 20000;
	employee_id NUMBER := 36325;
	PROCEDURE give_bonus (emp_id IN NUMBER, bonus_amt IN NUMBER) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE(emp_id);
		DBMS_OUTPUT.PUT_LINE(bonus_amt);
	END;
BEGIN
	give_bonus(employee_id,
		CASE
			WHEN salary >= 10000 AND salary <= 20000 THEN 1500
			WHEN salary > 20000 AND salary <= 40000 THEN 1000
			WHEN salary > 40000 THEN 500
			ELSE 0
		END);
END;

```

You can use a CASE expression anywhere you can use any other type of expression or
value. The following example uses a CASE expression to compute a bonus amount,
multiplies that amount by 10, and assigns the result to a variable that is displayed via
DBMS_OUTPUT:

```sql
DECLARE
	salary NUMBER := 20000;
	employee_id NUMBER := 36325;
	bonus_amount NUMBER;
BEGIN
	bonus_amount :=
		CASE
			WHEN salary >= 10000 AND salary <= 20000 THEN 1500
			WHEN salary > 20000 AND salary <= 40000 THEN 1000
			WHEN salary > 40000 THEN 500
			ELSE 0
		END * 10;
	DBMS_OUTPUT.PUT_LINE(bonus_amount);
END;

```

#### GOTO Statement

The GOTO statement performs unconditional branching to another executable statement
in the same execution section of a PL/SQL block.

The general format for a GOTO statement is:
`GOTO label_name;`
where label_name is the name of a label identifying the target statement. This GOTO
label is defined in the program as follows:
`<<label_name>>`

```sql
BEGIN
	GOTO second_output;
	DBMS_OUTPUT.PUT_LINE('This line will never execute.');
	<<second_output>>
	DBMS_OUTPUT.PUT_LINE('We are here!');
END;
```

There are several restrictions on the GOTO statement:

* At least one executable statement must follow a label.
* The target label must be in the same scope as the GOTO statement.
* The target label must be in the same part of the PL/SQL block as the GOTO.

Contrary to popular opinion (including mine), the GOTO statement can come in handy.
There are cases where a GOTO statement can simplify the logic in your program. On the other hand, because PL/SQL provides so many different control constructs and modularization techniques, you can almost always find a better way to do something than with a GOTO.


#### NULL Statement

```sql
IF :report_mgr.selection = 'DETAIL'
THEN
	exec_detail_report;
ELSE
	NULL; -- Do nothing
END IF;

```

In some cases, you can pair NULL with GOTO to avoid having to execute additional statements. If you ever do use GOTO, however, you should remember that when you GOTO a label, at least one executable statement must follow that label. In the following example, I use a GOTO statement to quickly move to the end of my program if the state of my data indicates that no further processing is required:

```sql
PROCEDURE process_data (data_in IN orders%ROWTYPE,
data_action IN VARCHAR2)
IS
	status INTEGER;
BEGIN
	-- First in series of validations.
	IF data_in.ship_date IS NOT NULL
	THEN
		status := validate_shipdate (data_in.ship_date);
		IF status != 0 THEN GOTO end_of_procedure; END IF;
	END IF;
	-- Second in series of validations.
	IF data_in.order_date IS NOT NULL
	THEN
		status := validate_orderdate (data_in.order_date);
		IF status != 0 THEN GOTO end_of_procedure; END IF;
	END IF;
	... more validations ...
	<<end_of_procedure>>
	NULL;
END;

```

With this approach, if I encounter an error in any single section, I use the GOTO to bypass all remaining validation checks. Because I do not have to do anything at the termination of the procedure, I place a NULL statement after the label because at least one executable statement is required there. Even though NULL does nothing, it is still an executable statement.