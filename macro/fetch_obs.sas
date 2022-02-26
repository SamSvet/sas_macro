%macro fetch_obs(mvDSName,mvColumn);
    %local dsid rc;
    %let dsid=%sysfunc(open(&mvDSName, i));
    %syscall set(dsid);
    %let rc = %sysfunc(fetch(&dsid));
    %do %while(&rc=0);
        %let &mvColumn=&&&mvColumn;
        &&&mvColumn
        %let rc = %sysfunc(fetch(&dsid));
    %end;
    %let rc=%sysfunc(close(&dsid));
%mend;