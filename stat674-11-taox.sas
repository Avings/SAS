title "STAT674 - Assignment 11 - Macros & the Freq Procedure - Xin Tao " ;
options linesize=80 noovp mprint ;

libname data "~pesek/Class/STAT674/data" ;

ods html body='~/public_html/assign11.html' style=grayscalePrinter ;

proc format ;
   value gender 1="Male" 2="Female" ;
   value educ 1="<High School" 2="High School" 3="Some College" ;
   value income 1="Low" 2="Medim" 3="High" ;
run;

ods select variables ;

proc contents data=data.foodfrequency ;
run;


/* Step 4. Array processing to change missing to 0 for q4-q13 */
data FoodFreq ;
   set data.foodfrequency ;
   array qar{*} q4-q13 ;
   do i=1 to dim(qar) ;
      if qar{i} = . then qar{i} = 0 ;
   end ;
run;

%let part=4 ;
%macro printit(part, list, NumObs) ;
   proc print data=FoodFreq(obs=&NumObs) ;
     var id &list ;
     title2 "Part &part. Array Processing - Change missing to zero (obs=&NumObs) " ;
   run;
%mend printit ;

%printit(4,q1-q13,10) ;


/* Step 5.Frequency table */ 
%let part=6 ;
%macro FreqA(dataset, item, options) ;  
   proc freq data=&dataset ;
      table &item / &options ; 
      title2 "Part &part. Frequency Table for q9" ;
   run; 
%mend FreqA ;

%FreqA(FoodFreq,q9,nopercent nocum) ; /* Step 6. Make a macro call with FreqA */ 

 
/* Step 7. */
/*options mprint mfile;
  filename mprint 'tempout1'; */
%let part=8 ;
%macro FreqB(dataset,list,options,order) ;
   %do i=1 %to %sysfunc(countw(&list,' ' )) ;
      %let newlist= %sysfunc(scan(&list,&i,' ')) ;
         proc freq data=&dataset &order;
           table &newlist / &options ;
           title2 "Part &part. Frequency Table for &newlist" ;
         run;
   %end;
%mend FreqB ;

%FreqB(FoodFreq,q1 q4 q6 q10,%str(),%str(order=freq) ) ; /*Step 8. Make a macro call with FreqB*/


/* Step 9. */  
%let part=10 ;
%macro FreqC(dataset,list,with,options,order) ;
   %do i=1 %to %sysfunc(countw(&list,' '‘)) ;
      %let newlist= %sysfunc(scan(&list,&i,' ')) ;
        %do j=1 %to %sysfunc(countw(&with,' ')) ;
          %let newwith=%sysfunc(scan(&with,&j,' ')) ;
            proc freq data=&dataset &order;
              table &newlist * &newwith / &options ;
             title2 "Part &part. Frequency Tables for &newlist * &newwith" ;
           run;
        %end ;
    %end;
%mend FreqC ;   

%FreqC(FoodFreq,q1 q2 q3,q4 q8 q9 q10,nopercent nocol,%str(order=internal)) ; /*  Step 10. Make a macro call with FreqC */

/* Step 11. */
%let part=12 ;
%macro FreqD(dataset,list,options,order) ;
    %do i=1 %to %eval(%sysfunc(countw(&list,' '))-1) ;
      %let newlist=%sysfunc(scan(&list,&i,' ')) ;
          %do j=1 %to %eval(%sysfunc(countw(&list,' '))-&i) ;
            %let newlist2=%sysfunc(scan(&list,%eval(&j+&i),' ')) ; 
              proc freq data=&dataset &order;
                table &newlist * &newlist2 / &options ;
               title2 "Part &part. Frequency Table for &newlist * &newlist2" ;
              run;
          %end;
    %end;
%mend FreqD ;

%FreqD(FoodFreq,q4 q5 q6 q7,norow nopercent,%str(order=data)) ; /* Step 12. Make a macro call with FreqD */


ods html close;
x 'chmod go+r ~/public_html/assign11.html' ;

endsas;




/* Alternative Step 7. Use FreqA by listing all variables for item.
Code generated:
proc freq data=FoodFreq order=freq;
table q1 q4 q6 q10 / ;
title2 "Part 8 Frequency Table for q1,q4,q6 and q10" ;
run;

%let part=8 ;
%macro FreqB(dataset,list,options,order) ;
   proc freq data=&dataset &order;
     table &list / &options ;
     title2 "Part &part. Frequency Table for q1,q4,q6 and q10" ;
   run;
%mend Freq ;

%FreqB(FoodFreq,q1 q4 q6 q10,%str(),%str(order=freq) ) ; /* Step 8. Make a macro call with FreqB */


%let part=8 ;
%macro FreqB(dataset,list,options,order) ;
   %do i=1 %to &list ;
      proc freq data=&dataset &order;
        table q&i / &options ;
        title2 "Part &part. Frequency Table for q1,q4,q6 and q10" ;
      run;
   %end ;
%mend FreqB ;
   
%FreqB(FoodFreq,10,%str(),%str(order=freq) ) ; /* Step 8. Make a macro call with FreqB*/

/*Alternative Step 9. */
%let part=10 ; 
%macro FreqC(dataset,list,with,options,order) ;
   proc freq data=&dataset &order;
     table (&list) * (&with) / &options ;
     title2 "Part &part. Frequency Tables by Crossing q1,q2,q3 with q4,q8,q9,q10" ;
   run;
%mend FreqC ;
         
%FreqC(FoodFreq,q1 q2 q3,q4 q8 q9 q10,%str(),%str(order=freq) ) ; /* Step 10. Make a macro call with FreqC */



