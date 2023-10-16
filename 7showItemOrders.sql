CREATE OR REPLACE PROCEDURE showItemOrders(custOrderId IN CustOrder.OrderId%type)
IS

custId Customers.CustId%type;
custName Customers.name%type;
custEmail Customers.email%type;
custType Customers.CustType%type;
custAddress Customers.address%type;
itemName ComicBook.title%type;
dateOrdered CustOrder.OrderDate%type;
shippingFee CustOrder.ShippingFee%type;
CURSOR c_orderLineItems IS
	SELECT * FROM OrderLineItem WHERE OrderId=custOrderId;
CURSOR c_paymentDetails IS
	SELECT * FROM payment_details WHERE OrderId=custOrderId;
CURSOR c_custOrderDetails IS
	SELECT ShippedDate, OrderDate, ShippingFee FROM CustOrder
    WHERE OrderId=custOrderId;
BEGIN
	SELECT CustId INTO custId FROM CustOrder
	WHERE OrderId = custOrderId;
	SELECT name INTO custName FROM Customers
	WHERE CustId=custId;
	SELECT email INTO custEmail FROM Customers
	WHERE CustId=custId;
	SELECT address INTO custAddress FROM Customers
	WHERE CustId=custId;
	dbms_output.put_line('Customer ID - ' || custId);
	dbms_output.put_line('Name - ' || custName);
	dbms_output.put_line('Email - ' || custEmail);
	dbms_output.put_line('Address - '|| custAddress);
	dbms_output.put_line('Order ID - '|| custOrderId);
	FOR c_orderLineItem IN c_orderLineItems LOOP
SELECT title INTO itemName FROM ComicBook WHERE ItemId=c_orderLineItem.ItemId;
IF itemName IS NULL THEN
SELECT title INTO itemName FROM CartoonMovie WHERE ItemId=c_orderLineItem.ItemId;
            	END IF;
    	dbms_output.put_line('Item name - ' || itemName);
    	dbms_output.put_line('Number of Items - ' || c_orderLineItem.NumOfItems);
	END LOOP;
FOR c_custOrderDetail IN c_custOrderDetails LOOP
shippingFee:= c_custOrderDetail.ShippingFee;
dbms_output.put_line('Date ordered - ' || c_custOrderDetail.OrderDate);
dbms_output.put_line('Shipped date - '|| c_custOrderDetail.ShippedDate);
       	END LOOP;
FOR c_paymentDetail in c_paymentDetails LOOP
dbms_output.put_line('Total - '|| c_paymentDetail.total);
dbms_output.put_line('Tax - '|| c_paymentDetail.tax);
dbms_output.put_line('Shipping Fee - '|| ShippingFee);
dbms_output.put_line('Discount - '|| c_paymentDetail.discount);
dbms_output.put_line('Grand Total - '|| c_paymentDetail.grand_total);
END LOOP;
	END;
/
show errors;