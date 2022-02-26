%macro check_os_process(mpid=&sysjobid, muser=sassrv);
    %local res rc1 rc2 filrf;
    %let filrf=mypipe;
    %let res=0;
    %let rc1=%sysfunc(filename(filrf, %str(ps -p &mpid. | sed '1'd), pipe));
    %let rc2 = %sysfunc(dosubl(%str(
        data _null_;
            infile mypipe end=eof;
            input;
            putlog _infile_;
            if eof then call symputx('res',_n_);
        run;
    )));
    &res
%mend;