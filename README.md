# SQL-Data-Exploration-Covid
A comprehensive SQL project exploring global pandemic data. Demonstrates data cleaning, relational mapping, and strategic KPI development for public health metrics.

# Project Overview
I wanted to see if I could find a correlation between how fast a country vaccinated its people and the decline in their death rates. I used a COVID-19 dataset from Our World in Data to practice my SQL skills.

# Key Evidence-Based Findings
- Total Toll: Brazil was the hardest hit in my dataset, with over 403,000 deaths by May 2021.
- Infection vs. Size: It was surprising to see that smaller countries like Andorra had a much higher percentage of their people infected (17%) compared to big countries like India (0.02%), even though India had millions more cases.
- The Rolling Total: I used a CTE and a Window Function to create a "Rolling Total" for vaccinations. This is much more useful than looking at daily numbers because it shows the actual progress toward "Herd Immunity."

# SQL Skills I used
- Joins: Combining the Deaths table and the Vaccinations table on Date and Location.
- CTEs: Creating temporary tables so I could calculate percentages on columns I just created.
- Window Functions: Using OVER(PARTITION BY) to get those cumulative sums.


