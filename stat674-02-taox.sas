%let name=Xin Tao ;
title "STAT674 Assignment 2" ;
title2 "Green Thumb Lawn Care Company" ;

options linesize=80 noovp;

data lawn;
   infile "stat674-2.data" firstobs=8 ;
   input loc formula rate ;
   label loc="Location" ;
   label formula="Fertilizer formula" ;
   label rate="Growth rate" ;
run;

proc print data=lawn ;
   var loc formula rate ;
run;

ods trace on;
ods select Variables;
proc contents data=lawn;
   title3 "Contens of sas data set lawn - &name";
run;

proc sql;
   describe table lawn ;
quit;
ods trace off;

proc means data=lawn n mean stderr maxdec=2 ;
   class formula;
   var rate;
   title3 "Averages using the MEANS procedure -&name" ;
run;

proc sql;
   title3 "Averages using the SQL procedure =&name" ;
      select formula, avg(rate) label="Mean Rate"
      from lawn 
      group by formula
      order by formula ;
quit;


