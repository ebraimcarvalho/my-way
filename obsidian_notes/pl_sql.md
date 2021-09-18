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

#### Loop Statements

- The simple loop

It’s called simple for a reason: it starts simply with the LOOP keyword and ends with the END LOOP statement. The loop will terminate if you execute an EXIT, EXIT WHEN, or RETURN within the body of the loop (or if an exception is raised):

```sql
/* File on web: loop_examples.sql */
PROCEDURE display_multiple_years (
	start_year_in IN PLS_INTEGER
	,end_year_in IN PLS_INTEGER
)
IS
	l_current_year PLS_INTEGER := start_year_in;
BEGIN
	LOOP
		EXIT WHEN l_current_year > end_year_in;
		display_total_sales (l_current_year);
		l_current_year := l_current_year + 1;
	END LOOP;
END display_multiple_years;

```

- The For loop

Oracle offers a numeric and a cursor FOR loop. With the numeric FOR loop, you specify the start and end integer value and PL/SQL does the rest of the work for you, iterating through each intermediate value and then terminating the loop:

```sql
/* File on web: loop_examples.sql */
PROCEDURE display_multiple_years (
	start_year_in IN PLS_INTEGER
	,end_year_in IN PLS_INTEGER
)
IS
BEGIN
	FOR l_current_year IN start_year_in .. end_year_in
	LOOP
		display_total_sales (l_current_year);
	END LOOP;
END display_multiple_years;

```

##### Rules for Numeric FOR Loops

Follow these rules when you use numeric FOR loops:

* Do not declare the loop index. PL/SQL automatically and implicitly declares it as a local variable with datatype INTEGER. The scope of this index is the loop itself; you cannot reference the loop index outside the loop.
* Expressions used in the range scheme (both for lowest and highest bounds) are evaluated once, when the loop starts. The range is not reevaluated during the exe‐cution of the loop. If you make changes within the loop to the variables that you used to determine the FOR loop range, those changes will have no effect.
* Never change the values of either the loop index or the range boundary from within the loop. This is an extremely bad programming practice. PL/SQL will either produce a compile error or ignore your instructions; in either case, you’ll have problems.
* Use the REVERSE keyword to force the loop to decrement from the upper bound to the lower bound. You must still make sure that the first value in the range specification (the lowest number in lowest number .. highest number) is less than the second value. Do not reverse the order in which you specify these values when you use the REVERSE keyword.

##### Examples of Numeric FOR Loops

These examples demonstrate some variations of the numeric FOR loop syntax:

* The loop executes 10 times; loop_counter starts at 1 and ends at 10:

```sql
FOR loop_counter IN 1 .. 10
LOOP
	... executable statements ...
END LOOP;
```

* The loop executes 10 times; loop_counter starts at 10 and ends at 1:

```sql
FOR loop_counter IN REVERSE 1 .. 10
LOOP
	... executable statements ...
END LOOP;
```

* Here is a loop that doesn’t execute even once. I specified REVERSE, so the loop index, loop_counter, will start at the highest value and end with the lowest. I then mistakenly concluded that I should switch the order in which I list the highest and lowest bounds:

```sql
FOR loop_counter IN REVERSE 10 .. 1
LOOP
	/* This loop body will never execute even once! */
	... executable statements ...
END LOOP;
```

Even when you specify a REVERSE direction, you must still list the lowest bound before the highest bound. If the first number is greater than the second number, the body of the loop will not execute at all. If the lowest and highest bounds have the same value, the loop will execute just once.

* The loop executes for a range determined by the values in the variable and expression:

```sql
FOR calc_index IN start_period_number ..
	LEAST (end_period_number, current_period)
LOOP
	... executable statements ...
END LOOP;
```

In this example, the number of times the loop will execute is determined at runtime. The boundary values are evaluated once, before the loop executes, and then applied for the duration of loop execution.


##### The Cursor FOR Loop

The cursor FOR loop has the same basic structure, but in this case you supply an explicit cursor or SELECT statement in place of the low-high integer range:

```sql
/* File on web: loop_examples.sql */
PROCEDURE display_multiple_years (
	start_year_in IN PLS_INTEGER
	,end_year_in IN PLS_INTEGER
)
IS
BEGIN
	FOR sales_rec IN (
		SELECT *
		FROM sales_data
		WHERE year BETWEEN start_year_in AND end_year_in)
	LOOP
		display_total_sales (l_current_year);
	END LOOP;
END display_multiple_years;

```

You should use a cursor FOR loop whenever you need to unconditionally fetch all rows from a cursor (i.e., there are no EXITs or EXIT WHENs inside the loop that cause early termination). Let’s take a look at how you can use the cursor FOR loop to streamline your code and reduce opportunities for error.

##### Examples of Cursor FOR Loops

Suppose I need to update the bills for all pets staying in my pet hotel, the Share-a-Din-Din Inn. The following example contains an anonymous block that uses a cursor, occupancy_cur, to select the room number and pet ID number for all occupants of the Inn. The procedure update_bill adds any new changes to that pet’s room charges:

```sql
1	DECLARE
2		CURSOR occupancy_cur IS
3			SELECT pet_id, room_number
4			FROM occupancy WHERE occupied_dt = TRUNC (SYSDATE);
5		occupancy_rec occupancy_cur%ROWTYPE;
6	BEGIN
7		OPEN occupancy_cur;
8		LOOP
9			FETCH occupancy_cur INTO occupancy_rec;
10			EXIT WHEN occupancy_cur%NOTFOUND;
11				update_bill 
12					(occupancy_rec.pet_id, occupancy_rec.room_number);
13		END LOOP;
14		CLOSE occupancy_cur;
15	END;

```

This code leaves nothing to the imagination. In addition to defining the cursor (line 2), you must explicitly declare the record for the cursor (line 5), open the cursor (line 7), start up an infinite loop (line 8), fetch a row from the cursor set into the record (line 9), check for an end-of-data condition with the %NOTFOUND cursor attribute (line 10), and finally perform the update (line 11). When you are all done, you have to remember
to close the cursor (line 14).

If I convert this PL/SQL block to use a cursor FOR loop, then I have:

```sql
DECLARE
	CURSOR occupancy_cur IS
		SELECT pet_id, room_number
		FROM occupancy WHERE occupied_dt = TRUNC (SYSDATE);
BEGIN
	FOR occupancy_rec IN occupancy_cur
	LOOP
		update_bill (occupancy_rec.pet_id, occupancy_rec.room_number);
	END LOOP;
END;
```

Here you see the beautiful simplicity of the cursor FOR loop! Gone is the declaration of the record. Gone are the OPEN, FETCH, and CLOSE statements. Gone is the need to check the %NOTFOUND attribute. Gone are the worries of getting everything right. Instead, you say to PL/SQL, in effect:

> You and I both know that I want each row, and I want to dump that row into a record that matches the cursor. Take care of that for me, will you?

And PL/SQL does take care of it, just the way any modern programming language should.


##### The While loop

The WHILE loop is very similar to the simple loop; a critical difference is that it checks the termination condition up front. It may not even execute its body a single time:

```sql
/* File on web: loop_examples.sql */
PROCEDURE display_multiple_years (
	start_year_in IN PLS_INTEGER
	,end_year_in IN PLS_INTEGER
)
IS
	l_current_year PLS_INTEGER := start_year_in;
BEGIN
	WHILE (l_current_year <= end_year_in)
	LOOP
		display_total_sales (l_current_year);
		l_current_year := l_current_year + 1;
	END LOOP;
END display_multiple_years;

```

##### Terminating a Simple Loop: EXIT and EXIT WHEN

```sql
LOOP
	balance_remaining := account_balance (account_id);
	IF balance_remaining < 1000
	THEN
		EXIT;
	ELSE
		apply_balance (account_id, balance_remaining);
	END IF;
END LOOP;


LOOP
	/* Calculate the balance */
	balance_remaining := account_balance (account_id);
	
	/* Embed the IF logic into the EXIT statement */
	EXIT WHEN balance_remaining < 1000;
	
	/* Apply balance if still executing the loop */
	apply_balance (account_id, balance_remaining);
END LOOP;
```

Notice that the second form doesn’t require an IF statement to determine when it should exit. Instead, that conditional logic is embedded inside the EXIT WHEN statement. So when should you use EXIT WHEN, and when is the stripped-down EXIT more appropriate?

* EXIT WHEN is best used when there is a single conditional expression that determines whether or not a loop should terminate. The previous example demonstrates this scenario clearly.
* In situations with multiple conditions for exiting or when you need to set a “return value” coming out of the loop based on different conditions, you are probably better off using an IF or CASE statement, with EXIT statements in one or more of the clauses.

The following example demonstrates a preferred use of EXIT. It is taken from a function
that determines if two files are equal (i.e., contain the same content):
```sql

	...
	IF (end_of_file1 AND end_of_file2)
	THEN
		retval := TRUE;
		EXIT;
	ELSIF (checkline != againstline)
	THEN
		retval := FALSE;
		EXIT;
	ELSIF (end_of_file1 OR end_of_file2)
	THEN
		retval := FALSE;
		EXIT;
	END IF;
END LOOP;
```

##### The Intentionally Infinite Loop

Some programs, such as system monitoring tools, are not designed to be executed on demand but should always be running. In such cases, you may actually want to use an infinite loop:

```sql
LOOP
	data_gathering_procedure;
END LOOP;
```

Here, data_gathering_procedure goes out and, as you’d guess, gathers data about the system. As anyone who has accidentally run such an infinite loop can attest, it’s likely that the loop will consume large portions of the CPU. The solution for this, in addition to ensuring that your data gathering is performed as efficiently as possible, is to pause between iterations:

```sql
LOOP
	data_gathering_procedure;
	DBMS_LOCK.sleep(10); -- do nothing for 10 seconds
END LOOP;
```

##### Terminating an Intentionally Infinite Loop

The best solution that I’ve come up with is to insert into the loop a kind of “command interpreter” that uses the database’s built-in interprocess communication, known as a database pipe:

```sql
DECLARE
	pipename CONSTANT VARCHAR2(12) := 'signaler';
	result INTEGER;
	pipebuf VARCHAR2(64);
BEGIN
	/* create private pipe with a known name */
	result := DBMS_PIPE.create_pipe(pipename);
	LOOP
		data_gathering_procedure;
		DBMS_LOCK.sleep(10);
		/* see if there is a message on the pipe */
		IF DBMS_PIPE.receive_message(pipename, 0) = 0
		THEN
			/* interpret the message and act accordingly */
			DBMS_PIPE.unpack_message(pipebuf);
			EXIT WHEN pipebuf = 'stop';
		END IF;
	END LOOP;
END;

```

The DBMS_PIPE calls should have little impact on the overall CPU load.
A simple companion program can then kill the looping program by sending a “stop” message down the pipe:

```sql
DECLARE
	pipename VARCHAR2 (12) := 'signaler';
	result INTEGER := DBMS_PIPE.create_pipe (pipename);
BEGIN
	DBMS_PIPE.pack_message ('stop');
	result := DBMS_PIPE.send_message (pipename);
END;
```


##### Loop Labels

```sql
<<year_loop>>
WHILE year_number <= 1995
LOOP
	<<month_loop>>
	FOR month_number IN 1 .. 12
	LOOP
		...
	END LOOP month_loop;
	year_number := year_number + 1;
END LOOP year_loop;
```

The loop label is potentially useful in several ways:

* When you have written a loop with a large body (say, one that starts at line 50, ends on line 725, and has 16 nested loops inside it), use a loop label to tie the end of the loop back explicitly to its start. This visual tag will make it easier for a developer to maintain and debug the program. Without the loop label, it can be very difficult to keep track of which LOOP goes with which END LOOP.
* You can use the loop label to qualify the name of the loop indexing variable (either a record or a number). Again, this can be helpful for  readability. Here is an example:

```sql
<<year_loop>>
FOR year_number IN 1800..1995
LOOP
	<<month_loop>>
	FOR month_number IN 1 .. 12
	LOOP
		IF year_loop.year_number = 1900 THEN ... END IF;
	END LOOP month_loop;
END LOOP year_loop;
```

* When you have nested loops, you can use the label both to improve readability and to increase control over the execution of your loops. You can, in fact, stop the execution of a specific named outer loop by adding a loop label after the EXIT keyword in the EXIT statement of a loop, as follows:

`EXIT loop_label;`
`EXIT loop_label WHEN condition;`

While it is possible to use loop labels in this fashion, I recommend that you avoid it. It leads to very unstructured logic (quite similar to GOTOs) that is hard to debug. If you feel that you need to insert code like this, you should consider restructuring your loop, and possibly switching from a FOR loop to a simple or WHILE loop.


#### The CONTINUE Statement

Use this statement to exit the current iteration of a loop, and immediately continue on to the next iteration of that loop.

```sql
BEGIN
	FOR l_index IN 1 .. 10
	LOOP
		CONTINUE WHEN MOD (l_index, 2) = 0;
		DBMS_OUTPUT.PUT_LINE ('Loop index = ' || TO_CHAR (l_index));
	END LOOP;
END;
/
```

The output is:
Loop index = 1
Loop index = 3
Loop index = 5
Loop index = 7
Loop index = 9

You can also use CONTINUE to terminate an inner loop and proceed immediately to the next iteration of an outer loop’s body. To do this, you will need to give names to your loops using labels. Here is an example:

```sql
BEGIN
	<<outer>>
	FOR outer_index IN 1 .. 5
	LOOP
		DBMS_OUTPUT.PUT_LINE (
			'Outer index = ' || TO_CHAR (outer_index));
		<<inner>>
		FOR inner_index IN 1 .. 5
		LOOP
			DBMS_OUTPUT.PUT_LINE (
			' Inner index = ' || TO_CHAR (inner_index));
			CONTINUE outer;
		END LOOP inner;
	END LOOP outer;
END;
/
```

The  output is:
Outer index = 1
Inner index = 1
Outer index = 2
Inner index = 1
Outer index = 3
Inner index = 1
Outer index = 4
Inner index = 1
Outer index = 5
Inner index = 1

```sql
-- best practices with continue statement

LOOP
	EXIT WHEN exit_condition_met;
	CONTINUE WHEN condition1;
	CONTINUE WHEN condition2;
	setup_steps_here;
	IF condition4 THEN
		action4_executed;
		CONTINUE;
	END IF;
	IF condition5 THEN
		action5_executed;
		CONTINUE; -- Not strictly required.
	END IF;
END LOOP;
```

#### Tips for Iterative Processing

* Use understandable Names for Loop Indexes

Use names that self-document the purposes of variables and loops. That way, other people will understand your code, and you will remember
what your own code does when you review it three months later.

* The proper way to say goodbye

One important and fundamental principle in structured programming is “one way in, one way out”; that is, a program should have a single point of entry and a single point of exit. A single point of entry is not an issue with PL/SQL: no matter what kind of loop you are using, there is always only one entry point into the loop—the first executable statement following the LOOP keyword. It is quite possible, however, to construct loops that have multiple exit paths. Avoid this practice. Having multiple ways of terminating a loop results in code that is much harder to debug and maintain.

* Do not use EXIT or EXIT WHEN statements within FOR and WHILE loops. You should use a FOR loop only when you want to iterate through all the values (integer or record) specified in the range. An EXIT inside a FOR loop disrupts this process and subverts the intent of that structure. A WHILE loop, on the other hand, specifies its termination condition in the WHILE statement itself.

* Do not use the RETURN or GOTO statements within a loop—again, these cause the premature, unstructured termination of the loop. It can be tempting to use these constructs because in the short run they appear to reduce the amount of time spent writing code. In the long run, however, you (or the person left to clean up your mess) will spend more time trying to understand, enhance, and fix your code over time.

##### Obtaining Information About FOR Loop Execution

```sql
DECLARE
	book_count PLS_INTEGER := 0;
BEGIN
	FOR book_rec IN books_cur (author_in => 'FEUERSTEIN,STEVEN')
	LOOP
		... process data ...
		book_count := books_cur%ROWCOUNT;
	END LOOP;
	IF book_count > 10 THEN ...
```

#### SQL Statement as Loop

I need to write a program to move the information for pets who have checked out of
the pet hotel from the occupancy table to the occupancy_history table.

```sql
DECLARE
	CURSOR checked_out_cur IS
		SELECT pet_id, name, checkout_date
		FROM occupancy WHERE checkout_date IS NOT NULL;
BEGIN
	FOR checked_out_rec IN checked_out_cur
	LOOP
		INSERT INTO occupancy_history (pet_id, name, checkout_date)
		VALUES (checked_out_rec.pet_id, checked_out_rec.name,
		checked_out_rec.checkout_date);
		DELETE FROM occupancy WHERE pet_id = checked_out_rec.pet_id;
	END LOOP;
END;
```

This code does the trick. But was it necessary to do it this way? I can express precisely the same logic and get the same result with nothing more than an INSERT-SELECT FROM followed by a DELETE, as shown here:

```sql
BEGIN
	INSERT INTO occupancy_history (pet_id, NAME, checkout_date)
		SELECT pet_id, NAME, checkout_date
		FROM occupancy WHERE checkout_date IS NOT NULL;
	DELETE FROM occupancy WHERE checkout_date IS NOT NULL;
END;
```

What are the advantages to this approach? I have written less code, and my code will run more efficiently because I have reduced the number of context switches (moving back and forth between the PL/SQL and SQL execution engines). I execute just a single INSERT and a single DELETE.

PL/SQL offers more flexibility as well. Suppose, for example, that I want to transfer as many of the rows as possible, and simply write a message to the error log for any transfers of individual rows that fail. In this case, I really do need to rely on the cursor FOR loop, but with the added functionality of an exception section:

```sql
BEGIN
	FOR checked_out_rec IN checked_out_cur
	LOOP
		BEGIN
			INSERT INTO occupancy_history ...
			DELETE FROM occupancy ...
		EXCEPTION
			WHEN OTHERS THEN
				log_checkout_error (checked_out_rec);
		END;
	END LOOP;
END;
;
```

#### Exception Handlers

In the PL/SQL language, errors of any kind are treated as exceptions—situations that should not occur—in your program. The exception handler mechanism allows you to cleanly separate your error-processing code from your executable statements. It also provides an event-driven model, as opposed to a linear code model, for processing errors. In other words, no matter how a particular exception is raised, it is handled by the same exception handler in the exception section. The processing in the current PL/SQL block’s execution section halts, and control is transferred to the separate exception section of the current block, if one exists, to handle the exception. You cannot return to that block after you finish handling the exception.

![Exception Handler](exception_handler.png "Exception Handler")


##### Declariong Named Exceptions

Your program might need to trap and handle errors such as “negative balance in account”
or “call date cannot be in the past.” While different in nature from “division by zero,” these errors are still exceptions to normal processing and should be handled gracefully by your program. You must do so yourself by declaring an exception in the declaration section of your
PL/SQL block. You declare an exception by listing the name of the exception you want
to raise in your program followed by the keyword EXCEPTION:

`exception_name EXCEPTION;`

```sql
PROCEDURE calc_annual_sales
	(company_id_in IN company.company_id%TYPE)
IS
	invalid_company_id EXCEPTION;
	negative_balance EXCEPTION;
	duplicate_company BOOLEAN;
BEGIN
	... body of executable statements ...
EXCEPTION
	WHEN NO_DATA_FOUND -- system exception
	THEN
		...
	WHEN invalid_company_id
	THEN
	
	WHEN negative_balance
	THEN
		...
END;
```

The names for exceptions are similar in format to (and “read” just like) Boolean variable names, but can be referenced in only two ways:

*  In a RAISE statement in the execution section of the program (to raise the exception), as in:

`RAISE invalid_company_id;`

* In the WHEN clauses of the exception section (to handle the raised exception), as in:

`WHEN invalid_company_id THEN`


##### Using EXCEPTION_INIT

EXCEPTION_INIT is a compile-time command or pragma used to associate a name with an internal error code. EXCEPTION_INIT instructs the compiler to associate an identifier, declared as an EXCEPTION, with a specific error number. Once you have made that association, you can then raise that exception by name and write an explicit WHEN handler that traps the error.

```sql
PROCEDURE my_procedure
IS
	invalid_month EXCEPTION;
	PRAGMA EXCEPTION_INIT (invalid_month, −1843);
BEGIN
	...
EXCEPTION
	WHEN invalid_month THEN
```

Let’s look at another example. In the following program code, I declare and associate an exception for this error:

```sql
ORA-2292 integrity constraint (OWNER.CONSTRAINT) violated - 
child record found.
```

This error occurs if I try to delete a parent row while it still has existing child rows. (A child row is a row with a foreign key reference to the parent table.) The code to declare the exception and associate it with the error code looks like this:

```sql
PROCEDURE delete_company (company_id_in IN NUMBER)
IS
	/* Declare the exception. */
	still_have_employees EXCEPTION;
	/* Associate the exception name with an error number. */
	PRAGMA EXCEPTION_INIT (still_have_employees, −2292);
BEGIN
	/* Try to delete the company. */
	DELETE FROM company
	WHERE company_id = company_id_in;
EXCEPTION
	/* If child records were found, this exception is raised! */
	WHEN still_have_employees
	THEN
		DBMS_OUTPUT.PUT_LINE
			('Please delete employees for company first.');
END;
```

Recommend that you centralize your usage of EXCEPTION_INIT into packages so that the definitions of exceptions are not scattered throughout your code. I don’t want to have to remember what the code is for this error, and it would be silly to define my pragmas in 20 different programs. So instead I predefine my own system exceptions in my own dynamic SQL package:

```sql
CREATE OR REPLACE PACKAGE dynsql
IS
	invalid_table_name EXCEPTION;
		PRAGMA EXCEPTION_INIT (invalid_table_name, −903);
	invalid_identifier EXCEPTION;
		PRAGMA EXCEPTION_INIT (invalid_identifier, −904);
```

and now I can trap for these errors in any program as follows:

`WHEN dynsql.invalid_identifier THEN ...`

Avoid hardcoding these literals directly into your application; instead, build (or generate) a package that assigns names to those error numbers. Here is an example of such a package:

```sql
PACKAGE errnums
IS
	en_too_young CONSTANT NUMBER := −20001;
	exc_too_young EXCEPTION;
	PRAGMA EXCEPTION_INIT (exc_too_young, −20001);
	en_sal_too_low CONSTANT NUMBER := −20002;
	exc_sal_too_low EXCEPTION;
	PRAGMA EXCEPTION_INIT (exc_sal_too_low , −20002);
END errnums;
```

By relying on such a package, I can write code like the following, without embedding the actual error number in the logic:
```sql
PROCEDURE validate_emp (birthdate_in IN DATE)
IS
	min_years CONSTANT PLS_INTEGER := 18;
BEGIN
	IF ADD_MONTHS (SYSDATE, min_years * 12 * −1) < birthdate_in
	THEN
		RAISE_APPLICATION_ERROR
		(errnums.en_too_young,
		'Employee must be at least ' || min_years || ' old.');
	END IF;
END;
```

Suppose that your program generates an unhandled exception for error ORA-6511. Looking up this error, you find that it is associated with the CURSOR_ALREADY_OPEN exception. Locate thePL/SQL block in which the  error occurs and add an exception handler for CURSOR_ALREADY_OPEN, as shown here:

```sql
EXCEPTION
	WHEN CURSOR_ALREADY_OPEN
	THEN
		CLOSE my_cursor;
END;
```

Of course, you would be even better off analyzing your code to determine proactively
which of the predefined exceptions might occur. You could then decide which of those exceptions you want to handle specifically, which should be covered by the WHEN OTHERS clause (discussed later in this chapter), and which would best be left unhandled.

Consider the following example of the exception overdue_balance declared in the procedure
check_account. The scope of that exception is the check_account procedure, and nothing else:

```sql
PROCEDURE check_account (company_id_in IN NUMBER)
IS
	overdue_balance EXCEPTION;
BEGIN
	... executable statements ...
	LOOP
		...
		IF ... THEN
		RAISE overdue_balance;
		END IF;
	END LOOP;
EXCEPTION
	WHEN overdue_balance THEN ...
END;

```

I can RAISE the overdue_balance inside the check_account procedure, but I cannot raise that exception from a program that calls check_account. Any identifiers—including exceptions—declared inside check_account are invisible outside of that program.

##### The RAISE Statement 

The RAISE statement can take one of three forms:

```sql
RAISE exception_name;
RAISE package_name.exception_name;
RAISE;
```

```sql
DECLARE
	invalid_id EXCEPTION; -- All IDs must start with the letter 'X'.
	id_value VARCHAR2(30);
BEGIN
	id_value := id_for ('SMITH');
	IF SUBSTR (id_value, 1, 1) != 'X'
	THEN
		RAISE invalid_id;
	END IF;
	...
END;

-- and then raising a system exception:

BEGIN
	IF total_sales = 0
	THEN
		RAISE ZERO_DIVIDE; -- Defined in STANDARD package
	ELSE
		RETURN (sales_percentage_calculation (my_sales, total_sales));
	END IF;
END;


-- exception declared inside a package

IF days_overdue (isbn_in, borrower_in) > 365
THEN
	RAISE overdue_pkg.book_is_lost;
END IF;
```

##### Using RAISE_APPLICATION_ERROR

The advantage of using RAISE_APPLICATION_ERROR instead of RAISE (which can also raise an application-specific, explicitly declared exception) is that you can associate an error message with the exception.

Here’s the header for this procedure (defined in package DBMS_STANDARD):

```sql
PROCEDURE RAISE_APPLICATION_ERROR (
	num binary_integer,
	msg varchar2,
	keeperrorstack boolean default FALSE);
```

where num is the error number and must be a value between −20,999 and −20,000 (just think: Oracle needs all the rest of those negative integers for its own exceptions!); msg is the error message and must be no more than 2,000 characters in length (any text beyond that limit will be ignored); and keeperrorstack indicates whether you want to add the error to any already on the stack (TRUE) or replace the existing errors (the default, FALSE).

```sql
PROCEDURE raise_by_language (code_in IN PLS_INTEGER)
IS
	l_message error_table.error_string%TYPE;
BEGIN
	SELECT error_string
	INTO l_message
	FROM error_table
	WHERE error_number = code_in
	AND string_language = USERENV ('LANG');
	RAISE_APPLICATION_ERROR (code_in, l_message);
END;
```

##### Handling Exceptions

```sql
DECLARE
	... declarations ...
BEGIN
	... executable statements ...
[ EXCEPTION
	... exception handlers ... ]
END;

-- The syntax for an exception handler is as follows:

WHEN exception_name [ OR exception_name ... ]
THEN executable statements
```

Example:

```sql
CREATE OR REPLACE PROCEDURE proc1 IS
BEGIN
	DBMS_OUTPUT.put_line ('running proc1');
	RAISE NO_DATA_FOUND;
END;
/

CREATE OR REPLACE PROCEDURE proc2 IS
	l_str VARCHAR2 (30) := 'calling proc1';
BEGIN
	DBMS_OUTPUT.put_line (l_str);
	proc1;
END;
/

CREATE OR REPLACE PROCEDURE proc3 IS
BEGIN
	DBMS_OUTPUT.put_line ('calling proc2');
	proc2;
EXCEPTION
	WHEN OTHERS
	THEN
		DBMS_OUTPUT.put_line ('Error stack at top level:');
		DBMS_OUTPUT.put_line (DBMS_UTILITY.format_error_backtrace);
END;
/

SQL> SET SERVEROUTPUT ON
SQL> BEGIN
2 DBMS_OUTPUT.put_line ('Proc3 -> Proc2 -> Proc1 backtrace');
3 proc3;
4 END;
5 /
```

Output:

Proc3 -> Proc2 -> Proc1 backtrace
calling proc2
calling proc1
running proc1
Error stack at top level:
ORA-06512: at "SCOTT.PROC1", line 4
ORA-06512: at "SCOTT.PROC2", line 5
ORA-06512: at "SCOTT.PROC3", line 4

You can, within a single WHEN clause, combine multiple exceptions together with an OR operator, just as you would combine multiple Boolean expressions:

```sql
WHEN invalid_company_id OR negative_balance
THEN
```

You can also combine application and system exception names in a single handler:

```sql
WHEN balance_too_low OR ZERO_DIVIDE OR DBMS_LDAP.INVALID_SESSION
THEN
```

You cannot, however, use the AND operator because only one exception can be raised at a time.

#### Example of exception propagation

![Exception Propagation](exception_propagation.png "Exception Proagation")

![Exception Propagation 2](exception_propagation_2.png "Exception Proagation 2")


##### Continue past exceptions

Consider the following scenario: I need to write a procedure that performs a series of DML statements against a variety of tables (delete from one table, update another, insert into a final table). My first pass at writing this  rocedure might produce code like the following:

```sql
PROCEDURE change_data IS
BEGIN
	DELETE FROM employees WHERE ... ;
	UPDATE company SET ... ;
	INSERT INTO company_history SELECT * FROM company WHERE ... ;
END;
```

This procedure certainly contains all the appropriate DML statements. But one of the requirements for this program is that, although these statements are executed in sequence, they are logically independent of each other. In other words, even if the DELETE fails, I want to go on and perform the UPDATE and INSERT.

With the current version of change_data, I can’t make sure that all three DML statements will at least be attempted. If an exception is raised from the DELETE, for example, the entire program’s execution will halt, and control will be passed to the exception section, if there is one. The remaining SQL statements won’t be executed.

How can I get the exception to be raised and handled without terminating the program as a whole? The solution is to place the DELETE within its own PL/SQL block. Consider this next version of the change_data program:

```sql
PROCEDURE change_data IS
BEGIN
	BEGIN
		DELETE FROM employees WHERE ... ;
	EXCEPTION
		WHEN OTHERS THEN log_error;
	END;
	
	BEGIN
		UPDATE company SET ... ;
	EXCEPTION
		WHEN OTHERS THEN log_error;
	END;
	
	BEGIN
		INSERT INTO company_history SELECT * FROM company WHERE ... ;
	EXCEPTION
		WHEN OTHERS THEN log_error;
	END;
END;
```


#### Building an Effective Error Management Architecture

Here are the some of the challenges you will encounter:


* The EXCEPTION is an odd kind of structure in PL/SQL. A variable declared to be EXCEPTION can only be raised and handled. It has at most two characteristics: an error code and an error message. You cannot pass an exception as an argument to a program; you cannot associate other attributes with an exception.

* It is very difficult to reuse exception-handling code. Directly related to the previous challenge is another fact: you cannot pass an exception as an argument; you end up cutting and pasting handler code, which is certainly not an optimal way to write programs.
* There is no formal way to specify which exceptions a program may raise. With Java, on the other hand, this information becomes part of the specification of the program. The consequence is that you must look inside the program implementation to see what might be raised—or hope for the best.
* Oracle does not provide any way for you to organize and categorize your application-specific exceptions. It simply sets aside (for the most part) the 1,000 error codes between −20,999 and −20,000. You are left to manage those values.

It is extremely important that you establish a consistent strategy and architecture for error handling in your application before you write any code. To do that, you must answer questions like these:

* How and when do I log errors so that they can be reviewed and corrected? Should I write information to a file, to a database table, and/or to the screen?
* How and when do I report the occurrence of errors back to the user? How much information should the user see and have to keep track of? How do I transform often obscure database error messages into text that is understandable to my users?
* Should I include an exception-handling section in every one of my PL/SQL blocks?
* Should I have an exception-handling section only in the top-level or outermost blocks?
* How should I manage my transactions when errors occur?


Here are some general principles you may want to consider:

* When an error occurs in your code, obtain as much information as possible about the context in which the error was raised. You are better off with more information than you really need, rather than with less. You can then propagate the exception to outer blocks, picking up more information as you go.
* Avoid hiding errors with handlers that look like WHEN error THEN NULL; (or, even worse, WHEN OTHERS THEN NULL;). There may be a good reason for you to write code like this, but make sure it is really what you want and document the usage so that others will be aware of it.
* Rely on the default error mechanisms of PL/SQL whenever possible. Avoid writing programs that return status codes to the host environment or calling blocks. The only time you will want to use status codes is if the host environment cannot gracefully handle Oracle errors (in which case, you might want to consider switching your host environment!).

I suggest that you meet this challenge by taking the following steps:

1. Study and understand how error raising and handling work in PL/SQL. It is not all completely intuitive. A prime example: an exception raised in the declaration section will not be handled by the exception section of that block.
2. Decide on the overall error management approach you will take in your application. Where and when do you handle errors? What information do you need to save, and how will you do that? How are exceptions propagated to the host environment? How will you handle deliberate, unfortunate, and unexpected errors?
3. Build a standard framework to be used by all developers; that framework will include underlying tables, packages, and perhaps object types, along with a welldefined process for using these elements. Don’t resign yourself to PL/SQL’s limitations. Work around them by enhancing the error management model.
4. Create templates that everyone on your team can use, making it easier to follow the standard than to write one’s own error-andling code.


#### Program Data PL/SQL


##### How declare program data

Naming Your Program Data:

1. Ensure that each name accurately reflects its usage and is understandable at a glance
2. Establish consistent, sensible naming conventions


##### Declaring a Variable

```sql
DECLARE
	-- Simple declaration of numeric variable
	l_total_count NUMBER;
	-- Declaration of number that rounds to nearest hundredth (cent):
	l_dollar_amount NUMBER (10,2);
	-- A single datetime value, assigned a default value of the database
	-- server's system clock. Also, it can never be NULL.
	l_right_now DATE NOT NULL DEFAULT SYSDATE;
	-- Using the assignment operator for the default value specification
	l_favorite_flavor VARCHAR2(100) := 'Anything with chocolate, actually';
	-- Two-step declaration process for associative array.
	-- First, the type of table:
	TYPE list_of_books_t IS TABLE OF book%ROWTYPE INDEX BY BINARY_INTEGER;
	-- And now the specific list to be manipulated in this block:
	oreilly_oracle_books list_of_books_t;

```

The DEFAULT syntax (see l_right_now in the previous example) and the assignment operator syntax (see l_favorite_flavor in the previous example) are equivalent and can be used interchangeably. So which should you use? I like to use the assignment operator (:=) to set default values for constants, and the DEFAULT syntax for variables. In the case of a constant, the assigned value is not really a default but an initial (and unchanging) value, so the DEFAULT syntax feels misleading to me.


##### Declaring Constants


There are just two differences between declaring a variable and declaring a constant: for a constant, you include the CONSTANT keyword, and you must supply a default value (which isn’t really a default at all, but rather is the only value). So, the syntax for the declaration of a constant is:

`name CONSTANT datatype [NOT NULL] := | DEFAULT default_value;`

Here are some examples of declarations of constants:

```sql
DECLARE
	-- The current year number; it's not going to change during my session.
	l_curr_year CONSTANT PLS_INTEGER :=
	TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
	-- Using the DEFAULT keyword
	l_author CONSTANT VARCHAR2(100) DEFAULT 'Bill Pribyl';
	-- Declare a complex datatype as a constant-
	-- this isn't just for scalars!
	l_steven CONSTANT person_ot :=
		person_ot ('HUMAN', 'Steven Feuerstein', 175,
			TO_DATE ('09-23-1958', 'MM-DD-YYYY') );
```


##### The NOT NULL Clause

`company_name VARCHAR2(60) NOT NULL DEFAULT 'PCS R US';`


##### Anchored Declarations


PL/SQL offers two kinds of anchoring:

* Scalar anchoring
Use the %TYPE attribute to define your variable based on a table’s column or some other PL/SQL scalar variable.

`l_company_id company.company_id%TYPE;`

* Record anchoring
Use the %ROWTYPE attribute to define your record structure based on a table or a predefined PL/SQL explicit cursor.

`l_book book%ROWTYPE;`

Suppose that I want to query a single row of information from the book table. Rather than declare individual variables for each column in the table (which, of course, I should do with %TYPE), I can simply rely on %ROWTYPE:

```sql
DECLARE
	l_book book%ROWTYPE;
BEGIN
	SELECT * INTO l_book
	FROM book
	WHERE isbn = '1-56592-335-9';
	process_book (l_book);
END;
```


You can also anchor against PL/SQL variables; this is usually done to avoid redundant declarations of the same hardcoded datatype. In this case, the best practice is to create a “reference” variable in a package and then reference that package variable in %TYPE statements. (You could also create SUBTYPEs in your package; this topic is covered later in the chapter.) The following example shows just a portion of a package intended to make it easier to work with Oracle Advanced Queuing (AQ):

```sql
/* File on web: aq.pkg */
PACKAGE aq
IS
/* Standard datatypes for use with Oracle AQ. */
	v_msgid RAW (16);
	SUBTYPE msgid_type IS v_msgid%TYPE;
	v_name VARCHAR2 (49);
	SUBTYPE name_type IS v_name%TYPE;
	...
END aq;
```

Suppose now that I only want to retrieve the author and title from the book table. In this case, I build an explicit cursor and then %ROWTYPE against that cursor:

```sql
DECLARE
	CURSOR book_cur IS
		SELECT author, title FROM book
		WHERE isbn = '1-56592-335-9';
	l_book book_cur%ROWTYPE;
BEGIN
	OPEN book_cur;
	FETCH book_cur INTO l_book; END;
```


##### Benefits of Anchored Declarations

* Synchronization with database columns
The PL/SQL variable “represents” database information in the program. If I declare explicitly and then change the structure of the underlying table, my program may not work properly.

* Normalization of local variables
The PL/SQL variable stores calculated values used throughout the application. What are the consequences of repeating (hardcoding) the same datatype and constraint for each declaration in all of our programs?


##### Anchoring to NOT NULL Datatypes

```sql
DECLARE
	max_available_date DATE NOT NULL :=
	ADD_MONTHS (SYSDATE, 3);
	last_ship_date max_available_date%TYPE;

/* 
The declaration of last_ship_date then fails to compile, with the following message:
*/

PLS_00218: a variable declared NOT NULL must have an initialization assignment.
```

If you use a NOT NULL variable in a %TYPE declaration, the new variable must have a default value provided. The same is not true, however, for variables declared with %TYPE where the source is a database column defined as NOT NULL. A NOT NULL constraint from a database table is not automatically transferred to a variable.


##### Programmer-Defined Subtypes

There are two kinds of subtypes, constrained and unconstrained:

* Constrained subtype
A subtype that restricts or constrains the values normally allowed by the datatype itself. POSITIVE is an example of a constrained subtype of BINARY_ INTEGER.

```sql
SUBTYPE POSITIVE IS BINARY_INTEGER RANGE 1 .. 2147483647;
```

A variable that is declared POSITIVE can store only integer values greater than zero.

* Unconstrained subtype
A subtype that does not restrict the values of the original datatype in variables declared with the subtype. FLOAT is an example of an unconstrained subtype of NUMBER. Its definition in the STANDARD package is:

`SUBTYPE FLOAT IS NUMBER;`

To make a subtype available, you first have to declare it in the declaration section of an anonymous PL/SQL block, procedure, function, or package. You’ve already seen the syntax for declaring a subtype used by PL/SQL in the STANDARD package. The general format of a subtype declaration is:

`SUBTYPE subtype_name IS base_type;`

where subtype_name is the name of the new subtype, and base_type is the datatype on which the subtype is based.

Example:

```sql
PACKAGE utility
AS
	SUBTYPE big_string IS VARCHAR2(32767);
	SUBTYPE big_db_string IS VARCHAR2(4000);
END utility;
```


#### Strings

Fixed-length Variable-length
Database character set CHAR VARCHAR2
National character set NCHAR NVARCHAR2

You will rarely need or want to use the fixed-length CHAR and NCHAR datatypes in Oracle-based applications; in fact, I recommend that you never use these types unless there is a specific requirement for fixed-length strings.


##### VARCHAR2

`variable_name VARCHAR2 (max_length [CHAR | BYTE]);`

If you omit the CHAR or BYTE qualifier when declaring a VARCHAR2 variable, then whether the size is in characters or bytes depends on the NLS_LENGTH_SEMANTICS initialization parameter. You can determine your current setting by querying NLS_SESSION_PARAMETERS.

Examples:

```sql
DECLARE
	small_string VARCHAR2(4);
	line_of_text VARCHAR2(2000);
	feature_name VARCHAR2(100 BYTE); -- 100-byte string
	emp_name VARCHAR2(30 CHAR); -- 30-character string
```

The maximum length allowed for PL/SQL VARCHAR2 variables is 32,767 bytes. Note, however, that SQL supports this maximum size only if the MAX_SQL_STRING_SIZE initialization parameter is set to EXTENDED; the default value is STANDARD.


##### Specifying String Constants

```sql
-- 'Brighten the corner where you are.'
-- 'Aren''t you glad you''re learning PL/SQL with O''Reilly?'
-- q'!Aren't you glad you're learning PL/SQL with O'Reilly?!'
-- q'{Aren't you glad you're learning PL/SQL with O'Reilly?}'
```

##### Using Nonprintable Characters

The built-in CHR function is especially valuable when you need to make reference to a nonprintable character in your code. Suppose you have to build a report that displays the address of a company. A company can have up to four address strings (in addition to city, state, and zip code). Your boss wants each address string to start on a new line. You can do that by concatenating all the address lines together into one long text value and using CHR to insert linefeeds where desired. The location in the standard ASCII collating sequence for the linefeed character is 10, so you can code:

```sql
SELECT name || CHR(10)
	|| address1 || CHR(10)
	|| address2 || CHR(10)
	|| city || ', ' || state || ' ' || zipcode
	AS company_address
FROM company
```

The results will end up looking like: 
COMPANY_ADDRESS
|----------------------
Harold Henderson
22 BUNKER COURT

WYANDANCH, MN 66557

What? You say your boss doesn’t want to see any blank lines? No problem. You can eliminate those with a bit of cleverness involving the NVL2 function:

```sql
SELECT name
	|| NVL2(address1, CHR(10) || address1, '')
	|| NVL2(address2, CHR(10) || address2, '')
	|| CHR(10) || city || ', ' || state || ' ' || zipcode
	AS company_address
FROM company
```

Now the query returns a single formatted column per company. The NVL2 function returns the third argument when the first is NULL, and otherwise returns the second argument. In this example, when address1 is NULL, the empty string (‘’) is returned, and likewise for the other address columns. In this way, blank address lines are not returned.

The ASCII function, in essence, does the reverse of CHR: it returns the decimal representation of a given character in the database character set. For example, execute the following code to display the decimal code for the letter J:

```sql
BEGIN
	DBMS_OUTPUT.PUT_LINE(ASCII('J'));
END;
```

and you’ll find that, in UTF-8 at least, the underlying representation of J is the value 74.


##### Concatenating Strings

There are two mechanisms for concatenating strings: the CONCAT function and the concatenation operator, represented by two vertical bar characters (||).

CONCAT ('abc', 'defg') --> 'abcdefg'
CONCAT (NULL, 'def') --> 'def'
CONCAT ('ab', NULL) --> 'ab'
CONCAT (NULL, NULL) --> NULL

Notice that you can concatenate only two strings with the database function. With the concatenation operator, you can combine several strings. For example:

```sql
DECLARE
	x VARCHAR2(100);
BEGIN
	x := 'abc' || 'def' || 'ghi';
	DBMS_OUTPUT.PUT_LINE(x);
END;
```

The output is: abcdefghi

To perform the identical concatenation using CONCAT, you would need to nest one call to CONCAT inside another:

`x := CONCAT(CONCAT('abc','def'),'ghi');`

##### Dealing with Case

Forcing a string to all upper- or lowercase

```sql
DECLARE
	name1 VARCHAR2(30) := 'Andrew Sears';
	name2 VARCHAR2(30) := 'ANDREW SEARS';
BEGIN
	IF LOWER(name1) = LOWER(name2) THEN
		DBMS_OUTPUT.PUT_LINE('The names are the same.');
	END IF;
END;
```

Capitalizing each word in a string

A third case-related function, after UPPER and LOWER, is INITCAP. This function forces the initial letter of each word in a string to uppercase, and all remaining letters to lowercase. For example, if I write code like this:

```sql
DECLARE
	name VARCHAR2(30) := 'MATT williams';
BEGIN
	DBMS_OUTPUT.PUT_LINE(INITCAP(name));
END;
```

The output will be: Matt Williams


##### Traditional Searching, Extracting, and Replacing

The INSTR function returns the character position of a substring within a larger string. The following code finds the locations of all the commas in a list of names:

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
	comma_location NUMBER := 0;
BEGIN
	LOOP
		comma_location := INSTR(names,',',comma_location+1);
		EXIT WHEN comma_location = 0;
		DBMS_OUTPUT.PUT_LINE(comma_location);
	END LOOP;
END;
```

The output is:
5
10
14
21
28
34

The first argument to INSTR is the string to search. The second is the substring to look for, in this case a comma. The third argument specifies the character position at which to begin looking. After each comma is found, the loop begins looking again one character further down the string. When no match is found, INSTR returns zero, and the loop ends.

Let’s extract the names instead. For that, I’ll use the SUBSTR function:

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jeff';
	names_adjusted VARCHAR2(61);
	comma_location NUMBER := 0;
	prev_location NUMBER := 0;
BEGIN
	-- Stick a comma after the final name
	names_adjusted := names || ',';
	LOOP
		comma_location := INSTR(names_adjusted,',',comma_location+1);
		EXIT WHEN comma_location = 0;
		DBMS_OUTPUT.PUT_LINE(
			SUBSTR(names_adjusted,
			prev_location+1,
			comma_location-prev_location-1));
		prev_location := comma_location;
	END LOOP;
END;
```

The list of names that I get is:
Anna
Matt
Joe
Nathan
Andrew
Aaron
Jeff

All this searching and extracting is fairly tedious. Sometimes I can reduce the complexity of my code by cleverly using some of the built-in functions. Let’s try the REPLACE function to swap those commas with newlines:

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Aaron,Jef';
BEGIN
	DBMS_OUTPUT.PUT_LINE(
		REPLACE(names, ',', chr(10))
	)
END;
```

To extract the final 10 characters of a string:

`SUBSTR('Brighten the corner where you are',-10)`

`INSTR('Brighten the corner where you are','re',-1,2)`

The result is 24. The fourth parameter, a 2, requests the second occurrence of “re”. The third parameter is −1, so the search begins at the last character of the string (the first character prior to the closing quote). The search progresses backward toward the beginning, past the “re” at the end of “are” (the first occurrence), until reaching the occurrence of “re” at the end of “where”.

There is one subtle case in which INSTR with a negative position will search forward. Here’s an example:

`INSTR('Brighten the corner where you are','re',-2,1)`

The −2 starting position means that the search begins with the r in “are”. The result is 32. Beginning from the r in “are”, INSTR looks forward to see whether it is pointing at an occurrence of “re”. And it is, so INSTR returns the current position in the string, which happens to be the 32nd character.

##### Padding

Occasionally it’s helpful to force strings to be a certain size. You can use LPAD and RPAD to add spaces (or some other character) to either end of a string in order to make the string a specific length. The following example uses the two functions to display a list of names two-up in a column, with the leftmost name being flush left and the rightmost name appearing flush right:

```sql
DECLARE
	a VARCHAR2(30) := 'Jeff';
	b VARCHAR2(30) := 'Eric';
	c VARCHAR2(30) := 'Andrew';
	d VARCHAR2(30) := 'Aaron';
	e VARCHAR2(30) := 'Matt';
	f VARCHAR2(30) := 'Joe';
BEGIN
	DBMS_OUTPUT.PUT_LINE( RPAD(a,10) || LPAD(b,10) );
	DBMS_OUTPUT.PUT_LINE( RPAD(c,10) || LPAD(d,10) );
	DBMS_OUTPUT.PUT_LINE( RPAD(e,10) || LPAD(f,10) );
END;

/*
The output is:
Jeff 			Eric
Andrew 		   Aaron
Matt 			 Joe
*/
```

The default padding character is the space. If you like, you can specify a fill character as the third argument. Change the lines of code to read:

```sql
DBMS_OUTPUT.PUT_LINE( RPAD(a,10,'.') || LPAD(b,10,'.') );
DBMS_OUTPUT.PUT_LINE( RPAD(c,10,'.') || LPAD(d,10,'.') );
DBMS_OUTPUT.PUT_LINE( RPAD(e,10,'.') || LPAD(f,10,'.') );

/*
And the output changes to:
Jeff............Eric
Andrew.........Aaron
Matt.............Joe
*/
```


##### Trimming

What LPAD and RPAD giveth, TRIM, LTRIM, and RTRIM taketh away. For example:

```sql
DECLARE
	a VARCHAR2(40) := 'This sentence has too many periods......';
	b VARCHAR2(40) := 'The number 1';
BEGIN
	DBMS_OUTPUT.PUT_LINE( RTRIM(a,'.') );
	DBMS_OUTPUT.PUT_LINE(
	LTRIM(b, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz')
	);
END;
```

The output is:

This sentence has too many periods
1

The default is to trim spaces from the beginning or end of the string. Specifying RTRIM(a) is the same as asking for RTRIM(a,‘ ’). The same goes for LTRIM(a) and LTRIM(a,‘ ’).

TRIM works a bit differently from LTRIM and RTRIM, as you can see:

```sql
DECLARE
	x VARCHAR2(30) := '.....Hi there!.....';
BEGIN
	DBMS_OUTPUT.PUT_LINE( TRIM(LEADING '.' FROM x) );
	DBMS_OUTPUT.PUT_LINE( TRIM(TRAILING '.' FROM x) );
	DBMS_OUTPUT.PUT_LINE( TRIM(BOTH '.' FROM x) );
	-- The default is to trim from both sides
	DBMS_OUTPUT.PUT_LINE( TRIM('.' FROM x) );
	-- The default trim character is the space:
	DBMS_OUTPUT.PUT_LINE( TRIM(x) );
END;
```

The output is:

Hi there!.....
.....Hi there!
Hi there!
Hi there!
.....Hi there!.....

It’s one function, yet you can use it to trim from either side or from both sides. However, you can specify only a single character to remove. You cannot, for example, write:

`TRIM(BOTH ',.;' FROM x)`

Instead, to solve this particular problem, you can use a combination of RTRIM and LTRIM:

`RTRIM(LTRIM(x,',.;'),',.;')`


##### Regular Expression

The general syntax for the REGEXP_LIKE function is:

`REGEXP_LIKE (source_string, pattern [,match_modifier])`

Where source_string is the character string to be searched, pattern is the regular expression pattern to search for in source_string, and match_modifier is one or more modifiers that apply to the search. If REGEXP_LIKE finds pattern in source_string, then it returns the Boolean TRUE; otherwise, it returns FALSE.

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Jeff,Aaron';
	names_adjusted VARCHAR2(61);
	comma_delimited BOOLEAN;
BEGIN
	-- Look for the pattern
	comma_delimited := REGEXP_LIKE(names,'^([a-z A-Z]*,)+([a-z A-Z]*){1}$');
	-- Display the result
	DBMS_OUTPUT.PUT_LINE(
		CASE comma_delimited
		WHEN true THEN 'We have a delimited list!'
		ELSE 'The pattern does not match.'
		END);
END;

-- The result is:
-- We have a delimited list!
```

##### Locating a pattern

You can use REGEXP_INSTR to locate occurrences of a pattern within a string. The general syntax for REGEXP_INSTR is:

```sql
REGEXP_INSTR (source_string, pattern [,beginning_position [,occurrence
	[,return_option [,match_modifier [,subexpression]]]]])
```

For example, to find the first occurrence of a name beginning with the letter A and ending with a consonant, you might specify:

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Jeff,Aaron';
	names_adjusted VARCHAR2(61);
	comma_delimited BOOLEAN;
	j_location NUMBER;
BEGIN
	-- Look for the pattern
	comma_delimited := REGEXP_LIKE(names,'^([a-z ]*,)+([a-z ]*)$', 'i');
	-- Only do more if we do, in fact, have a comma-delimited list
	IF comma_delimited THEN
		j_location := REGEXP_INSTR(names, 'A[a-z]*[^aeiou],|A[a-z]*[^aeiou]$');
		DBMS_OUTPUT.PUT_LINE(j_location);
	END IF;
END;
```

A[a-z ]*[^aeiou]

I add [^aeiou] because I want my name to end with anything but a vowel. The caret ^ creates an exclusion set—any character except a vowel will match. Because I specify no quantifier, exactly one such nonvowel is required.

While REGEXP_INSTR has its uses, I am often more interested in returning the text matching a pattern than I am in simply locating it.


##### Extracting text matching a pattern

Let’s use a different example to illustrate regular expression extraction. Phone numbers are a good example because they follow a pattern, but often there are several variations on this pattern. The phone number pattern includes the area code (three digits) followed by the exchange (three digits) followed by the local number (four digits). So, a phone number is a string of 10 digits. But there are many optional and alternative ways to represent the number. The area code may be enclosed within parentheses and is usually, but not always, separated from the rest of the phone number with a space, dot, or dash character. The exchange is also usually, but not always, separated from the rest of the phone number with a space, dot, or dash character. Thus, a legal phone number may include any of the following:

>7735555253
773-555-5253
(773)555-5253
(773) 555 5253
773.555.5253

The general syntax for REGEXP_SUBSTR is:

```sql
REGEXP_SUBSTR (source_string, pattern [,position [,occurrence
	[,match_modifier [,subexpression]]]])
```

REGEXP_SUBSTR returns a string containing the portion of the source string matching the pattern or subexpression. If no matching pattern is found, a NULL is returned.

```sql
DECLARE
	contact_info VARCHAR2(200) := '
		address:
		1060 W. Addison St.
		Chicago, IL 60613
		home 773-555-5253
	';
	phone_pattern VARCHAR2(90) :=
		'\(?\d{3}\)?[[:space:]\.\-]?\d{3}[[:space:]\.\-]?\d{4}';
BEGIN
	DBMS_OUTPUT.PUT_LINE('The phone number is: '||
	REGEXP_SUBSTR(contact_info,phone_pattern,1,1));
END;
-- This code shows me the phone number:
-- The phone number is: 773-555-5253
```

##### Counting regular expression matches

Sometimes, you just want a count of how many matches your regular expression has.

`REGEXP_COUNT (source_string, pattern [,position [,match_modifier]])`

```sql
DECLARE
	contact_info VARCHAR2(200) := '
		address:
		1060 W. Addison St.
		Chicago, IL 60613
		home 773-555-5253
		work (312) 123-4567';
	phone_pattern VARCHAR2(90) :=
		'\(?(\d{3})\)?[[:space:]\.\-]?(\d{3})[[:space:]\.\-]?\d{4}';
BEGIN
	DBMS_OUTPUT.PUT_LINE('There are '
		||REGEXP_COUNT(contact_info,phone_pattern)
		||' phone numbers');
END;

-- The result is:
-- There are 2 phone numbers
```

##### Replacing text

Imagine that you’re faced with the problem of displaying a comma-delimited list of names two to a line. One way to do that is to replace every second comma with a newline character. Again, this is hard to do with standard REPLACE, but easy using REGEXP_REPLACE.

`REGEXP_REPLACE (source_string, pattern [,replacement_string
[,position [,occurrence [,match_modifier]])`

```sql
DECLARE
	names VARCHAR2(60) := 'Anna,Matt,Joe,Nathan,Andrew,Jeff,Aaron';
	names_adjusted VARCHAR2(61);
	comma_delimited BOOLEAN;
	extracted_name VARCHAR2(60);
	name_counter NUMBER;
BEGIN
	-- Look for the pattern
	comma_delimited := REGEXP_LIKE(names,'^([a-z ]*,)+([a-z ]*){1}$', 'i');
	-- Only do more if we do, in fact, have a comma-delimited list
	IF comma_delimited THEN
		names := REGEXP_REPLACE(
			names,
			'([a-z A-Z]*),([a-z A-Z]*),',
			'\1,\2' || chr(10) );
	END IF;
	DBMS_OUTPUT.PUT_LINE(names);
END;
```

The output from this bit of code is:

Anna,Matt
Joe,Nathan
Andrew,Jeff
Aaron

I can do even more! I can easily change the replacement text to use a tab (an ASCII 9) rather than a comma:

```sql
names := REGEXP_REPLACE(
	names,
	'([a-z A-Z]*),([a-z A-Z]*),',
	'\1' || chr(9) || '\2' || chr(10) );
	
/*
And now I get my results in two nice, neat columns:
Anna 	Matt
Joe 	Nathan
Andrew 	Jeff
Aaron
*/
```

##### Working with Empty Strings

Oracle database treats empty strings as NULLs. This is contrary to the ISO SQL standard, which recognizes the difference between an empty string and a string variable that is NULL.

```sql
IF (user_entered_name <> name_from_database)
	OR (user_entered_name IS NULL) THEN
```


#### Numbers

```sql
DECLARE
	x NUMBER;
	-- NUMBER(precision, scale)
	fixed_point NUMBER(9,2) -- 9999999.99

DECLARE
	loop_counter PLS_INTEGER;
	days_in_standard_year CONSTANT PLS_INTEGER := 365;
	emp_vacation_days PLS_INTEGER DEFAULT 14;
```

The PLS_INTEGER datatype was designed for speed, are represented using your hardware platform’s native integer format. I recommend that you consider using PLS_INTEGER whenever you’re faced with intensive integer arithmetic. You’ll gain the greatest efficiency when you use PLS_INTEGER for integer arithmetic (and for loop counters) in cases where you can avoid multiple conversions to and from the NUMBER type. When this datatype is used in integer arithmetic, the resulting values are rounded to whole numbers, as shown in this example:

```sql
DECLARE
	int1 PLS_INTEGER;
	int2 PLS_INTEGER;
	int3 PLS_INTEGER;
	nbr NUMBER;
BEGIN
	int1 := 100;
	int2 := 49;
	int3 := int2/int1;
	nbr := int2/int1;
	DBMS_OUTPUT.PUT_LINE('integer 49/100 =' || TO_CHAR(int3));
	DBMS_OUTPUT.PUT_LINE('number 49/100 =' || TO_CHAR(nbr));
	int2 := 50;
	int3 := int2/int1;
	nbr := int2/int1;
	DBMS_OUTPUT.PUT_LINE('integer 50/100 =' || TO_CHAR(int3));
	DBMS_OUTPUT.PUT_LINE('number 50/100 =' || TO_CHAR(nbr));
END;

/*
This gives the following output:
integer 49/100 =0
number 49/100 =.49
integer 50/100 =1
number 50/100 =.5
*/
```

##### The SIMPLE_INTEGER Type

The SIMPLE_INTEGER datatype was introduced in Oracle Database 11g. This datatype is a performance-enhanced version of PLS_INTEGER with a few caveats. But it does not support NULL values or check for overflow conditions.

>To avoid ambiguity and possible errors involving implicit conversions, I recommend explicit conversions, such as with the functions TO_NUMBER, TO_BINARY_FLOAT, and TO_BINARY_DOUBLE.

Use TO_NUMBER whenever you need to convert character string representations of numbers into their corresponding numeric values. Invoke TO_NUMBER as follows:

`TO_NUMBER(string [,format [,nls_params]])`

The TO_CHAR function is the converse of TO_NUMBER, and converts numbers to their character representations. Using an optional format mask, you can be quite specific about the form those character representations take. Invoke TO_CHAR as follows:

`TO_CHAR(number [,format [,nls_params]])`

The CAST function is used to convert numbers to strings and vice versa. The general format of the CAST function is as follows:

`CAST (expression AS datatype)`

CAST has the disadvantage of not supporting the use of number format models. An advantage of CAST, however, is that it is part of the ISO SQL standard, whereas the TO_CHAR and TO_NUMBER functions are not. If writing 100% ANSI-compliant code is important to you, you should investigate the use of CAST. Otherwise, I recommend using the traditional TO_NUMBER and TO_CHAR functions.

Explicit conversions also make your intent clear to other programmers, making your code more selfdocumenting and easier to understand. When you use an implicit conversion you are giving up some of that control. You should always know when conversions are taking place, and the best way to do that is to code them explicitly.

`a := TO_NUMBER('123.400' || TO_CHAR(999));`

```sql
/*
Table 9-6. Numeric operators and precedence
Operator 		Operation 					Precedence
** 				Exponentiation 				1
+ 				Identity 					2
− 				Negation 					2
* 				Multiplication 				3
/ 				Division 					3
+ 				Addition 					4
− 				Subtraction 				4
= 				Equality 					5
< 				Less than 					5
> 				Greater than 				5
<= 				Less than or equal to 		5
>= 				Greater than or equal to 	5
<>, !=, ~=, ^= 	Not equal 					5
IS NULL 		Nullity 					5
BETWEEN 		Inclusive range 			5
NOT 			Logical negation 			6
AND 			Conjunction 				7
OR 				Inclusion 					8
*/
```

There are four different numeric functions that perform rounding and truncation actions:

CEIL, FLOOR, ROUND, and TRUNC.


#### Dates and Timestamps

The four datetime datatypes are:

DATE 

Stores a date and time, resolved to the second. Does not include time zone.

TIMESTAMP

Stores a date and time without respect to time zone. Except for being able to resolve time to the billionth of a second (nine decimal places of precision), TIMESTAMP is the equivalent of DATE. 

TIMESTAMP WITH TIME ZONE

Stores the time zone along with the date and time value, allowing up to nine decimal places of precision.

TIMESTAMP WITH LOCAL TIME ZONE

Stores a date and time with up to nine decimal places of precision. This datatype is sensitive to time zone differences. Values of this type are automatically converted between the database time zone and the local (session) time zone. When values are stored in the database, they are converted to the database time zone, but the local (session) time zone is not stored. When a value is retrieved from the database, that value is converted from the database time zone to the local (session) time zone.

##### Declaring Datetime Variables

Use the following syntax to declare a datetime variable:

`var_name [CONSTANT] datetime_type [{:= | DEFAULT} initial_value]`

Replace datetime_type with any one of the following:

```sql
/*
DATE
TIMESTAMP [(precision)]
TIMESTAMP [(precision)] WITH TIME ZONE
TIMESTAMP [(precision)] WITH LOCAL TIME ZONE
*/

DECLARE
	hire_date TIMESTAMP (0) WITH TIME ZONE;
	todays_date CONSTANT DATE := SYSDATE;
	pay_date TIMESTAMP DEFAULT TO_TIMESTAMP('20050204','YYYYMMDD');
```

To specify a default initial_value, you can use a conversion function such as TO_TIMESTAMP, or you can use a date or timestamp literal.

##### Choosing a Datetime Datatype

With such an abundance of riches, I won’t blame you one bit if you ask for some guidance as to which datetime datatype to use when. To a large extent, the datatype you choose depends on the level of detail that you want to store:

• Use one of the TIMESTAMP types if you need to track time down to a fraction of a second.

• Use TIMESTAMP WITH LOCAL TIME ZONE if you want the database to automatically convert a time between the database and session time zones.

• Use TIMESTAMP WITH TIME ZONE if you need to keep track of the session time zone in which the data was entered.

• You can use TIMESTAMP in place of DATE. A TIMESTAMP that does not contain subsecond precision takes up 7 bytes of storage, just like a DATE datatype does. When your TIMESTAMP does contain subsecond data, it takes up 11 bytes of storage.

• Use DATE when it’s necessary to maintain compatibility with an existing application written before any of the TIMESTAMP datatypes were introduced.

• In general, you should use datatypes in your PL/SQL code that correspond to, or are at least compatible with, the underlying database tables. Think twice, for example, before reading a TIMESTAMP value from a table into a DATE variable, because you might lose information (in this case, the fractional seconds and perhaps the time zone).

• If you’re using a version older than Oracle9i Database, then you have no choice but to use DATE.

• When adding or subtracting years and months, you get different behavior from using ADD_MONTHS, which operates on values of type DATE, than from using interval arithmetic on the timestamp types.


##### Getting the Current Date and Time

```sql
Function 			Time zone 			Datatype returned
CURRENT_DATE 		Session 			DATE
CURRENT_TIMESTAMP 	Session 			TIMESTAMP WITH TIME ZONE
LOCALTIMESTAMP 		Session 			TIMESTAMP
SYSDATE 			Database server 	DATE
SYSTIMESTAMP 		Database server 	TIMESTAMP WITH TIME ZONE
```

So which function should you use in a given situation? The answer depends on several factors, which you should probably consider in the following order:

1. Whether you are using a release prior to Oracle8i Database or need to maintain compatibility with such a release. In either case, your choice is simple: use SYSDATE.
2. Whether you are interested in the time on the database server or for your session. If for your session, then use a function that returns the session time zone. If for the database server, then use a function that returns the database time zone.
3. Whether you need the time zone to be returned as part of the current date and time. If so, then call either SYSTIMESTAMP or CURRENT_TIMESTAMP.


If you decide to use a function that returns the time in the session time zone, be certain that you have correctly specified your session time zone. The functions SESSIONTIMEZONE and DBTIMEZONE will report your session and database time zones, respectively. To report on the time in the database time zone, you must alter your session time zone to DBTIMEZONE and then use one of the session time zone functions. The following example illustrates some of these functions:

```sql
BEGIN
	DBMS_OUTPUT.PUT_LINE('Session Timezone='||SESSIONTIMEZONE);
	DBMS_OUTPUT.PUT_LINE('Session Timestamp='||CURRENT_TIMESTAMP);
	DBMS_OUTPUT.PUT_LINE('DB Server Timestamp='||SYSTIMESTAMP);
	DBMS_OUTPUT.PUT_LINE('DB Timezone='||DBTIMEZONE);
	EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE=DBTIMEZONE';
	DBMS_OUTPUT.PUT_LINE('DB Timestamp='||CURRENT_TIMESTAMP);
	-- Revert session time zone to local setting
	EXECUTE IMMEDIATE 'ALTER SESSION SET TIME_ZONE=LOCAL';
END;

/*
The output is:
	Session Timezone=-04:00
	Session Timestamp=23-JUN-08 12.48.44.656003000 PM −04:00
	DB Server Timestamp=23-JUN-08 11.48.44.656106000 AM −05:00
	DB Timezone=+00:00
	DB Timestamp=23-JUN-08 04.48.44.656396000 PM +00:00
*/
```

The database supports two interval datatypes. Both were introduced in Oracle9i Database, and both conform to the ISO SQL standard:

INTERVAL YEAR TO MONTH

Allows you to define an interval of time in terms of years and months.

INTERVAL DAY TO SECOND

Allows you to define an interval of time in terms of days, hours, minutes, and seconds (including fractional seconds).

```sql
DECLARE
	start_date TIMESTAMP;
	end_date TIMESTAMP;
	service_interval INTERVAL YEAR TO MONTH;
	years_of_service NUMBER;
	months_of_service NUMBER;
BEGIN
	-- Normally, we would retrieve start and end dates from a database.
	start_date := TO_TIMESTAMP('29-DEC-1988','dd-mon-yyyy');
	end_date := TO_TIMESTAMP ('26-DEC-1995','dd-mon-yyyy');
	
	-- Determine and display years and months of service
	service_interval := (end_date - start_date) YEAR TO MONTH;
	DBMS_OUTPUT.PUT_LINE(service_interval);
	
	-- Use the new EXTRACT function to grab individual
	-- year and month components.
	years_of_service := EXTRACT(YEAR FROM service_interval);
	months_of_service := EXTRACT(MONTH FROM service_interval);
	DBMS_OUTPUT.PUT_LINE(years_of_service || ' years and '
		|| months_of_service || ' months');
END;
```