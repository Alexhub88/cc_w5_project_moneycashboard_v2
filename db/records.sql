DROP TABLE  transactions;
DROP TABLE  tagtypes;
DROP TABLE  merchants;

CREATE TABLE merchants(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE tagtypes(
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL4 PRIMARY KEY,
  merchant_id INT4 REFERENCES merchants(id) ON DELETE CASCADE,
  value INT4,
  tagtype_id INT4 REFERENCES tagtypes(id) ON DELETE CASCADE,
  date DATE
);
