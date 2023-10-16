
CREATE OR REPLACE PROCEDURE createOrderLineItem(custOrderId IN CustOrder.OrderId%type, itemId IN StoreItems.ItemId%type, customerId IN Customers.CustId%type, dateOrdered IN CustOrder.OrderDate%type, noOrdered IN OrderLineItem.NumOfItems%type, shippedDate IN CustOrder.ShippedDate%type)
AS
noOfCopies StoreItems.NumOfCopies%type;
invalidQuantityException EXCEPTION;
custType Customers.CustType%type;
shippingFee CustOrder.ShippingFee%type;

BEGIN
noOfCopies:=0;
SELECT NumOfCopies INTO noOfCopies FROM StoreItems WHERE ItemId = itemId;
IF noOrdered>noOfCopies THEN
    RAISE invalidQuantityException;
END IF;
SELECT CustType INTO custType FROM Customers WHERE CustId = customerId;
IF custType = 'gold' THEN
    shippingFee := 0;
ElSIF custType = 'regular' THEN
    shippingFee := 10;
END IF;
INSERT INTO OrderLineItem(LineId, ItemId, OrderId, NumOfItems) VALUES (line_id_seq.NEXTVAL, itemId, custOrderId, noOrdered);
noOfCopies := noOfCopies - noOrdered;
UPDATE StoreItems SET NumOfCopies=noOfCopies WHERE ItemId=itemId;

EXCEPTION
    WHEN invalidQuantityException THEN
         dbms_output.put_line('Invalid quantity'); 
END;
/
show errors;