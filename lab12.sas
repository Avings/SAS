title "674 Lab Exercise 12 Tabulate Xin Tao";
 
options linesize=80 noovp fmtsearch=(books) ;
 
/* Libname to access hypothetical SAS books data base */
libname  books  "~pesek/Class/STAT674/books" ;
/*
proc datasets library=books ;   
     contents data=_all_ ;
run;
quit;
*/
 
proc format;
   value dw 1="Sunday" 
            2="Monday" 
            3="Tuesday" 
            4="Wednesday" 
            5="Thursday"
            6="Friday" 
            7="Saturday" ;
run;	
                
proc sql ;
   create table sales  as
   select orders.orderno as orderno, 
          weekday(dateord)as dateord label="Day of Week Ordered" format=dw.,
          customers.city,
          customers.stcode,
          scan(salesrep.name,-1,' ') as last length=20
          label="Sales Representative",
          items.quantity,
          prices.price
   from books.orders natural join books.salesrep
          natural join books.customers
          natural join books.items
          natural join books.prices 
   where dateord between datefirst and datelast ;
quit;  

ods html body="~/public_html/lab12.html" style=barrettsblue ;

/*Step 5a. */
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5a. Total Sales for Each Day of the Week" ;
   var price ;
   class dateord ;
   table dateord*price*sum ;
run;

/*Step 5b. */
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5b. Total Sales for Each Day of the Week with Total Sales for All Days" ;
   var price ;
   class dateord ;
   table (dateord all)*price*sum ;
run;

/*Step 5c. */
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5c. Total Sales for Each State" ;
   var price ;
   class stcode ;
   table stcode, price*sum ;
run;

/*Step 5d. */
proc tabulate data=sales ; 
   freq quantity ;
   title3 "Step 5d. Total Sales for Each State with Total Sales for All States" ;
   var price ;
   class stcode ;
   table stcode all, price*sum ;
run;
  
/*Step 5e. */
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5e. Total Sales for Each State and Day of the Week" ;
   var price ;
   class stcode dateord ;
   table stcode, dateord*price*sum ;
run;

/*Step 5f. */   
proc tabulate data=sales ; 
   freq quantity ;
   title3 "Step 5f. Total Sales for Each State and Day of the Week with Total Sales for Each 
      Day" ;
   var price ;
   class stcode dateord ;  
   table (stcode all), dateord*price*sum ;
run;

/*Step 5g. */   
proc tabulate data=sales ; 
   freq quantity ;
   title3 "Step 5g. Total Sales for Each Day of the Week and for Each State" ;
   var price ;
   class stcode dateord ;  
   table (stcode all), (all dateord)*price*sum ;
run;

/*Step 5h. */
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5h. Enhanced Table f with Dollar Formats" ;
   var price ;
   class stcode dateord ;  
   table (stcode="State" all="Total Sales of Each Day of the Week"), dateord="Sales for Each 
         State on Each Day of the Week" *price=' '*sum=' '*f=dollar14.2 / Box='Total Sales 
         of State*Day' ; 
run;

/*Step 5i.*/
proc format ;
   value $traffic 'AL'-'GA'='red'
                  'IA'-'MI'='green'
                  'NC'-'WI'='blue' ;
run;
  
proc tabulate data=sales ;
   freq quantity ;
   title3 "Step 5i. Enhance the html version of Table h" ;
   var price ;
   class stcode dateord ;  
   classlev stcode / style=[font_weight=bold background=white foreground=$traffic.] ;
   table (stcode="State" all="Total Sales of Each Day of the Week"), dateord="Sales for Each
         State on Each Day of the Week" *price=' '*sum=' '*f=dollar14.2 
         *[style=[background=blue foreground=orange fontsize=2]]
         / Box='Total Sales of State*Day'  ;
run;

ods html close ;
x "chmod o+r ~/public_html/lab12.html" ;
 
