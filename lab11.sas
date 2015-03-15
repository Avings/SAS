title "Lab 11 STAT674 Aggregation in SAS - Xin Tao"  ;
options linesize = 80  noovp fmtsearch=(books);
  
/* Additional libname to access formats for data base */
libname  books   "~pesek/Class/STAT674/books" ;

ods html body='~/public_html/lab11.html' style=analysis ;

/*Step 4. */ 
proc sql ;
    create table sales as
    select orders.*,
           name,
           year(dateord) as yearordered label="Year ordered",
           quantity,
           price
    from books.orders inner join books.salesrep
       on orders.salesid=salesrep.salesid
                     inner join books.items
       on orders.orderno=items.orderno
                     inner join books.prices
       on items.bookid=prices.bookid
    where dateord between datefirst and datelast;
quit;

/* Step 5. */
proc means data=sales n sum mean maxdec=2 ;
   title2 "Step 5. Number, total and average sales for each salesid" ;
   freq quantity ;
   class salesid ; 
   types salesid ;
   var price ;
run;


/* Step 6. */
proc summary data=sales ;
   freq quantity ;
   class salesid ;
   types salesid ;
   var price ;
   id name ;
   output out=salessum n(price)=Number_Sold mean(price)=AverageSales sum(price)=TotalSales ;  
run; 

proc print data=salessum label ;
title2 "Step 6. Summary of salessum" ;
   var salesid name Number_Sold AverageSales TotalSales ;
   format number_sold 5. AverageSales Dollar14.2 TotalSales Dollar14.2 ;
   label Number_Sold="Number of books sold"
       AverageSales="Average Sales ($)"
       TotalSales="Total Sales ($)" ;
run;

/* Step 7. */
proc summary data=sales ;
   freq quantity ;
   class salesid yearordered ;
   types salesid*yearordered ;
   var price ;
   id name ;
   output out=salessum2 n(price)=Number_Sold mean(price)=AverageSales 
   sum(price)=TotalSales ;
run;

proc print data=salessum2 label ;
title2 "Step 7. Summary of salessum2" ;
   var salesid yearordered name Number_Sold AverageSales TotalSales ;
   format number_sold 5. AverageSales Dollar14.2 TotalSales Dollar14.2 ;
   label Number_Sold="Number of books sold"
       AverageSales="Average Sales ($)"
       TotalSales="Total Sales ($)" ;

/* Step 8. */
proc sql ;
    create table salessum3 as
    select distinct salesid,
           name,
           sum(quantity) as NumberSales label="Number of books sold" format=5.,
           mean(price) as AverageSales  label="Average Sales ($)" format=dollar14.2,
           sum(price*quantity) as TotalSales label="Total Sales ($)" format=dollar14.2
    from sales
    group by salesid
    order by salesid ;
quit;

proc print data=salessum3 label ;
title2 "Step 8. Summary of salessum3" ;
   var salesid name NumberSales AverageSales TotalSales ;
run;

/* Step 9. */
proc sql ;
    create table salessum4 as
    select distinct salesid,
           name,
           sum(quantity) as NumberSales label="Number of books sold" format=5.,
           mean(price) as AverageSales  label="Average Sales ($)" format=dollar14.2,
           sum(price*quantity) as TotalSales label="Total Sales ($)" format=dollar14.2
    from sales
    group by salesid 
    having TotalSales > 132000
    order by salesid ;
quit;

proc print data=salessum4 label ;
title2 "Step 9. Summary of salessum4" ;
   var salesid name NumberSales AverageSales TotalSales ;
run;

/* Step 10. */
proc sql ;
    create table salessum5 as
    select distinct salesid,
           name,
           yearordered,
           sum(price*quantity) as TotalSales label="Total Sales ($)" format=dollar14.2
    from sales
    group by salesid, yearordered 
    order by salesid, yearordered ;
quit;

proc print data=salessum5 label ;
title2 "Step 10. Summary of salessum5" ;
   var salesid name yearordered TotalSales ;
run;

ods html close;
x 'chmod go+r ~/public_html/lab11.html' ;


