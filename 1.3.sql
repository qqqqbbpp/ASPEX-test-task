INSERT INTO [Bicycle] ([Brand], [RentPrice], [Status]) VALUES
('Stels', 500, 'Available'),
('Forward', 600, 'Available'),
('Merida', 800, 'Rented'),
('Giant', 900, 'Under Maintenance'),
('Trek', 1000, 'Available'),
('Scott', 750, 'Available'),
('Cannondale', 850, 'Rented'),
('Specialized', 950, 'Available'),
('Cube', 700, 'Under Maintenance'),
('GT', 650, 'Available');

INSERT INTO [Client] ([FirstName], [MiddleName], [LastName], [Country], [PhoneNumber], [Passport]) VALUES
('Ivan', 'Ivanovich', 'Ivanov', 'Russia', '+79161234567', '1234567890'),
('Petr', 'Petrovich', 'Petrov', 'Russia', '+79162345678', '2345678901'),
('Maria', 'Sergeevna', 'Sidorova', 'Russia', '+79163456789', '3456789012'),
('Alexey', 'Vladimirovich', 'Kuznetsov', 'Kazakhstan', '+77011234567', 'A12345678'),
('Elena', 'Dmitrievna', 'Popova', 'Kazakhstan', '+77012345678', 'B23456789'),
('Sergey', 'Alexandrovich', 'Vasiliev', 'Russia', '+79165678901', '4567890123'),
('Olga', 'Nikolaevna', 'Morozova', 'Ukraine', '+38050123456', '123098661'),
('Dmitry', 'Olegovich', 'Novikov', 'Russia', '+79166789012', '5678901234'),
('Anna', 'Viktorovna', 'Fedorova', 'Kazakhstan', '+77013456789', 'C34567890'),
('Alexander', 'Igorevich', 'Volkov', 'Russia', '+79167890123', '6789012345');

INSERT INTO [Staff] ([FirstName], [MiddleName], [LastName], [Passport], [Date], [Salary]) VALUES
('Andrey', 'Sergeevich', 'Smirnov', '4012345678', '2020-01-15', 50000),
('Natalya', 'Vladimirovna', 'Ivanova', '4023456789', '2021-03-20', 45000),
('Mikhail', 'Petrovich', 'Kozlov', '4034567890', '2022-11-10', 55000),
('Ekaterina', 'Andreevna', 'Lebedeva', '4045678901', '2023-05-05', 42000),
('Vladimir', 'Nikolaevich', 'Sokolov', '4056789012', '2024-07-30', 48000),
('Tatyana', 'Olegovna', 'Pavlova', '4067890123', '2025-09-12', 43000),
('Pavel', 'Dmitrievich', 'Orlov', '4078901234', '2020-12-01', 60000),
('Yulia', 'Sergeevna', 'Zakharova', '4089012345', '2021-02-14', 40000),
('Igor', 'Vasilievich', 'Belov', '4090123456', '2022-06-25', 47000),
('Svetlana', 'Alexandrovna', 'Medvedeva', '4101234567', '2023-08-18', 44000);

INSERT INTO [Detail] ([Brand], [Type], [Name], [Price], [QuantityInStock]) VALUES
('Shimano', 'Chain', 'CN-HG701', 2500, 15),
('SRAM', 'Brake', 'G2 RS', 3500, 8),
('Shimano', 'Sprocket', 'FC-M371', 1800, 12),
('Continental', 'Tire', 'Race King', 3200, 20),
('RockShox', 'Fork', 'Recon Silver', 15000, 5),
('Shimano', 'Shifter', 'SLX M7000', 4200, 10),
('SRAM', 'Cassette', 'PG-1130', 3800, 7),
('Tektro', 'Brake Pad', 'P15-11', 800, 25),
('WTB', 'Saddle', 'Volt Sport', 2200, 18),
('Shimano', 'Hub', 'FH-M8010', 5500, 6);

INSERT INTO [DetailForBicycle] ([BicycleId], [DetailId]) VALUES
(1, 1), (1, 3), (1, 4),
(2, 1), (2, 2), (2, 6),
(3, 1), (3, 3), (3, 7),
(4, 2), (4, 5), (4, 8),
(5, 1), (5, 6), (5, 9),
(6, 3), (6, 4), (6, 10),
(7, 2), (7, 7), (7, 8),
(8, 1), (8, 5), (8, 9),
(9, 3), (9, 6), (9, 10),
(10, 4), (10, 7), (10, 8);

INSERT INTO [ServiceBook] ([BicycleId], [DetailId], [Date], [Price], [StaffId]) VALUES
(1, 1, '2025-01-15', 1000, 1),
(4, 5, '2025-01-20', 2500, 3),
(9, 10, '2025-02-01', 1500, 2),
(2, 2, '2025-02-10', 1200, 5),
(6, 4, '2025-02-15', 800, 4),
(3, 7, '2025-02-20', 1800, 6),
(8, 9, '2025-03-01', 900, 7),
(5, 6, '2025-03-05', 1100, 8),
(10, 8, '2025-03-10', 700, 9),
(7, 3, '2025-03-15', 1300, 10);

INSERT INTO [RentBook] ([Date], [Time], [Paid], [BicycleId], [ClientId], [StaffId]) VALUES
('2025-03-01', 3, 1, 3, 1, 2),
('2025-03-02', 2, 1, 7, 3, 4),
('2025-03-03', 5, 0, 1, 5, 6),
('2025-03-04', 1, 1, 2, 7, 8),
('2025-03-05', 4, 1, 5, 9, 10),
('2025-03-06', 3, 0, 6, 2, 1),
('2025-03-07', 2, 1, 8, 4, 3),
('2025-03-08', 6, 1, 10, 6, 5),
('2025-03-09', 1, 1, 4, 8, 7),
('2025-03-10', 3, 0, 9, 10, 9);