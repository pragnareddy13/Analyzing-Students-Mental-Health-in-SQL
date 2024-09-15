-- Select all columns from the students table
SELECT *
FROM students;

-- Calculate average scores for international students
SELECT 
    AVG(todep) AS avg_depression,
    AVG(tosc) AS avg_social_connectedness,
    AVG(toas) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter';

-- Analyze scores based on length of stay
SELECT 
    stay_period,
    AVG(todep) AS avg_depression,
    AVG(tosc) AS avg_social_connectedness,
    AVG(toas) AS avg_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay_period
ORDER BY stay_period;

-- Compare scores of students staying less than 6 months vs. more than 2 years
WITH short_stay AS (
    SELECT AVG(todep) AS avg_depression_short
    FROM students
    WHERE inter_dom = 'Inter' AND stay_period = '< 6 months'
),
long_stay AS (
    SELECT AVG(todep) AS avg_depression_long
    FROM students
    WHERE inter_dom = 'Inter' AND stay_period = '> 2 years'
)
SELECT 
    avg_depression_short,
    avg_depression_long,
    (avg_depression_long - avg_depression_short) AS depression_difference
FROM short_stay, long_stay;