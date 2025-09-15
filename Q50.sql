DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INT,
    name VARCHAR(20),
    age INT,
    gender VARCHAR(10)
);
INSERT INTO patients VALUES
(1, 'John Doe', 35, 'Male'),
(2, 'Jane Smith', 45, 'Female'),
(3, 'Alice Johnson', 25, 'Female');
-- Medications Table
DROP TABLE IF EXISTS medications;
CREATE TABLE medications (
    medication_id INT,
    medication_name VARCHAR(20),
    manufacturer VARCHAR(20)
);
INSERT INTO medications VALUES
(1, 'Aspirin', 'Pfizer'),
(2, 'Tylenol', 'Johnson & Johnson'),
(3, 'Lipitor', 'Pfizer');
-- Prescriptions Table
DROP TABLE IF EXISTS prescriptions;
CREATE TABLE prescriptions (
    prescription_id INT,
    patient_id INT,
    medication_id INT,
    prescription_date DATE
);
INSERT INTO prescriptions VALUES
(1, 1, 1, '2023-01-01'),
(2, 1, 2, '2023-02-15'),
(3, 2, 1, '2023-03-10'),
(4, 3, 3, '2023-04-20');
-- Adverse Reactions Table
DROP TABLE IF EXISTS adverse_reactions;
CREATE TABLE adverse_reactions (
    reaction_id INT,
    patient_id INT,
    reaction_description VARCHAR(20),
    reaction_date DATE
);
INSERT INTO adverse_reactions VALUES
(1, 1, 'Nausea', '2023-01-05'),
(2, 2, 'Headache', '2023-03-20'),
(3, 3, 'Dizziness', '2023-05-01'),
(4, 1, 'Rash', '2023-01-20');

select m.medication_id,m.medication_name, 
count(case when datediff(a.reaction_date, p.prescription_date) between 0 and 30
 then a.reaction_id end) as no_of_reacns
from medications m
join prescriptions p on m.medication_id=p.medication_id
join adverse_reactions a on p.patient_id=a.patient_id 
group by m.medication_id
order by m.medication_name;
