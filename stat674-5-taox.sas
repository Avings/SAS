%let name=Xin Tao;
title "STAT674 Assignment 5 - Using character functions in SAS -&name" ;
options linesize=80 noovp ;

libname data "~pesek/Class/STAT674/data" ;

proc contents data=data.RareEarth ;
run;

data RareEarth ;
   set data.RareEarth ;
/* 5a. First name of the chemist in discoverer */
       length first $ 25 ;
       first=scan(Discoverer,1,' ') ;

/* 5b. Last name of the chemist in discoverer */
       length last $ 25 ;
       last=scan(Discoverer,-1,' ') ;

      /* Add leading blanks */
         blank="       " ;  /* There are seven blanks inside the quote marks */
         first=substrn(blank, 1, ceil(7*ranuni(2011100310)))||first ;
         last=substrn(blank, 1, ceil(7*ranuni(2011100310)))||last ;
         
/* 5c. Compute name in the form of first last */
       length newfull $ 35 ;
       newfull=strip(first)||' '||strip(last) ;

/* 5d. Compute name in the form of last, first */
       length newfull2 $ 35 ;
       newfull2= strip(last) || ',' || ' '||strip(first) ;

/* 5e. Compute name in the form 1st initial. last */
       length filast $ 30 ;
       filast=substrn(strip(first),1,1)|| '. '||strip(last) ;

/* 5f. Compute middle names in discoverer */
       length middle $ 30 ;
       length middle1 $ 20 ;
       length middle2 $ 20 ;
       middle1=scan(discoverer, 2, ' ') ;
       middle2=scan(discoverer, 3, ' ') ;
       if middle1=scan(discoverer,-1,' ') then middle=' ' ; 
       else if middle2=scan(discoverer,-1,' ') then middle=middle1 ;
       else middle= middle1||' '||middle2 ; /* Assume no more than 2 middle names */

/* 5g. Compute a variable indicating the location of the first occurence of a word in a 
string */
       firstmagnet=find(lowcase(SelectedUsages), "magnet", ' ') ;

/* 5h. Create a variable whose value is Yes if the discoverer is Carl Auer Freiherr von Welsbach */
       length ByvonWelsbach $10 ;
       if Discoverer='Carl Auer Freiherr von Welsbach'  or Codiscover='Carl Auer Freiherr von Welsbach'  or coDiscover2='Carl Auer Freiherr von Welsbach'  then 
       ByvonWelsbach='Yes' ;
       else ByvonWelsbach='No' ;  

/* 5i. Create a variable borndied */
       length bornyr $ 10 ;
       length diedyr $ 10 ;
       length borndied $ 20 ;
       bornyr=scan(born,-1,' ') ;
       diedyr=scan(died,-1,' ,') ;
       borndied=bornyr||'-'||diedyr ; 
run;

/* 6. Display variables computed in 5 */
proc sql ;
   select discoverer, first, last, newfull, newfull2, filast, middle, firstmagnet, ByvonWelsbach, borndied from RareEarth ;
quit;

/* 7. Dispaly output in html format */
ods html body='~/public_html/assign5.html' ;
proc print data=RareEarth ;
   var discoverer / style=[background=white foreground=black ] ;
   var first / style=[background=purple foreground=white ] ;   
   var last / style=[background=darkolivegreen foreground=gold ] ;  
   var newfull / style=[background=dimgray foreground=chocolate ] ;
   var newfull2 / style=[background=navy foreground=orange ] ;   
   var filast / style=[background=turquoise foreground=orchid ] ;
   var middle / style=[background=purple foreground=white ] ;
   var firstmagnet / style=[background=slategray foreground=beige ] ;
   var ByvonWelsbach / style=[background=teal foreground=deeppink ] ;  
   var BornDied / style=[background=black foreground=green ] ;
run;
ods html close;

x 'chmod o+r ~/public_html/assign5.html' ;
