caslib _all_ list;

caslib _all_ assign;

libname mysas "/opt/sasinside/DemoData/pgvy34_files";
NEW UPDATES


/* LOAD CUSTOMERS DATASET TO CAS USING DATASTEP TO DEFAULt CAS LIBRARY*/
data casuser.mycustomers;
  set mysas.customers;
run;  

proc print data=casuser.mycustomers (obs=10);
run;

/* LOAD CUSTOMERS DATASET TO CAS USING PROC CASUTIL */
proc casutil;
	load data=mysas.customers outcaslib="CASUSER"
	casout="mycustomers" replace;
quit;

proc print data=casuser.mycustomers (obs=10);
run;

/* LOAD XLS FILE TO CAS USING PROC CASUTIL */
proc casutil;
    load file='/opt/sasinside/DemoData/pgvy34_files/products.xlsx'
    casout='myproducts'
    outcaslib='casuser'
    importoptions=(filetype='excel' getnames=true)
    replace;
quit;    

proc print data=casuser.myproducts (obs=10);
run;

/* LOAD CSV FILE TO CAS USING PROC CASUTIL */
proc casutil;
    load file='/opt/sasinside/DemoData/pgvy34_files/sales.csv'
    casout='mysales'
    outcaslib='casuser'
    importoptions=(filetype='csv' getnames=true)
    replace;
quit;  

proc print data=casuser.mysales (obs=10);
run;

caslib _all_ list;

proc casutil;
  list tables;
  list files;
quit;  

