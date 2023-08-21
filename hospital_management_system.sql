CREATE TABLE hospital (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    hospital_name VARCHAR(100),
    director_first_name VARCHAR(25),
    director_last_name VARCHAR(25),
    building ENUM('A', 'B', 'C', 'D'),
    floor TINYINT UNSIGNED,
    opening_year DATE,
    contact_phone VARCHAR(15) DEFAULT '994501234567',
    contact_email VARCHAR(100) DEFAULT 'info@samplehospital.com',
    web_url VARCHAR(100) DEFAULT 'www.samplehospital.com',
    CONSTRAINT ck_floor CHECK (floor BETWEEN 1 AND 15),
    CONSTRAINT ck_opening_year CHECK (opening_year >= '2023-01-01'),
    CONSTRAINT pk_hospital PRIMARY KEY (id)
);

CREATE TABLE department (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    department_name VARCHAR(100),
    building ENUM('A', 'B', 'C', 'D'),
    floor TINYINT UNSIGNED,
    contact_phone VARCHAR(15) DEFAULT '994501234567',
    hospital_id tinyint UNSIGNED,
    CONSTRAINT pk_department PRIMARY KEY (id),
    CONSTRAINT uq_department UNIQUE (department_name),
    CONSTRAINT ck_floor_department CHECK (floor BETWEEN 1 AND 15),
    CONSTRAINT fk_hospital_id FOREIGN KEY (hospital_id)
        REFERENCES hospital (id)
);

CREATE TABLE speciality (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    speciality_name VARCHAR(100) NOT NULL,
    speciality_keycode VARCHAR(20),
    start_of_activity DATE,
    department_id tinyint UNSIGNED,
    CONSTRAINT pk_specialty PRIMARY KEY (id, specialty_keycode),
    CONSTRAINT fk_department_id FOREIGN KEY (department_id)
        REFERENCES department (id),
    CONSTRAINT ck_activity CHECK (start_of_activity >= '2023-01-01')
);

CREATE TABLE patient_service (
    id INT UNSIGNED AUTO_INCREMENT,
    patient_service_name ENUM('regular', 'emergency', 'specialty'),
    CONSTRAINT pk_patient_service PRIMARY KEY (id)
);

CREATE TABLE payment_basis (
    id INT UNSIGNED AUTO_INCREMENT,
    payment_basis ENUM('cash', 'insurance'),
    CONSTRAINT pk_payment_basis PRIMARY KEY (id)
);

CREATE TABLE patient (
    id INT UNSIGNED AUTO_INCREMENT,
    patient_name VARCHAR(25) NOT NULL,
    patient_surname VARCHAR(25) NOT NULL,
    father_name VARCHAR(25) NOT NULL,
    birth_date DATE,
    contact_phone VARCHAR(15) NOT NULL,
    contact_address VARCHAR(100),
    email VARCHAR(100),
    health_condition VARCHAR(100),
    patient_service_id INT UNSIGNED,
    payment_basis_id INT UNSIGNED,
    speciality_id tinyint UNSIGNED,
    CONSTRAINT pk_patient PRIMARY KEY (id),
    CONSTRAINT ck_birth_date CHECK (birth_date > '1930-01-01'),
    CONSTRAINT fk_speciality FOREIGN KEY (speciality_id)
        REFERENCES speciality (id),
    CONSTRAINT fk_payment_basis FOREIGN KEY (payment_basis_id)
        REFERENCES payment_basis (id),
    CONSTRAINT fk_patient_service FOREIGN KEY (patient_service_id)
        REFERENCES patient_service (id)
);
