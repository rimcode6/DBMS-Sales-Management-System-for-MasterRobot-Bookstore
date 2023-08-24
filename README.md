# Sales Management System for MasterRobot Bookstore
DBMS-Sales-Management-System-for-MasterRobot-Bookstore

## Introduction
Designed and Implemented a Sales Management System for MasterRobot, an online bookstore specializing in children's comic books and Cartoon movies. This system will utilize a Relational Database managed by Oracle to maintain sales and customer records and facilitate various queries for tracking customer orders.

## System Components

### 1. StoreItems
- Comic books and cartoon movies are considered StoreItems.
- Each StoreItem has:
  - ItemId (unique identifier)
  - Price
  - Number of copies
- Comic books have an additional attribute:
  - Title
  - Published Date
- Cartoon movies have:
  - Title
  - Studio name
  - Description

### 2. Customers
- Customers can be of two types: regular or gold.
- Common attributes for customers:
  - Custid (unique identifier)
  - CustType (either 'regular' or 'gold')
  - Name
  - Phone/Email
  - Address

#### Gold Customers
- Gold customers have additional attributes:
  - DateJoined
  - Coupons
- Gold customers pay an annual fee and enjoy free shipping on their orders.

### 3. Orders
- When a customer (either regular or gold) places an order for StoreItems, a CustOrder is created.
- CustOrder attributes:
  - Orderid (unique identifier)
  - Date of order
  - ShippedDate
  - ShippingFee
- Each CustOrder is associated with one or more OrderLineItems.
- OrderLineItems have a unique line id within an order and are associated with a specific StoreItem and a quantity.

## Constraints to Enforce
1. The custType of a customer can only be 'regular' or 'gold'.
2. Phone or email must be unique and not null.
3. The number of copies of a comic book or a cartoon movie cannot be less than 0.
4. The number of copies ordered cannot exceed the available number of copies.
5. ShippedDate cannot be earlier than the OrderedDate.
6. If a regular customer changes to 'gold' before their order is shipped, the shipping fee on pending orders must be changed to 0.

## Functionality and Queries

### a) Data Initialization
- Create a variety of customers (mix of regular and gold), comic books, and cartoons with at least 10 records for each.

### b) PLSQL Function: createCustOrder()
- Generate a random orderId for a new CustOrder.
- Return the orderId to the calling program.

### c) PLSQL Procedure: createOrderLineItem()
- Accept parameters like custOrderId, itemid, customerid, date ordered, number ordered, and shipped date (among others if necessary).
- Check if the ordered quantity is less than or equal to the available copies.
- Set the shipping fee based on the customer's type (gold or regular).
- Create an OrderLineItem with a reference to the CustOrder.
- Update the item table with the remaining number of copies.

### d) Trigger
- Create a trigger to check if a customer's custType is updated to 'gold'.
- If so, check for pending orders and set their shippingFee to 0.

### e) PLSQL Procedure: setShippingDate()
- Given an orderId and shipping date, set the shippingDate for that order.

### f) PLSQL Function: computeTotal()
- Given an orderId, calculate the total for that order considering customer type, tax, shipping fee, discounts (for Gold Customers), and the grand total.
- Return the total.

### g) PLSQL Procedure: showItemOrders()
- Accept a custOrderId as a parameter.
- Display details of the CustOrder, including customer details, item details, and payment details (total, tax, shipping fee, discounts, and grand total).

### h) PLSQL Procedure: showItemOrdersAfter()
- Accept a customerid and a date as parameters.
- Display details of each CustOrder placed by that customer after the given date, similar to the function in part g).

This Sales Management System will efficiently handle sales and customer records for MasterRobot's online bookstore, ensuring data accuracy and providing essential functionalities for managing orders and customers.
