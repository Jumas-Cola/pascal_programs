uses StrUnit;

var
    str: string;
    chr: char;

begin
    writeln('Введите строку:'); readln(str);
    write('Введите символ: '); readln(chr);
    writeln;
    writeln('Слов в строке, содержащих указанный символ: ' + CountHasChar(str, chr, true));
    writeln;
    writeln('Слов в строке, не содержащих указанный символ: ' + CountHasChar(str, chr, false));
end.