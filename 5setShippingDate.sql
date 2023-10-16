CREATE OR REPLACE PROCEDURE setShippingDate(orderId IN CustOrder.OrderId%type, shippedDate IN CustOrder.ShippedDate%type)
		IS BEGIN
UPDATE CustOrder SET ShippedDate = shippedDate WHERE OrderId = orderId;
END;
/
show errors;
