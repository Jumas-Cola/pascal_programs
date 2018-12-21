var a,b,X : real;
begin
  // Ввод исходных данных
  writeln('Введите исходные данные:');
  write ('a = ');
    readln(a);
  write('b = ');
    readln(b);
    
  // Расчетная часть
  if (a>b) then
    begin
      X:=2*a+b;
    end
  else if (a=b) then
    begin
      X:=-2;
    end
  else if ((a<b) and (b<>0)) then
    begin
      X:=(a-5)/(b);
    end
  else
    begin
      writeln('Ввод некорректен.');
      exit;
    end;
    
  // Вывод результатов
  writeln('Результат:');
  writeln('X = ', X);
end.