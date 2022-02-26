%macro intersection(firstList, secondList, srcDlm=%str( ), trgDlm=%str( ));
    %local nvalues iter temp resDlm;
    %let nvalues = %sysfunc(countw(&firstList, &srcDlm));
    %let resDlm=;
    %do iter=1 %to &nvalues;
        %let temp = %scan(&firstList, &iter, &srcDlm);
        %if %sysfunc(indexw(&secondList, &temp, &srcDlm)) %then %do;%superq(resDlm)%superq(temp)
            %let resDlm=&trgDlm;
        %end;
    %end;
%mend;