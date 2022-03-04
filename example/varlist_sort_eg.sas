/*
Variable list of a specified data set, e.g. SASHELP.CLASS
Space is a default delimiter
*/
%put %varlist(SASHELP.CLASS);

/* You can specify custom delimiter by setting second optional parameter - dlm */
%put %varlist(SASHELP.CLASS, dlm=%str(|) );

/* varlist can be combined with the sort macro to get a sorted list */
%put %sort( %varlist(SASHELP.CLASS) );

/*
sort macro have 2 optional parameters - srcDlm and trgDlm:
srcDlm - delimiter for the passed list in first argument
trgDlm - output list delimiter
*/
%put %sort( %varlist(SASHELP.CLASS, dlm=%str(|)), srcDlm=%str(|), trgDlm=%str(#) );

/*
sort and varlist belong to inline macro type
This means that you can use them inside data step for example
*/
data WORK.RESULT;
length varlist varlist_sort $1024;
set SASHELP.CLASS;
varlist="%varlist(SASHELP.CLASS)";
varlist_sort="%sort(%varlist(SASHELP.CLASS))";
run;
