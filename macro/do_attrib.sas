%macro do_attrib(mvDSName,mvAttrName,mvFormatName,mvInformatName);
    %local dsid rc;
    %let dsid=%sysfunc(open(&mvDSName, IS));
    %syscall set(dsid);
    %let rc = %sysfunc(fetch(&dsid));
    %do %while(&rc=0);
        %let &mvAttrName=&&&mvAttrName;
        %let &mvFormatName=&&&mvFormatName;
        %let &mvInformatName=&&&mvInformatName;
        &&&mvAttrName format=&&&mvFormatName informat=&&&mvInformatName
        %let rc = %sysfunc(fetch(&dsid));
    %end;
    %let rc=%sysfunc(close(&dsid));
%mend;