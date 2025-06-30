/*Exercise 1: Control Structures

Scenario 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
o	Question: Write a PL/SQL block that loops through all customers, checks their age, and if they are above 60, apply a 1% discount to their current loan interest rates.
Scenario 2: A customer can be promoted to VIP status based on their balance.
o	Question: Write a PL/SQL block that iterates through all customers and sets a flag IsVIP to TRUE for those with a balance over $10,000.
Scenario 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
o	Question: Write a PL/SQL block that fetches all loans due in the next 30 days and prints a reminder message for each customer.*/


-- Combined PL/SQL Block for All Three Scenarios

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor for Scenario 1: Apply interest discount for senior citizens
    CURSOR cust_cursor IS
        SELECT c.CustomerID, l.LoanID, l.InterestRate, c.Age
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;

    -- Cursor for Scenario 2: Mark VIPs
    CURSOR vip_cursor IS
        SELECT CustomerID, Balance FROM Customers;

    -- Cursor for Scenario 3: Loan reminders
    CURSOR due_cursor IS
        SELECT l.LoanID, c.Name, l.DueDate
        FROM Loans l
        JOIN Customers c ON c.CustomerID = l.CustomerID
        WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30;

BEGIN
    -- Scenario 1: Apply 1% discount if age > 60
    FOR rec IN cust_cursor LOOP
        IF rec.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = rec.LoanID;
        END IF;
    END LOOP;

    -- Scenario 2: Set IsVIP to 'Y' if balance > 10000
    FOR rec IN vip_cursor LOOP
        IF rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = rec.CustomerID;
        END IF;
    END LOOP;

    -- Scenario 3: Print reminder for loans due in next 30 days
    FOR rec IN due_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.LoanID ||
                             ' for ' || rec.Name ||
                             ' is due on ' || TO_CHAR(rec.DueDate, 'DD-MON-YYYY'));
    END LOOP;

    COMMIT;
END;

/* OUTPUT
Reminder: Loan ID 101 for Alice is due on 30-JUN-2025
Reminder: Loan ID 102 for Bob is due on 15-JUL-2025  
*/

