alter table CustOrder add constraint shipping_date_check check (ShippedDate >= OrderDate); 

CREATE OR REPLACE TRIGGER updateShippingFee 

AFTER UPDATE OF CustType ON Customers 

FOR EACH ROW 

WHEN (NEW. CustType ='gold') 

BEGIN 
	UPDATE CustOrder 

SET ShippedFee = 0 

WHERE CustId= :new. CustId AND ShippedDate!=NULL; 
END; 
CREATE OR REPLACE TRIGGER addGo


CREATE SEQUENCE orderId_seq START WITH 100;

CREATE OR REPLACE FUNCTION createCustOrder
RETURN CustOrder.OrderId%type
IS
newOrderId CustOrder.OrderId%type;
BEGIN
	newOrderId := orderId_seq.NEXTVAL;
RETURN newOrderId;
END;
/
show errors;