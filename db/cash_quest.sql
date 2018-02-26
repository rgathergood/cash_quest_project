DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE merchants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) not null UNIQUE
);

CREATE TABLE tags (
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255) not null UNIQUE
);

CREATE TABLE transactions (
  id SERIAL4 PRIMARY KEY,
  amount INT4 NOT NULL,
  merchant_id INT4 REFERENCES merchants(id),
  tag_id INT4 REFERENCES tags(id)
);
