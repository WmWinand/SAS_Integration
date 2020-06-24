/* INITIAL PROGRAM STEP */
proc print data = sashelp.cars (obs=10);
run;

/* CREATE AVERAGE_MPG VAR */
data cars_new;
  set sashelp.cars;
  Average_MPG = mean(MPG_City, MPG_Highway);
  keep origin make model type MSRP Average_MPG;
run;

proc freq data=cars_new;
  tables origin;
run;

proc freq data=cars_new;
  tables type;
run;  

proc print data=cars_new (obs=25);
run;

proc sort data=cars_new;
  by origin;
  run;

proc means data=cars_new;
  by origin;
run;

 proc gchart data=cars_new;
    donut type / sumvar=average_mpg
	type = sum noheading;
  run;