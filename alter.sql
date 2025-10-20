-- Phone number лучше ограничить до 12 символов, чтобы при вводе не возникало ошибок.
ALTER TABLE [Client]
ALTER COLUMN [PhoneNumber] VARCHAR(12) NOT NULL;


-- Чтобы исключить ошибку при вводе номера добавил проверку для номера паспорта
ALTER TABLE [Client]
ADD CONSTRAINT [CK_Client_Passport_Format]
CHECK (
    ([Country] NOT IN ('Россия', 'Казахстан'))
    OR
    ([Country] = 'Россия' AND [Passport] LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    OR
    ([Country] = 'Казахстан' AND [Passport] LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- Добавил ограничения для целостности данных, цена не может быть отрицательной
ALTER TABLE [Bicycle]
ADD CONSTRAINT [CK_Bicycle_RentPrice]
CHECK ([RentPrice] >= 0);


ALTER TABLE [Detail]
ADD CONSTRAINT [CK_Detail_Price]
CHECK ([Price] >= 0);


ALTER TABLE [ServiceBook]
ADD CONSTRAINT [CK_ServiceBook_Price]
CHECK ([Price] >= 0);


-- Добавить статус велосипеда
ALTER TABLE [Bicycle]
ADD [Status] VARCHAR(20) NOT NULL
    CONSTRAINT [CK_Bicycle_Status]
    CHECK ([Status] IN ('Доступен', 'В аренде', 'На обслуживании'));


-- Добавить число запчастей в наличии
ALTER TABLE [Detail]
ADD [QuantityInStock] INT NOT NULL
    CONSTRAINT [CK_Detail_QuantityInStock]
    CHECK ([QuantityInStock] >= 0);


-- Добавил зарплату сотрудника для следующих заданий
ALTER TABLE [Staff]
ADD [Salary] INT NOT NULL
    CONSTRAINT [CK_Staff_Salary]
    CHECK ([Salary] >= 0);