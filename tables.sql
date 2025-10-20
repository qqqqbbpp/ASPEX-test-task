CREATE TABLE [Bicycle] (
    [Id]        INT IDENTITY(1,1) NOT NULL,
    [Brand]     VARCHAR(50)       NOT NULL,
    [RentPrice] INT               NOT NULL,  -- цена аренды
    PRIMARY KEY ([Id])
);

CREATE TABLE [Client] (
    [Id]          INT IDENTITY(1,1) NOT NULL,
    [FirstName]   VARCHAR(25)       NOT NULL,
    [MiddleName]  VARCHAR(25)       NOT NULL,
    [LastName]    VARCHAR(25)       NOT NULL,
    [Country]     VARCHAR(50)       NOT NULL,
    [PhoneNumber] VARCHAR(50)       NOT NULL,
    [Passport]    VARCHAR(50)       NOT NULL,
    PRIMARY KEY ([Id])
);

CREATE TABLE [Staff] (
    [Id]       INT IDENTITY(1,1) NOT NULL,
    [FirstName]   VARCHAR(25)    NOT NULL, -- имя сотрудника
    [MiddleName]  VARCHAR(25)    NOT NULL,
    [LastName]    VARCHAR(25)    NOT NULL,  
    [Passport] VARCHAR(50)       NOT NULL,
    [Date]     DATE              NOT NULL,  -- дата начала работы
    PRIMARY KEY ([Id])
);

CREATE TABLE [Detail] (  -- запчасти велосипеда
    [Id]    INT IDENTITY(1,1) NOT NULL,
    [Brand] VARCHAR(50)       NOT NULL,
    [Type]  VARCHAR(50)       NOT NULL,  -- тип детали (цепь, звезда, etc.)
    [Name]  VARCHAR(50)       NOT NULL,  -- название детали
    [Price] INT               NOT NULL,
    PRIMARY KEY ([Id])
);

CREATE TABLE [DetailForBicycle] (  -- список деталей подходящих к велосипедам
    [BicycleId] INT NOT NULL,
    [DetailId]  INT NOT NULL,
    FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
    FOREIGN KEY ([DetailId])  REFERENCES [Detail] ([Id])
);

CREATE TABLE [ServiceBook] (  -- сервисное обслуживание велосипедов
    [BicycleId] INT  NOT NULL,
    [DetailId]  INT  NOT NULL,
    [Date]      DATE NOT NULL,
    [Price]     INT  NOT NULL,  -- цена работы
    [StaffId]   INT  NOT NULL,
    FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
    FOREIGN KEY ([StaffId])   REFERENCES [Staff] ([Id]),
    FOREIGN KEY ([DetailId])  REFERENCES [Detail] ([Id])
);

CREATE TABLE [RentBook] (  -- аренда велосипеда клиентом
    [Id]        INT IDENTITY(1,1) NOT NULL,
    [Date]      DATE              NOT NULL,  -- дата аренды
    [Time]      INT               NOT NULL,  -- время аренды в часах
    [Paid]      BIT               NOT NULL,  -- 1 оплатил; 0 не оплатил
    [BicycleId] INT               NOT NULL,
    [ClientId]  INT               NOT NULL,
    [StaffId]   INT               NOT NULL,
    FOREIGN KEY ([BicycleId]) REFERENCES [Bicycle] ([Id]),
    FOREIGN KEY ([StaffId])   REFERENCES [Staff] ([Id]),
    FOREIGN KEY ([ClientId])  REFERENCES [Client] ([Id])
);