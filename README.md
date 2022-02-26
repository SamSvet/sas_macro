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