/* proc casutil; */
/*    droptable casdata="mycustomers" incaslib="casuser" quiet; */
/*    load data=mysas.customers casout="mycustomers" promote; */
/* quit; */
/* DATA step processed in workspace server */

proc sort data=mysas.customers out=customers;
   by Continent City;
run;

data work.CityTotals(where=(city ne ' '));
   set customers;
   by Continent City;
   if first.City then
      do;
         TotalCost=0;
         numOrders=0;
      end;
   TotalCost+Cost;
   numOrders+1;
   if last.City then
      output;
   keep Continent City TotalCost numOrders;
run;

title "Base SAS DATA Step (5 rows)";
proc print data=work.CityTotals(obs=5);
run;


/* MODIFIED TO RUN IN CAS */
data casuser.CityTotals;
   set casuser.mycustomers(where=(city ne ' ')) end=last;
   by Continent City;
   if first.City then
      do;
         TotalCost=0;
         numOrders=0;
      end;
   TotalCost+Cost;
   numOrders+1;
   if last.City;
   keep Continent City TotalCost numOrders;
   if last then put _threadid_= _nthreads_=;
run;

title "CAS DATA Step (5 rows)";
proc print data=casuser.CityTotals(obs=5);
run;

options msglevel=i;
title "work.cityTotals";
proc print data=work.CityTotals;
   where city='Abbeville' and continent='North America'  ;
run;

title "casuser.cityTotals";
proc print data=casuser.CityTotals;
   where city='Abbeville' and continent='North America'  ;
run;
options msglevel=n;
