%macro resolve_sql(mvSQLTemplate);
    %local rcdsbl mname;
    %let mname=&sysmacroname;
    %let rcdsbl = %sysfunc(dosubl(%str(
        data &mname;
            length sql_row $1024;
            infile "&mvSQLTemplate." lrecl=1024 encoding='utf-8';
            input;
            sql_row=resolve(_infile_);
        run;
    )));
    %fetch_obs(&mname,sql_row)
%mend;