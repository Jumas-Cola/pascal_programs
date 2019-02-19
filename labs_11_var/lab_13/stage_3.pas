var
    N, i: integer; // Количество групп данных и их счётчик.
    Data: array[ ,] of real;// Динамический двумерный массив

begin
    N := 0;
    while (N < 1) do
    begin
        Writeln;
        Write('Введите количество групп даных. N=');
        Readln(N);
        if (N < 1)
        then begin
            Writeln('Количество групп должно быть не менее 1');
            Writeln('Повторите ввод.');
        end;
    end;
    
    Data := new real[N, 4];
    
    Writeln('Введите тройки чисел');
    for i := 1 to N do
    begin
        Writeln;
        while (Data[i - 1, 0] = Data[i - 1, 1]) or (Data[i - 1, 0] = Data[i - 1, 2]) or (Data[i - 1, 1] = Data[i - 1, 2]) do
        begin
            Writeln;
            Writeln('Тройка № ', i);
            Write('X='); Readln(Data[i - 1, 0]);
            Write('Y='); Readln(Data[i - 1, 1]);
            Write('Z='); Readln(Data[i - 1, 2]);
            if (Data[i - 1, 0] = Data[i - 1, 1]) or (Data[i - 1, 0] = Data[i - 1, 2]) or (Data[i - 1, 1] = Data[i - 1, 2])
            then begin
                Writeln('Числа в тройке не должны совпадать.');
                Writeln('Повторите ввод.');
            end;
        end;
    end;
    for i := 1 to N do
        if (Min(Min(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) < Data[i - 1, 0]) and
           (Max(Max(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) > Data[i - 1, 0]) then
            Data[i - 1, 3] := Data[i - 1, 0]
        else if (Min(Min(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) < Data[i - 1, 1]) and
           (Max(Max(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) > Data[i - 1, 1]) then
            Data[i - 1, 3] := Data[i - 1, 1]
        else if (Min(Min(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) < Data[i - 1, 2]) and
           (Max(Max(Data[i - 1, 0], Data[i - 1, 1]), Data[i - 1, 2]) > Data[i - 1, 2]) then
            Data[i - 1, 3] := Data[i - 1, 2];
    
    Writeln;
    Writeln('Результаты вычислений:');
    for i := 1 to N do Writeln('Среднее число в тройке №', i:2, ' = ', Data[i - 1, 3]);
end.