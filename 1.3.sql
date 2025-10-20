SELECT TOP 5 -- 5 наиболее рентабельных велосипедов
    b.Id AS BicycleId,
    b.Brand,
    b.RentPrice,
    ISNULL(SUM(rb.Time * b.RentPrice), 0) AS TotalRevenue,
    ISNULL(SUM(sb.Price), 0) AS TotalServiceCost,
    ISNULL(SUM(rb.Time * b.RentPrice), 0) - ISNULL(SUM(sb.Price), 0) AS Profit
FROM 
    Bicycle b
LEFT JOIN 
    RentBook rb ON b.Id = rb.BicycleId
LEFT JOIN 
    ServiceBook sb ON b.Id = sb.BicycleId
GROUP BY 
    b.Id, b.Brand, b.RentPrice
ORDER BY 
    Profit DESC;

SELECT -- финальная цена аренды
    rb.Date,
    c.FirstName + ' ' + c.LastName AS ClientName,
    b.RentPrice * rb.Time AS FinalPrice,
    CASE 
        WHEN rb.Paid = 1 THEN 'Paid'
        ELSE 'Not paid'
    END AS PaymentStatus
FROM 
    RentBook rb
INNER JOIN 
    Client c ON rb.ClientId = c.Id
INNER JOIN 
    Bicycle b ON rb.BicycleId = b.Id
INNER JOIN 
    Staff s ON rb.StaffId = s.Id
ORDER BY 
    rb.Date DESC;

SELECT  -- статистика сотрудников
    s.Id,
    s.FirstName + ' ' + s.LastName AS StaffName,
    s.Salary,
    COUNT(rb.Id) AS TotalRents,
    SUM(b.RentPrice * rb.Time) AS TotalRevenue,
    CASE 
        WHEN COUNT(rb.Id) > 0 THEN SUM(b.RentPrice * rb.Time) / COUNT(rb.Id)
        ELSE 0 
    END AS AvgRevenuePerRent
FROM 
    Staff s
LEFT JOIN 
    RentBook rb ON s.Id = rb.StaffId
LEFT JOIN 
    Bicycle b ON rb.BicycleId = b.Id
GROUP BY 
    s.Id, s.FirstName, s.LastName, s.Salary
ORDER BY 
    TotalRevenue DESC;

SELECT  -- обслуживание велосипедов
    b.Id AS BicycleId,
    b.Brand AS BicycleBrand,
    b.Status,
    d.Name AS DetailName,
    d.Type AS DetailType,
    d.Brand AS DetailBrand,
    sb.Date AS ServiceDate,
    sb.Price AS ServiceCost,
    s.FirstName + ' ' + s.LastName AS ServiceStaff,
    COUNT(dfb.DetailId) OVER(PARTITION BY b.Id) AS TotalDetailsOnBicycle
FROM 
    Bicycle b
INNER JOIN 
    ServiceBook sb ON b.Id = sb.BicycleId
INNER JOIN 
    Detail d ON sb.DetailId = d.Id
INNER JOIN 
    Staff s ON sb.StaffId = s.Id
LEFT JOIN 
    DetailForBicycle dfb ON b.Id = dfb.BicycleId
ORDER BY 
    sb.Date DESC, b.Brand;

SELECT -- клиентская база
    c.Country,
    COUNT(DISTINCT c.Id) AS TotalClients,
    COUNT(rb.Id) AS TotalRents,
    SUM(b.RentPrice * rb.Time) AS TotalSpent,
    AVG(b.RentPrice * rb.Time) AS AvgSpentPerRent,
    COUNT(DISTINCT rb.BicycleId) AS UniqueBicyclesRented,
    SUM(CASE WHEN rb.Paid = 0 THEN 1 ELSE 0 END) AS UnpaidRents
FROM 
    Client c
LEFT JOIN 
    RentBook rb ON c.Id = rb.ClientId
LEFT JOIN 
    Bicycle b ON rb.BicycleId = b.Id
GROUP BY 
    c.Country
ORDER BY 
    TotalSpent DESC;