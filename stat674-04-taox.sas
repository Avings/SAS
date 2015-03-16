%let name=Xin Tao;
title "STAT674 Assignment 4" ;
title2 "Yogurt Culturing Time" ;
options linesize=80 noovp;

proc format;
   value culture 1="L. acidophilus" 2="Bulgaricus" ;
run;

data yogurt;
   infile "stat674-4.data" firstobs=7 ;
   input culture time ;
   format culture culture. ;
   label culture="Yogurt culturle" ;
   label time="Culturing time(hours)" ;
run;

ods trace on;
proc print data=yogurt;
   title3 "The data as displayed by the print procedure -&name" ;
run;


proc means data=yogurt n mean stderr maxdec=2 ;
   class culture;
   var time;
   title3 "Averages using the MEANS procedure -&name" ;
run;
ods trace off;

proc sql;
   select culture,
      count(culture) as count,
      avg(time)   as means 
   from yogurt
   group by culture;
   title3 "Output from the SQL procedure -&name" ;
quit;

endsas;

Assignment 4

2. Give explicitly the rules for a temporary SAS dataset name.

1) It has 1 to 32 characters.
2) It must start with a letter or an underscore ( _ ).
3) The remaining characters must be letters, underscores or digits (0-9).

The same rules apply to variable names.

3. What is the purpose of the format procedure?

The purpose of the format procedure is to define formats. It should not be
confused with the format statement which is used to assign format to
variables.

4. What is the purpose of the programming style?

The purpose of programming style is make the program readable to those using
the program which includes the original programmer as well as others. A good
programming style uses short lines, plenty of white space such as blank lines
between sections, indentation and judicious of comments.

5. When the sas log contains obscure and confusing error messages, what
should you check for? Give at least three examples of this.

You could look for punctuation error such as:
1) Missing or extra semi-colons.
2) Unmatched or mismatched quotes;
3) Runaway comments such as /* without a matcing */.

6. What do the commands ods trace on and ods trace off do?

The command ods trace on turns on the recording of the names of output table
from precedures in the log and ods trace off turns of this recording.






 

