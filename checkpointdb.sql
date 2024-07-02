-----------
--- DDL ---
-----------
-- 1.2 - 1.3 create tables with data types
DROP VIEW IF EXISTS view_contacts;
DROP TABLE IF EXISTS contact_categories, contact_types, contacts, items;

CREATE TABLE IF NOT EXISTS contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	organization VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS items (
	contact VARCHAR(30) NOT NULL,
	contact_id INT NOT NULL,
	contact_type_id INT NOT NULL,
	contact_category_id INT NOT NULL,
	FOREIGN KEY (contact_id) REFERENCES contacts(id),
	FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
	FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id)
);

-----------
--- DML ---
-----------
-- 1.4 - 1.5 add data, including self in items
INSERT INTO contact_categories(contact_category) VALUES
	('Home'),
	('Work'),
	('Fax');

INSERT INTO contact_types(contact_type) VALUES
	('Email'),
	('Phone'),
	('Skype'),
	('Instagram');

INSERT INTO contacts(first_name, last_name, title, organization) VALUES
	('Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna', 'Sundh', null, null),
	('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
	('Ann-Marie', 'Bergqvist', 'Cousin', null),
	('Herman', 'Appelkvist', null, null),
	('Anna', 'Valdez', null, null);

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
	('011-12 33 45', 3, 2, 1),
	('goran@infolab.se', 3, 1, 2),
	('010-88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2),
	('+1510-295-8777', 6, 2, 1);

-- 1.6 unused contact types query
SELECT ct.contact_type
	FROM contact_types ct
	LEFT JOIN items i ON i.contact_type_id = ct.id
	WHERE i.contact_type_id IS NULL;

-- 1.7 view contacts
CREATE VIEW view_contacts AS
	SELECT c.first_name, c.last_name, i.contact, ct.contact_type, cc.contact_category
		FROM contacts c
		JOIN items i ON i.contact_id = c.id
		JOIN contact_types ct ON ct.id = i.contact_type_id
		JOIN contact_categories cc ON cc.id = i.contact_category_id;

-- 1.8 list all columns
SELECT c.first_name, c.last_name, c.title, c.organization,
		i.contact, ct.contact_type, cc.contact_category
	FROM contacts c
	FULL JOIN items i ON i.contact_id = c.id
	FULL JOIN contact_types ct ON ct.id = i.contact_type_id
	FULL JOIN contact_categories cc ON cc.id = i.contact_category_id;

	