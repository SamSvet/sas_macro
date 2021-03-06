%macro checkerr(mvMessage, mvPrevErr=0);
    %global _RC_ _RS_;
    %if (&mvPrevErr. ne 0) and (&_RC_. > 0) %then %return;

    %if %eval(&SYSCC + 0)>0 and %eval(&SYSCC + 0) ne 4 %then %do;
        %let _RC_=&SYSCC;
        %if %length(&mvMessage)=0 %then %let _RS_=&SYSERRORTEXT;
        %else %let _RS_=&mvMessage;
    %end;

    %else %if %eval(&SQLRC + 0)>0 and %eval(&SQLRC + 0) ne 4 %then %do;
        %let _RC_=&SQLRC;
        %if %length(&mvMessage)=0 %then %let _RS_=&SYSERRORTEXT;
        %else %let _RS_=&mvMessage;
    %end;

    %else %if %eval(&SQLXRC + 0)>0 and %eval(&SQLXRC + 0) ne 4 %then %do;
        %let _RC_=&SQLXRC;
        %if %length(&mvMessage)=0 %then %let _RS_=&SQLXMSG;
        %else %let _RS_=&mvMessage;
    %end;
%mend;