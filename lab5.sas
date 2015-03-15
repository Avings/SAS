title "Lab Exercise 5 Reading Flat Files -Xin Tao" ;
options linesize=80  noovp ;
 
ods html body="~/public_html/lab5.html" style=sasweb ;
 
/*Step 7. Read in 01soy92.data into a dataset called soy1 */
data soy1 ;
   infile "01soy92.data" firstobs=7 ; 
   input exp rep trt yield ;
   label exp = "Maturity"
         rep = "Rep (Block)"
         trt = "Entry Number" 
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy1 label;
   title2 "Step 7. Read 01soy92.data into dataset soy1" ;
run;
  
/*Step 8. Read in 02soy92.data into a dataset called soy2 */
data soy2 ;
   infile "02soy92.data" firstobs=8 pad ;
   input pedigree $ 1-23  exp 26 rep 27 trt 28 yield 30-33 ;
   label pedigree = "Brand & Variety"
         exp = "Maturity"
         rep = "Rep (Block)"
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy2 label;
   title2 "Step 8. Read 02soy92.data into dataset soy2" ;
run;

/*Step 9. Read in 03soy92.data into a dataset called soy3 */
data soy3 ;
   infile "03soy92.data" firstobs=8 dlm=',' dsd ;
   length pedigree $ 23;
   input pedigree exp rep trt yield ;
   label pedigree = "Brand & Variety"
         exp = "Maturity"
         rep = "Rep (Block)"
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy3 label;
   title2 "Step 9. Read 03soy92.data into dataset soy3" ;
run;

/*Step 10. Read in 04soy92.data into a dataset called soy4 */
data soy4 ;
   infile "04soy92.data" firstobs=8 dlm='09'x dsd ;
   length pedigree $ 23;
   input pedigree exp rep trt yield ;
   label pedigree = "Brand & Variety" 
         exp = "Maturity"   
         rep = "Rep(Block)"
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy4 label;
   title2 "Step 10. Read 04soy92.data into dataset soy4" ;
run;

/*Step 11. Read in 05soy92.data into a dataset called soy5 */
data soy5 ;
   infile "05soy92.data" firstobs=8 pad;
   input pedigree $ 1-23 @26 exp 1. @27 rep 1. @28 trt 1. @30 yield 3.1 ;
   label pedigree = "Brand & Variety"
         exp = "Maturity"   
         rep = "Rep(Block)" 
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy5 label;
   title2 "Step 11. Read 05soy92.data into dataset soy5" ;
run;

/*Step 12. Read in 06soy92.data into a dataset called soy6 */
data soy6 ;
   infile "06soy92.data" firstobs=7 ;
   input exp rep trt yield :3.1 ;
   label exp = "Maturity"   
         rep = "Rep(Block)" 
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy6 label;
   title2 "Step 12. Read 06soy92.data into dataset soy6" ;
run;

/*Step 13. Read in 07soy92.data into a dataset called soy7 */
data soy7 ;
   infile "07soy92.data" firstobs=8 dlm= ',' dsd termstr=crlf ;
   length pedigree $ 23;
   input pedigree exp rep trt yield ;
   label pedigree = "Brand & Variety"
         exp = "Maturity"   
         rep = "Rep(Block)" 
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;

proc print data = soy7 label;
   title2 "Step 13. Read 07soy92.data into dataset soy7" ;
run;

/*Step 14. Read in 08soy92.data into a dataset called soy8 */
data soy8 ;
   infile "08soy92.data" firstobs=8 dlm= ',' dsd termstr=cr ;
   length pedigree $ 23;
   input pedigree exp rep trt yield ;
   label pedigree = "Brand & Variety"
         exp = "Maturity"
         rep = "Rep(Block)"
         trt = "Entry Number"
         yield = "Yield Bushels per Acre" ;
run;
         
proc print data = soy8 label;
   title2 "Step 14. Read 08soy92.data into dataset soy8" ;
run;

ods html close ;
x 'chmod go+r ~/public_html/lab5.html' ;
