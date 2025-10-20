CREATE TABLE StaffBonus (
    Year INT,
    Month INT,
    StaffName NVARCHAR(255),
    BonusAmount DECIMAL(18,2)
);

WITH StaffExperience AS (
    SELECT 
        Id,
        CASE 
            WHEN DATEDIFF(YEAR, Date, GETDATE()) < 1 THEN 0.05
            WHEN DATEDIFF(YEAR, Date, GETDATE()) BETWEEN 1 AND 2 THEN 0.10
            ELSE 0.15
        END AS ExperienceBonus
    FROM Staff
),
RentIncome AS (
    SELECT 
        rb.StaffId,
        YEAR(rb.Date) AS Year,
        MONTH(rb.Date) AS Month,
        SUM(b.RentPrice * rb.Time * 0.3) AS RentBonus
    FROM RentBook rb
    JOIN Bicycle b ON rb.BicycleId = b.Id
    WHERE rb.Paid = 1
    GROUP BY rb.StaffId, YEAR(rb.Date), MONTH(rb.Date)
),
RepairIncome AS (
    SELECT 
        sb.StaffId,
        YEAR(sb.Date) AS Year,
        MONTH(sb.Date) AS Month,
        SUM(sb.Price * 0.8) AS RepairBonus
    FROM ServiceBook sb
    GROUP BY sb.StaffId, YEAR(sb.Date), MONTH(sb.Date)
),
CombinedIncome AS (
    SELECT 
        COALESCE(r.StaffId, rep.StaffId) AS StaffId,
        COALESCE(r.Year, rep.Year) AS Year,
        COALESCE(r.Month, rep.Month) AS Month,
        COALESCE(r.RentBonus, 0) AS RentBonus,
        COALESCE(rep.RepairBonus, 0) AS RepairBonus
    FROM RentIncome r
    FULL OUTER JOIN RepairIncome rep 
        ON r.StaffId = rep.StaffId AND r.Year = rep.Year AND r.Month = rep.Month
)
INSERT INTO StaffBonus (Year, Month, StaffName, BonusAmount)
SELECT 
    ci.Year,
    ci.Month,
    s.FirstName + ' ' + s.MiddleName + ' ' + s.LastName AS StaffName,
    ROUND(ci.RentBonus + (ci.RepairBonus * se.ExperienceBonus), 0) AS BonusAmount
FROM CombinedIncome ci
JOIN Staff s ON ci.StaffId = s.Id
JOIN StaffExperience se ON s.Id = se.Id
WHERE ci.RentBonus > 0 OR ci.RepairBonus > 0;