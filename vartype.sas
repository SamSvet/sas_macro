%macro vartype(tablename, varname);
    %local vartype;
    %let vartype=;
    %let dsid=%sysfunc(open(&tablename,i));
    %if &dsid>0 %then %do;
        %let vartype=%sysfunc(vartype(&dsid, %sysfunc(varnum(&dsid, &varname))));
        %let vartype=&vartype ;
    %end;
    %let rc=%sysfunc(close(&dsid));
    &vartype
%mend;