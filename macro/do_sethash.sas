%macro do_sethash(mvDSCondition);
    %local dsid rc prxrc &sysmacroname._res;
    %let dsid=%sysfunc(open(&mvDSCondition(where=(^missing(dataset_name))), IS));
    %if &dsid>0 %then %do;
        DO _do_sethash_iter_=1 TO 1;
        %syscall set(dsid);
        %let rc = %sysfunc(fetch(&dsid));
        %let prxrc=%sysfunc(prxparse( %nrstr(s/(\w+)/'$1',/) ));
        %do %while(&rc=0);
            %let dataset_name=&dataset_name;
            %let defineKey=&defineKey;
            %let defineData=&defineData;
            DECLARE HASH &dataset_name.(DATASET: "&dataset_name");                                              
            %if %length(&defineKey)>1 %then %do;
                %let &sysmacroname._res=%sysfunc(prxchange(&prxrc, -1, &defineKey));
                %let &sysmacroname._res=%substr(%nrbquote(&&&sysmacroname._res), 1,%eval(%length(&&&sysmacroname._res)-1));
                &dataset_name..DEFINEKEY(&&&sysmacroname._res);
            %end;

            %else %do;
                &dataset_name..DEFINEKEY(ALL: 'YES');
            %end;

            %if %length(&defineData)>1 %then %do;
                %let &sysmacroname._res=%sysfunc(prxchange(&prxrc, -1, &defineData));
                %let &sysmacroname._res=%substr(%nrbquote(&&&sysmacroname._res), 1,%eval(%length(&&&sysmacroname._res)-1));
                &dataset_name..DEFINEDATA(&&&sysmacroname._res);
            %end;

            &dataset_name..DEFINEDONE();
            %let rc = %sysfunc(fetch(&dsid));
        %end;
        %let rc=%sysfunc(close(&dsid));
        END;
    %end;
%mend do_sethash;