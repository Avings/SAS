title "STAT 674 - Assignment 7 - Xin Tao" ;
options linesize=80 noovp ;

ods html body='~/public_html/assign7.html' style=fancyprinter ;

/* Data set 7a */
data ds7a ;
   infile "stat674-7a.data" ;
   length first $ 10 last $ 15 ;  
   input exam1 exam2 exam3 exam4 id first last @@ ;  /*Create variable names*/
         diff = exam4 - exam1 ;                      /*Difference between exam4 and exam1 score*/
   label exam1="Exam1 Score"                         /*Create labels*/ 
         exam2="Exam2 Score"
         exam3="Exam3 Score"
         exam4="Exam4 Score"
         id="Student ID"
         first="First Name"
         last="Last Name" 
         diff="4th and 1st Exam Scores Difference" ;
run;

proc print data=ds7a label;
   title2 "Data Set 7a. Reading Multiple Obs per Line of Raw Data" ;
   var id first last exam1 exam2 exam3 exam4 diff;
run;

/* Data set 7b */
data ds7b ;
   infile "stat674-7b.data" termstr=cr ;
   length first $ 10 last $ 15 ;
   input id 1-4 (exam1 exam2)(3.1) first 11-19 last 20-31 (exam3 exam4)(3.1) ;  /*Create variable names*/
         diff = exam4 - exam1 ;                                                 /*Difference between exam4 and exam1 score*/
   label exam1="Exam1 Score"                                                    /*Create labels*/
         exam2="Exam2 Score"
         exam3="Exam3 Score"
         exam4="Exam4 Score"
         id="Student ID"
         first="First Name"
         last="Last Name"
         diff="4th and 1st Exam Scores Difference" ;
run;

proc print data=ds7b label;
   title2 "Data Set 7b. Reading MAC Formatted Data" ;
   var id first last exam1 exam2 exam3 exam4 diff;
run;

/* Data set 7c */
data ds7c ;
   infile "stat674-7c.data" dlm='09'x termstr=crlf ;
   length first $ 10 last $ 15 ;
   input id first last exam1 exam2 exam3 exam4 ;    /*Create variable names*/
         diff = exam4 - exam1 ;                     /*Difference between exam4 and exam1 score*/
   label exam1="Exam1 Score"                         /*Create labels*/ 
         exam2="Exam2 Score"
         exam3="Exam3 Score"
         exam4="Exam4 Score"
         id="Student ID"
         first="First Name"
         last="Last Name"   
         diff="4th and 1st Exam Scores Difference" ;
run;
         
proc print data=ds7c label;
   title2 "Data Set 7c. Reading Tab Delimited Data" ;
   var id first last exam1 exam2 exam3 exam4 diff;
run;

/* Data set 7d */
data ds7d ;
   infile "stat674-7d.data" ;
   length first $ 10 last $ 15 ;
   input #2 exam1 exam2 
         #4 id first 
         #6 exam3 exam4 
         #8 last  ;                           /*Create variable names*/
         diff = exam4 - exam1 ;                      /*Difference between exam4 and exam1 score*/
   label exam1="Exam1 Score"                         /*Create labels*/
         exam2="Exam2 Score"
         exam3="Exam3 Score"
         exam4="Exam4 Score"
         id="Student ID"
         first="First Name"
         last="Last Name"   
         diff="4th and 1st Exam Scores Difference" ;
run;
         
proc print data=ds7d label;
   title2 "Data Set 7d. Reading Multiple Lines of Raw Data per Observation" ;
   var id first last exam1 exam2 exam3 exam4 diff;
run;

/* Data set 7e */
data ds7e ;
   infile "stat674-7e.data" dlm=':' ;
   length first $ 10 last $ 15 ;
   input exam1:3.1 exam2:3.1 exam3:3.1 id first last exam4:3.1 ;    /*Create variable names*/
         diff = exam4 - exam1 ;                     /*Difference between exam4 and exam1 score*/
   label exam1="Exam1 Score"                         /*Create labels*/
         exam2="Exam2 Score"
         exam3="Exam3 Score"
         exam4="Exam4 Score"
         id="Student ID"
         first="First Name"
         last="Last Name"
         diff="4th and 1st Exam Scores Difference" ;
run;

proc print data=ds7e label;
   title2 "Data Set 7e. Reading Raw Data Seperated by Colon" ;
   var id first last exam1 exam2 exam3 exam4 diff;
run;

ods html close ;
x 'chmod go+r ~/public_html/assign7.html' ;

