title 'STAT 674 - Simulated Attitudes Toward Agriculture Survey' ;
title2 "Week 10 Lab Exercise Macros - Xin Tao" ;
options linesize=80 noovp;
 
libname data "~pesek/Class/STAT674/data" ;

ods html body='~/public_html/lab10.html' style=EGDefault ;
 
%include "~pesek/Class/STAT674/agatt-format.sas" ;
 
data attitude;
     set data.agatt;
%include "~pesek/Class/STAT674/agatt-lab.sas" ;
     format q1 q1f. q2 q2f. q3 q3f. q4 q4f. q5 q5f. q6 q6f. ;
run;
 
ods select position ;
proc contents data=attitude varnum;
run;

/*Step 5.*/
options mprint symbolgen ;
%let part=5 ;
   proc print data=attitude(obs=20) ;
      title3 "Part &part" ;
run;
 
%let part=5 ;
   proc print data=attitude(obs=20) ;
      title3 'Part &part' ;
run;

/*SAS will not resolve macro expressions inside single quotes. 
Single quote prints "Part&part whereas double quote prints "Part 5". */

/*Step 6.*/
%let part=6 ;
%let VariableList=q1 q2 q3 ;
   proc print data=attitude(obs=20) ;
      var &VariableList ;             
      title3 "Part &part" ;                
run;

/*Step7.*/
%let part=7 ;
%let VariableList=surveyid q2-q6 ;
   proc print data=attitude(obs=20) ;
      var &VariableList ;
      title3 "Part &part" ;
run;

/*Step8.*/
options nosymbolgen ;
%macro printit(part,list,NumObs) ;
   proc print data=attitude(obs=&NumObs) ;
      var &list ;
      title3 "Part &part" ;
run;
%mend printit ;

%printit(8a, q1-q4, 23) ;
%printit(8b, surveyid q5 q6, 17) ;

/*Step9.*/
%macro printitB(part,list,NumObs,double) ;
%if &double=Y %then %let text=double;
   %else %let text= ;
      proc print data=attitude(obs=&NumObs) &text;
         var &list ;
         title3 "Part &part" ;
run;
%mend printitB ;

%printitB(9a, surveyid q1-q3, 16, Y) ;
%printitB(9b, surveyid q1-q3, 16, single) ;

/*Step10.*/
%macro printitC(part,list,NumObs,double) ;
%if %substr(%upcase(&double),1,1)=Y %then %let text=double;
   %else %let text= ;
      proc print data=attitude(obs=&NumObs) &text;
         var &list ;
         title3 "Part &part" ;
run;
%mend printitC ;
 
%printitC(10a, surveyid q1-q5, 14, yes sir!) ;
%printitC(10b, surveyid q1-q5, 14, No way!) ;

/*Step11.*/
%macro printitD(part,list,NumObs) ;
%let newlist= ;
   %do i=1 %to %sysfunc(countw(&list,#));
      %let newlist=&newlist %sysfunc(scan(&list, &i, #));
   %end ;
      proc print data=attitude(obs=&NumObs) ;
         var &newlist ;
         title3 "Part &part" ;
run;
%mend printitD ;
 
%printitD(11,q1#q2#q3#q4#q5,28) ;


/*Step 12.*/
%macro convertA(pound) ;
%let i=1 ;
%do %while(%qsysfunc(scan(&pound,&i,%str()))^=) ;
   %if &i=1 %then %let newlist=%sysfunc(scan(&pound,&i,%str())) ;
      %else %let newlist=&newlist#%sysfunc(scan(&pound,&i,%str())) ;
         %let i=%eval(&i+1) ;
%end;
&newlist
%mend convertA ;

%put %convertA(q1 q2 q3 q4 q5-q8) ;
 
ods html close;
x 'chmod go+r ~/public_html/lab10.html' ;
