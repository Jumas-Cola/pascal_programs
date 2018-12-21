// функция одновременного вывода на экран и записи в файл
procedure file_write_show(file_name:text; str:string);
  begin
    writeln(str);
    writeln(file_name,str);
  end;

// количество вхождений символов одной строки в другой строке
function count(sub_str:string; str:string):integer;
  var c:=0;
  begin
    foreach i:char in str do
        if (i in sub_str) then
            c+=1;
    count:=c;
  end;
  
// запрос имени файла с проверкой существования
function inp_file_name:string;
  var file_name:string;
  begin
    repeat
      write('Введите имя файла: ');
      readln(file_name);
      if not fileexists(file_name) then
        writeln('Файл не найден');
    until(fileexists(file_name));
    inp_file_name:=file_name;
  end;
  
// считывание строк файла с контольным выводом на экран
function file_to_str(file_name:string):string;
  var f:text;
      res_str,temp:string;
  begin
    assign(f, file_name);
    reset(f);
    writeln('Содержимое файла "'+file_name+'" :');
    while not eof(f) do
      begin
        readln(f,temp);
        writeln(temp);
        res_str+=temp;
        temp:='';
      end;
    close(f);
    file_to_str:=res_str;
  end;
  
//запись в файл пронумерованного списка с контольным выводом на экран
procedure file_write_ennum_list(file_name:text; list:set of string);
  var counter:=1;
  begin
    file_write_show(file_name,'-------------------');
    file_write_show(file_name,'№  | sign  | count');
    file_write_show(file_name,'-------------------');
    foreach i:string in list do
      begin
        file_write_show(file_name, counter+i);
        counter+=1;
      end;
    file_write_show(file_name,'-------------------');
  end;
  
  


begin

// запись содержимого файла в строку
var file_str:=file_to_str(inp_file_name);
writeln;

// формирование множества с количествами вхождений символов с тексте файла
var sign_count_list:set of string;
foreach i:char in file_str do
  sign_count_list+=[' | "'+i+'" | '+count(i,file_str)+''];

// создание файла с результатами анализа текста
var output:text;
var output_name:string;
write('Введите имя файла: '); readln(output_name);
assign(output, output_name);
rewrite(output);

// запись в файл комментирующего текста
file_write_show(output,'Гласных букв русского алфавита - '+count('аеёиоуыэюяАЕЁИОУЫЭЮЯ',file_str)+' штук');
file_write_show(output,'Согласных букв русского алфавита - '+count('бвгджзйклмнпрстфхцчшщБВГДЖЗЙКЛМНПРСТФХЦЧШЩ',file_str)+' штук');
file_write_show(output,'Гласных букв латинского алфавита - '+count('aeiouyAEIOUY',file_str)+' штук');
file_write_show(output,'Согласных букв латинского алфавита - '+count('bcdfghjklmnpqrstvwxzBCDFGHJKLMNPQRSTVWXZ',file_str)+' штук');

// запись множества с количествами вхождений в таблицу
file_write_ennum_list(output,sign_count_list);
close(output);

end.