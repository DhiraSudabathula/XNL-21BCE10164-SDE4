import random
import time
import psycopg2 
conn = psycopg2.connect(database="salesdb", user="your_user", password="your_password", host="localhost", port="5432")
cursor = conn.cursor()
def generate_sales_data(num_records):
    regions = ['North', 'South', 'East', 'West']
    for _ in range(num_records):
        product_id = random.randint(1, 1000)
        sale_amount = round(random.uniform(10, 5000), 2)
        sale_date = f"2024-{random.randint(1, 12):02d}-{random.randint(1, 28):02d}"
        region = random.choice(regions)

        cursor.execute("INSERT INTO sales (Product_ID, Sale_Amount, Sale_Date, Region) VALUES (%s, %s, %s, %s)", 
                       (product_id, sale_amount, sale_date, region))

    conn.commit()

start_time = time.time()
generate_sales_data(1_000_000) 
print(f"Data Insertion Time: {time.time() - start_time:.2f} seconds")

cursor.close()
conn.close()
