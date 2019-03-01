unit StrUnit;

interface
{Находит в строке str и считает слова, которые СОДЕРЖАТ символ chr (если flag = true).
Или слова, которые НЕ СОДЕРЖАТ символ chr (если flag = false)}
function CountHasChar(str: string; chr: char; flag: boolean): integer;

implementation

// разбиение строки на массив слов по разделителям
function SplitString(str: string; delims: string): array of string;
var
    temp_str: string;
    res_arr: array of string;
begin
    for i: integer := 1 to length(str) do
        if not (str[i] in delims) then
            temp_str += str[i]
        else begin
            if length(temp_str) <> 0 then
            begin
                SetLength(res_arr, length(res_arr) + 1);
                res_arr[length(res_arr) - 1] := temp_str;
                temp_str := '';
            end;
        end;
    if length(temp_str) <> 0 then
    begin
        SetLength(res_arr, length(res_arr) + 1);
        res_arr[length(res_arr) - 1] := temp_str;
    end;
    SplitString := res_arr;
end;

function CountHasChar: integer;
var
    words_count: integer;
    str_arr: array of string;
    first_word: boolean;
begin
    first_word := true;
    str_arr := SplitString(str, ' ,.!?');
    
    if flag then writeln('Слова, содержащие символ "' + chr + '":')
    else writeln('Слова, не содержащие символ "' + chr + '":');
    
    for i: integer := 0 to length(str_arr) - 1 do
        if (chr in str_arr[i]) = flag then
        begin
            if not first_word then write(', ');
            words_count += 1;
            write(str_arr[i]);
            first_word := false;
        end;
    writeln;
    
    CountHasChar := words_count;
end;

//--------------------------------------------------------------------
// ИНИЦИАЛИЗАЦИОННЫЙ БЛОК МОДУЛЯ
initialization
    writeln('Программа использует модуль "StrUnit".');
    writeln('Инициализация библиотеки прошла успешно.');
    writeln('Осуществляется запуск основной программы.');
    writeln;
//--------------------------------------------------------------------
// ФИНАЛИЗАЦИОННЫЙ БЛОК МОДУЛЯ
finalization
    writeln;
    writeln('Работа программы завершена.');
    writeln('Осуществляется завершение работы модуля "StrUnit".');
//--------------------------------------------------------------------

end.