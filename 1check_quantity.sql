In CUSTOMERS  -> CHECK (CustType IN (‘regular’, ‘gold’) 
In CUSTOMERS -> Unique and Not Null  
In StoreItems -> CHECK (NumOfCopies>0)

ALTER TABLE OrderLineItem ADD CONSTRAINT check_quantity_constraint CHECK(check_quantity(ItemId)="true"); 

CREATE OR REPLACE TRIGGER check_quantity_trigger
AFTER 
UPDATE 
OF NumOfItems
ON OrderLineItem
DECLARE 

CREATE OR REPLACE FUNCTION check_quantity(itemId IN StoreItems.ItemId%type) 
AS 
qty StoreItems.NumOfCopies%type; 
qty_orderLineItems OrderLineItem.NumOfItems%type; 
result CHAR(10); 
BEGIN SELECT NumOfCopies  INTO qty FROM StoreItems WHERE ItemId = itemId; 
SELECT NumOfItems INTO qty_orderLineItems FROM OrderLineItem  WHERE ItemId = itemId; 

IF qty>qty_orderLineItems THEN 

	Result := ‘true’; 

ELSE  

	result:=’false’; 

END IF; 
RETURN result; 
END; 
/
show errors;

	
