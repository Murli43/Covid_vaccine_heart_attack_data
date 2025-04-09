-- Selecting the `Heart_Attack_Vaccine` database to ensure all subsequent queries are executed within the correct database context.
use Heart_Attack_Vaccine


-- Selecting all records from the `vaccine_heart_data` table to view Patients details
SELECT * FROM vaccine_heart_data


--Q1. How many patients received each vaccine dose ?
SELECT 
    Vaccine_Dose, 
        COUNT(*) AS PatientCount
FROM 
    vaccine_heart_data
GROUP BY 
    Vaccine_Dose


--Q2. What is the average age of patients by gender?
SELECT 
    Gender, 
        AVG(Age) AS Average_age
FROM 
    vaccine_heart_data
GROUP BY 
    Gender


--Q3. How many patients got vaccinated each year?
SELECT 
    YEAR(Vaccination_Date) AS Year, 
        COUNT(Patient_ID) AS Total_patients
FROM 
    vaccine_heart_data
GROUP BY 
    YEAR(Vaccination_Date)


--Q4. Which city had the highest number of vaccinated individuals?
SELECT 
    [Location], 
        COUNT(Patient_ID) AS Highest_number_of_vaccinated
FROM 
    vaccine_heart_data
GROUP BY 
    [Location]
ORDER BY Highest_number_of_vaccinated DESC


--Q5. How many patients had each type of pre-existing condition?
SELECT 
    Pre_existing_Conditions, 
        COUNT(*) AS Total_patients
FROM 
    vaccine_heart_data
GROUP BY 
    Pre_existing_Conditions


--Q6. What percentage of patients had no pre-existing conditions?
SELECT 
    COUNT(*) * 100 / (SELECT COUNT(*) FROM vaccine_heart_data) AS Percentages 
FROM 
    vaccine_heart_data
WHERE Pre_existing_Conditions = 'None'


--Q7.  Is  there  a  significant  difference  in  average  cholesterol  levels  between  patients  with  and  without diabetes?
SELECT 
    Diabetes_Status, 
        AVG(Cholesterol_Level) AS Average_cholesterol_levels
FROM 
    vaccine_heart_data
GROUP BY 
    Diabetes_Status


--Q8. How does BMI vary with smoking history?
SELECT 
    Smoking_History, 
        ROUND(AVG(BMI),2) AS Avg_BMI, 
            ROUND(MIN(BMI),2) AS Min_BMI, 
                MAX(BMI) AS Max_BMI, 
                    COUNT(*) AS Patient_count
FROM 
    vaccine_heart_data
GROUP BY 
    Smoking_History


--Q9. How many patients suffered a heart attack after vaccination?
SELECT  
    COUNT(Heart_Attack_Date) AS Count_of_Heart_attack
FROM 
    vaccine_heart_data
WHERE Heart_Attack_Date IS NOT NULL


--Q10. What is the distribution of heart attack severity by age group?
SELECT 
    CASE 
        WHEN Age BETWEEN 0  AND 29 THEN '0-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END AS Age_Group,
    Severity, 
    COUNT(*) AS Patient_count
FROM vaccine_heart_data
WHERE Heart_Attack_Date IS NOT NULL AND Severity IS NOT NULL
GROUP BY 
    CASE 
        WHEN Age BETWEEN 0  AND 29 THEN '0-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END,
    Severity
ORDER BY Age_Group, Severity


--Q11. What are the outcomes (e.g., recovered, deceased) of patients who had heart attacks?
SELECT 
    Outcome, 
        COUNT(*) AS Patient_count 
FROM 
    vaccine_heart_data
WHERE Heart_Attack_Date IS NOT NULL AND Outcome IS NOT NULL
GROUP BY 
    Outcome


--Q12. Is there a pattern between vaccine dose and heart attack occurrence?
SELECT 
    Vaccine_Dose, 
        COUNT(*) AS Total_patients,
            SUM(CASE WHEN Heart_Attack_Date IS NOT NULL THEN 1 ELSE 0 END) AS Heart_attack_patients,
                CAST(SUM(CASE WHEN Heart_Attack_Date IS NOT NULL THEN 1 ELSE 0 END) * 100 / COUNT(*) AS DECIMAL(5,2))AS Heart_attack_percentage
FROM 
    vaccine_heart_data
WHERE Vaccine_Dose IS NOT NULL 
GROUP BY 
    Vaccine_Dose


--Q13. What is the average cholesterol level and BMI by location?
SELECT 
    [Location], 
        AVG(Cholesterol_Level) AS Average_cholesterol_level, 
            ROUND(AVG(BMI),2) AS Average_BMI
FROM 
    vaccine_heart_data
WHERE Cholesterol_Level IS NOT NULL AND BMI IS NOT NULL 
GROUP BY 
    [Location]
ORDER BY [Location] DESC 


--Q14. How many patients have elevated or high blood pressure?
SELECT 
    Blood_Pressure, 
        COUNT(*) AS Total_patient
FROM 
    vaccine_heart_data
WHERE Blood_Pressure  IN ('Elevated', 'High')
GROUP BY 
    Blood_Pressure


--Q15. What is the correlation between blood pressure level and heart attack severity?
SELECT 
    Blood_Pressure, 
    Severity, 
        COUNT(*) AS Patient_count
FROM 
    vaccine_heart_data
WHERE Heart_Attack_Date IS NOT NULL AND Severity IS NOT NULL  AND Blood_Pressure IS NOT NULL
GROUP BY 
    Blood_Pressure, Severity
ORDER BY Blood_Pressure, Severity 


--Q16. Among heart attack patients, how many had diabetes and/or were smokers?
SELECT 
    SUM(CASE WHEN Diabetes_Status = 1 THEN 1 ELSE 0 END) AS Diabetic_Patients,
    SUM(CASE WHEN Smoking_History = 1 THEN 1 ELSE 0 END) AS Smoker_Patients,
    SUM(CASE WHEN Diabetes_Status = 1 AND Smoking_History = 1 THEN 1 ELSE 0 END) AS Both_Diabetic_And_Smoker
FROM 
    vaccine_heart_data
WHERE Heart_Attack_Date IS NOT NULL



