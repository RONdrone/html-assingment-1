sql
-- =========================================
-- Create patients table
-- =========================================
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each patient
    first_name VARCHAR(50) NOT NULL,            -- Patient's first name
    last_name VARCHAR(50) NOT NULL,             -- Patient's last name
    date_of_birth DATE NOT NULL,                 -- Patient's date of birth
    gender VARCHAR(10) NOT NULL,                 -- Patient's gender
    language VARCHAR(20) NOT NULL               -- Patient's preferred language
);

-- =========================================
-- Create providers table
-- =========================================
CREATE TABLE providers (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each provider
    first_name VARCHAR(50) NOT NULL,            -- Provider's first name
    last_name VARCHAR(50) NOT NULL,             -- Provider's last name
    provider_speciality VARCHAR(50) NOT NULL,   -- Provider's specialty
    email_address VARCHAR(100),                 -- Provider's email address
    phone_number VARCHAR(15),                   -- Provider's phone number
    date_joined DATE NOT NULL                   -- Date when the provider joined
);

-- =========================================
-- Create visits table
-- =========================================
CREATE TABLE visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,      -- Unique identifier for each visit
    patient_id INT,                             -- Foreign key referencing patients(patient_id)
    provider_id INT,                            -- Foreign key referencing providers(provider_id)
    date_of_visit DATE NOT NULL,                -- Date of the visit
    date_scheduled DATE NOT NULL,               -- Scheduled date for the visit
    visit_department_id INT,                    -- Department where the visit occurred
    visit_type VARCHAR(50) NOT NULL,            -- Type of the visit
    blood_pressure_systollic INT,               -- Systolic blood pressure reading
    blood_pressure_diastollic DECIMAL(5,2),     -- Diastolic blood pressure reading
    pulse DECIMAL(5,2),                         -- Pulse reading
    visit_status VARCHAR(50) NOT NULL,          -- Status of the visit
    
    -- Foreign key constraints
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),  -- Ensures the patient exists
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id) -- Ensures the provider exists
);

-- =========================================
-- Create ed_visits table
-- =========================================
CREATE TABLE ed_visits (
    ed_visit_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each ED visit
    visit_id INT,                               -- Foreign key referencing visits(visit_id)
    patient_id INT,                             -- Foreign key referencing patients(patient_id)
    acuity INT NOT NULL,                       -- Acuity level of the visit
    reason_for_visit VARCHAR(100) NOT NULL,    -- Reason for the ED visit
    disposition VARCHAR(50) NOT NULL,          -- Disposition after the ED visit
    
    -- Foreign key constraints
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),  -- Ensures the visit exists
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) -- Ensures the patient exists
);

-- =========================================
-- Create admissions table
-- =========================================
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each admission
    patient_id INT,                             -- Foreign key referencing patients(patient_id)
    admission_date DATE NOT NULL,               -- Date of admission
    discharge_date DATE NOT NULL,               -- Date of discharge
    discharge_disposition VARCHAR(50) NOT NULL, -- Disposition upon discharge
    service VARCHAR(50) NOT NULL,               -- Service or department where admitted
    primary_diagnosis VARCHAR(100) NOT NULL,    -- Primary diagnosis at admission
    
    -- Foreign key constraints
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) -- Ensures the patient exists
);

-- =========================================
-- Create discharges table
-- =========================================
CREATE TABLE discharges (
    discharge_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each discharge
    admission_id INT,                           -- Foreign key referencing admissions(admission_id)
    patient_id INT,                             -- Foreign key referencing patients(patient_id)
    discharge_date DATE NOT NULL,               -- Date of discharge
    discharge_disposition VARCHAR(50) NOT NULL, -- Disposition upon discharge
    
    -- Foreign key constraints
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id),  -- Ensures the admission exists
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) -- Ensures the patient exists
);
