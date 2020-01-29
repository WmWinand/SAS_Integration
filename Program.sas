/* Step 1: Print SASHELP.CARS */
proc print data=sashelp.cars (obs=10);
run;

/* Step 2: Sort data by type and MSRP */
proc sort data=sashelp.cars out=cars_sorted;
  by type MSRP;
run;

proc print data=cars_sorted (obs=10);
run;