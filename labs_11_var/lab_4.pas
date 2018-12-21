var	S1,S2 : string ; // Строки
    valid_str, valid_sign : boolean ; // Переменные для валидации
begin
  // Ввод строки и контрольная печать
  {writeln('Введите строку');
  readln(S1);}
  S1:='123 +-++ 45 - 23';
  
  // Контрольная печать
  writeln('Вы ввели строку: «', S1, '»');
  writeln;

  // Подсчёт числа символов '+'/'-' в строке
  var plus_count:=0;
  var minus_count:=0;
  for i:integer:=1 to length(S1) do 
    if S1[i]='+' then
      plus_count+=1
    else if S1[i]='-' then
      minus_count+=1;
  writeln('В строке ',plus_count,' символа «+» и ',minus_count,' символа «–»');
  writeln;
    
  // Валидация арифметического выражения
  valid_str:=true;
  for i:integer:=1 to length(S1) do
    begin
      valid_sign:=false;
      foreach code:integer in [43,45,48..57] do
        begin
          if ((S1[i]=chr(code)) or (S1[i]=' ')) then
            begin
              valid_sign:=true;
              break;
            end;
        end;
      if valid_sign=false then
        begin
          valid_str:=false;
          break;
        end;
    end;
    
  // проверка на наличие знака первого числа
  for i:integer:=1 to length(S1) do 
    if S1[i]<>' ' then
      if ((S1[i]<>'+') and (S1[i]<>'-')) then
        begin
          S1:='+'+S1;
          break;
        end
      else
        begin
          break;
        end;
  
  if not valid_str then
    writeln('Выражение некорректно')
  else
    begin
      writeln('Выражение корректно');
      // Поиск чисел
      var sum:=0;
      var elem, code:integer;
      var str_elem:string;
      S2:='';
      var sign:='';
      for i:integer:=1 to length(S1) do
        begin
          if ((S1[i]<>'+') and (S1[i]<>'-') and (S1[i]<>' '))then
            begin
              S2+=S1[i];
            end
          else
            begin
              // знак
              if ((S1[i]<>' ') and (sign='')) then
                sign:=S1[i];
              if ((length(S2)<>0)) then
                  begin
                    str_elem:=Concat(sign,S2);
                    write(str_elem);
                    val(str_elem,elem,code);
                    sum+=elem;
                    // знак
                    if (S1[i]<>' ') then
                      sign:=S1[i]
                    else
                      sign:='';
                  end;
              S2:='';
            end;
          if ((i=length(S1)) and (length(S2)<>0)) then
            begin
              str_elem:=Concat(sign,S2);
              write(str_elem);
              val(str_elem,elem,code);
              sum+=elem;
            end;
        end;
      writeln(' = ', sum);
    end;
end.
