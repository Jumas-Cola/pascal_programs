program lab_12;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// Создание типа данных - "студент"
type student=record
  fio: record
    surname: string;
    name: string;
    patronymic: string;
  end;
  group_num: integer;
  marks: array of integer;
end;

// Вывод записи студента на экран
procedure print_student(stud:student);
var i: integer;
begin
  writeln('Фамилия: ',stud.fio.surname);
  writeln('Имя: ',stud.fio.name);
  writeln('Отчество: ',stud.fio.patronymic);
  writeln('Группа № ',stud.group_num);
  writeln('Оценки: ');
  for i:=0 to length(stud.marks)-1 do
  begin
    if i<>0 then
      write(', ');
    write(stud.marks[i]);
  end;
end;

// Среднее значение массива
function avg(arr:array of integer):real;
var sum,i:integer;
begin
  sum:=0;
  for i:=0 to length(arr)-1 do
    sum := sum + arr[i];
  avg:=sum/length(arr);
end;

// Конструктор записи студента
function student_init(surname,name,patronymic:string; group_num:integer; marks:array of integer):student;
var new_stud : student;
    i: integer;
begin
  new_stud.fio.surname:=surname;
  new_stud.fio.name:=name;
  new_stud.fio.patronymic:=patronymic;
  new_stud.group_num:=group_num;
  setlength(new_stud.marks, 5);
  for i:=0 to length(marks)-1 do
    new_stud.marks[i]:=marks[i];
  student_init:=new_stud;
end;

// Генерация записи студента
function generate_stud:student;
var i: integer;
    new_stud: student;
    names: array of string;
    surnames: array of string;
    patronymics: array of string;
begin
  names := ['Василий', 'Пётр', 'Илья', 'Глеб', 'Влад',
                              'Елена', 'Антонина', 'Алевтина', 'Анна'];
  surnames := ['Иванов', 'Петров', 'Сидоров'];
  patronymics := ['Олегов', 'Иванов', 'Семёнов', 'Александров', 'Юрьев'];
  new_stud.fio.name := names[random(length(names))];
  if (new_stud.fio.name[new_stud.fio.name.length] = 'а') then
    begin
      new_stud.fio.surname := surnames[random(length(surnames))]+'а';
      new_stud.fio.patronymic := patronymics[random(length(patronymics))]+'на';
    end
  else
    begin
      new_stud.fio.surname := surnames[random(length(surnames))];
      new_stud.fio.patronymic := patronymics[random(length(patronymics))]+'ич';
    end;
  new_stud.group_num := random(8)+1;
  setlength(new_stud.marks, 5);
  for i := 0 to 4 do
      new_stud.marks[i] := random(3) + 3;
  generate_stud := new_stud;
end;

var marks: array of integer;
    i: integer;
    stud: student;
    len: integer;
    stud_arr : array of student;
begin
  try
    randomize;
    // Создание экземпляра и его вывод
    writeln('Создание экземпляра и его вывод:');
    writeln;
    setlength(marks, 5);
    for i := 0 to 4 do
      marks[i] := random(3) + 3;
    stud := student_init('Балабасов', 'Илья', 'Олегович', 5, marks);
    print_student(stud);
    writeln;

    // Создание массива экземпляров и вывод только тех, средний балл которых составляет 4 и более
    writeln('Создание массива экземпляров и вывод только тех, средний балл которых составляет 4 и более:');
    writeln;
    len := 5;// Количество экземпляров
    setlength(stud_arr, len);
    for i:=0 to len-1 do stud_arr[i]:=generate_stud; // генерация массива студентов
    for i:=0 to len-1 do
    begin
      writeln('Средний балл: ', avg(stud_arr[i].marks));
      if avg(stud_arr[i].marks)>4 then
        print_student(stud_arr[i]);
      writeln;
      writeln;
    end;
    readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
