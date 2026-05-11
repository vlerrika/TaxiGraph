USE master;
DROP DATABASE IF EXISTS Taxi;
CREATE DATABASE Taxi;
USE Taxi;

-- Table Passengers

CREATE TABLE [Passengers]
(
 [PassengerID] Int NOT NULL,
 [NameOfPassenger] Nvarchar(30) NOT NULL,
 [Telephone] Nvarchar(20) NOT NULL,
 [PaymentMethod] Nvarchar(15) NOT NULL
)
AS NODE
go

-- Add keys for table Passengers

ALTER TABLE [Passengers] ADD CONSTRAINT [PK_Passengers] PRIMARY KEY ([PassengerID])
go

ALTER TABLE [Passengers] ADD CONSTRAINT [Телефон] UNIQUE ([Telephone])
go

-- Table Driver

CREATE TABLE [Driver]
(
 [DriverID] Int NOT NULL,
 [NameOfDriver] Nvarchar(30) NOT NULL,
 [Rating] Int NOT NULL,
 [Status] Nvarchar(10) NOT NULL,
 [CurrentCoordinates] Nvarchar(100) NOT NULL
)
AS NODE
go

-- Add keys for table Driver

ALTER TABLE [Driver] ADD CONSTRAINT [PK_Driver] PRIMARY KEY ([DriverID])
go

-- Table Car

CREATE TABLE [Car]
(
 [CarID] Int NOT NULL,
 [Model] Nvarchar(50) NOT NULL,
 [Color] Nvarchar(15) NOT NULL,
 [LicenseNumber] Nvarchar(25) NOT NULL,
 [Class] Nvarchar(10) NOT NULL
)
AS NODE
go

-- Add keys for table Car

ALTER TABLE [Car] ADD CONSTRAINT [PK_Car] PRIMARY KEY ([CarID])
go

ALTER TABLE [Car] ADD CONSTRAINT [Госномер] UNIQUE ([LicenseNumber])
go

-- Table Trip

CREATE TABLE [Trip]
(
 [TripID] Int NOT NULL,
 [StartingPoint] Nvarchar(50) NOT NULL,
 [EndPoint] Nvarchar(50) NOT NULL,
 [RequestTime] Date NOT NULL,
 [EndTime] Date NOT NULL,
 [Status] Nvarchar(15) NOT NULL,
 [Price] Decimal(5,2) NOT NULL
)
AS NODE
go

-- Add keys for table Trip

ALTER TABLE [Trip] ADD CONSTRAINT [PK_Trip] PRIMARY KEY ([TripID])
go

-- Table Orders

CREATE TABLE [Orders]
(
 [Date] Date NOT NULL,
 [Time] Time NOT NULL
)
AS EDGE
go

ALTER TABLE [Orders]
ADD CONSTRAINT EC_Orders
CONNECTION (Passengers TO Trip)
GO

-- Table Accepted

CREATE TABLE [Accepted]
(
 [RequestTime] Date NOT NULL,
 [EndTime] Date NOT NULL,
 [Status] Nvarchar(15) NOT NULL
)
AS EDGE
go

ALTER TABLE [Accepted]
ADD CONSTRAINT EC_Accepted
CONNECTION (Driver TO Trip)
GO

-- Table UsedIn

CREATE TABLE [UsedIn]
(
 [MileageBeforeTrip] Int NOT NULL,
 [MileageAfterTrip] Int NOT NULL
)
AS EDGE
go

ALTER TABLE [UsedIn]
ADD CONSTRAINT EC_UsedIn
CONNECTION (Car TO Trip)
GO

-- Table Manages

CREATE TABLE [Manages]
(
 [StartDate] Date NOT NULL,
 [EndDate] Date NOT NULL
)
AS EDGE
go

ALTER TABLE [Manages]
ADD CONSTRAINT EC_Manages
CONNECTION (Driver TO Car)
GO


-- ЗАПОЛНЕНИЕ
-- Passengers
INSERT INTO Passengers
VALUES (1, N'Иван Петров', N'+375291234567', N'Card')
	  ,(2, N'Анна Смирнова', N'+375336543210', N'Cash')
	  ,(3, N'Дмитрий Орлов', N'+375297654321', N'Card')
	  ,(4, N'Мария Волкова', N'+375447891234', N'Card')
	  ,(5, N'Сергей Иванов', N'+375255551122', N'Cash')
	  ,(6, N'Елена Кузнецова', N'+375291112233', N'Card')
	  ,(7, N'Павел Сидоров', N'+375336667788', N'Card')
	  ,(8, N'Ольга Морозова', N'+375447778899', N'Cash')
	  ,(9, N'Алексей Фролов', N'+375259990011', N'Card')
	  ,(10, N'Татьяна Белова', N'+375297771155', N'Cash')
GO


-- Drivers

INSERT INTO Driver
VALUES (1, N'Андрей Егоров', 5, N'Online', N'55.751244,37.618423')
	  ,(2, N'Максим Павлов', 4, N'Busy', N'55.752000,37.615000')
	  ,(3, N'Игорь Романов', 5, N'Online', N'55.753000,37.620000')
	  ,(4, N'Виктор Лебедев', 3, N'Offline', N'55.750000,37.619000')
	  ,(5, N'Николай Соколов', 4, N'Busy', N'55.754000,37.617000')
	  ,(6, N'Артем Новиков', 5, N'Online', N'55.756000,37.616000')
	  ,(7, N'Константин Жуков', 5, N'Online', N'55.757000,37.618000')
	  ,(8, N'Руслан Федоров', 4, N'Busy', N'55.758000,37.621000')
	  ,(9, N'Денис Васильев', 3, N'Offline', N'55.759000,37.622000')
	  ,(10, N'Олег Крылов', 5, N'Online', N'55.760000,37.623000')
GO


-- Cars

INSERT INTO Car
VALUES (1, N'Toyota Camry', N'Black', N'1234 AB-7', N'Comfort')
	  ,(2, N'Kia Rio', N'White', N'5678 BM-5', N'Econom')
	  ,(3, N'Hyundai Solaris', N'Silver', N'2468 CT-7', N'Econom')
	  ,(4, N'BMW 5', N'Black', N'1357 EI-1', N'Business')
	  ,(5, N'Mercedes E200', N'White', N'9087 KM-7', N'Business')
	  ,(6, N'Skoda Octavia', N'Gray', N'7744 MP-5', N'Comfort')
	  ,(7, N'Volkswagen Polo', N'Blue', N'6622 HO-7', N'Econom')
	  ,(8, N'Audi A6', N'Black', N'4815 OP-1', N'Business')
	  ,(9, N'Ford Focus', N'Red', N'9901 PP-7', N'Comfort')
	  ,(10, N'Tesla Model 3', N'White', N'7777 TT-7', N'Premium')
GO


-- Trips

INSERT INTO Trip
VALUES (1, N'ул. Ленина 10, Минск', N'пр. Независимости 95, Минск',
	    '2026-05-01 10:00', '2026-05-01 11:00', N'Completed', 35.50)
	  ,(2, N'ул. Кирова 3, Минск', N'ул. Немига 12, Минск',
		'2026-05-01 12:00', '2026-05-01 12:40', N'Completed', 18.20)
	  ,(3, N'ул. Якуба Коласа 25, Минск', N'ул. Сурганова 57, Минск',
		'2026-05-02 09:15', '2026-05-02 09:45', N'Completed', 12.90)
	  ,(4, N'пр. Победителей 7, Минск', N'ул. Притыцкого 44, Минск',
		'2026-05-02 18:00', '2026-05-02 18:50', N'Completed', 22.40)
	  ,(5, N'ул. Академическая 15, Минск', N'ул. Бобруйская 6, Минск',
		'2026-05-03 16:00', '2026-05-03 16:30', N'Completed', 14.70)
	  ,(6, N'ул. Тимирязева 74, Минск', N'ул. Интернациональная 11, Минск',
		'2026-05-03 20:00', '2026-05-03 20:45', N'Completed', 19.80)
	  ,(7, N'ул. Кальварийская 21, Минск', N'ул. Матусевича 35, Минск',
		'2026-05-04 11:00', '2026-05-04 11:15', N'Completed', 8.50)
	  ,(8, N'ул. Кижеватова 58, Минск', N'ул. Лобанка 94, Минск',
		'2026-05-04 13:00', '2026-05-04 13:20', N'Completed', 9.30)
	  ,(9, N'Национальный аэропорт Минск', N'ул. Зыбицкая 9, Минск',
		'2026-05-05 08:00', '2026-05-05 09:00', N'Completed', 42.00)
	  ,(10, N'ул. Революционная 17, Минск', N'пр. Победителей 120, Минск',
	    '2026-05-05 14:00', '2026-05-05 14:35', N'Completed', 16.60)
GO


-- Orders
INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-01', '10:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 1 AND t.TripID = 1
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-01', '12:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 2 AND t.TripID = 2
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-02', '09:15'
FROM Passengers p, Trip t
WHERE p.PassengerID = 3 AND t.TripID = 3
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-02', '18:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 4 AND t.TripID = 4
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-03', '16:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 5 AND t.TripID = 5
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-03', '20:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 6 AND t.TripID = 6
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-04', '11:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 7 AND t.TripID = 7
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-04', '13:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 8 AND t.TripID = 8
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-05', '08:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 9 AND t.TripID = 9
GO

INSERT INTO Orders ($from_id, $to_id, [Date], [Time])
SELECT p.$node_id, t.$node_id, '2026-05-05', '14:00'
FROM Passengers p, Trip t
WHERE p.PassengerID = 10 AND t.TripID = 10
GO


-- Accepted (Driver -> Trip)

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-01 10:05', '2026-05-01 11:00', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 1 AND t.TripID = 1
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-01 12:05', '2026-05-01 12:40', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 2 AND t.TripID = 2
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-02 09:17', '2026-05-02 09:45', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 3 AND t.TripID = 3
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-02 18:05', '2026-05-02 18:50', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 4 AND t.TripID = 4
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-03 16:05', '2026-05-03 16:30', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 5 AND t.TripID = 5
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-03 20:05', '2026-05-03 20:45', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 6 AND t.TripID = 6
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-04 11:05', '2026-05-04 11:15', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 7 AND t.TripID = 7
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-04 13:05', '2026-05-04 13:20', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 8 AND t.TripID = 8
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-05 08:05', '2026-05-05 09:00', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 9 AND t.TripID = 9
GO

INSERT INTO Accepted ($from_id, $to_id, RequestTime, EndTime, [Status])
SELECT d.$node_id, t.$node_id, '2026-05-05 14:05', '2026-05-05 14:35', N'Accepted'
FROM Driver d, Trip t
WHERE d.DriverID = 10 AND t.TripID = 10
GO


-- UsedIn (Car -> Trip)

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 10000, 10050
FROM Car c, Trip t
WHERE c.CarID = 1 AND t.TripID = 1
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 20000, 20025
FROM Car c, Trip t
WHERE c.CarID = 2 AND t.TripID = 2
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 15000, 15018
FROM Car c, Trip t
WHERE c.CarID = 3 AND t.TripID = 3
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 5000, 5050
FROM Car c, Trip t
WHERE c.CarID = 4 AND t.TripID = 4
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 7000, 7020
FROM Car c, Trip t
WHERE c.CarID = 5 AND t.TripID = 5
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 12000, 12032
FROM Car c, Trip t
WHERE c.CarID = 6 AND t.TripID = 6
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 18000, 18012
FROM Car c, Trip t
WHERE c.CarID = 7 AND t.TripID = 7
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 9000, 9015
FROM Car c, Trip t
WHERE c.CarID = 8 AND t.TripID = 8
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 22000, 22055
FROM Car c, Trip t
WHERE c.CarID = 9 AND t.TripID = 9
GO

INSERT INTO UsedIn ($from_id, $to_id, MileageBeforeTrip, MileageAfterTrip)
SELECT c.$node_id, t.$node_id, 3000, 3040
FROM Car c, Trip t
WHERE c.CarID = 10 AND t.TripID = 10
GO


-- Manages (Driver -> Car)

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 1 AND c.CarID = 1
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 2 AND c.CarID = 2
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 3 AND c.CarID = 3
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 4 AND c.CarID = 4
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 5 AND c.CarID = 5
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 6 AND c.CarID = 6
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 7 AND c.CarID = 7
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 8 AND c.CarID = 8.
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 9 AND c.CarID = 9
GO

INSERT INTO Manages ($from_id, $to_id, StartDate, EndDate)
SELECT d.$node_id, c.$node_id, '2025-01-01', '2099-12-31'
FROM Driver d, Car c
WHERE d.DriverID = 10 AND c.CarID = 10
GO


-- ЗАДАНИЕ 5 (MATCH)

-- Пассажиры, чьи поездки были приняты водителем и выполнены на машине, которой он управляет
SELECT DISTINCT p.NameOfPassenger,
                d.NameOfDriver,
                c.Model,
                t.StartingPoint,
                t.EndPoint
FROM Passengers AS p,
     Orders AS o,
     Trip AS t,
     Accepted AS a,
     Driver AS d,
     Manages AS m,
     Car AS c
WHERE MATCH(p-(o)->t<-(a)-d-(m)->c)
  AND t.Status = N'Completed';
GO

-- Водители и машины, которые участвовали в поездках, заказанных пассажирами, оплатившими картой
SELECT DISTINCT d.NameOfDriver,
                c.Model,
                t.TripID,
                p.NameOfPassenger,
                p.PaymentMethod
FROM Driver AS d,
     Manages AS m,
     Car AS c,
     UsedIn AS u,
     Trip AS t,
     Orders AS o,
     Passengers AS p
WHERE MATCH(d-(m)->c-(u)->t<-(o)-p)
  AND p.PaymentMethod = N'Card';
GO

-- Пассажиры, поездки которых обслуживались водителями рейтинга 5 и машинами Business или Premium
SELECT DISTINCT p.NameOfPassenger,
                d.NameOfDriver,
                d.Rating,
                c.Class,
                t.Price
FROM Passengers AS p,
     Orders AS o,
     Trip AS t,
     Accepted AS a,
     Driver AS d,
     Manages AS m,
     Car AS c
WHERE MATCH(p-(o)->t<-(a)-d-(m)->c)
  AND d.Rating = 5
  AND c.Class IN (N'Business', N'Premium');
GO

-- Найти пассажиров, которых обслуживали водители со статусом Online и рейтингом не ниже 5
SELECT DISTINCT p.NameOfPassenger,
                d.NameOfDriver,
                d.Status,
                d.Rating,
                t.StartingPoint,
                t.EndPoint,
                t.Price
FROM Passengers AS p,
     Orders AS o,
     Trip AS t,
     Accepted AS a,
     Driver AS d
WHERE MATCH(p-(o)->t<-(a)-d)
  AND d.Status = N'Online'
  AND d.Rating >= 5;
GO

-- Водители, которые управляли автомобилями, использованными в дорогих поездках
SELECT DISTINCT
    d.NameOfDriver,
    c.Model,
    t.Price
FROM Driver AS d,
     Manages AS m,
     Car AS c,
     UsedIn AS u,
     Trip AS t
WHERE MATCH(d-(m)->c-(u)->t)
  AND t.Price > 20;
GO

-- ЗАДАНИЕ 6 (SHORTEST_PATH)

-- Кратчайший путь от пассажира к машине с шаблоном "+"
SELECT
    p.NameOfPassenger,
    STRING_AGG(
        CONCAT(
            N'Trip ', CAST(t.TripID AS nvarchar(10)),
            N' -> Driver ', d.NameOfDriver,
            N' -> Car ', c.Model
        ),
        ' -> '
    ) WITHIN GROUP (GRAPH PATH) AS PathText
FROM Passengers AS p,
     Orders FOR PATH AS o,
     Trip FOR PATH AS t,
     Accepted FOR PATH AS a,
     Driver FOR PATH AS d,
     Manages FOR PATH AS m,
     Car FOR PATH AS c,
     UsedIn AS u2,
     Trip AS t2
WHERE MATCH(
    SHORTEST_PATH(p(-(o)->t<-(a)-d-(m)->c)+)
    AND LAST_NODE(c)-(u2)->t2
)
AND p.PassengerID = 1;
GO

-- Кратчайший путь от водителя к пассажиру с шаблоном "{1,3}"
SELECT
    d.NameOfDriver,
    STRING_AGG(
        CONCAT(
            N'Car ', c.Model,
            N' -> Trip ', CAST(t.TripID AS nvarchar(10)),
            N' -> Passenger ', p.NameOfPassenger
        ),
        ' -> '
    ) WITHIN GROUP (GRAPH PATH) AS PathText
FROM Driver AS d,
     Manages FOR PATH AS m,
     Car FOR PATH AS c,
     UsedIn FOR PATH AS u,
     Trip FOR PATH AS t,
     Orders FOR PATH AS o,
     Passengers FOR PATH AS p,
     Orders AS o2,
     Trip AS t2
WHERE MATCH(
    SHORTEST_PATH(d(-(m)->c-(u)->t<-(o)-p){1,3})
    AND LAST_NODE(p)-(o2)->t2
)
AND d.DriverID = 1;
GO
