/*Exercise 3: Stored Procedures

Scenario 1: The bank needs to process monthly interest for all savings accounts.
o	Question: Write a stored procedure ProcessMonthlyInterest that calculates and updates the balance of all savings accounts by applying an interest rate of 1% to the current balance.

Scenario 2: The bank wants to implement a bonus scheme for employees based on their performance.
o	Question: Write a stored procedure UpdateEmployeeBonus that updates the salary of employees in a given department by adding a bonus percentage passed as a parameter.

Scenario 3: Customers should be able to transfer funds between their accounts.
o	Question: Write a stored procedure TransferFunds that transfers a specified amount from one account to another, checking that the source account has sufficient balance before making the transfer.
*/

-- Stored Procedure for Scenario 1: Process Monthly Interest

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';
    
    COMMIT;
END;
/

-- Stored Procedure for Scenario 2: Update Employee Bonus

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_DepartmentID IN NUMBER,
    p_BonusPercent IN NUMBER
) IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * (p_BonusPercent / 100))
    WHERE DepartmentID = p_DepartmentID;
    
    COMMIT;
END;
/

-- Stored Procedure for Scenario 3: Transfer Funds Between Accounts

CREATE OR REPLACE PROCEDURE TransferFunds(
    p_SourceAccID IN NUMBER,
    p_TargetAccID IN NUMBER,
    p_Amount IN NUMBER
) IS
    v_SourceBalance NUMBER;
BEGIN
    -- Get source account balance
    SELECT Balance INTO v_SourceBalance FROM Accounts WHERE AccountID = p_SourceAccID FOR UPDATE;

    -- Check for sufficient funds
    IF v_SourceBalance >= p_Amount THEN
        -- Deduct from source
        UPDATE Accounts
        SET Balance = Balance - p_Amount
        WHERE AccountID = p_SourceAccID;

        -- Add to target
        UPDATE Accounts
        SET Balance = Balance + p_Amount
        WHERE AccountID = p_TargetAccID;

        COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
    END IF;
END;
/
