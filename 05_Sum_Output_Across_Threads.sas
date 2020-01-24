
/* DROP TABLES FROM CAS MEMORY AND LOAD MYCUSTOMERS */
proc casutil;
  droptable casdata="mycustomers" incaslib="casuser" quiet;
  droptable casdata="NAcustomers" incaslib="casuser" quiet; 
  droptable casdata="NA_Sums" incaslib="casuser" quiet;
  load data=mysas.customers casout="mycustomers" promote;
quit;

/* SUM NA CUSTOMERS BY THREAD IN CAS */
data casuser.NA_sums;
  set casuser.mycustomers end=eof;
  if continent="North America" then NAsum+1;
  if eof then output;
  keep NAsum;
run;  

proc print data=casuser.NA_sums;
run;

/* SUM ALL THREAD COUNTS TOGETHER USING SINGLE THREAD */
data work.NACustomers2 /single=yes;
  keep NACustomers;
  set casuser.NA_sums end=eof;
  NACustomers + NAsum;
  if eof then output;
run;

proc print data=work.NACustomers2;
run;

/* FOR CAMPARISON GET ONE COUNT FOR NA CUSTOMERS USING A SINGLE THREAD */
data casuser.NACustomers / single = yes;
  set casuser.mycustomers end=eof;
  if continent = "North America" then NACustomers+1;
  if eof then output;
  keep NACustomers;
run;  

proc print data=casuser.NACustomers;
run;

/* USE DATA STEP IN BASE SAS TO COUNT NA CUSTOMERS - ONE ANSWER AS SINGLE THREAD */
data work.NACustomers;
  set mysas.customers end=eof;
  if continent="North America" then NACustomers+1;
  if eof then output;
  keep NACustomers;
run;  

proc print data=work.NACustomers;
run;