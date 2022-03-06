data mapping;
attrib
     src_name length=$1024
     trg_name length=$1024
     key length=3
;
src_name="glossary.title";trg_name="glossary_title";key=1;output;
src_name="glossary.GlossDiv.GlossList.GlossEntry.Acronym";trg_name="GlossEntry_Acronym";key=0;output;
src_name="glossary.GlossDiv.GlossList.GlossEntry.GlossTerm";trg_name="GlossEntry_GlossTerm";key=0;output;
src_name="glossary.GlossDiv.GlossList.GlossEntry.ID";trg_name="GlossEntry_ID";key=0;output;
run;

filename ftmp clear;
filename ftmp temp;
data _null_;
     file ftmp encoding='utf-8';
put 'import json';
put 'import sys';
put 'def flatten_dict(d):';
put '   def items():';
put '       for key, value in d.iteritems():';
put '           if isinstance(value, dict):';
put '               for subkey, subvalue in flatten_dict(value).iteritems():';
put '                   yield "{0}.{1}".format(key,subkey), subvalue';
put '           elif isinstance(value, list):';
put '               for subkey, subvalue in flatten_dict(dict(enumerate(value))).iteritems():';
put '                   yield "{0}.{1}".format(key,subkey), subvalue';
put '           else:';
put '               yield key, value';
put '   return dict(items())';
put 'def to_str(elem):';
put '   if isinstance(elem ,tuple):';
put '       return "{0}\t{1}".format(to_str(elem[0]), to_str(elem[1]))';
put '   if isinstance(elem, bool):';
put '       return 1 if elem else 0';
put '   elif isinstance(elem, unicode):';
put '       return elem.encode("utf-8")';
put '   elif isinstance(elem, (int, float)):';
put '       return str(elem)';
put '   elif elem is None:';
put '       return ""';
put '   return str(elem)';
put 'if __name__ == "__main__":';
put '   if len(sys.argv) < 2:';
put '       print("Insufficient number of arguments")';
put '       print("Use python {0} filename_to_read".format(sys.argv[0]))';
put '       sys.exit(1)';
put '   with open(sys.argv[1], "r") as json_file:';
put '       print("\r\n".join(map(to_str, flatten_dict(json.loads(json_file.read())).iteritems())))';
run;

data WORK.RESULT;
    infile "python %sysfunc(pathname(ftmp)) /your/path/to/example/do_rename_eg.json" pipe encoding='utf-8' dsd dlm='09'x missover termstr=crlf;
    length key_name key_value $1024;
    input key_name key_value;
    key_name=trim(left(key_name));
    key_value=trim(left(key_value));
    %do_rename(mapping, key_name, key_value);
run;

%put &=glossary_title;
%put &=GlossEntry_Acronym;
%put &=GlossEntry_GlossTerm;
%put &=GlossEntry_ID;