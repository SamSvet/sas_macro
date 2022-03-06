data WORK.CLASS;
set SASHELP.CLASS(keep=(name sex age));
run;

%put %intersection( %varlist(SASHELP.CLASS), %varlist(WORK.CLASS));