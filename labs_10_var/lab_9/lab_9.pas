// запрос имени файла с проверкой существования
function inp_file_name: string;
var
    file_name: string;
begin
    repeat
        write('Введите имя файла: ');
        readln(file_name);
        if not fileexists(file_name) then
            writeln('Файл не найден');
    until(fileexists(file_name));
    inp_file_name := file_name;
end;

// считывание строк файла с контольным выводом на экран
function file_to_str(file_name: string): string;
var
    f: text;
    res_str, temp: string;
begin
    assign(f, file_name);
    reset(f);
    writeln('Содержимое файла "' + file_name + '" :');
    while not eof(f) do
    begin
        readln(f, temp);
        writeln(temp);
        res_str += temp;
        temp := '';
    end;
    close(f);
    file_to_str := res_str;
end;

// количество вхождений символов одной строки в другой строке
function count(sub_str: string; str: string): integer;
var
    c := 0;
begin
    foreach i: char in str do
        if (i in sub_str) then
            c += 1;
    count := c;
end;

// функция одновременного вывода на экран и записи в файл
procedure file_write(file_name: text; str: string);
begin
    writeln(str);
    writeln(file_name, str);
end;

// функция перевода строки в массив уникальных кодов символов
function str_to_ord_arr(str: string): array of integer;
var
    char_set: set of char;
    ord_arr: array of integer;
begin
    // формирование множества с символами файла
    foreach i: char in str do
        char_set += [i];
    
    // формирование и сортировка массива числовых кодов символов
    foreach i: char in char_set do
    begin
        setlength(ord_arr, length(ord_arr) + 1);
        ord_arr[length(ord_arr) - 1] := ord(i);
    end;
    try
        sort(ord_arr);
    except
        writeln('Ошибка. Невозможно сформировать массив кодов.');
        halt; //останавливает выполнение программы и выходит в операционную систему
    end;
    str_to_ord_arr := ord_arr;
end;

// поиск и запись в конечный файл символов, встречающихся в строке только один раз
procedure write_lonely_chars(ord_arr: array of integer; str: string; out_file: text);
var
    lonely_chars: string; // строка для записи в файл
    first_char := true;// переменная для постановки запятых
begin
    foreach i: integer in ord_arr do
        if count(chr(i), str) = 1 then
        begin
            if not first_char then lonely_chars += ', ';
            lonely_chars += '"' + chr(i) + '"';
            first_char := false;
        end;
    if length(lonely_chars) <> 0 then
    begin
        file_write(out_file, 'Символы, встречающиеся в файле только один раз:');
        file_write(out_file, lonely_chars);
        file_write(out_file, '');
    end;
end;

// запись в файл таблицы символов
procedure write_table(ord_arr: array of integer; str: string; out_file: text);
var
    lonley: string;
    c: integer;
begin
    file_write(out_file, '----------------------------');
    file_write(out_file, '| Код | Символ | Количество |');
    file_write(out_file, '----------------------------'); 
    foreach i: integer in ord_arr do
    begin
        c := count(chr(i), str);
        if c = 1 then lonley := '*'
        else lonley := '';
        file_write(out_file, '|   ' + i + '   |   ' + chr(i) + '   |   ' + c + '   |' + lonley);
    end;
    file_write(out_file, '----------------------------');
end;


begin
    // запись содержимого файла в строку
    var file_str := file_to_str(inp_file_name);
    writeln;
    
    // перевод строки в массив уникальных кодов символов
    var ord_arr := str_to_ord_arr(file_str);
    
    // создание файла с результатами анализа текста
    var output: text;
    var output_name: string;
    write('Введите имя файла результатов: '); readln(output_name);
    assign(output, output_name);
    rewrite(output);
    
    // поиск и запись в конечный файл символов, встречающихся в строке только один раз
    write_lonely_chars(ord_arr, file_str, output);
    
    // запись в файл таблицы символов
    write_table(ord_arr, file_str, output);
    
    close(output);
end.