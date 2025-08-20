-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS db_medi_center
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE db_medi_center;

-- =======================
-- Tabla: USERS
-- =======================
CREATE TABLE USERS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('ADMIN', 'DOCTOR', 'RECEPTIONIST', 'PATIENT') NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =======================
-- Tabla: PATIENTS
-- =======================
CREATE TABLE PATIENTS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  identification_number VARCHAR(50) UNIQUE,
  birth_date DATE,
  gender ENUM('M', 'F', 'OTHER'),
  phone VARCHAR(30),
  address TEXT,
  email VARCHAR(150),
  emergency_contact VARCHAR(150),
  emergency_phone VARCHAR(30),
  blood_type VARCHAR(10),
  allergies TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_patient_user FOREIGN KEY (user_id) REFERENCES USERS(id)
);

-- =======================
-- Tabla: DOCTORS
-- =======================
CREATE TABLE DOCTORS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  license_number VARCHAR(50) UNIQUE,
  specialty VARCHAR(150),
  phone VARCHAR(30),
  email VARCHAR(150),
  consultation_fee DECIMAL(10,2),
  schedule_start TIME,
  schedule_end TIME,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_doctor_user FOREIGN KEY (user_id) REFERENCES USERS(id)
);

-- =======================
-- Tabla: RESOURCES
-- =======================
CREATE TABLE RESOURCES (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  type ENUM('CONSULTATION_ROOM', 'EQUIPMENT', 'LABORATORY') NOT NULL,
  description TEXT,
  capacity INT,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =======================
-- Tabla: APPOINTMENTS
-- =======================
CREATE TABLE APPOINTMENTS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  patient_id BIGINT NOT NULL,
  doctor_id BIGINT NOT NULL,
  resource_id BIGINT,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  duration_minutes INT,
  status ENUM('SCHEDULED', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'NO_SHOW') DEFAULT 'SCHEDULED',
  reason TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES PATIENTS(id),
  CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTORS(id),
  CONSTRAINT fk_appointment_resource FOREIGN KEY (resource_id) REFERENCES RESOURCES(id)
);

-- =======================
-- Tabla: MEDICAL_RECORDS
-- =======================
CREATE TABLE MEDICAL_RECORDS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  patient_id BIGINT NOT NULL,
  doctor_id BIGINT NOT NULL,
  appointment_id BIGINT NOT NULL,
  record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  chief_complaint TEXT,
  physical_examination TEXT,
  diagnosis TEXT,
  treatment_plan TEXT,
  vital_signs JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_record_patient FOREIGN KEY (patient_id) REFERENCES PATIENTS(id),
  CONSTRAINT fk_record_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTORS(id),
  CONSTRAINT fk_record_appointment FOREIGN KEY (appointment_id) REFERENCES APPOINTMENTS(id)
);

-- =======================
-- Tabla: PRESCRIPTIONS
-- =======================
CREATE TABLE PRESCRIPTIONS (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  medical_record_id BIGINT NOT NULL,
  medication_name VARCHAR(150) NOT NULL,
  dosage VARCHAR(100),
  frequency VARCHAR(100),
  duration_days INT,
  instructions TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_prescription_record FOREIGN KEY (medical_record_id) REFERENCES MEDICAL_RECORDS(id)
);

-- =======================
-- Tabla: INVOICES
-- =======================
CREATE TABLE INVOICES (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  patient_id BIGINT NOT NULL,
  appointment_id BIGINT NOT NULL,
  invoice_number VARCHAR(100) NOT NULL UNIQUE,
  issue_date DATE,
  due_date DATE,
  subtotal DECIMAL(10,2),
  tax_amount DECIMAL(10,2),
  total_amount DECIMAL(10,2),
  status ENUM('PENDING', 'PAID', 'CANCELLED', 'OVERDUE') DEFAULT 'PENDING',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_invoice_patient FOREIGN KEY (patient_id) REFERENCES PATIENTS(id),
  CONSTRAINT fk_invoice_appointment FOREIGN KEY (appointment_id) REFERENCES APPOINTMENTS(id)
);