/* iteration #1 */

libname gitlib 'C:\MyDemos\Git_Project';
Proc sort data=sashelp.cars out=gitlib.cars_sorted;
  by type msrp;
run;

/* NEW COMMENT */


added stuff