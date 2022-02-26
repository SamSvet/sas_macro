%macro oracle_objectexist(mvOwner=, mvObjectName=, mlib=metaora);
    %local &sysmacroname._res &sysmacroname._rc;
    %let &sysmacroname._res=0;
    %let mvOwner=%upcase(&mvOwner);
    %let mvObjectName=%upcase(&mvObjectName);
    
    %let &sysmacroname._rc = %sysfunc(dosubl(%str(
        data _null_;
            set &mlib..ALL_OBJECTS(keep=owner object_name where=(owner="&mvOwner." and object_name="&mvObjectName.")) end=eof;
            if eof then call symputx("&sysmacroname._res",_N_);
        run;
    )));

    &&&sysmacroname._res
%mend;