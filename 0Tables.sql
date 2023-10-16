Drop table payment_details;
Drop table OrderLineItem;
Drop table CustOrder;
Drop table Customers;
Drop table CartoonMovie;
Drop table ComicBook;
Drop table StoreItems;

CREATE TABLE StoreItems (
	ItemId INT PRIMARY KEY,
	NumOfCopies INT CHECK (NumOfCopies >= 0),
	price NUMBER(5, 2)
);


COLUMN ItemId format 999999999999 WRA
COLUMN NumOfCopies format 999999999999 WRA
SET linesize 100

CREATE TABLE ComicBook (
	title VARCHAR(20),
	PublishedDate DATE,
	ItemId INT PRIMARY KEY,
	FOREIGN KEY (ItemId) REFERENCES StoreItems(ItemId)
);

COLUMN title format a20 WRA
COLUMN ItemId format 999999999999 WRA
SET linesize 100

CREATE TABLE CartoonMovie(
	StudioName VARCHAR(20),
	title VARCHAR(20),
	description VARCHAR(50),
	ItemId INT PRIMARY KEY,
	FOREIGN KEY (ItemId) REFERENCES StoreItems(ItemId)
);

COLUMN StudioName format a20 WRA
COLUMN title format a20 WRA
COLUMN description format a30 WRA
COLUMN ItemId format 999999 WRA
SET linesize 100

CREATE TABLE Customers(
	CustId INT PRIMARY KEY,
	name VARCHAR(30),
	email VARCHAR(30) UNIQUE NOT NULL,
	address VARCHAR(50),
	CustType VARCHAR(10) CHECK (CustType = 'regular' OR CustType = 'gold'),
	DateJoined DATE,
	Coupon INT 
);

COLUMN CustId format 999999 WRA
COLUMN name format a20 WRA
COLUMN email format a30 WRA
COLUMN address format a30 WRA
COLUMN CustType format a10 WRA
SET linesize 100

CREATE TABLE CustOrder(
	OrderId INT PRIMARY KEY,
	CustId INT REFERENCES Customers(CustId),
	OrderDate DATE,
	ShippedDate DATE,
	ShippingFee NUMBER NOT NULL,
	CONSTRAINT DateCheck CHECK (ShippedDate >= OrderDate),
	NumOfItems INT
);

COLUMN OrderId format 999999999999 WRA
COLUMN CustId format 999999999999 WRA
SET linesize 100


CREATE TABLE OrderLineItem(
	LineId INT PRIMARY KEY,
	ItemId INT REFERENCES StoreItems(ItemId),
	NumOfItems INT,
	OrderId INT,
	FOREIGN KEY (OrderId) REFERENCES CustOrder(OrderId)
);

COLUMN LineId format 999999999999 WRA
COLUMN ItemId format 999999999999 WRA
COLUMN NumOfItems format 999999999999 WRA
COLUMN OrderId format 999999999999 WRA
SET linesize 100

CREATE TABLE payment_details(
	total INT,
	tax INT,
	ShippingFee NUMBER(5, 2),
	discount INT,
	grand_total INT,
	OrderId INT,
	FOREIGN KEY (OrderId) REFERENCES CustOrder(OrderId)
);


COLUMN total format 999999999999 WRA
COLUMN tax format 999999999999 WRA
COLUMN discount format 999999999999 WRA
COLUMN grand_total format 999999999999 WRA
COLUMN OrderId format 999999999999 WRA
SET linesize 100

INSERT INTO StoreItems VALUES(1, 17,  15.00);
INSERT INTO StoreItems VALUES(2, 16,  12.49);
INSERT INTO StoreItems VALUES(3, 10,  25.25);
INSERT INTO StoreItems VALUES(4, 20,  14.75);
INSERT INTO StoreItems VALUES(5, 21,  9.99);
INSERT INTO StoreItems VALUES(6, 31,  7.99);
INSERT INTO StoreItems VALUES(7, 33,  13.99);
INSERT INTO StoreItems VALUES(8, 35,  11.99);
 
INSERT INTO ComicBook VALUES('Pokemon', '08-AUG-97', 1);
INSERT INTO ComicBook VALUES('Yu-Gi-Oh', '30-SEP-96', 2);
INSERT INTO ComicBook VALUES('Star Wars', '12-APR-77', 3);
INSERT INTO ComicBook VALUES('Spider Man', '01-AUG-62', 4);
INSERT INTO CartoonMovie VALUES('DC','Robin','Robin the main lead.', 5);
INSERT INTO CartoonMovie VALUES('WaltDisney','Maleficent','She is evil fairy.', 6);
INSERT INTO CartoonMovie VALUES('Sony Pic','Spider Man','Peter struggles with power.', 7);
INSERT INTO CartoonMovie VALUES('Paramount','KungFu','KungFu Panda a Legend.', 8);

INSERT INTO Customers VALUES(1, 'Rima Modak', 'rimamodak@yahoo.com', 'El Camino', 'regular', NULL,NULL);
INSERT INTO Customers VALUES(2, 'Bob Bato', 'bobbyb@gmail.com', '30th Ave', 'regular', NULL, NULL);
INSERT INTO Customers VALUES(3, 'Nick Carrey', ' ncarrey@yahoo.com', 'Mission St', 'gold', '01-JAN-19', 3);
INSERT INTO Customers VALUES(4, 'Billy Heyward', 'thekid@gmail.com', 'Twins Ave', 'gold', '15-OCT-21', 5);
INSERT INTO Customers VALUES(5, 'Lou Collins', 'loucfb@gmail.com', 'Jen St', 'gold', '01-SEP-20', 10);
INSERT INTO Customers VALUES(6, 'Chris Lamont', 'clamont@gmail.com', 'Hamilton Ct', 'regular', NULL, NULL);
INSERT INTO Customers VALUES(7, 'John Coi', ' coijohn@yahoo.com', 'Flat St', 'gold', '10-JAN-17', 15);
INSERT INTO Customers VALUES(8, 'Mike Rai', 'raimike@gmail.com', 'Elvis Ave', 'gold', '05-OCT-22', 20);
INSERT INTO Customers VALUES(9, 'Voi Patt', 'pattvoi@gmail.com', 'James St', 'gold', '15-SEP-21', 25);
INSERT INTO Customers VALUES(10, 'Javes Broi', 'broijaves@gmail.com', 'Hill St', 'regular', NULL, NULL);

INSERT INTO CustOrder VALUES(101, 1, '05-OCT-22', '10-OCT-22', 10, 2);
INSERT INTO CustOrder VALUES(102, 3, '06-OCT-22', '11-OCT-22', 0, 2);
INSERT INTO CustOrder VALUES(103, 5, '07-OCT-22', '12-OCT-22', 10, 1);
INSERT INTO CustOrder VALUES(104, 6, '10-OCT-22', '15-OCT-22', 0, 3);
INSERT INTO CustOrder VALUES(105, 9, '15-OCT-22', '20-OCT-22', 10, 3);


INSERT INTO  OrderLineItem VALUES(00001, 4, 1, 101);
INSERT INTO  OrderLineItem VALUES(00002, 7, 1, 101);
INSERT INTO  OrderLineItem VALUES(00003, 3, 1, 102);
INSERT INTO  OrderLineItem VALUES(00004, 6, 1, 102);
INSERT INTO  OrderLineItem VALUES(00005, 8, 1, 103);
INSERT INTO  OrderLineItem VALUES(00006, 3, 1, 104);
INSERT INTO  OrderLineItem VALUES(00007, 6, 1, 104);
INSERT INTO  OrderLineItem VALUES(00008, 2, 1, 104);
INSERT INTO  OrderLineItem VALUES(00009, 1, 1, 105);
INSERT INTO  OrderLineItem VALUES(00010, 5, 1, 105);
INSERT INTO  OrderLineItem VALUES(00011, 3, 1, 105);

INSERT INTO payment_details VALUES(28.74,1.437,10,0,40.18,101);
INSERT INTO payment_details VALUES(33.24,1.66,0,0,34.90,102);
INSERT INTO payment_details VALUES(9.99,0.51,10,0,20.50,103);
INSERT INTO payment_details VALUES(45.73,2.29,0,0,48.02,104);
INSERT INTO payment_details VALUES(50.24,2.51,10,0,62.75,105);



SELECT * FROM StoreItems;
SELECT * FROM ComicBook;
SELECT * FROM CartoonMovie;
SELECT * FROM Customers;

