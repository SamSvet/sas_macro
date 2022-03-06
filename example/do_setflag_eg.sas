data cars;
set sashelp.cars;
run;

data conditionRC;
attrib
     rule_num           length=8
     rule_condition     length=$2056
     rule_value         length=$2056
     rule_description   length=$2056
;
infile datalines dsd missover dlm='09'x;
input rule_num rule_condition rule_value rule_description;
datalines;
1   horsepower>249  1   catx(byte(10), &mvFlagName, 'Too much power')
2   cylinders>4 2   catx(byte(10), &mvFlagName, 'Complex mechanism')
3   weight>4000 3   catx(byte(10), &mvFlagName, 'Too heavy')
4   enginesize>2    4   catx(byte(10), &mvFlagName, 'High fuel consumption')
5   length>200  5   catx(byte(10), &mvFlagName, 'Limousine')
6   max(of &mvFlagName{*})<-1   0   "'OK'"
run;

data conditionRS;
if 0 then set conditionRC;
set conditionRC;
rule_condition=cats('RC_ARR[',_n_,']=',rule_value);
rule_value=rule_description;
run;

data conditionRC_overall;
attrib
     rule_num             length=8
     rule_condition       length=$1024
     rule_value           length=$256
;
infile datalines dsd missover dlm='09'x;
input rule_num rule_condition rule_value;
datalines;
1   1=1    ifn(max(of RC_ARR{*})=0, min(of RC_ARR{*}), max(of RC_ARR{*}))
run;

data WORK.RESULT;
    set WORK.CARS;
    length RS $2056 RC 8;
    array RC_ARR{%obsnum(conditionRC)} 8 ;
    %do_setflag_array(conditionRC, RC_ARR);
    %do_setflag(conditionRC_overall, RC);
    %do_setflag(conditionRS, RS);  
run;