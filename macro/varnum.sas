%macro varnum(tablename, variablename);
    %let dsid=%sysfunc(open(&tablename,i));
    %if &dsid>0 %then %do;
        %sysfunc(varnum(&dsid, %upcase(&variablename)))
        %let rc=%sysfunc(close(&dsid));
        %return;
    %end;
    0
%mend;