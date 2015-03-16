%let name=Xin Tao;
title "STAT674 Assignment 3" ;
title2 "Coefficients of digestibility of dry matter" ;
title3 "Steele and Torrie - p.74" ;
options linesize=80 noovp;

proc format;
   value animal 1="Sheep" 2="Steer" ;
run;

data digest;
   infile "stat674-3.data" firstobs=7 ;
   input animal coef ;
   format animal animal. ;
   label animal = "Animal type";
   label coef = "Coefficients of digestibility in percent";
   
run;

proc print data=digest ;
   title4 "The data as displayed by the print procedure -&name" ;
run;

proc sql;
   title4 "Output from the SQL procedure -&name" ;
   select * from digest ;
quit;

proc sort data=digest; by animal ;
run;

ods trace on;
ods exclude ExtremeObs ;
proc univariate data=digest plot; by animal ;
   title4 "Univariate procedure output -&name" ;
   var coef ;
run;
ods trace off;

endsas;

Assignment 3.

2. When does case (upper of lower) matter in SAS?

On input case matters only when in quotes. On output case matters only in
quotes except that a variable name is displayed as it first appears. For
instance if the variable wheatfield first appears as WheatField then other
ways such as WHEATFIELD will be recognized but will display as WheatField.

3. Is it true that "SAS" statements must begin and end on the same
line"? If not, how do you know that a SAS statement is done?

No, it is not. SAS statements end with a semi-colon. They can span several
lines and several statements can be on the same line.

4. What is the purpose of the title statement?

The purpose is to label the output. You can have up to ten title statement,
title title2 title3 etc.

5. In general what is the purpose of the DATA step?

The purpose of the data step is to manage data such as reading from a data
file, doing computation, selecting or deleting observations and concatenating
datasets.

6. In general what is the purpose of the PROC step?

The purpose of the proc step is to produce results such as displaying the
data, producing a graph or a statistical analysis.

7. Name three uses of the output delivery system.

1) To display sas output in modern formats such as html, pdf or rtf.
2) To select which talbes of output from a procedure will be displayed. Some
procedure such as univariate display a lot of output and being selective
often clarifys things.
3) To save output from a procedure into a sas dataset for further processing
such as predicting outcome using a regression equation.
 
