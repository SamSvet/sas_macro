# SAS Macro
Here I have collected a set of utility macros that I have been using for creating ETL procedures.
Some of them turned out to be useful [SAS_FileUploader](https://github.com/SamSvet/SAS_FileUploader) project.
You can find an example of using macros in the folder [*example*](example).

## Installation
Download [*macro*](macro) folder to somewhere under your SAS system. 

Then update your [sasautos](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/mcrolref/p12b2qq72dkxpsn1e19y57emerr6.htm) path to have macros available,eg:
```sas
options mautosource insert=(sasautos="/your/path/to/macro");
```

Alternatively you can [include](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.2/lestmtsglobal/p1s3uhhqtscz2sn1otiatbovfn1t.htm) whole folder without updating any SAS options:
```sas
%include "/your/path/to/macro/*";
```

## Details

**Datastep macro**
Macros whose name starts with _do\__ belong to _datastep_ macros, i.e. generate code and apply inside data step.
[*do_setflag.sas*](macro/do_setflag.sas), [*do_setflag_array.sas*](macro/do_setflag_array.sas), [*do_sametype.sas*](macro/do_sametype.sas) I used in a [SAS_FileUploader](https://github.com/SamSvet/SAS_FileUploader) project.

**Inline macro**
Some macros return a value and might be used inside sas macro statements, so they are called _inline_.
```sas
data varlist;
length varlist $1024;
varlist="%varlist(sashelp.class)"; output;
varlist="%varlist(sashelp.cars)"; output;
run;
%put %sort(12 3 7 9 4);
```
This group includes [*varlist.sas*](macro/varlist.sas), [*attrntype.sas*](macro/attrntype.sas), [*sort.sas*](macro/sort.sas), [*intersection.sas*](macro/intersection.sas) and some others.

**Resolve SQL macro**
[*resolve_sql.sas*](macro/resolve_sql.sas) allows you to execute SQL-templates inside _proc sql_.
SQl-template is external file, e.g. [*select_class.txt*](example/select_class.txt), which contains DDL, DML commands. You can see usage example here [*resolve_sql_eg.sas*](example/resolve_sql_eg.sas). 

**Error control macro**
[*seterr.sas*](macro/seterr.sas), [*clearerr.sas*](macro/clearerr.sas), [*checkerr.sas*](macro/checkerr.sas) is used to control errors in sas programs.

All these macros make the code more declarative and therefore more readable and reusable. 