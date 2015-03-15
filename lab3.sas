title 'STAT/FREC674  Character Manipulation -Xin Tao' ;
title2 'Lab exercise 3' ;
options linesize=80    noovp   ;
 

data version ;
   infile "lab3.data"  pad;
   input id 1-2 @4 first $CHAR11. @16 last $Char12.  pre  post   motto $80.;
   diff=post-pre ;
   label  
        first="First Name"
        last="Last Name"
        pre="Pre Score"
        post="Post Score"
        diff="Change in Score" 
   ;

/* 8. Use length statement to define character variable. 
The lst output shows that a new column called "fullname" is created as the concatenation of the first and last name of each student 
is given per cell. */

length fullname $30 ;
fullname = first || ' ' ||last ;

/* 9. Define variable fullname2 and apply strip function.
Through comparison with fullname and fullname2 in the lst outputs, we see that the strip function remove all leading and trailing 
blanks of the argument. The output of fullname2 is a concatenation of first and last name with only one blank in between (defined by 
' ') */
 
length fullname2 $20 ;
fullname2 = strip(first)|| ' ' ||strip(last) ;

/* 10. Define a varialbe called last_then_first. The lst output shows that last_then_first variable is in the form of last name, 
first name (E.g. Smith, Robert) */

length last_then_first $20 ;
last_then_first = strip(last)|| ','|| ' ' ||strip(first) ;

/* 11. Define a variable called first_initial of length 6. The substrn function extracts the first letter of the variable first name. 
*/

length first_initial $6 ;
first_initial = substrn(strip(first), 1, 1) ;

/* 12. Define variable fi_last. Output e.g.: R. Smith. */

length fi_last $20 ;
fi_last = substrn(strip(first), 1, 1)||'.' || ' ' ||strip(last) ;

/* 13. Denfine variable new_first. Extract the first name from variable fullname2 */

length new_first $10;
new_first = scan(fullname2, 1) ;

/* 14. Define variable new_last. Extract the last name from variable last_then_first. */

length new_last $ 10 ;
new_last = scan(last_then_first, 1) ;

/* 15. Compute length in bytes of last_then_first excluding trailing blanks. */

LenthLastFirstA = lengthn(last_then_first) ;
 
/* 16. Compute length in bytes of last_then_first including trailing blanks. */

LenthLastFirstB = lengthc(last_then_first) ;

/* 17. Compute the position of the first occurence of the character string Smith in fullname2.  */

FirstSmith = find(fullname2, 'Smith') ;

/* 18. Compute the number of words in motto as separated by one or more blanks.*/

CoutWords = countw(motto, ' ') ;

/* 19. Compute the position of the first occurrence of the word 'a' as separated by one or more blanks in motto. */

First_a = findw(motto, 'a', ' ', 'i') ; 

run;

/* 7. Ods display */
ods html body='~/public_html/lab3.html' ;
   proc sql ;
   select * from version ;
quit;
ods html close;

x 'chmod o+r ~/public_html/lab3.html' ;






