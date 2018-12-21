// функция рекурсивного вычисления
function delimit(x:real; y:real; count:integer:=0):string;
  var S:='';
  begin
    if (x/y)<=1 then
      begin
        Str(count, S);
        delimit:=S;
      end
    else if y>1 then
        delimit:=delimit(x/y,y,count+1)
    else
        delimit:='ထ'
  end;


var x:real;
    y:real;
begin
  // ввод параметров
  write('(real) X = ');
    readln(x);
  write('(real) Y = ');
    readln(y);
  // вывод результата
  writeln('Столько раз можно поделить число X начисло Y,');
  writeln('чтобы результат по-прежнему оставался больше единицы: ',delimit(x,y));
end.