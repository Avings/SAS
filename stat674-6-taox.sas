title "STAT674 - Assignment 6 -  Xin Tao" ;
options linesize=80 noovp fmtsearch=(books);

libname books "~pesek/Class/STAT674/books" ;

ods html body='~/public_html/assign6.html' style=BarrettsBlue ;

proc sql ;
   create table orderinfo as
      select orderno, custid, salesid, name, dateord, dateship, bookid
      from books.orders natural join
           books.items natural join
           books.salesrep;
quit;

/* Step 3. print the first 70 obs */
proc print data = orderinfo (obs=70) ;
   title2 "Step 3 - First 70 observations by PRINT" ;
run;

proc sql ;
   title2 "Step 3 - First 70 observations by SQL" ;
   select * from orderinfo (obs=70) ;
quit;

/* Step 4. print the next 50 obs */
proc print data = orderinfo (firstobs=71 obs=120) ;
   title2 "Step 4 - Next 50 observations by PRINT" ;
run;
    
proc sql ;
   title2 "Step 4 - Next 50 observations by SQL" ;
   select * from orderinfo (firstobs=71 obs=120) ;
quit; 

/* Step 5. print the obs with order # 100450-100510 & 50320-50380 */ 
proc print data = orderinfo ;
   where 100450 <= orderno <= 100510 or 50320 <= orderno <= 50380; 
   title2 "Step 5 - Observations with order # 100450-100510 & 50320-50380 by PRINT" ; 
run;
    
proc sql ;
   title2 "Step 5 - Observations with order # 100450-100510 & 50320-50380 by SQL" ; 
   select * from orderinfo
   where 100450 <= orderno <= 100510 or 50320 <= orderno <= 50380;
quit;

/* Step 6. First 65 obs list only vars: orderno, salesid, bookid, dateship */
proc print data = orderinfo(obs=65 keep=orderno salesid bookid dateship) ;
   title2 "Step 6 - First 65 obs orderno, saleid, bookid, dataship by PRINT";
run;

proc sql ;
   title2 "Step 6 - First 65 obs orderno, saleid, bookid, dataship by SQL";
   select * from orderinfo (obs=65 keep=orderno salesid bookid dateship) ;
quit;

/* 7. Step 7. First 20 obs list only vars:bookid, orderno, name, custid in fix order
(suppress/add obs for print/sql) */
proc print data = orderinfo(obs=20) noobs ;
   var bookid orderno name custid ;
   title2 "Step 7 - First 20 obs bookid, orderno, name, custid in fix order by PRINT";
run; 

proc sql number ;
   title2 "Step 7 - First 20 bookid, orderno, name, custid in fix order by SQL";
   select bookid, orderno, name, custid 
   from orderinfo (obs=20) ;
quit;

/* 8. Step 8. First 30 obs list vars: orderno, name then change them to OrderNumber, 
nameofsalesrep */
proc print data = orderinfo(obs=30 keep=orderno name rename=(orderno=OrderNumber 
                  name=nameofsalesrep)) ;
   title2 "Step 8 - First 30 obs with orderno and name renamed by PRINT";
run; 

proc sql ;
   title2 "Step 8 - First 30 obs with orderno and name renamed by SQL";
   select orderno as OrderNumber label="orderno is now OrderNumber", 
          name as nameofsalesrep label="name is now nameofsalesrep" 
   from orderinfo (obs=30);
quit;

/* Step 9. Create new temporary data set containing the first 500 obs sorted by 
name in ascending order and dateord in descending order */
proc sort data = orderinfo (obs=500) out = sortfirst500 ;
   by name descending dateord ;
run;

/* Step 10. Print out the new data set created in 9 */
proc print data = sortfirst500 ;
   title2 "Step 10 - First 500 obs sorted by name (ascending) and dateord (descendingh) by PRINT" ;
   by name descending dateord ;
run;

proc sql ;
   title2 "Step 10 - First 500 obs sorted by name (ascending) and dateord (descendingh) by SQL" ;  
   select * from sortfirst500
   order by name, dateord desc ;
quit;

/* Step 11. Create a permanent dataset books2.orderinfo containing the first 700 obs */ 
libname books2 '.' ;
data books2.orderinfo (pw=rosebud label="Order Information" encrypt=yes) ;
   set orderinfo(obs=700) ;
run;

/* Step 12. Display books2.orderinfo by print and content procedure */
proc print data = books2.orderinfo(pw=rosebud) ;
   title2 "Step 12 - Display books2.orderinfo" ;
run;

proc contents data = books2.orderinfo(pw=rosebud) ;
   title3 "Step 12 - Display contents of books2.orderinfo" ;
run;

/* Step 13. Create a permanent xml formatted data set books3.orderinfo containing the first 150 obs */
libname books3 xml "books.xml" ;

data books3.orderinfo ;
   set orderinfo (obs=150) ;
run;


ods html close ;

x 'chmod o+r ~/public_html/assign6.html' ;



