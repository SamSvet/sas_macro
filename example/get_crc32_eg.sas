%let checkSum=0;
%let result=0;
%get_crc32(/path/to/select_class.txt, checkSum, result);
%put &=checkSum;
%put &=result;
