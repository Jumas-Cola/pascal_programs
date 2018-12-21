Unit n_o;

interface

function input:set of integer; // ввод множества чисел
function nod(x:set of integer):integer; // НОД множества чисел
function nok(x:set of integer):integer; // НОК множества чисел
procedure print(str:string; num:integer); // вывод результата

implementation

// ввод значения с проверкой типа
function check_input(message:string):integer;
  var str:string;
      num,code:integer;
  begin
    repeat
      write(message);
      readln(str);
      val(str, num, code)
    until(code=0);
    check_input:=num;
  end;

// функция ввода с проверкой корректности
function input:set of integer;
  var n:integer;
      res:set of integer;
  begin
    n:=check_input('Введите количество элементов: ');
    for i:integer:=1 to n do
      res+=[check_input('Введите '+i+' элемент: ')];
    input:=res;
  end;

//НОД 2 чисел
function nod_2(x,y:integer):integer;
  begin
    while x<>y do
      if x>y then x:=x-y
      else y:=y-x;
    nod_2:=x;
  end;
  
// НОД массива чисел
function nod:integer;
  var c:=0;
      res:integer;
  begin
    foreach i:integer in x do
      begin
        if c=0 then
          res:=i
        else
          res:=nod_2(res, i);
        c+=1;
      end;
    nod:=res;
  end;
  
// НОК массива чисел
function nok:integer;
  var c:=0;
      res:integer;
  begin
    foreach i:integer in x do
      begin
        if c=0 then
          res:=i
        else
          res:=res * trunc(i/nod_2(res, i));
        c+=1;
      end;
    nok:=res;
  end;

// вывод результата с проверкой переполнения
procedure print;
  begin
    if num<0 then
      writeln('При вычислении произошло переполнение')
    else
      writeln(str, num);
  end;
  
//--------------------------------------------------------------------
// ИНИЦИАЛИЗАЦИОННЫЙ БЛОК МОДУЛЯ
initialization
writeln('Программа использует библиотеку "n_o".');
writeln('Инициализация библиотеки прошла успешно.');
writeln('Осуществляется запуск основной программы.');
writeln;
//--------------------------------------------------------------------
// ФИНАЛИЗАЦИОННЫЙ БЛОК МОДУЛЯ
finalization
writeln;
writeln('Работа программы завершена.');
writeln('Осуществляется завершение работы библиотеки "n_o".');
//--------------------------------------------------------------------

end.
