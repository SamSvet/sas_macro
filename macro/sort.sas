%macro sort(list, srcDlm=%str( ), trgDlm=%str( ));
    %local nvalues sorti args comma resDlm;
    %let nvalues = %sysfunc(countw(&list, &srcDlm));
    %do sorti=1 %to &nvalues;
        %local x&sorti;
        %let x&sorti = %scan(&list, &sorti, &srcDlm);
        %let args = &args &comma x&sorti;
        %let comma = ,;
    %end;
    %syscall sortn(&args);
    %let resDlm=;
    %do sorti = 1 %to &nvalues;%superq(resDlm)%superq(x&sorti)
        %let resDlm=&trgDlm; 
    %end;
%mend;