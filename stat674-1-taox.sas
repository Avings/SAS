%let name= Xin Tao ;

title "STAT 674- Assignment 1 - Data in SAS program" ;
title2 "Tree Basal Area vs. Timber Volume" ;

options linesize=80 noovp;

data volume;
   input tree barea volume ; 
   label barea="Basal area" ;
   label volume="Timber volume" ;
cards;
1 .3 6
2 .5 9
3 .4 7
4 .9 19
5 .7 15
6 .2 5
7 .6 12
8 .5 9
9 .8 20
10 .4 9
11 .8 18
12 .6 13
  ;
run;

ods trace on;
proc print data=volume;
   title3 "Output from the PRINT procedure - &name" ;
run;

proc sql ;
   title3 "Output from the SQL procedure - &name" ;
   slect * from volume ;
quit;

proc plot data=volume ;
   plot volume*barea ;
   title3 "Output from Plot procedure - &name" ;
run;
ods trace off;

libname data xml "volume.xml" ;

data data.volume ;
   set volume ;
run;





