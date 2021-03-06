%macro get_crc32(mvFullFileName, mvCheckSum, mvResult);
    %local mname crc32python;
    %let mname=&sysmacroname;
    %let &mvResult=1;
    %let crc32python=%sysfunc(pathname(WORK))/&mname..py;

    data _null_;
        file "&crc32python" encoding='utf-8' nobom termstr=lf;
        put 'import zlib';
        put 'import sys';
        put 'def crc32(fileName, chunkSize=1048576):';
        put "   with open(fileName, 'rb') as fh:";
        put '       hash=0';
        put '       while True:';
        put '           chunk = fh.read(chunkSize)';
        put '           if not chunk:';
        put '               break';
        put '           hash = zlib.crc32(chunk, hash)';
        put '       return (hash & 0xFFFFFFFF)';
        put 'if __name__ == "__main__":';
        put '   if len(sys.argv) < 2:';
        put '       print("Insufficient number of arguments")';
        put '       print("Use python {0} filename_to_read".format(sys.argv[0]))';
        put '       sys.exit(1)';
        put '   print(crc32(sys.argv[1]))';
    run;

    data _null_;
        infile "python &crc32python &mvFullFileName; echo $?" pipe end=EOF;
        input; putlog _infile_;
        if _n_=1 then call symputx("&mvCheckSum", _infile_);
        if EOF then call symputx("&mvResult", _infile_);
    run;
%mend;