%macro filesize(mvSourceFilePath, mvSourceFileName);
    %local &sysmacroname._rc &sysmacroname._fid;
    %let &sysmacroname._rc=0;
    %let &sysmacroname._fid=0;
    %let &sysmacroname._rc=%sysfunc(filename(fref1, &mvSourceFilePath/&mvSourceFileName));
    %let &sysmacroname._fid=%sysfunc(fopen(&fref1, I));
    %if &&&sysmacroname._fid eq 0 %then %do;
        -1
    %end;

    %else %do;
        %sysfunc(finfo(&&&sysmacroname._fid, File Size (bytes)))
        %let &sysmacroname._fid=%sysfunc(fclose(&&&sysmacroname._fid));
        %let &sysmacroname._rc=%sysfunc(filename(fref1));
    %end;
%mend;