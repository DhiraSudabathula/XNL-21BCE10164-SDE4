import pandas as pd
import numpy as np
import random
from faker import Faker
from sqlalchemy import create_engine
from tqdm import tqdm


fake = Faker()


DB_TYPE = "postgresql"  
DB_HOST = "localhost"
DB_PORT = "5432"  
DB_NAME = "XNL"
DB_USER = "root"
DB_PASSWORD = "Root"

# Create database connection
engine = create_engine(f"{DB_TYPE}://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Function to generate Users
def generate_users(n=1000000):
    users = []
    for i in tqdm(range(n), desc="Generating Users"):
        user_id = i + 1
        name = fake.name()
        email = f"user{user_id}@example.com"
        phone = f"+123456789{random.randint(1000, 9999)}"
        kyc_status = random.choice([True, False])
        account_type = random.choice(["Savings", "Current", "Investment"])
        users.append((user_id, name, email, phone, kyc_status, account_type))
    
    df = pd.DataFrame(users, columns=["User_ID", "Name", "Email", "Phone", "KYC_status", "Account_type"])
    df.to_sql("User", con=engine, if_exists="append", index=False, chunksize=10000)

# Function to generate Transactions
def generate_transactions(n=5000000):
    transactions = []
    for i in tqdm(range(n), desc="Generating Transactions"):
        transaction_id = i + 1
        user_id = random.randint(1, 1000000)
        timestamp = fake.date_time_this_year()
        status = random.choice(["Pending", "Completed", "Failed"])
        payment_type = random.choice(["Credit Card", "Bank Transfer", "UPI"])
        gateway_id = random.randint(1, 100)  # Assuming 100 payment gateways
        fee = round(random.uniform(1, 50), 2)
        discount = round(random.uniform(0, 10), 2)
        transactions.append((transaction_id, user_id, timestamp, status, payment_type, gateway_id, fee, discount))
    
    df = pd.DataFrame(transactions, columns=[
        "Transaction_ID", "User_ID", "Timestamp", "Transaction_Status", "Payment_Type", "Gateway_ID", "Transaction_Fee", "Discount"
    ])
    df.to_sql("Transaction", con=engine, if_exists="append", index=False, chunksize=10000)

# Function to generate Vendors
def generate_vendors(n=5000):
    vendors = []
    for i in tqdm(range(n), desc="Generating Vendors"):
        vendor_id = i + 1
        name = fake.company()
        service_type = random.choice(["Payment Gateway", "Bank", "Investment Firm"])
        contract_details = fake.sentence()
        total_revenue = round(random.uniform(10000, 1000000), 2)
        success_rate = round(random.uniform(80, 100), 2)
        vendors.append((vendor_id, name, service_type, contract_details, total_revenue, success_rate))
    
    df = pd.DataFrame(vendors, columns=["Vendor_ID", "Name", "Service_Type", "Contract_Details", "Total_Revenue", "Success_Rate"])
    df.to_sql("Vendor", con=engine, if_exists="append", index=False, chunksize=10000)

# Function to generate Investments
def generate_investments(n=2000000):
    investments = []
    for i in tqdm(range(n), desc="Generating Investments"):
        investment_id = i + 1
        user_id = random.randint(1, 1000000)
        asset_type = random.choice(["Stock", "Bond", "Crypto", "Real Estate"])
        amount = round(random.uniform(500, 50000), 2)
        risk_level = random.choice(["Low", "Medium", "High"])
        investments.append((investment_id, user_id, asset_type, amount, risk_level))
    
    df = pd.DataFrame(investments, columns=["Investment_ID", "User_ID", "Asset_Type", "Amount", "Risk_level"])
    df.to_sql("Investment", con=engine, if_exists="append", index=False, chunksize=10000)


if __name__ == "__main__":
    generate_users(1000000)       # 1M Users
    generate_transactions(5000000) # 5M Transactions
    generate_vendors(5000)         # 5K Vendors
    generate_investments(2000000)  # 2M Investments

