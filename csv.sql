-- insert python script into sql
-- run python code
-- insert genreated 5 csv files into sql

-- user.csc
LOAD DATA INFILE 'user.csv'
INTO TABLE User
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- transaction.csv
LOAD DATA INFILE 'transaction.csv'
INTO TABLE Transaction
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- investment.csv
LOAD DATA INFILE 'Investment.csv'
INTO TABLE Investment
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- vendor.csv
LOAD DATA INFILE 'vedor.csv'
INTO TABLE Vendor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;