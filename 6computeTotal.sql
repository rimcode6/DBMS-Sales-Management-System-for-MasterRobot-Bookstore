CREATE OR REPLACE FUNCTION computeTotal(orderId IN CustOrder.OrderId%type)
RETURN number
AS
grandTotal payment_details.grand_total%type;
itemPrice StoreItems.price%type;
shippingFee CustOrder.ShippingFee%type;
CURSOR c_orderLineItems IS
SELECT ItemId, NumOfItems FROM OrderLineItem WHERE OrderId=orderId;
BEGIN
	FOR c_orderLineItem in c_orderLineitems 
LOOP
SELECT price INTO itemPrice FROM StoreItems WHERE   ItemId=c_orderLineItem.ItemId;
grandTotal := grandTotal+(itemPrice*c_orderLineItem.NumOfItems);
			END LOOP;
			SELECT ShippingFee INTO shippingFee FROM CustOrder
WHERE OrderId=orderId;
grandTotal := grandTotal + shippingFee;
RETURN grandTotal;
		END;
/
show errors;