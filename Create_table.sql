
CREATE TABLE user_montrack (
    id SERIAL PRIMARY KEY,
    password VARCHAR(255),
    name VARCHAR(100),
    email VARCHAR(150),
    pin INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);


CREATE TABLE wallet (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES user_montrack(id),
    amount BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);


CREATE TABLE pocket (
    id SERIAL PRIMARY KEY,
    wallet_id INTEGER REFERENCES wallet(id),
    name VARCHAR(50),
    emoji_data VARCHAR(10),  
    description VARCHAR(200),
    budget_amount BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);


CREATE TABLE transaction_type_dict (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);


CREATE TABLE transaction (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(200),
    date_transaction TIMESTAMP,
    transaction_type_id INTEGER REFERENCES transaction_type_dict(id),
    amount BIGINT,
    pocket_id INTEGER REFERENCES pocket(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE goals_data (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES user_montrack(id),
    name VARCHAR(100),
    image VARCHAR(255), 
    description VARCHAR(200),
    balance BIGINT,
    goal_amount BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);


CREATE TABLE goals_transaction (
    id SERIAL PRIMARY KEY,
    goal_id INTEGER REFERENCES goals_data(id),
    amount BIGINT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

create table pocket_summary (
	id serial primary key,
	pocket_id INTEGER references pocket(id),
	wallet_id INTEGER REFERENCES wallet(id),
	budget bigint,
	spend bigint,
	created_at timestamp,
	updated_at timestamp,
	deleted_at timestamp
)

