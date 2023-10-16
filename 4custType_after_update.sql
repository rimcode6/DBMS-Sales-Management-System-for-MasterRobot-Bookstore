	CREATE OR REPLACE TRIGGER custType_after_update
    	AFTER UPDATE ON Customers
    	FOR EACH ROW
    	WHEN (NEW.CustType='gold' AND OLD.CustType!='gold')
    	BEGIN
        	UPDATE CustOrder SET ShippingFee=0 WHERE CustId=:new.CustId;
END;
/
show errors;