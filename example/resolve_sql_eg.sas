%let filterAge=14;
proc sql noprint;
    create view WORK.CLASS_V as
    %resolve_sql(/path/to/select_class.txt)
;
quit;