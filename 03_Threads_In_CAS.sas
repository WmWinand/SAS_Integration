/* RUNNING DATA STEP IN BASE SAS - IT RUNS ON A SINGLE THREAD */
data _null_;
  put "Processed on " _threadid_= _Nthreads_=;
run;  

/* RUNNING DATA STEP IN CAS - IT RUNS ACROSS ALL THREADS - ORDER CHANGES */
data _null_/sessref="MySession";
  put "Processed on " _threadid_= _nthreads_;
run;  

/* RUNNING DATA STEP IN CAS WITH SINLE=YES OPTION - IT RUNS ON A SINGLE THREAD - WHERE ORDER IS IMPORTANT */
data _null_/sessref="MySession" single=YES;
  put "Processed on " _threadid_= _nthreads_;
run; 