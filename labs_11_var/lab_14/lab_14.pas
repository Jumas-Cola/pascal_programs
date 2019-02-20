// Предварительные описания.
type
    PNode = ^Node;
    Node = record
        fio: record
            surname: string;
            name: string;
            patronymic: string;
        end;
        group_num: integer;
        marks: array of integer;
        next: PNode;
    end;

// Конструктор записи студента
function StudentConstruct(surname, name, patronymic: string; group_num: integer; marks: array of integer): PNode;
begin
    New(Result);
    Result^.fio.surname := surname;
    Result^.fio.name := name;
    Result^.fio.patronymic := patronymic;
    Result^.group_num := group_num;
    Result^.marks := marks;
end;

procedure AppendNode(
    var first: PNode;
    surname: string;
    name: string;
    patronymic: string;
    group_num: integer;
    marks: array of integer);
begin
    var p := first;
    var res := StudentConstruct(surname, name, patronymic, group_num, marks);
    while (p <> nil) and (p^.next <> nil) do
        p := p^.next;
    if p <> nil then
        p^.next := res
    else
        first := res;
end;

// Вывод записи студента на экран
procedure PrintStudent(stud: Node);
begin
    writeln('Фамилия: ', stud.fio.surname);
    writeln('Имя: ', stud.fio.name);
    writeln('Отчество: ', stud.fio.patronymic);
    writeln('Группа № ', stud.group_num);
    writeln('Оценки: ', stud.marks);
    writeln;
end;

// Вывод списка, на первый элемент которого указывает p.
procedure PrintList(p: PNode);
begin
    while p <> nil do
    begin
        PrintStudent(p^);
        p := p^.next;
    end;
    writeln;
end;

procedure Filter(var p: PNode; mark: integer);
var
    cur := p;
    prev: PNode;
    t: PNode;
begin
    while cur <> nil do
    begin
        if (cur^.marks.sum / length(cur^.marks) < mark) then
        begin
            if (cur = p) then
            begin
                p := cur^.next;
                Dispose(cur);
                cur := p;
            end else begin
                prev^.next := cur^.next;
                t := cur;
                cur := cur^.next;
                Dispose(t);
            end;
        end else begin
            prev := cur;
            cur := cur^.next;
        end;
    end;
end;

procedure Delete(var p: PNode);
begin
    while p <> nil do
    begin
        var t := p;
        p := p^.next;
        Dispose(t);
    end;
end;

procedure SmartInsert(var p: PNode; item: PNode);
var
    cur: PNode;
    prev: PNode;
    group_num := item^.group_num;
    surname := item^.fio.surname;
begin
    if ((p^.group_num > group_num) or ((p^.group_num = group_num) and (p^.fio.surname >= surname))) then
    begin
        item^.next := p;
        p := item;
    end else begin
        cur := p;
        while ((cur <> nil) and (cur^.group_num < group_num)) do
        begin
            prev := cur;
            cur := cur^.next;
        end;
        while ((cur <> nil) and (cur^.fio.surname < surname) and (cur^.group_num = group_num)) do
        begin
            prev := cur;
            cur := cur^.next;
        end;
        if (cur = nil) then
            prev^.next := item
        else begin
            item^.next := cur;
            prev^.next := item;
        end;
    end;
end;



var
    list: PNode; // начало списка
    s: PNode;
    a: array of integer = (0, 0, 0, 0, 0);
    count, group_num: integer;
    surname, name, patronymic: string;
    
begin
    writeln('Введите количество студентов: '); readln(count);
    for i:integer:=0 to count-1 do
    begin
        write('Введите фамилию: ');readln(surname);
        write('Введите имя: ');readln(name);
        write('Введите отчество: ');readln(patronymic);
        write('Введите № группы ');readln(group_num);
        for j:integer:=0 to length(a)-1 do
        begin
            write('Введите оценку №', j+1, ': ');readln(a[j]);
        end;
        if i=0 then
            AppendNode(list, surname, name, patronymic, group_num, Copy(a))
        else begin
            s := StudentConstruct(surname, name, patronymic, group_num, Copy(a));
            SmartInsert(list, s);
        end;
        writeln;
    end;
        
    {a[0] := 3; a[1] := 4; a[2] := 4; a[3] := 4; a[4] := 3;
    AppendNode(list, 'Абрамов', 'Иван', 'Иванович', 1, Copy(a));
    a[0] := 4; a[1] := 4; a[2] := 5; a[3] := 4; a[4] := 3;
    AppendNode(list, 'Борисов', 'Иван', 'Геннадьевич', 2, Copy(a));
    a[0] := 4; a[1] := 4; a[2] := 5; a[3] := 5; a[4] := 5;
    AppendNode(list, 'Васильев', 'Иван', 'Семёнович', 3, Copy(a));
    
    a[0] := 3; a[1] := 3; a[2] := 3; a[3] := 4; a[4] := 5;
    s := StudentConstruct('Булкин', 'Иван', 'Васильевич', 2, Copy(a));
    SmartInsert(list, s);
    a[0] := 5; a[1] := 4; a[2] := 5; a[3] := 4; a[4] := 4;
    s := StudentConstruct('Ааронов', 'Абрам', 'Исаакович', 1, Copy(a));
    SmartInsert(list, s);
    a[0] := 3; a[1] := 3; a[2] := 3; a[3] := 3; a[4] := 4;
    s := StudentConstruct('Громов', 'Филимон', 'Фролович', 3, Copy(a));
    SmartInsert(list, s);}
    
    PrintList(list);
    
    writeln('-------------------------------------');
    writeln('Фильтрация списка по среднему баллу.');
    writeln('-------------------------------------');
    writeln;
    Filter(list, 4);
    PrintList(list);
    
    Delete(list);
end.