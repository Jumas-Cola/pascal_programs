Var
X : array[1..10, 1..10] of integer; // Матрица
i,j : integer; // Счётчики строк и столбцов
ran_min, ran_max : integer; // Диапазон случайных чисел
N : integer; // Дополнительная переменная – вводимая пользователем
str_sum : integer; // Переменные для подсчёта суммы элементов строки
min, max : integer; // минимальный и максимальный элемент соответственно
Begin
// Заполнение матрицы
randomize();
{write('Ввведите нижний диапазон: '); readln(ran_min);
write('Ввведите верхний диапазон: '); readln(ran_max);}
ran_min:=0;
ran_max:=99;
for i:=1 to 10 do
  for j:=1 to 10 do
    X[i][j]:= random(ran_max-ran_min+1)+ran_min;
    
// Вывод матрицы на экран
for i:=1 to 10 do
begin for j:=1 to 10 do write(X[i,j]:3);
writeln;
end;

// Диалог с пользователем
writeln;
repeat
  write('Введите номер строки. N = ');
  Readln(N);
  if ((N<1) or (N>10))then
    writeln('Строки с таким номером в матрице нет')
until((N>=1) and (N<=10));

// Подсчёт суммы элементов строки
writeln;
str_sum:=0;
for j:=1 to 10 do
  begin
    write(X[N,j]);
    if j<>10 then write(' + ');
    str_sum+=X[N,j];
  end;
write(' = ', str_sum);

// Поиск максимального и минимального элементов матрицы
min := X[1][1];
max := X[1][1];
for i:=1 to 10 do
  for j:=1 to 10 do
    begin
      if X[i][j]>max then
        max:=X[i][j];
      if X[i][j]<min then
        min:=X[i][j];
    end;
writeln;
writeln;
writeln('Минимальный элемент: ', min);
writeln('Максимальный элемент: ', max);
End.