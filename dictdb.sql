DROP TABLE IF EXISTS dictionary;

CREATE TABLE IF NOT EXISTS dictionary (
	id SERIAL PRIMARY KEY,
	word TEXT,
	translation TEXT
);