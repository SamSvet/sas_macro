/*
attrntype is an inline macro for ATTRN Function
attribute name is passed as an optional named parameter type
obsnum(DS) and attrntype(DS, type=NOBS) are equal
Most commonly used to get observation number
*/
%put nobs=%attrntype(SASHELP.CLASS, type=NOBS);
%put crdte=%sysfunc(putn(%attrntype(SASHELP.CLASS, type=CRDTE), datetime20.);

/*
inline macro might be used inside data step
*/
data RESULT;
format crdte_n datetime20.;
nobs=%attrntype(SASHELP.CLASS, type=NOBS);
crdte_s="%sysfunc(putn(%attrntype(SASHELP.CLASS, type=CRDTE), datetime20.)";
crdte_n=%attrntype(SASHELP.CLASS, type=CRDTE);
run;

/*
inline macro might be used inside macro statement
*/
%macro test;
    %local i;
    %do i=1 %to %obsnum(SASHELP.CLASS);
        data _null_;
        set SASHELP.CLASS(firstobs=&i obs=&i);
        put (_all_)(+0);
        run;
    %end;
%mend;
%test;