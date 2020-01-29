/* Step 1: Print SASHELP.CARS */
proc print data=sashelp.cars (obs=10);
run;

/* Step 2: Sort data by type and MSRP */
proc sort data=sashelp.cars out=cars_sorted;
  by type MSRP;
run;
/* Step 3: Create mpg_avg */
data cars_new;
  set cars_sorted;
  mpg_avg = (mpg_city + mpg_highway) / 2;
run;

proc print data=cars_new (obs=10);
run;