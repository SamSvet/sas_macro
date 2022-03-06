data WORK.CLASS;
set SASHELP.CLASS(keep=name sex age);
run;

%get_common_columns_meta(SASHELP.CLASS, WORK.CLASS, WORK.COMMON_COLUMNS);