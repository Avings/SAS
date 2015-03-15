title "STAT 674 - Writing flat files from a SAS data set - Xin Tao";
options linesize=80 noovp ;
 
proc format;
     value gender 1='Male' 2='Female' ;
run;
 
data blank ;
    infile '~pesek/Class/STAT674/lab7.csv' firstobs=2 delimiter=',';
    input id gender pre post ;
 /* Recode gender using if-else if */
    if gender=1 then gender=2 ;
       else if gender=2 then gender=1;
    format gender gender. ;
    label gender="Gender" id="Identification" 
          pre="Pre score" post="Post score" ;
run;

/* Check data */
/* proc print data=blank; run;*/

/* Step 5 */
data _null_ ;
   file "delim-ex1.data" ;
   set blank ;
   put id gender pre post ;
run;

/* Step 6 */
data _null_ ;
   file "delim-ex2.data" ;
   set blank ;
   put id @6 gender 1. @8 pre 2. @11 post ;
run;

/* Step 7 */
data _null_ ;
   file "delim-ex3.data" ;
   set blank ;
   if _n_ = 1 then put @1 'Id' @6 'Gender' @13 'Pre' @17 'Post' ; 
   put @1 id @6 gender 1. @13 pre 2. @17 post ;
run;

/* Step 8 */
data _null_ ;
   file "delim-ex4.csv" dlm = "," ;
   set blank ;
   if _n_ = 1 then put 'Id, Gender, Pre, Post' ;
   put id:4. gender:1. pre:2. post:2. ;
run;

/* Step 9 */
data _null_ ;
   file "delim-ex5.txt" dlm = '09'x ;
   set blank ;
   if _n_ =1 then put "id"'09'x"gender"'09'x"pre"'09'x"post" ;
   put id:4. gender:1. pre:2. post:2. ;
run;
 
/* Step 10 */
data ex5 ;
  infile "delim-ex5.csv" dlm = ',' firstobs=2 ;
  input id gender pre post ;
run;

proc print data = ex5 ;
title "delim-ex5.csv" ;
run;


