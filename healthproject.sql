CREATE TABLE Department (
    DepartmentID NUMBER(10) PRIMARY KEY,
    Name VARCHAR2(50),
    Location VARCHAR2(50),
    Type VARCHAR2(50),
    CostCenterCode VARCHAR2(50),
    Virtual CHAR(1) CHECK (Virtual IN ('Y', 'N'))
);

CREATE TABLE Insurance (
    InsuranceID NUMBER(10) PRIMARY KEY,
    Provider VARCHAR2(50),
    PolicyNumber VARCHAR2(50),
    PolicyType VARCHAR2(50),
    CoverageStartDate DATE,
    CoverageEndDate DATE,
    Premium NUMBER(10,2),
    Deductible NUMBER(10,2),
    CoPayment NUMBER(10,2)
);

-- Create Nurse, Patient, Doctor, and Medication tables
CREATE TABLE Nurse (
    NurseID NUMBER(10) PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Gender CHAR(1),
    ContactNumber VARCHAR2(15),
    Email VARCHAR2(50),
    Qualification VARCHAR2(50),
    LicenseNumber VARCHAR2(50),
    YearsOfExperience NUMBER(3),
    DepartmentID NUMBER(10),
    Shift VARCHAR2(20),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Patient (
    PatientID NUMBER(10) PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    DOB DATE,
    Gender CHAR(1),
    ContactNumber VARCHAR2(15),
    Email VARCHAR2(50),
    Address VARCHAR2(100),
    EmergencyContactName VARCHAR2(50),
    EmergencyContactNumber VARCHAR2(15),
    PrimaryCarePhysician VARCHAR2(50),
    MedicalHistory CLOB,
    InsuranceID NUMBER(10),
    FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID)
);

CREATE TABLE Doctor (
    DoctorID NUMBER(10) PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Gender CHAR(1),
    ContactNumber VARCHAR2(15),
    Email VARCHAR2(50) NOT NULL,
    Specialization VARCHAR2(50),
    LicenseNumber VARCHAR2(50),
    YearsOfExperience NUMBER(3),
    DepartmentID NUMBER(10),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Medication (
    MedicationID NUMBER(10) PRIMARY KEY,
    DrugName VARCHAR2(100) NOT NULL,
    Barcode VARCHAR2(50) UNIQUE NOT NULL,
    Manufacturer VARCHAR2(100),
    DateManufactured DATE,
    ExpiryDate DATE,
    Description CLOB,
    DosageInstructions VARCHAR2(200),
    SideEffects CLOB,
    Price NUMBER(10, 2),
    PrescriptionRequired CHAR(1) CHECK (PrescriptionRequired IN ('Y', 'N'))
);

-- Create MedicalRecord, Prescription, and Billing tables
CREATE TABLE MedicalRecord (
    RecordID NUMBER(10) PRIMARY KEY,
    PatientID NUMBER(10),
    DoctorID NUMBER(10),
    Symptoms VARCHAR2(100),
    Diagnosis VARCHAR2(100),
    Treatment VARCHAR2(100),
    PrescriptionID NUMBER(10),
    TreatmentCost NUMBER(10, 2),
    DateOfRecord DATE,
    FollowUpDate DATE,
    Notes CLOB,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Prescription (
    PrescriptionID NUMBER(10) PRIMARY KEY,
    RecordID NUMBER(10),
    MedicationID NUMBER(10),
    Dosage VARCHAR2(50),
    Frequency VARCHAR2(50),
    StartDate DATE,
    EndDate DATE,
    Refills NUMBER(3),
    Pharmacy VARCHAR2(50),
    Price NUMBER(10, 2),
    FOREIGN KEY (RecordID) REFERENCES MedicalRecord(RecordID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);

CREATE TABLE Billing (
    BillID NUMBER(10) PRIMARY KEY,
    PatientID NUMBER(10),
    Amount NUMBER(10, 2),
    DateOfBilling DATE,
    PaymentMethod VARCHAR2(50),
    PaymentDate DATE,
    InsuranceID NUMBER(10),
    AmountCoveredByInsurance NUMBER(10, 2),
    Status VARCHAR2(10),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID)
);
CREATE TABLE Appointments (
    AppointmentID NUMBER(10) PRIMARY KEY,
    PatientID NUMBER(10),
    DoctorID NUMBER(10),
    NurseID NUMBER(10) NULL, -- Optional: In case a nurse is also assigned for the appointment
    DepartmentID NUMBER(10),
    AppointmentDate DATE
);

/* Values */
INSERT ALL
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (1, 'Pediatrics', 'Block A', 'Medical', 'CC123', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (2, 'Psychiatry', 'Block B', 'Medical', 'CC456', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (3, 'Orthopedics', 'Block C', 'Medical', 'CC789', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (4, 'Emergency Medicine', 'Block D', 'Medical', 'CC246', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (5, 'Urology', 'Block E', 'Medical', 'CC135', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (6, 'Neurology', 'Block F', 'Medical', 'CC680', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (7, 'Family Medicine', 'Block G', 'Medical', 'CC791', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (8, 'Anesthesiology', 'Block H', 'Medical', 'CC234', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (9, 'Pathology', 'Block I', 'Medical', 'CC567', 'N')
INTO Department (DepartmentID, Name, Location, Type, CostCenterCode, Virtual) VALUES (10, 'Gynaecology', 'Block J', 'Medical', 'CC908', 'N')
SELECT * FROM dual;



-- Insert values into the Insurance table with realistic insurance provider names
INSERT ALL
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (1111, 'BlueCross BlueShield', 'BC123456', 'Health', DATE '2021-01-01', DATE '2021-12-31', 150.00, 500.00, 20.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (2378, 'Aetna', 'AET987654', 'Health', DATE '2021-03-15', DATE '2021-12-31', 180.00, 300.00, 25.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (3770, 'UnitedHealthcare', 'UHC543210', 'Health', DATE '2021-02-10', DATE '2021-12-31', 200.00, 400.00, 15.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (4230, 'Cigna', 'CGN777777', 'Health', DATE '2021-04-01', DATE '2021-12-31', 130.00, 350.00, 10.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (5872, 'Humana', 'HUM555555', 'Health', DATE '2021-02-25', DATE '2021-12-31', 160.00, 250.00, 30.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (6651, 'Anthem', 'ANT111111', 'Health', DATE '2021-01-15', DATE '2021-12-31', 190.00, 450.00, 18.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (7000, 'Kaiser Permanente', 'KP888888', 'Health', DATE '2021-03-01', DATE '2021-12-31', 175.00, 320.00, 22.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (8433, 'Aflac', 'AFL222222', 'Health', DATE '2021-01-10', DATE '2021-12-31', 140.00, 400.00, 15.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (9700, 'MetLife', 'MET666666', 'Health', DATE '2021-04-15', DATE '2021-12-31', 170.00, 380.00, 20.00)
INTO Insurance (InsuranceID, Provider, PolicyNumber, PolicyType, CoverageStartDate, CoverageEndDate, Premium, Deductible, CoPayment) VALUES (1000, 'Cobra Insurance', 'CBI444444', 'Health', DATE '2021-02-01', DATE '2021-12-31', 155.00, 300.00, 25.00)
SELECT * FROM dual;

INSERT ALL
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2001, 'Paracetamol', '123456789001', 'PharmaCo', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Pain and fever reducer.', 'Take 1 tablet every 4-6 hours.', 'Nausea, upset stomach.', 5.99, 'N')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2002, 'Ibuprofen', '123456789002', 'MediCare', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Anti-inflammatory and pain reliever.', 'Take 1 tablet every 6-8 hours.', 'Dizziness, rash.', 7.49, 'N')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2003, 'Amoxicillin', '123456789003', 'BioHealth', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Antibiotic.', 'Take 1 capsule twice a day.', 'Diarrhea, stomach pain.', 12.99, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2004, 'Lisinopril', '123456789004', 'PharmaCo', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Treats high blood pressure.', 'Take 1 tablet daily.', 'Dizziness, headache.', 9.99, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2005, 'Metformin', '123456789005', 'MediCare', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Treats type 2 diabetes.', 'Take 1 tablet twice a day.', 'Nausea, upset stomach.', 8.49, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2006, 'Atorvastatin', '123456789006', 'BioHealth', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Lowers cholesterol.', 'Take 1 tablet daily.', 'Muscle pain, liver problems.', 11.99, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2007, 'Albuterol', '123456789007', 'PharmaCo', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Treats asthma and COPD.', 'Use as needed.', 'Shakiness, nervousness.', 15.99, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2008, 'Omeprazole', '123456789008', 'MediCare', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2025-08-01', 'YYYY-MM-DD'), 'Treats acid reflux.', 'Take 1 capsule daily.', 'Headache, stomach pain.', 10.49, 'N')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2009, 'Losartan', '123456789009', 'BioHealth', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'Treats high blood pressure.', 'Take 1 tablet daily.', 'Dizziness, fatigue.', 9.49, 'Y')
INTO Medication (MedicationID, DrugName, Barcode, Manufacturer, DateManufactured, ExpiryDate, Description, DosageInstructions, SideEffects, Price, PrescriptionRequired) VALUES (2010, 'Hydrochlorothiazide', '123456789010', 'PharmaCo', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'Diuretic.', 'Take 1 tablet daily.', 'Thirst, dry mouth.', 7.99, 'Y')
SELECT * FROM dual;


INSERT ALL
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5001, 'Nancy', 'Smith', 'F', '1234567891', 'nancy.smith@example.com', 'RN', 'NUR5001', 5, 1, 'Day')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5002, 'Robert', 'Johnson', 'M', '1234567892', 'robert.johnson@example.com', 'LPN', 'NUR5002', 3, 2, 'Night')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5003, 'Linda', 'Williams', 'F', '1234567893', 'linda.williams@example.com', 'RN', 'NUR5003', 7, 3, 'Day')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5004, 'Michael', 'Jones', 'M', '1234567894', 'michael.jones@example.com', 'LPN', 'NUR5004', 2, 4, 'Night')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5005, 'Karen', 'Brown', 'F', '1234567895', 'karen.brown@example.com', 'RN', 'NUR5005', 6, 5, 'Day')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5006, 'James', 'Davis', 'M', '1234567896', 'james.davis@example.com', 'LPN', 'NUR5006', 4, 6, 'Night')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5007, 'Patricia', 'Miller', 'F', '1234567897', 'patricia.miller@example.com', 'RN', 'NUR5007', 8, 7, 'Day')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5008, 'John', 'Wilson', 'M', '1234567898', 'john.wilson@example.com', 'LPN', 'NUR5008', 3, 8, 'Night')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5009, 'Jennifer', 'Moore', 'F', '1234567899', 'jennifer.moore@example.com', 'RN', 'NUR5009', 9, 9, 'Day')
INTO Nurse (NurseID, FirstName, LastName, Gender, ContactNumber, Email, Qualification, LicenseNumber, YearsOfExperience, DepartmentID, Shift) VALUES (5010, 'William', 'Taylor', 'M', '1234567800', 'william.taylor@example.com', 'LPN', 'NUR5010', 5, 10, 'Night')
SELECT * FROM dual;
INSERT ALL
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (1111, 'Dr. Max', 'Miller', 'M', '1234567890', 'max.miller@example.com', 'Pediatrics', 'LIC123', 15, 1)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (2546, 'Dr. Mia', 'Miller', 'F', '2345678901', 'mia.miller@example.com', 'Psychiatry', 'LIC456', 10, 2)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (3000, 'Dr. Mike', 'Davis', 'M', '3456789012', 'mike.davis@example.com', 'Orthopedics', 'LIC789', 8, 3)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (4789, 'Dr. Daisy', 'Davis', 'F', '4567890123', 'daisy.davis@example.com', 'Emergency Medicine', 'LIC246', 12, 4)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (5322, 'Dr. Daniel', 'Wilson', 'M', '5678901234', 'daniel.wilson@example.com', 'Urology', 'LIC135', 7, 5)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (6111, 'Dr. Winnie', 'Wilson', 'F', '6789012345', 'winnie.wilson@example.com', 'Neurology', 'LIC680', 9, 6)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (7000, 'Dr. William', 'Moore', 'M', '7890123456', 'william.moore@example.com', 'Family Medicine', 'LIC791', 6, 7)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (8324, 'Dr. Monica', 'Moore', 'F', '8901234567', 'monica.moore@example.com', 'Anesthesiology', 'LIC234', 11, 8)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (9333, 'Dr. Martin', 'Taylor', 'M', '9012345678', 'martin.taylor@example.com', 'Pathology', 'LIC567', 14, 9)
INTO Doctor (DoctorID, FirstName, LastName, Gender, ContactNumber, Email, Specialization, LicenseNumber, YearsOfExperience, DepartmentID) VALUES (1011, 'Dr. Tina', 'Taylor', 'F', '0123456789', 'tina.taylor@example.com', 'Gynaecology', 'LIC908', 5, 10)
SELECT * FROM dual;

--Patient
INSERT ALL
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (1789, 'John', 'Doe', DATE '1980-01-01', 'M', '1234567890', 'john.doe@gmail.com', '123 Main St, City', 'Jane Doe', '9876543210', 'Dr. Max Miller', 'No significant history.', 1111)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (2657, 'Jane', 'Doe', DATE '1985-02-02', 'F', '2345678901', 'jane.doe@outlook.com', '456 Elm St, Town', 'John Smith', '8765432109', 'Dr. Max Miller', 'Allergies to pollen.', 2378)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (3790, 'Jim', 'Smith', DATE '1990-03-03', 'M', '3456789012', 'jim.smith@gmail.com', '789 Oak St, Village', 'Sarah Johnson', '7654321098', 'Dr. Mike Davis', 'None.', 3770)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (4112, 'Jill', 'Smith', DATE '1995-04-04', 'F', '4567890123', 'jill.smith@yahoo.com', '890 Maple St, Hamlet', 'Jake Johnson', '6543210987', 'Dr. Mike Davis', 'Previous surgeries: Appendectomy.', 4230)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (5654, 'Joe', 'Johnson', DATE '2000-05-05', 'M', '5678901234', 'joe.johnson@hotmail.com', '901 Pine St, City', 'Emily Johnson', '5432109876', 'Dr. Daisy Davis', 'Asthma.', 5872)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (6667, 'Jenny', 'Johnson', DATE '2005-06-06', 'F', '6789012345', 'jenny.johnson@gmail.com', '234 Cedar St, Town', 'Daniel Johnson', '4321098765', 'Dr. Daisy Davis', 'None.', 6651)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (7811, 'Jack', 'Williams', DATE '2010-07-07', 'M', '7890123456', 'jack.williams@yahoo.com', '567 Birch St, Village', 'Olivia Williams', '3210987654', 'Dr. Daniel Wilson', 'Allergies: Peanuts.', 7000)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (8000, 'Jessica', 'Williams', DATE '2015-08-08', 'F', '8901234567', 'jessica.williams@outlook.com', '678 Walnut St, Hamlet', 'William Williams', '2109876543', 'Dr. Daniel Wilson', 'None.', 8433)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (9754, 'James', 'Brown', DATE '2020-09-09', 'M', '9012345678', 'james.brown@bing.com', '789 Oak St, City', 'Sophia Brown', '1098765432', 'Dr. Winnie Wilson', 'None.', 9700)
INTO Patient (PatientID, FirstName, LastName, DOB, Gender, ContactNumber, Email, Address, EmergencyContactName, EmergencyContactNumber, PrimaryCarePhysician, MedicalHistory, InsuranceID) VALUES (1056, 'Julia', 'Brown', DATE '2021-10-10', 'F', '0123456789', 'julia.brown@yahoo.com', '123 Elm St, Town', 'Ethan Brown', '9876543210', 'Dr. Winnie Wilson', 'Allergies to penicillin.', 1000)
SELECT * FROM dual;

--Doctor

INSERT ALL
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (1, 1789, 1111, 'Fever, Cough', 'Common Cold', 'Rest, Fluids', NULL, 25.00, DATE '2023-08-06', DATE '2023-08-10', 'Recheck if symptoms persist.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (2, 2657, 2546, 'Anxiety, Sleeplessness', 'Generalized Anxiety Disorder', 'Therapy, Meditation', NULL, 40.00, DATE '2023-09-06', DATE '2023-09-15', 'Follow up on progress.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (3, 3790, 3000, 'Knee Pain', 'Sprained Knee', 'Rest, Ice, Compression', NULL, 30.00, DATE '2023-08-07', DATE '2023-08-14', 'Physical therapy recommended.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (4, 4112, 4789, 'Fatigue, Weight Gain', 'Hypothyroidism', 'Hormone Replacement', NULL, 15.00, DATE '2023-10-08', DATE '2023-10-15', 'Monitor thyroid levels.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (5, 5654, 5322, 'Heartburn', 'Gastric Reflux', 'Dietary Changes', NULL, 10.00, DATE '2023-09-09', DATE '2023-09-16', 'Avoid spicy foods.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (6, 6667, 6111, 'Depression', 'Major Depressive Disorder', 'Therapy, Medication', NULL, 35.00, DATE '2023-08-10', DATE '2023-08-20', 'Monitor mood changes.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (7, 7811, 7000, 'High Blood Pressure', 'Hypertension', 'Lifestyle Changes', NULL, 20.00, DATE '2023-08-11', DATE '2023-08-18', 'Diet and exercise recommendations.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (8, 8000, 8324, 'Cholesterol Check', 'Hypercholesterolemia', 'Dietary Changes', NULL, 25.00, DATE '2023-08-12', DATE '2023-08-19', 'Follow up on cholesterol levels.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (9, 9754, 9333, 'Asthma Exacerbation', 'Asthma', 'Inhaler, Rest', NULL, 15.00, DATE '2023-08-13', DATE '2023-08-20', 'Monitor lung function.')
INTO MedicalRecord (RecordID, PatientID, DoctorID, Symptoms, Diagnosis, Treatment, PrescriptionID, TreatmentCost, DateOfRecord, FollowUpDate, Notes) VALUES (10, 1056, 1011, 'Headache', 'Tension Headache', 'Rest, Hydration', NULL, 5.00, DATE '2023-08-14', DATE '2023-08-21', 'Stress-related headache.')
SELECT * FROM dual;

INSERT ALL
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (1, 1, 2001, '2 tsp', 'Every 6 hours', DATE '2023-08-06', DATE '2023-08-15', 2, 'PharmaCare', 10.00) -- Assuming 'Cough Syrup' corresponds to 'Paracetamol'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (2, 2, 2002, '1 tablet', 'Once daily', DATE '2023-09-06', DATE '2023-09-20', 1, 'MediCure', 20.00) -- 'Anti-anxiety Medication' -> 'Ibuprofen'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (3, 3, 2003, '1 tablet', 'As needed', DATE '2023-08-07', DATE '2023-08-14', 3, 'HealthRx', 5.00) -- 'Pain Reliever' -> 'Amoxicillin'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (4, 4, 2004, '1 tablet', 'Once daily', DATE '2023-10-08', DATE '2023-10-20', 2, 'PharmaNow', 10.00) -- 'Levothyroxine' -> 'Lisinopril'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (5, 5, 2005, '1 tablet', 'Twice daily', DATE '2023-09-09', DATE '2023-09-20', 1, 'MediCure', 8.00) -- 'Antacid' -> 'Metformin'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (6, 6, 2006, '1 tablet', 'Once daily', DATE '2023-08-10', DATE '2023-08-25', 2, 'HealthRx', 15.00) -- 'Antidepressant' -> 'Atorvastatin'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (7, 7, 2007, '1 tablet', 'Three times daily', DATE '2023-08-11', DATE '2023-08-22', 3, 'PharmaNow', 12.00) -- 'Blood Pressure Medication' -> 'Albuterol'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (8, 8, 2008, '1 tablet', 'Once daily', DATE '2023-08-12', DATE '2023-08-25', 1, 'MediCure', 10.00) -- 'Statins' -> 'Omeprazole'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (9, 9, 2009, '2 puffs', 'Once daily', DATE '2023-08-13', DATE '2023-08-21', 2, 'HealthRx', 10.00) -- 'Albuterol' -> 'Losartan'
INTO Prescription (PrescriptionID, RecordID, MedicationID, Dosage, Frequency, StartDate, EndDate, Refills, Pharmacy, Price)
VALUES (10, 10, 2010, '1 tablet', 'As needed', DATE '2023-08-14', DATE '2023-08-24', 3, 'PharmaNow', 5.00) -- Assuming another 'Pain Reliever' -> 'Hydrochlorothiazide'
SELECT * FROM dual;

INSERT ALL
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (1, 1789, 150.00, DATE '2023-08-06', 'Credit Card', DATE '2023-08-07', 1111, 100.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (2, 2657, 80.50, DATE '2023-09-06', 'Cash', DATE '2023-09-07', 2378, 50.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (3, 3790, 200.75, DATE '2023-08-07', 'Debit Card', DATE '2023-08-08', 3770, 180.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (4, 4112, 45.25, DATE '2023-10-08', 'Cash', DATE '2023-10-09', 4230, 0.00, 'Pending')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (5, 5654, 75.90, DATE '2023-09-09', 'Credit Card', DATE '2023-09-10', 5872, 70.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (6, 6667, 30.00, DATE '2023-08-10', 'Debit Card', DATE '2023-08-11', 6651, 20.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (7, 7811, 120.25, DATE '2023-08-11', 'Cash', DATE '2023-08-12', 7000, 100.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (8, 8000, 50.75, DATE '2023-08-12', 'Credit Card', DATE '2023-08-13', 8433, 30.00, 'Paid')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (9, 9754, 15.50, DATE '2023-08-13', 'Cash', DATE '2023-08-14', 9700, 0.00, 'Pending')
INTO Billing (BillID, PatientID, Amount, DateOfBilling, PaymentMethod, PaymentDate, InsuranceID, AmountCoveredByInsurance, Status) VALUES (10, 1056, 25.00, DATE '2023-08-14', 'Debit Card', DATE '2023-08-15', 1000, 20.00, 'Paid')
SELECT * FROM dual;

INSERT ALL
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1001, 101, 201, 5001, 1, TO_DATE('2023-08-10', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1002, 102, 202, 5002, 2, TO_DATE('2023-08-11', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, DepartmentID, AppointmentDate) VALUES (1003, 103, 203, 3, TO_DATE('2023-08-12', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1004, 104, 204, 5004, 4, TO_DATE('2023-08-13', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1005, 105, 205, 5005, 5, TO_DATE('2023-08-14', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, DepartmentID, AppointmentDate) VALUES (1006, 106, 206, 6, TO_DATE('2023-08-15', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1007, 107, 207, 5007, 7, TO_DATE('2023-08-16', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, DepartmentID, AppointmentDate) VALUES (1008, 108, 208, 8, TO_DATE('2023-08-17', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, NurseID, DepartmentID, AppointmentDate) VALUES (1009, 109, 209, 5009, 9, TO_DATE('2023-08-18', 'YYYY-MM-DD'))
INTO Appointments (AppointmentID, PatientID, DoctorID, DepartmentID, AppointmentDate) VALUES (1010, 110, 210, 10, TO_DATE('2023-08-19', 'YYYY-MM-DD'))
SELECT * FROM dual;


--1. 
select cast(ceil( months_between(enddate,startdate)) AS INT) AS "Months" from prescription;


--cast: converts the result to integer data type
--ceil: rounds up to the nearest whole number

--2.

SELECT CONCAT(CONCAT(CONCAT(CONCAT(firstname,' '),lastname), ' specializes in '), specialization) AS concatenatedstring FROM doctor;


--concat(firstname,lastname) : concatenates the firstname and lastname together
--CONCAT(CONCAT(FIRSTNAME, LASTNAME), ' specializes in ') : concatenates the firstname,lastname and specailizes in
-- last concat concatenates all of it to specailization



--4. Operators

 select * from medication where drugname = 'Lisinopril' AND price=9.99;

-- retrives columns where prescription = lisinopril and diagnosis = hypertension

 select * from billing where amount<200 and amountcoveredbyinsurance= 0 and status = 'Pending';

-- retreives columns in billing where amount is less than 200 and insurance is not cover

--5. Joining

SELECT 
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    d.FirstName || ' ' || d.LastName AS DoctorName,
    mr.Symptoms,
    mr.Diagnosis,
    mr.Treatment
FROM Patient p
JOIN (
    SELECT 
        PatientID,
        MAX(DateOfRecord) AS LatestRecordDate
    FROM MedicalRecord
    GROUP BY PatientID
) latest_mr ON p.PatientID = latest_mr.PatientID
JOIN MedicalRecord mr ON p.PatientID = mr.PatientID AND latest_mr.LatestRecordDate = mr.DateOfRecord
JOIN Doctor d ON mr.DoctorID = d.DoctorID;

--5. b

SELECT p.FirstName || ' ' || p.LastName AS PatientName, SUM(mr.TreatmentCost) AS TotalCost 

FROM Patient p 

JOIN MedicalRecord mr ON p.PatientID = mr.PatientID 

GROUP BY p.FirstName, p.LastName; 

--5.c

SELECT p.FirstName || ' ' || p.LastName AS PatientName 

FROM Patient p 

LEFT JOIN MedicalRecord mr ON p.PatientID = mr.PatientID 

WHERE mr.RecordID IS NULL; 