CREATE INDEX idx_user_id ON "User" ("User_ID");

CREATE INDEX idx_transaction_id ON "Transaction" ("Transaction_ID");
CREATE INDEX idx_transaction_user_id ON "Transaction" ("User_ID");

CREATE INDEX idx_transaction_timestamp ON "Transaction" ("Timestamp");

CREATE INDEX idx_transaction_payment ON "Transaction" ("Payment_Type");

CREATE INDEX idx_vendor_id ON "Vendor" ("Vendor_ID");

CREATE INDEX idx_investment_id ON "Investment" ("Investment_ID");
CREATE INDEX idx_investment_user_id ON "Investment" ("User_ID");
