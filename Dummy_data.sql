insert into transaction_type_dict  (name,description,created_at,updated_at, deleted_at)
values 
('INCOME', 'an income',NOW(), NOW(), null),
('Expense', 'an Expense',NOW(), NOW(), null);

select * from transaction_type_dict ttd ;

INSERT INTO user_montrack (password, name, email, pin, created_at, updated_at, deleted_at)
VALUES
('$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4JMX4pjydi', 'John Doe', 'john.doe@email.com', 123456, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),
('$2a$12$kWyPq1hyHXhk0uB2.8E5NO3U5/zmGjXeQdZQfrLV3QgHEKqiXnP.O', 'Jane Smith', 'jane.smith@email.com', 234567, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),
('$2a$12$9ZnWFm4.e6OYf4xA1h0rUemf5/4lqNReDISJrl9s.ZuF0GLxzXz7m', 'Bob Wilson', 'bob.wilson@email.com', 345678, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),
('$2a$12$mKyPq1hyHXhk0uB2.8E5NO3U5/zmGjXeQdZQfrLV3QgHEKqiXnP.O', 'Alice Brown', 'alice.brown@email.com', 456789, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),
('$2a$12$tPyPq1hyHXhk0uB2.8E5NO3U5/zmGjXeQdZQfrLV3QgHEKqiXnP.O', 'Charlie Davis', 'charlie.davis@email.com', 567890, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL);

select * from user_montrack um ;

select * from wallet;
insert into wallet (user_id, amount, created_at, updated_at, deleted_at)
values
(1,0,NOW(),NOW(),null);

select * from pocket ;
INSERT INTO pocket (
    wallet_id,
    name,
    emoji_data,
    description,
    budget_amount,
    created_at,
    updated_at,
    deleted_at
)
VALUES (
    1,                              
    'Daily Expenses',               
    'U+1F4B0',                          
    'Pocket for daily spending',   
    1000000,                      
    CURRENT_TIMESTAMP,            
    CURRENT_TIMESTAMP,             
    NULL                         
);

select * from pocket p ;

select * from transaction;

INSERT INTO transaction (
   name,
   description,
   date_transaction,
   transaction_type_id,
   amount,
   pocket_id,
   created_at,
   updated_at,
   deleted_at
)
VALUES
-- Income transactions
(
   'Salary',
   'Monthly salary payment',
   CURRENT_TIMESTAMP,
   1,                -- transaction_type_id for INCOME
   5000000,          -- amount (assuming in cents/smallest currency unit)
   1,                -- pocket_id from previous pocket
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
),
(
   'Bonus',
   'Year-end bonus',
   CURRENT_TIMESTAMP,
   1,                -- transaction_type_id for INCOME
   2000000,
   1,
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
),
-- Expense transactions
(
   'Groceries',
   'Weekly grocery shopping',
   CURRENT_TIMESTAMP,
   2,                -- transaction_type_id for EXPENSE
   150000,
   1,
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
),
(
   'Internet Bill',
   'Monthly internet subscription',
   CURRENT_TIMESTAMP,
   2,                -- transaction_type_id for EXPENSE
   100000,
   1,
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
);


INSERT INTO pocket_summary (
    pocket_id,
    wallet_id,
    budget,
    income,
    expense,
    created_at,
    updated_at,
    deleted_at
)
SELECT 
    p.id,
    p.wallet_id,
    p.budget_amount AS budget,
    SUM(CASE WHEN t.transaction_type_id = 2 THEN t.amount END) AS income,
    SUM(CASE WHEN t.transaction_type_id = 1 THEN t.amount END) AS expense,
    NOW(),
    NOW(),
    NULL
FROM transaction t
JOIN pocket p ON t.pocket_id = p.id
GROUP BY 
    p.id,
    p.wallet_id,
    p.budget_amount;
   
   select * from pocket_summary ps ;


-- First, insert the goals_data
INSERT INTO goals_data (
   user_id,
   name,
   image,
   description,
   balance,
   goal_amount,
   created_at,
   updated_at,
   deleted_at
)
VALUES (
   1,                                              -- user_id
   'Bali Holiday Trip',                           -- name
   'https://storage.montrack.com/goals/bali.jpg', -- dummy image URL
   'Save money for dream vacation in Bali 2025',  -- description
   0,                                             -- initial balance
   25000000,                                      -- goal_amount (25M - assuming in smallest currency unit)
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
);

-- Then, insert initial transaction for this goal
INSERT INTO goals_transaction (
   goal_id,
   amount,
   created_at,
   updated_at,
   deleted_at
)
VALUES (
   (SELECT id FROM goals_data WHERE name = 'Bali Holiday Trip'), -- getting the goal_id from the previous insert
   2000000,                                                     -- initial deposit of 2M
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP,
   NULL
);

select * from goals_transaction gt ;


select * from goals_data gd ;
