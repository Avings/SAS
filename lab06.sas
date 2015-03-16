title "Lab 6 Selecting and concatenating data" ;
title2 "Xin Tao" ;
 
options linesize=80 noovp fmtsearch=(books) ;
 
libname books "~pesek/Class/STAT674/books" ;
  
/* Dataset procedure can be used to manage libraries */
proc datasets library=books;
    contents data=_all_ ;
run;
quit;
         
/* Can use means procedure to find ranges of variables */
proc means data=books.orders min max ;
run;

ods html body='~/public_html/lab6.html' style=normal ;
  
/* Step 5. Create a temporary data set ds508 containing orders made on 
05/08/2010 */
data ds508 ;
   set books.orders ;
   if dateord="08May2010"d ;
run;

proc print data = ds508 ;
title2 'Step 5. ds508 Orders on May 8, 2010' ; 
run;

/* Step 6. Creat a temporary data set ds508b */
data ds508b ;
   set books.orders ;
   if  dateord ^= "08May2010"d then delete ;
run;

proc print data = ds508b ;
title2 'Step 6. ds508b Orders on May 8, 2010' ;
run;

/* Step 7. Compare ds508 and ds508b */
proc compare base=ds508 
             compare=ds508b ;
title3 'Step 7. Compare ds508 and ds508b' ;
run;

/* Yes. 190. 
SAS OUTPUT: 
                                                          
                                                                                
                              Observation Summary                               
                                                                                
                         Observation      Base  Compare                         
                                                                                
                         First Obs           1        1                         
                         Last  Obs         190      190                         
                                                                                
        Number of Observations in Common: 190.                                  
        Total Number of Observations Read from WORK.DS508: 190.                 
        Total Number of Observations Read from WORK.DS508B: 190.                
                                                                                
        Number of Observations with Some Compared Variables Unequal: 0.         
        Number of Observations with All Compared Variables Equal: 190.          
                                                                                
        NOTE: No unequal values were found. All values compared are exactly     
              equal.                                                            
                                                                               
*/

/* Step 8. Create data set ord0708 and ord0809 */
data ord0708 ord0809 ;
   set books.orders ;
     if dateord="07May2010"d or dateord="08May2010"d then output ord0708 ; 
     if dateord="08May2010"d or  dateord="09May2010"d then output ord0809 ;
run;

proc print data = ord0708 ;
title2 'Step 8. ds0708' ;

proc print data = ord0809 ;
title2 'Step 8. ds0809' ;
run;    

/* Step 9. Print the first 10 obs of each data set */
proc print data = ord0708 (obs=10) ;
title2 'Step 9. Print the first 10 obs of each data set' ;
title3 'First 10 obs in ds0708' ;
run;

proc print data = ord0809 (obs=10) ;
title2 'Step 9. Print the first 10 obs of each data set' ;
title3 'First 10 obs in ds0809' ;
run;
 
/* Step 10. Create data sets sord0708 and sord0809 */
proc sql  ;
title2 'Step 10. Create data set sord0708' ;           
  create table sord0708 as
    select * from books.orders 
       where dateord in ("07May2010"d, "08May2010"d) ;
quit;

proc print data = sord0708 (obs=10) ;
title3 'Print the first 10 obs in sord0708' ;
run; 

proc sql  ;
title2 'Step 10. Create data set sord0809' ;
  create table sord0809 as
    select * from books.orders
       where dateord in ("08May2010"d, "09May2010"d) ;
quit;

proc print data = sord0809 (obs=10) ;
title3 'Print the first 10 obs in sord0809' ;
run; 

/* Step 11. Create data set o0789 */
Data o0789 ;
  set ord0708 ord0809 ;
run;

proc print data = o0789 ;
title2 'Step 11. Create data set o0789' ;
run;

/* Step 12. Create 4 data set s0789a/b/c/c */
proc sql ;
      title2 "Step 12. Union" ;
      create table s0789a as 
         select * from sord0708
         union 
         select * from sord0809 ;
      title2 "Step 12. Union Corresponding" ;
      create table s0789b as
         select * from sord0708
         union corresponding
         select * from sord0809 ;
      title2 "Step 12. Outer Union" ;
      create table s0789c as
         select * from sord0708
         outer union 
         select * from sord0809 ;
      title2 "Step 12. Outer Union Corresponding" ;
      create table s0789d as
         select * from sord0708
         outer union corresponding 
         select * from sord0809 ;
quit;

/* Step 13. Sort 5 data sets o0789, s0789a/b/c/d */
proc sort data = o0789 out=so0789;
     by  orderno ;
run;

proc print data = so0789 ;
title2 "Step 13. Print data set sort o0789 by orderno" ;
run;

proc sort data = s0789a out=ss0789a;
     by  orderno ;          
run;
      
proc print data = ss0789a ;  
title2 "Step 13. Print data set sort s0789a by orderno" ;
run;

proc sort data = s0789b out=ss0789b;
     by  orderno ;          
run;
      
proc print data = ss0789b ;  
title2 "Step 13. Print data set sort s0789bb by orderno" ;
run;
              
proc sort data = s0789c out=ss0789c;
     by  orderno ;          
run;
      
proc print data = ss0789c ;  
title2 "Step 13. Print data set sort s0789c by orderno" ;
run;
       
proc sort data = s0789d out=ss0789d;
     by  orderno ;          
run;
      
proc print data = ss0789d ;  
title2 "Step 13. Print data set sort s0789d by orderno" ;
run;
       
/* Step 14. Compare 3 pairs of data sets. s0789a/b; o0789 and s0789c; o0789 and s0789d */
proc compare base = s0789a
     compare = s0789b;
title3 "Step 14. Compare s0789a with s0789b" ;
run;

proc compare base = o0789
     compare = s0789c;
title3 "Step 14. Compare o0789 with s0789c" ;
run;  

proc compare base = o0789
     compare = s0789d;
title3 "Step 14. Compare o0789 with s0789d" ;
run;  

/* SAS OUTPUT
                           Comparing s0789a and s0789b

                              Observation Summary                               
                                                                                
                         Observation      Base  Compare                         
                                                                                
                         First Obs           1        1                         
                         Last  Obs         429      429                         
                                                                                
        Number of Observations in Common: 429.                                  
        Total Number of Observations Read from WORK.S0789A: 429.                
        Total Number of Observations Read from WORK.S0789B: 429.                
                                                                                
        Number of Observations with Some Compared Variables Unequal: 0.         
        Number of Observations with All Compared Variables Equal: 429.          
                                                                                
        NOTE: No unequal values were found. All values compared are exactly     
              equal.                                           

                          Comparing o0789 and s0789c
                            Observation Summary                               
                                                                                
                         Observation      Base  Compare                         
                                                                                
                         First Obs           1        1                         
                         First Unequal     260      260                         
                         Last  Unequal     619      619                         
                         Last  Obs         619      619                         
                                                                                
       Number of Observations in Common: 619.                                   
       Total Number of Observations Read from WORK.O0789: 619.                  
       Total Number of Observations Read from WORK.S0789C: 619.                 
                                                                                
       Number of Observations with Some Compared Variables Unequal: 360.        
       Number of Observations with All Compared Variables Equal: 259.           
                                                                                
                                                                                
                           Values Comparison Summary                            
                                                                                
        Number of Variables Compared with All Observations Equal: 0.            
        Number of Variables Compared with Some Observations Unequal: 4.         
        Number of Variables with Missing Value Differences: 4.                  
        Total Number of Values which Compare Unequal: 1440.                     
        Maximum Difference: 0. 

                          Comparing o0789 and s0789d                          
                              Observation Summary                               
                                                                                
                         Observation      Base  Compare                         
                                                                                
                         First Obs           1        1                         
                         Last  Obs         619      619                         
                                                                                
        Number of Observations in Common: 619.                                  
        Total Number of Observations Read from WORK.O0789: 619.                 
        Total Number of Observations Read from WORK.S0789D: 619.                
                                                                                
        Number of Observations with Some Compared Variables Unequal: 0.         
        Number of Observations with All Compared Variables Equal: 619.          
                                                                                
        NOTE: No unequal values were found. All values compared are exactly     
              equal.                                                            
                                           
Comment: The first pair of data set (s0789a and s0789b) are the same.
         The second pair of data set (o0789 and s0789c) are different.
         The third pair of data set (o0789 and s0789d) are the same.
*/

ods html close;
x 'chmod go+r ~/public_html/lab6.html' ;
