title "STAT674  - Lab 8 - Joining Tables using SQL" ;
title2 "SAS books -Inner Joins - Xin Tao" ;
options linesize=80 noovp ;
 
options fmtsearch=(books);
 
/* Libname to access hypothetical SAS books data base */
libname  books  "~pesek/Class/STAT674/books" ;
 
 
/* Determine variable names and labels */
proc datasets library=books ;   
     contents data=_all_ ;
run;
quit;  

ods html body='~/public_html/lab8.html' style=plateau ;

/* Step 3. */
proc sql number ;
title3 "Step 3. All orders for customer id #4323 by inner join " ;
   select orderno,
          fname format=$15.,
          lname format=$15.,
          address1,
          zip
   from books.orders inner join books.customers
      on orders.custid = customers.custid
     where customers.custid = 4323 ;
quit;

/* Step 4. Repeat step 3 but use natural join */
proc sql number ;
title3 "Step 4. All orders for customer id #4323 by natural join " ;
   select orderno,
          fname format=$15.,
          lname format=$15.,
          address1,
          zip
   from books.orders natural join books.customers
     where customers.custid = 4323 ;
quit;

/* Step 5. Display all records with customer id # 3003 or 4213 */
proc sql number ;
title3 "Step 5. All orders for customer id #3003 or 4213 by inner join " ;
   select orders.custid,
          orderno,
          fname format=$15.,
          lname format=$15.,
          orders.salesid,
          salesrep.name
   from books.orders inner join books.customers 
      on orders.custid = customers.custid
   inner join books.salesrep
      on orders.salesid = salesrep.salesid 
     where customers.custid in (3003, 4213)
   order by orderno ;
quit;

/* Step 6. Repeat step 5 but use natural join */
proc sql number ;
title3 "Step 6. All orders for customer id #3003 or 4213 by natural join " ;
   select orders.custid,
          orderno,
          fname format=$15.,
          lname format=$15.,
          orders.salesid,
          salesrep.name
   from books.orders natural join books.customers
                     natural join books.salesrep
     where customers.custid in (3003, 4213)
   order by orderno  ;
quit;

/* Step 7. Display all orders with customer id # 5013, 8425 or 3376 */
proc sql number ;
title3 "Step 7. All orders for customer id # 5013, 8425 or 3376 by inner join " ;
   select orders.custid,
          orders.orderno,
          fname format=$15.,
          lname format=$15.,
          dateship,
          name
   from books.orders inner join books.customers
      on orders.custid = customers.custid
   inner join books.salesrep
      on orders.salesid = salesrep.salesid
   inner join books.items
      on orders.orderno = items.orderno 
    where customers.custid in (5013, 8425, 3376)
   order by orderno ;
quit;        

/* Step 8. Repeat step 5 but use natural join */
proc sql number ;
title3 "Step 8. All orders for customer id # 5013, 8425 or 3376 by natural join " ;
   select orders.custid,
          orders.orderno,
          fname format=$15.,
          lname format=$15.,
          dateship,
          name
   from books.orders natural join books.customers
                     natural join books.salesrep
                     natural join books. items
     where customers.custid in (5013,8425,3376)
   order by orderno  ;
quit; 
   
/* Step 9. Repeat step 7. but adding variable 'title' */
proc sql number ;
title3 "Step 9. All orders for customer id # 5013, 8425 or 3376 with book title" ;
   select orders.custid,
          orders.orderno,
          fname format=$15.,
          lname format=$15.,
          dateship,
          name,
          title
   from books.orders inner join books.customers
      on orders.custid = customers.custid
   inner join books.salesrep
      on orders.salesid = salesrep.salesid
   inner join books.items
      on orders.orderno = items.orderno
   inner join books.list   
      on items.bookid = list.bookid 
   where customers.custid in (5013, 8425, 3376)
   order by orderno ;
quit;

/* Step 10. Repeat step 10. but adding variable 'title'  */
proc sql number ;
title3 "Step 10. All orders for customer id # 5013, 8425 or 3376 with price and first author " ;
   select orders.custid,
          orders.orderno,
          fname format=$15.,
          lname format=$15.,
          dateship,
          name,
          author,
          price
   from books.orders inner join books.customers
      on orders.custid = customers.custid
   inner join books.salesrep
      on orders.salesid = salesrep.salesid
   inner join books.items
      on orders.orderno = items.orderno
   inner join books.list
      on items.bookid = list.bookid
   inner join books.prices
      on list.bookid = prices.bookid
   where customers.custid in (5013, 8425, 3376) 
         and dateord between datefirst and datelast
   order by orderno ;
quit;


ods html close;
x 'chmod go+r ~/public_html/lab8.html' ;
  
