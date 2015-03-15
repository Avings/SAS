title "Lab 13 Proc Transpose - Xin Tao" ;

options linesize=80 noovp ;

proc format ;
   value gender 1="Male" 2="Female" ;
run;

data scores ;
   length first $ 12 last $ 12 fullname $ 40 ; 
   infile "lab13.data" ;
   input ident date:mmddyy10. first $ last $ gender score1-score4 ;
   label ident="Student id"
       date="Evaluation date" 
       first="First name" 
       last="Last Name"  
       gender="Gender" 
       score1="Score #1"
       score2="Score #2"
       score3="Score #3"
       score4="Score #4" ; 
       fullname=strip(first)||' '||strip(last);  
   format date date9. gender gender. ;
run;

ods html body='~/public_html/lab13.html' style=curve ;

proc print data=scores ;
   title2 "The original form of the data" ;
run;   

/* Step 4 */
proc transpose data=scores out=scorestr ;
run;

proc print data=scorestr ;
   title2 'Step 4. Score Data After Transposing' ;
run;

/*Comment: The output has a bunch of variables with names like 'COLx' which is not readable.*/

/* Step 5 */
proc transpose data=scores out=scorestr ;
   var score1-score4 ;
   where date='10Jan08'd ;
run;
       
proc print data=scorestr ;
   title2 'Step 5. Score Data After Transposing with Selected Variables' ;
run;

/* Step 6 */
proc transpose data=scores out=scorestr prefix=student ;
   var score1-score4 ;  
   where date='10Jan08'd ;
run; 
       
proc print data=scorestr ;
  title2 'Step 6. Score Data After Transposing with Prefix Option' ;
run;

/* Step 7 */
proc transpose data=scores out=scorestr prefix=student ;
   id ident ;
   var score1-score4 ;  
   where date='10Jan08'd ;
run; 
       
proc print data=scorestr ;
   title2 'Step 7. Score Data After Transposing with id Statement' ;
run;

/* Step 8 */
proc transpose data=scores out=scorestr prefix=student ;
   id ident ;
   idlabel fullname ;
   var score1-score4 ;
   where date='10Jan08'd ;
run;   

proc print data=scorestr label;
   title2 "Step 8. Score Data After Transposing with New Variable 'Fullname'" ;
run;

/* Step 9 */
proc transpose data=scores out=scorestr prefix=student name=test label=testlabel ;
   id ident ;
   idlabel fullname ;
   var score1-score4 ;
   where date='10Jan08'd ;
run;
   
proc print data=scorestr ;
   title2 "Step 9. Score Data After Transposing with Variable Name Changed" ;
run;   

/* Step 10 */
proc transpose data=scores out=scorestr prefix=student name=test label=testlabel ;
   id ident ;
   idlabel fullname ;
   var score1-score4 ;
   by date ;
run;
   
proc print data=scorestr label ;
   title2 "Step 10. Score Data After Transposing with by statement" ;
run;
   

ods html close ;

x "chmod go+r ~/public_html/lab13.html" ;

