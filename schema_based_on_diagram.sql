-- create db
CREATE DATABASE hospital
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE hospital
    IS 'A hospital db based on a existing ERD';
    
-- create patients table
BEGIN;

CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    PRIMARY KEY(id)
);

COMMIT;

-- medical_histories table
BEGIN;

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(50),
    PRIMARY KEY(id),
    CONSTRAINT fk_medical_histories FOREIGN KEY(patient_id)
    REFERENCES patients(id)
);

COMMIT;

-- treatments table
BEGIN;

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(100),
    name VARCHAR(100),
    PRIMARY KEY(id)
);

COMMIT;

-- invoices table
CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT fk_invoices FOREIGN KEY(medical_history_id)
    REFERENCES medical_histories(id),
    PRIMARY KEY(id)
);

COMMIT;

-- invoice_items table
BEGIN;

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT fk_invoice_items1 FOREIGN KEY (invoice_id)
    REFERENCES invoices(id),
    CONSTRAINT fk_invoice_items2 FOREIGN KEY (treatment_id)
    REFERENCES treatments(id),
    PRIMARY KEY (id)
);

COMMIT;

--Creating joining table between medical_histories and treatments tables
BEGIN;

CREATE TABLE history_treatments (
    medical_histories_id INT,
    treatments_id INT, 
    CONSTRAINT fk_history_treatments1 FOREIGN KEY (medical_histories_id)
    REFERENCES medical_histories(id),
    CONSTRAINT fk_history_treatments2 FOREIGN KEY (treatments_id)
    REFERENCES treatments(id)
);

COMMIT;
 

