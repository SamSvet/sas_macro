%macro resolve_value;
    %let value=%sysfunc(dequote(&value));
    %let result=;
    proc sql noprint;
        connect to oracle(path=sasma authdomain=OracleEGAuth connection=global);
        select value format=best. into :result from connection to oracle(
            select &value as value from dual
        );
        disconnect from oracle;
    quit;
    %put result=[&result];
%mend;