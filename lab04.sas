title "STAT674 Class 4 Lab exercise - Xin Tao"  ;

options linesize=80 noovp fmtsearch=(books) ; 
  
/* Libname to access hypothetical SAS books data base */
libname  books  "~pesek/Class/STAT674/books" ;
 
  
data customers;
     set books.customers ; 

/* 6. Display in html format */
ods html body='~/public_html/lab4.html' style=seaside ;
 
/* 5. Determine variable names: address1; city; custid; fname; lname; phone; stcode; zip */
proc contents data=books.customers;
title2 "Determine variable names and other information about books.customers" ;
run;

/* 7. Print the first 25 obs */
proc print data=customers(obs=25) ;

/* 8a. Add title2 in print */
title2 "Contents of book.customers by print" ;

run;

/* 8b&9. Add title2 in sql. Note: if the title2 statement is put as the last statement immediately before the quit
statement, the title2 statement does not take effect (evidence: the title2 does not change). title2 statement should
be put immediately before the select statement. */
proc sql ;
title2 "Contents of book.customers by sql" ;
    select *
       from customers(obs=25) ;
quit;

/* 10. Display obs 41-60 */
proc print data=customers(firstobs=41 obs=60);
title2 "Observation 41 through 60 using print" ;
run;

proc sql ;
title2 "Observation 41 through 60 using sql" ;
    select *
       from customers(firstobs=41 obs=60);
quit;

/* 11. Display obs 81-100 with selected variables */
data customers2 ;
    set customers(keep=custid zip fname lname) ;
proc print data=customers2(firstobs=81 obs=100);
   title2 "Observation 81 through 100 using print with custid zip fname lname only" ;
run;

proc sql ;
title2 "Observation 81 through 100 using sql with custid zip fname lname only" ;
    select custid, zip, fname, lname 
       from customers(firstobs=81 obs=100);
quit;

/* 12. Display obs 81-100 without certain variables */
data customers2 ;
    set customers(drop=custid fname lname) ;
proc print data=customers2(firstobs=81 obs=100);
   title2 "Observation 81 through 100 using print without custid fname lname" ;
run; 

proc sql ;
title2 "Observation 81 through 100 using sql without custid fname lname" ;
    select address1, city, phone, stcode, zip
       from customers(firstobs=81 obs=100);
quit;

/* 13. Display obs 121-140 with selected variables using var statement for the print procedure */
proc print data=customers(firstobs=121 obs=140);
   var custid zip stcode ;
   title2 "Observation 121 through 140 using print with custid, zip, state" ;
run;
    
proc sql ;
title2 "Observation 121 through 140 using sql with custid, zip, state" ;
    select custid, zip, stcode
       from customers(firstobs=121 obs=140);
quit;

/* 14. Repeat step12 but double space the output for each procedure */
data customers2 ;
    set customers(drop=custid fname lname) ;

proc print data=customers2(firstobs=81 obs=100) double;
   title2 "Observations 81 through 100 using print without custid, fname, lname - double space" ;
run;
    
proc sql double ;
title2 "Observations 81 through 100 using sql without custid, fname, lname - double space" ;
    select address1, city, phone, stcode, zip
       from customers(firstobs=81 obs=100);

/* 15. Display variable with custid between 2100 and 2200 OR between 3100 and 3200 */
proc print data=customers ;
   where 2100 <= custid <= 2200 or 3100 <= custid <= 3200 ;
   title2 "Observations with custid between 2100 and 2200 OR between 3100 and 3200 using print" ;
run;

proc sql ;
    title2 "Observations with custid between 2100 and 2200 OR between 3100 and 3200 using sql" ;
    select *
    from customers
       where (2100 <= custid <= 2200) or (3100 <= custid <= 3200) ;
quit;

/* 16. Create a new temporary data set containing the first 60 obs from customers sorted by state */
proc sort data = customers (obs= 60) out = customerssort;
   by stcode ;
run;
proc print data=customerssort;
   title2 "First 60 observations sorted by state using print" ;
run;

proc sql ;
title2 "First 60 observations sorted by state using sql" ; 
    select *
       from customerssort(obs=60);
quit;

/* 17. Use the by statement in the print procedure to display the new data set by state and use order by in sql*/
proc print data=customerssort;
   by stcode;
   title2 "First 60 observations sorted by state using print (with by statement)" ;
run;
   
proc sql ;
title2 "First 60 observations sorted by state using sql (with order by)" ;
    select *
       from customerssort(obs=60)
    order by stcode;
quit;
  
ods html close ;

x 'chmod o+r ~/public_html/lab4.html' ;

  

 
