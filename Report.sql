SET ECHO ON                                                  

SPOOL C:\Users\Rim\Documents>DbProjectReport.txt      

REM ** set formatting commands ...              
TTITLE CENTER "Master Robot Sales Management System" SKIP 1 -                      
        CENTER "Report of a Customer Order " SKIP 3 -
	CENTER "Rima Modak " SKIP 2 -

BTITLE RIGHT "=======================================================" SKIP 1 -
       CENTER "Rima Modak" -
       RIGHT "Page" FORMAT 999 SQL.PNO skip 1

// show heading. If you don't need it, set it off
SET HEADING ON
// the size of one page
SET PAGESIZE 33
// the size of each row
SET LINESIZE 55
// show feedback, in the result "21 rows select.". If you don't need it, set it off
SET FEEDBACK ON
//SET RECSEP {WR[APPED] | EA[CH] | OFF}. WR:print a record separator only when a line wraps. This is the default setting. EA: print a record separator after each record.
SET RECSEP EACH

VARIABLE grand_total NUMBER;
VARIABLE OrderId NUMBER;

DECLARE 
   a number; 
   b number;
   orderid1 Customers.CustType%type;
   lineid OrderLineItem.LineId%type;

   price1 StoreItems.price%type;
   itemid StoreItems.ItemId%type;
   quantity StoreItems.NumOfCopies%type;
   name1 Customers.name%type;
   custtype Customers.CustType%type;
   email Customers.email%type;
   address Customers.address%type;
   custid  CustOrder.CustId%type;
   shippingfee CustOrder.ShippingFee%type;
   orderdate CustOrder.OrderDate%type;
   shippingdate CustOrder.ShippedDate%type;
   numberofitems CustOrder.NumOfItems%type;

BREAK ON course_code  NODUPLICATES -
           ON address               NODUPLICATES

REM ** Insert SELECT statement

   CURSOR details is 
    SELECT LineId,OrderId,NumOfItems,ItemId FROM OrderLineItem; 
PROCEDURE showItemOrders(orderid IN OUT number) IS 
BEGIN 
   b:=0;
   
   select CustId into custid
   from CustOrder
   where OrderId=orderid;

 select name,email,CustType,address into name1,email,custtype,address
   from Customers
   where CustId=custid;
   dbms_output.put_line('Customer ID: '||custid||'  '||'Name: '||name1||'  '||'EmailID: '||email||'  '||'Customer_type: '||custtype||'  '||'Address: '||address); 
   
   select NumOfItems,OrderDate,ShippedDate,ShippingFee into numberofitems,orderdate,shippingdate,shippingfee
   from CustOrder
   where OrderId=orderid;
   dbms_output.put_line('OrderID: '||orderid||'  '||'NumberOfOrders: '||numberofitems||'   '||'DateOrdered: '||orderdate||'  '||'ShippedDate: '||shippingdate||'    '||'Shipping Fee: '||shippingfee);
   
   OPEN details; 
   LOOP 
   FETCH details into lineid,orderid1, quantity,itemid;
      EXIT WHEN details%notfound; 
      if orderid=orderid1 then
      
      select price into price1
      from StoreItems
      where ItemId=itemid;
      
      b:=b+price1*quantity;
      dbms_output.put_line('Line_ID: '||lineid||'   '||'ItemID: '||itemid||'   '||'Price: '||price1||'  '||'Quantity: '||quantity); 
      end if;
      END LOOP; 
       b:=b+shippingfee;
       :grand_total:=b;
      dbms_output.put_line('Total Bill: '|| b);
   CLOSE details; 
END;

BEGIN 
   a:=&Order_ID;
   :OrderId:=a;
   showItemOrders(a);
END;
/

select * from Customers where CustId in (select CustId from CustOrder where OrderId=:orderid);

select *from CustOrder where OrderId=:orderid;

select *from OrderLineItem where OrderId=:orderid;

select * from StoreItems where ItemId in (select ItemId from OrderLineItem where OrderId=:orderid);

select OrderLineItem.ItemId, StoreItems.price, CartoonMovie.title from ((StoreItems
INNER JOIN OrderLineItem ON StoreItems.ItemId = OrderLineItem.ItemId)
INNER JOIN CartoonMovie ON StoreItems.ItemId = CartoonMovie.ItemId)
where OrderLineItem.OrderId=:orderid;a

select OrderLineItem.ItemId, ComicBook.title from ((StoreItems
INNER JOIN OrderLineItem ON StoreItems.ItemId = OrderLineItem.ItemId)
INNER JOIN ComicBook ON StoreItems.ItemId = ComicBook.ItemId)
where OrderLineItem.OrderId=:orderid;

select OrderLineItem.NumOfItems*StoreItems.price AS SUB_TOTAL, OrderLineItem.OrderId 
from OrderLineItem
INNER JOIN StoreItems ON OrderLineItem.ItemId=StoreItems.ItemId
where OrderLineItem.OrderId=:orderid;

PRINT grand_total;


REM ** clear all formatting commands ...
CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF
BTITLE OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET PAGESIZE 10
SET LINESIZE 75
SET RECSEP OFF
SET ECHO OFF

SPOOL OUT

show errors;
