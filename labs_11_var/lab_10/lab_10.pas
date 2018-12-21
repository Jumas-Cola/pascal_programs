uses Arrays;

// ввод значения с проверкой типа
function check_input(message:string):integer;
  var str:string;
      num,code:integer;
  begin
    repeat
      write(message);
      readln(str);
      val(str, num, code)
    until((code=0) and (num>=1) and (num mod 1 = 0));
    check_input:=num;
  end;

// дозапись в файл массива
procedure file_write(arr:array of integer; file_name:string);
  var F:file of integer;
  begin
    assign(F, file_name);
    if not fileexists(file_name) then
      rewrite(F)
    else
      reset(F);
    for i:integer:=0 to length(arr)-1 do
      begin
        seek(F,filesize(F));
        write(arr[i]:2);
        write(F, arr[i]);
      end;
    close(F);
  end;
// перегруженная процедура дозаписи в файл числа
procedure file_write(num:integer; file_name:string);
  var F:file of integer;
  begin
    assign(F, file_name);
    if not fileexists(file_name) then
      rewrite(F)
    else
      reset(F);
    seek(F,filesize(F));
    write(F, num);
    close(F);
  end;
  
// считывание последовательности чисел из файла в массив
function file_to_arr(file_name:string):array of integer;
  var F:file of integer;
      res_arr:array of integer;
      num:integer;
  begin
    var len:=1;
    assign(F, file_name);
    reset(F);
    while not eof(F) do
      begin
        read(F,num);
        setlength(res_arr,len);
        res_arr[len-1]:= num;
        len+=1;
      end;
    close(F);
    file_to_arr:=res_arr;
  end;

// фильтрация НЕ кратных данному чисел массива
function filter_arr_non_mult(num:integer; arr:array of integer):array of integer;
  var res_arr:array of integer;
  begin
    var len:=1;
    foreach i:integer in arr do
      begin
        if (i mod num <> 0) or (i = 0) then
          begin
            setlength(res_arr,len);
            res_arr[len-1]:= i;
            len+=1;
          end;
      end;
    filter_arr_non_mult:=res_arr;
  end;

//очистка файла
procedure clear_file(file_name:string);
  var F:file of integer;
  begin
    assign(F, file_name);
    rewrite(F);
    close(F);
  end;

// разбиение массиыв на потоки по правилу:
// [кол-во потоков, кол-во серий в 1 потоке, ...серии, и т.д...]
function parser(arr:array of integer):array of array of array of integer;
  var res_arr:array of array of array of integer;
      series_arr:array of array of integer;
      nums_in_series:integer;
  begin
  var counter:=1;
  setlength(res_arr,arr[0]);//установка длины массива потоков
  for i:integer:=1 to arr[0] do //счётчик потоков
    begin
      setlength(series_arr,arr[counter]);//установка длины массива серий потока
      for j:integer:=1 to arr[counter] do //счётчик серий
        begin
          counter+=1;
          nums_in_series:=arr[counter];//установка длины серии
          series_arr[j-1]:=arr[counter+1:counter+nums_in_series+1];//считывание текущей серии
          counter+=nums_in_series;//сдвиг к следующей серии
        end;
      res_arr[i-1]:= series_arr;//добавление потока в рез.массив
      setlength(series_arr,0);//очищение массива серий потока
      counter+=1;
    end;
  parser:=res_arr;
  end;

var file_name:string;
    streams_count:integer;
    elems_count:integer;
    file_arr:array of integer;
    curr_arr:array of integer;

// Главная часть
begin
var nums_in_series:=5; //количество чисел в серии
var num_filter:=2; //записывать во 2 файл элементы не кратные этому числу

//заполнение файла потоками массивов случайных чисел
write('Введите имя файла: '); readln(file_name);
clear_file(file_name);
streams_count := check_input('Введите количество потоков: ');
file_write(streams_count, file_name);
for i:integer:=1 to streams_count do
  begin
    elems_count := check_input('Введите количество серий в '+i+' потоке: ');
    file_write(elems_count, file_name);
    for j:integer:=1 to elems_count do
      begin
        write('Серия №',j,':');
        curr_arr:=CreateRandomIntegerArray(nums_in_series,0,9);
        file_write(length(curr_arr), file_name);
        file_write(curr_arr, file_name);
        writeln;
      end;
  end;
  
file_arr:=file_to_arr(file_name);
writeln('"Сырой" массив, считанный из файла: ',file_arr);
var streams := parser(file_arr);
writeln('Массив, разбитый парсером на потоки: ',streams);
writeln;

//заполнение файла потоками фильтрованных массивов
var filtered_arr:array of integer;
write('Введите имя конечного файла: '); readln(file_name);
clear_file(file_name);
streams_count := length(streams);
file_write(streams_count, file_name);
for i:integer:=0 to streams_count-1 do
  begin
    writeln('___Поток №___',i+1);
    elems_count := length(streams[i]);
    file_write(elems_count, file_name);
    for j:integer:=0 to elems_count-1 do
      begin
        write('Серия №',j+1,':');
        curr_arr:=filter_arr_non_mult(num_filter, streams[i][j]);
        file_write(length(curr_arr), file_name);
        file_write(curr_arr, file_name);
        writeln;
      end;
  end;
  
file_arr:=file_to_arr(file_name);  
writeln('"Сырой" массив, считанный из файла: ',file_arr);
writeln('Массив, разбитый парсером на потоки: ',parser(file_arr));
end.