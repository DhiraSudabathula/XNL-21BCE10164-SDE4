-- partition table for transaction

CREATE TABLE "Transaction" (
    "Transaction_ID" SERIAL PRIMARY KEY,
    "User_ID" INT NOT NULL,
    "Timestamp" TIMESTAMP NOT NULL,
    "Transaction_Status" VARCHAR(20),
    "Payment_Type" VARCHAR(50),
    "Gateway_ID" INT,
    "Transaction_Fee" DECIMAL(10,2),
    "Discount" DECIMAL(10,2)
) PARTITION BY RANGE ("Timestamp");
CREATE TABLE transaction_2023 PARTITION OF "Transaction"
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
CREATE TABLE transaction_2024 PARTITION OF "Transaction"
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE transaction_2025 PARTITION OF "Transaction"
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- partition table for user by region

CREATE TABLE "User" (
    "User_ID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(100),
    "Email" VARCHAR(100),
    "Region" VARCHAR(50)
) PARTITION BY LIST ("Region");
CREATE TABLE user_usa PARTITION OF "User"
    FOR VALUES IN ('USA');
CREATE TABLE user_india PARTITION OF "User"
    FOR VALUES IN ('India');
CREATE TABLE user_europe PARTITION OF "User"
    FOR VALUES IN ('Germany', 'France', 'UK');


-- partition table for investment by investment type

CREATE TABLE "Investment" (
    "Investment_ID" SERIAL PRIMARY KEY,
    "User_ID" INT NOT NULL,
    "Investment_Type" VARCHAR(50),
    "Amount" DECIMAL(15,2),
    "Timestamp" TIMESTAMP NOT NULL
) PARTITION BY LIST ("Investment_Type");
CREATE TABLE investment_stocks PARTITION OF "Investment"
    FOR VALUES IN ('Stocks');
CREATE TABLE investment_real_estate PARTITION OF "Investment"
    FOR VALUES IN ('Real Estate');
CREATE TABLE investment_crypto PARTITION OF "Investment"
    FOR VALUES IN ('Cryptocurrency');
    

-- partition table for vendor by location

CREATE TABLE "Vendor" (
    "Vendor_ID" SERIAL PRIMARY KEY,
    "Vendor_Name" VARCHAR(100),
    "Country" VARCHAR(50)
) PARTITION BY LIST ("Country");
CREATE TABLE vendor_usa PARTITION OF "Vendor"
    FOR VALUES IN ('USA');
CREATE TABLE vendor_india PARTITION OF "Vendor"
    FOR VALUES IN ('India');
CREATE TABLE vendor_uk PARTITION OF "Vendor"
    FOR VALUES IN ('UK');


