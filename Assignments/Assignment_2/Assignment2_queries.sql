USE FinanceLab;

-- ============================================================
-- CASE STUDY 1: Silent High-Value Accounts
-- ============================================================

WITH acc_behavior AS (
    SELECT
        a.account_id,
        a.customer_id,
        a.account_type,
        a.opening_balance,
        COUNT(t.transaction_id)  AS total_transactions,
        IFNULL(SUM(t.amount), 0) AS amount_moved
    FROM Accounts a
    LEFT JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY a.account_id, a.customer_id, a.account_type, a.opening_balance
)

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.segment,
    ab.account_id,
    ab.account_type,
    ab.opening_balance,
    ab.total_transactions,
    ab.amount_moved,

    (SELECT MIN(customer_name)
     FROM Customers
     WHERE city = c.city
     AND customer_id != c.customer_id) AS same_city_peer,

    CASE
        WHEN ab.total_transactions = 0 AND ab.opening_balance >= 100000
            THEN 'Silent High-Value Account'
        WHEN ab.total_transactions = 0 AND ab.opening_balance < 100000
            THEN 'Inactive Low-Balance Account'
        WHEN ab.total_transactions BETWEEN 1 AND 2 AND ab.opening_balance >= 100000
            THEN 'Underutilized High-Value Account'
        WHEN ab.total_transactions >= 3
            THEN 'Active Account'
        ELSE 'Low Balance Occasional User'
    END AS Account_Flag

FROM acc_behavior ab
INNER JOIN Customers c ON ab.customer_id = c.customer_id
RIGHT JOIN acc_behavior ab2 ON ab.account_id = ab2.account_id

ORDER BY ab.opening_balance DESC, ab.total_transactions ASC;

-- ============================================================
-- CASE STUDY 2: Hidden Customer Behavior Network
-- ============================================================
    
WITH cust_summary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.city,
        c.segment,
        c.registration_date,
        COUNT(DISTINCT a.account_id)      AS total_accounts,
        IFNULL(SUM(a.opening_balance), 0) AS total_balance,
        COUNT(t.transaction_id)           AS total_txns,
        IFNULL(SUM(t.amount), 0)          AS total_amount,
        IFNULL(AVG(t.amount), 0)          AS avg_amount,
        MAX(t.transaction_date)           AS last_activity
    FROM Customers c
    LEFT JOIN Accounts a     ON c.customer_id = a.customer_id
    LEFT JOIN Transactions t ON a.account_id  = t.account_id
    GROUP BY c.customer_id, c.customer_name, c.city, c.segment, c.registration_date
)

SELECT
    cs.customer_id,
    cs.customer_name,
    cs.city,
    cs.segment,
    cs.registration_date,
    cs.total_accounts,
    cs.total_balance,
    cs.total_txns,
    cs.total_amount,
    cs.avg_amount,
    cs.last_activity,

    (SELECT MIN(customer_name)
     FROM Customers
     WHERE city = cs.city
     AND customer_id != cs.customer_id) AS city_peer,

    CASE
        WHEN cs.total_accounts = 0
            THEN 'No Account - Unengaged Customer'
        WHEN cs.total_txns = 0
            THEN 'Has Account But Never Transacted'
        WHEN cs.total_txns BETWEEN 1 AND 2
            THEN 'Occasional User'
        WHEN cs.total_txns >= 3 AND cs.total_balance >= 100000
            THEN 'Active High-Value Customer'
        WHEN cs.total_txns >= 3
            THEN 'Active Low-Balance Customer'
        ELSE 'Needs Further Review'
    END AS Customer_Behavior

FROM cust_summary cs
RIGHT JOIN Customers c3 ON cs.customer_id = c3.customer_id  

ORDER BY cs.total_balance DESC, cs.total_txns DESC;