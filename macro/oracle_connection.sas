%macro oracle_connection(muser=, mpassword=, mpath=, mschema=, mlib=srcora, moracleauth=);
    %global _RC_ _RS_;
    %clearerr;
    %if %length(&moracleauth.)>1 %then %do;
        %let mcredentials=%str(authdomain=&moracleauth.);
    %end;

    %else %do;
        %let mcredentials=%str(user="&muser." password="&mpassword.");
    %end;

    %let mname=&sysmacroname;
    libname &mlib. clear;

    libname &mlib. oracle
        PATH=&mpath.
        &mcredentials.
        schema=&mschema.
        sql_functions="external_append=work.sys_context"
        preserve_tab_names=yes
        connection=global
    ;

    %checkerr(&mname:Could not establish connection to oracle);
    %if &_RC_ %then %return;
%mend;