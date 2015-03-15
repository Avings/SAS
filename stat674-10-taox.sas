title "STAT674 - Assignment 10 - Joining tables using SQL - Xin Tao " ;
options linesize=80 noovp ;

options fmtsearch=(books) ;
libname  books  "~pesek/Class/STAT674/books" ;

ods html body='~/public_html/assign10.html' style=festival ;


/*Step 4. Listign all data sets in a library */
title2 "Step 4. Listing Data Sets" ;
proc datasets lib=books ;
     contents data=_all_ ;
run;


/*Step 5a. List the orders #141250-141275 */
proc sql number ;
   title2 "Step 5a1. Orders #141250-141275 by Inner Join" ;
   select orders.custid,
          dateord,
          orderno,
          salesid,
          strip(lname)|| ', ' || fname  label="Customer Full Name"
   from books.orders INNER JOIN books.customers
      on orders.custid=customers.custid
   where orderno between 141250 and 141275 ;
quit;

proc sql number ;
   title2 "Step 5a2. Orders #141250-141275 by Natural Join" ;
      select custid,
            dateord,
            orderno,
            salesid,
            strip(lname)|| ', ' || fname  label="Customer Full Name"
      from books.orders NATURAL JOIN books.customers
      where orderno between 141250 and 141275 ;
quit;

/*Step 5b. List the items #21010-21040 */
proc sql number ;
   title2 "Step 5b1. Items #21010-21040 by Inner Join" ;
      select items.orderno,
             dateord,
             dateship,
             scan(title,1,' ')||' '||scan(title,2,' ')||' '||scan(title,3,' ')||' '||scan(title,4,' ')||' '||scan(title,5,' ')
             label="Title (First Five Words)"
      from books.orders INNER JOIN books.items
         on orders.orderno=items.orderno
                        INNER JOIN books.list
         on items.bookid=list.bookid
     where items.orderno between 21010 and 21040 ;
quit;

proc sql number ;
   title2 "Step 5b2. Items #21010-21040 by Natural Join" ;
      select items.orderno,
             dateord,
             dateship,
             scan(title,1,' ')||' '||scan(title,2,' ')||' '||scan(title,3,' ')||' '||scan(title,4,' ')||' '||scan(title,5,' ')
             label="Title (First Five Words)"
      from books.orders NATURAL JOIN books.items
                        NATURAL JOIN books.list
      where items.orderno between 21010 and 21040 ;
quit;

/*Step 5c. List the itmes #90530-90570 */
proc sql number ;
   title2 "Step 5c. Items #90530-90570 by Inner Join" ;
      select orders.orderno,
             name,
             items.bookid,
             author
      from books.orders INNER JOIN books.salesrep
      on orders.salesid=salesrep.salesid
                        INNER JOIN books.items
      on orders.orderno=items.orderno
                        INNER JOIN books.list
      on items.bookid=list.bookid
      where orders.orderno between 90530 and 90570;
quit;

/*Step 5d. List the itmes #75000-75030 */
proc sql number ;
   title2 "Step 5d. Items #75000-75030 by Natural Join" ;
      select orderno,
             name,
             phone,
             dateship,
             author2
      from books.orders NATURAL JOIN books.salesrep
                        NATURAL JOIN books.items
                        NATURAL JOIN books.customers
                        NATURAL JOIN books.list
      where orderno between 75000 and 75030;
quit;

/*Step 5e. List the itmes #123450-123475 */
proc sql number ;
   title2 "Step 5e. Items #123450-123475 by Inner Join" ;
      select orders.orderno,
             dateord,
             dateship,
             scan(name,-1,' ') label="Sales Representative Last Name",
             isbn,
             lname,
             price
      from books.orders INNER JOIN books.salesrep
      on orders.salesid=salesrep.salesid
                        INNER JOIN books.items
      on orders.orderno=items.orderno
                        INNER JOIN books.list
      on items.bookid=list.bookid
                        INNER JOIN books.customers
      on orders.custid=customers.custid
                        INNER JOIN books.prices
      on list.bookid=prices.bookid
      where orders.orderno between 123450 and 123475
         and datefirst <= dateord <= datelast ;
quit;


/*Step 6. Customers who made no orders in 2010*/
proc sql ;
   create table orders2010 as
   select *
   from books.orders
   where dateord >= '1jan2010'd and dateord <= '31dec2010'd ;
quit;

proc sql number ;
   title2 "Step 6. Customers with No Orders in 2010 by Outer Join" ;
   select customers.custid,
          fname,
          lname
   from books.customers LEFT JOIN orders2010
      on customers.custid=orders2010.custid
   where orders2010.dateord= . ;
quit;


/*Step 7. Repeat Step6. using 3 data steps, 2 sort and print procedures*/
data orders2010b;
   set books.orders;
   where dateord >= '1jan2010'd and dateord <= '31dec2010'd ;
run;

data customers ;
   set books.customers ;
run;

proc sort data=orders2010b ;
   by custid ;
run;

proc sort data=customers ;
   by custid ;
run;

data noorders2010 ;
   MERGE orders2010b customers ;
   by custid ;
   if dateord = . ;
run;

proc print data = noorders2010 ;
   title2 "Step 7. Customers with No Orders in 2010 by Data Step" ;
   var custid fname lname ;
run;


/*Step 8 Items not sold by John Bardeen on March 30, 2009*/
proc sql ;
   create table Bardeen as
   select custid,
          dateord,
          orders.orderno,
          orders.salesid,
          bookid,
          name
    from books.orders INNER JOIN books.salesrep
    on orders.salesid=salesrep.salesid
                      INNER JOIN books.items
    on orders.orderno=items.orderno
    where name="John Bardeen" and dateord='30Mar2009'd ;
quit ;

proc sql ;
   create table Bardeen2 as 
   select list.bookid,
          title,
          author,
          dateord
   from books.list LEFT JOIN Bardeen
      on list.bookid=Bardeen.bookid
   where name=' ' and dateord= .  ;
quit;

proc sql ;
   title2 "Step 8. Books Not Sold by John Bardeen on March 30, 2009" ;
   select prices.bookid,
          title,
          price,
          author
   from Bardeen2 INNER JOIN books.prices
      on Bardeen2.bookid=prices.bookid
   where datefirst <= '30Mar2009'd <= datelast ;
quit;


/*Step 9. blocks */
data blocks ;
   do block=2 to 4;
      output;
   end;
run;

data Nitrogen ;
   input N ;
cards ;
0
40
90
  ;
run;

data PlantingDate ;
   length Date $10 ;
   input Date $ ; 
cards ;
4/15/2014
5/1/2014
5/15/2014
6/1/2014
   ;
run;

proc sql ;
   title2 "Step9. Blocks" ;
      select block "Blocks",
             N "Nitrogen",
             Date "PlantingDate"
      from blocks, Nitrogen, PlantingDate
      order by block, ranuni(2013111823) ;
quit;


ods html close;
x 'chmod go+r ~/public_html/assign10.html' ;

endsas;

/* End */




/* Step5e by natural join
proc sql number ;
   title2 "Step 5e2. Items #123450-123475 by Natural Join" ;
      select orderno,
             dateord,
             dateship,
             scan(name,-1,' ') label="Sales Representative Last Name",
             isbn,
             lname label="Customer Last Name",
             price
      from books.orders NATURAL JOIN books.salesrep
                        NATURAL JOIN books.items
                        NATURAL JOIN books.list
                        NATURAL JOIN books.prices
                        NATURAL JOIN books.customers
      where orders.orderno between 123450 and 123475
         and datefirst <= dateord <= datelast ;
quit;

proc print data=books.prices (firstobs=1 obs=30);
run;

proc print data=books.orders (firstobs=1 obs=30);
run;
*/

