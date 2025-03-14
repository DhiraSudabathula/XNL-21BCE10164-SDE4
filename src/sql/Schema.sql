-- user table
CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20) UNIQUE NOT NULL,
    KYC_status BOOLEAN NOT NULL,
    Account_type VARCHAR(50) CHECK (Account_type IN ('Savings', 'Current', 'Investment'))
);

-- Investment table
CREATE TABLE Investment (
    Investment_ID INT PRIMARY KEY,
    User_ID INT,
    Asset_Type VARCHAR(100) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL CHECK (Amount > 0),
    Risk_level VARCHAR(50) CHECK (Risk_level IN ('Low', 'Medium', 'High')),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

-- stakeholders table
CREATE TABLE Stakeholders (
    Stakeholder_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(100) NOT NULL,
    Contact_Details VARCHAR(255) NOT NULL
);

-- Audits table
CREATE TABLE Audits (
    Audit_ID INT PRIMARY KEY,
    Stakeholder_ID INT,
    User_ID INT,
    Audit_data TEXT NOT NULL,
    FOREIGN KEY (Stakeholder_ID) REFERENCES Stakeholders(Stakeholder_ID) ON DELETE SET NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

-- vendor table
CREATE TABLE Vendor (
    Vendor_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Service_Type VARCHAR(100) NOT NULL,
    Contract_Details TEXT NOT NULL,
    Total_Revenue DECIMAL(15,2) DEFAULT 0 CHECK (Total_Revenue >= 0),
    Success_Rate DECIMAL(5,2) CHECK (Success_Rate BETWEEN 0 AND 100)
);

-- payment gateway table
CREATE TABLE Payment_Gateway (
    Gateway_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    API_Details TEXT NOT NULL,
    Supported_Currencies TEXT NOT NULL,
    Vendor_ID INT,
    FOREIGN KEY (Vendor_ID) REFERENCES Vendor(Vendor_ID) ON DELETE SET NULL
);

-- transaction table
CREATE TABLE Transaction (
    Transaction_ID INT PRIMARY KEY,
    User_ID INT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Transaction_Status VARCHAR(50) CHECK (Transaction_Status IN ('Pending', 'Completed', 'Failed')),
    Payment_Type VARCHAR(50) NOT NULL,
    Gateway_ID INT,
    Transaction_Fee DECIMAL(10,2) CHECK (Transaction_Fee >= 0),
    Discount DECIMAL(10,2) CHECK (Discount >= 0),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Gateway_ID) REFERENCES Payment_Gateway(Gateway_ID) ON DELETE SET NULL
);

-- market data table
CREATE TABLE Market_Data (
Marketdata_ID INT PRIMARY KEY,
    Vendor_ID INT,
    Asset_Type VARCHAR(100) NOT NULL,
    Price DECIMAL(15,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (Vendor_ID) REFERENCES Vendor(Vendor_ID) ON DELETE CASCADE
);

-- compliance security table
CREATE TABLE Compliance_Security (
    Compliance_ID INT PRIMARY KEY,
    User_ID INT,
    KYC_Status BOOLEAN NOT NULL,
    Fraud_Risk_Score INT CHECK (Fraud_Risk_Score BETWEEN 0 AND 100),
    Regulation_Compliance VARCHAR(255) NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE
);

-- to check if user KYC status is verified before allowing investment
DELIMITER $$

CREATE TRIGGER before_investment_insert
BEFORE INSERT ON Investment
FOR EACH ROW
BEGIN
    DECLARE user_kyc TINYINT(1);
    SELECT KYC_status INTO user_kyc FROM User WHERE User_ID = NEW.User_ID;
    IF user_kyc = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'KYC verification required before investment';
    END IF;
END $$
DELIMITER ;

-- Trigger to enforce fraud detection before transaction
DELIMITER $$
CREATE TRIGGER before_transaction_insert
BEFORE INSERT ON Transaction
FOR EACH ROW
BEGIN
    DECLARE fraud_score INT;
    SELECT Fraud_Risk_Score INTO fraud_score 
    FROM Compliance_Security 
    WHERE User_ID = NEW.User_ID 
    LIMIT 1;
    IF fraud_score > 80 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction flagged due to high fraud risk';
    END IF;
END $$
DELIMITER ;








