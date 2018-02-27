DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE categories;

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null UNIQUE
);

CREATE TABLE categories (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255) not null UNIQUE
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  amount INT4 NOT NULL,
  merchant_id INT4 REFERENCES merchants(id),
  category_id INT4 REFERENCES categories(id)
);
