%macro oracle_meta_connection(muser=, mpassword=, mpath=, mlib=metaora, moracleauth=);
    %global _RC_ _RS_;
    %clearerr;
    %if %length(&moracleauth.)>1 %then %do;
        %let mcredentials=%str(authdomain=&moracleauth.);
    %end;

    %else %do;
        %let mcredentials=%str(user="&muser." password="&mpassword.");
    %end;

    %let mname=&sysmacroname;
    data sys_context;
        sasfuncname = 'sys_context';
        sasfuncnamelen = length(sasfuncname);
        dbmsfuncname = 'sys_context';
        dbmsfuncnamelen = length(dbmsfuncname);
        function_category = 'SCALAR';
        func_usage_context = 'WHERE_ORDERBY';
        function_returntyp = 'INTEGER';
        function_num_args = 2;
        convert_args = 0;
        engineindex = 0;
        output;
    run;

    libname &mlib. clear;
    libname &mlib. oracle
        PATH=&mpath.
        &mcredentials.
        sql_functions="external_append=work.sys_context"
        preserve_tab_names=yes
        connection=global DBCOMMIT=0 INSERTBUFF=10000
    ;
    
    %checkerr(&mname:Could not establish connection to oracle);
    %if &_RC_ %then %return;
%mend;