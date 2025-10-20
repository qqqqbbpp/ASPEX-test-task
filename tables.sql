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

-- Phone number ограничить до 12 символов, чтобы при вводе не возникало ошибок.
ALTER TABLE [Client] 
ALTER COLUMN [PhoneNumber] VARCHAR(12) NOT NULL;

-- У Name слишком мало символов, бывают имена с большим числом букв, увеличить число символов до 20.
ALTER TABLE [Client] 
ALTER COLUMN [Name] VARCHAR(20) NOT NULL;

ALTER TABLE [Staff] 
ALTER COLUMN [Name] VARCHAR(20) NOT NULL;

-- Кроме имени стоит добавить фамилию и отчество, клиенты любят когда к ним обращаются уважительно. А о сотрудниках должны быть полные данные.
ALTER TABLE [Client] 
ADD [LastName] VARCHAR(20) NOT NULL,
    [MiddleName] VARCHAR(20) NOT NULL;

ALTER TABLE [Staff] 
ADD [LastName] VARCHAR(20) NOT NULL,
    [MiddleName] VARCHAR(20) NOT NULL;

-- Добавить проверку для номера паспорта
ALTER TABLE [Client] 
ADD CONSTRAINT [CK_Client_Passport_Format] 
CHECK (
    ([Country] NOT IN ('Россия', 'Казахстан'))
    OR 
    ([Country] = 'Россия' AND [Passport] LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    OR 
    ([Country] = 'Казахстан' AND [Passport] LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- Добавить ограничения для целостности данных, цена не может быть отрицательной
ALTER TABLE [Bicycle] 
ADD CONSTRAINT [CK_Bicycle_RentPrice] 
CHECK ([RentPrice] >= 0);

ALTER TABLE [Detail] 
ADD CONSTRAINT [CK_Detail_Price] 
CHECK ([Price] >= 0);

ALTER TABLE [ServiceBook] 
ADD CONSTRAINT [CK_ServiceBook_Price] 
CHECK ([Price] >= 0);

-- Добавить финальную цену аренды, будет удобно иметь такой 
ALTER TABLE [RentBook] 
ADD [TotalAmount] AS ([Time] * (
    SELECT [RentPrice] 
    FROM [Bicycle] 
    WHERE [Id] = [RentBook].[BicycleId]
));

-- Добавить статус велосипеда
ALTER TABLE [Bicycle] 
ADD [Status] VARCHAR(20) NOT NULL DEFAULT 'Доступен'
    CONSTRAINT [CK_Bicycle_Status] 
    CHECK ([Status] IN ('Доступен', 'В аренде', 'На обслуживании'));

-- Добавить число запчастей в наличии
ALTER TABLE [Detail] 
ADD [QuantityInStock] INT NOT NULL DEFAULT 0
    CONSTRAINT [CK_Detail_QuantityInStock] 
    CHECK ([QuantityInStock] >= 0);

-- Добавить зарплату сотрудника
ALTER TABLE [Staff] 
ADD [Salary] INT NOT NULL DEFAULT 0
    CONSTRAINT [CK_Staff_Salary] 
    CHECK ([Salary] >= 0);