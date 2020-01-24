/* libname mysas "/opt/sasinside/DemoData/pgvy34_files"; */

/* USE DATA STEP TO COUNT NA CUSTOMERS - ONE ANSWER AS SINGLE THREAD */
data work.NACustomers;
  set mysas.customers end=eof;
  if continent="North America" then NACustomers+1;
  if eof then output;
  keep NACustomers;
run;  

proc print data=work.NACustomers;
run;

/* LOAD CUSTOMERS TO CAS */
proc casutil;
	load data=mysas.customers outcaslib="casuser"
	casout="mycustomers" replace;
quit;

/* USE CAS TO COUNT NA CUSTOMERS - ONE TOTAL FOR EACH THREAD */
data casuser.TestCustomers;
  set casuser.mycustomers end=eof;
  if continent="North America" then NAcustomers+1;
  if eof then output;
  keep NAcustomers;
run; 

proc print data=casuser.TestCustomers;
run; 

/* USE SINGLE=YES TO FORCE RUNNING ON A SINGLE THREAD */
data casuser.TestCustomers/single=YES;
  set casuser.mycustomers end=eof;
  if continent="North America" then NAcustomers+1;
  if eof then output;
  keep NAcustomers;
run;  

proc print data=casuser.TestCustomers;
run; 


