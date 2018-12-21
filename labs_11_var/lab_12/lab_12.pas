uses Arrays;

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
begin
  writeln('Фамилия: ',stud.fio.surname);
  writeln('Имя: ',stud.fio.name);
  writeln('Отчество: ',stud.fio.patronymic);
  writeln('Группа № ',stud.group_num);
  writeln('Оценки: ',stud.marks);
end;

// Генерация записи студента
function generate_stud:student;
var new_stud : student;
    names: array of string := ('Василий', 'Пётр', 'Илья', 'Глеб', 'Влад', 
                              'Елена', 'Антонина', 'Алевтина', 'Анна');
    surnames: array of string := ('Иванов', 'Петров', 'Сидоров');
    patronymics: array of string := ('Олегов', 'Иванов', 'Семёнов', 'Александров', 'Юрьев');
begin
  new_stud.fio.name := names[random(names.length)];
  if (new_stud.fio.name[new_stud.fio.name.length] = 'а') then
    begin
      new_stud.fio.surname := surnames[random(surnames.length)]+'а';
      new_stud.fio.patronymic := patronymics[random(patronymics.length)]+'на';
    end
  else
    begin
      new_stud.fio.surname := surnames[random(surnames.length)];
      new_stud.fio.patronymic := patronymics[random(patronymics.length)]+'ич';
    end;
  new_stud.group_num := random(8)+1;
  new_stud.marks := CreateRandomIntegerArray(5,3,5);
  generate_stud := new_stud;
end;

// Среднее значение массива
function avg(arr:array of integer):real;
var sum:=0;
begin
  foreach i:integer in arr do
    sum+=i;
  avg:=sum/arr.length;
end;

// Конструктор записи студента
function student_init(surname,name,patronymic:string; group_num:integer; marks:array of integer):student;
var new_stud : student;
begin
  new_stud.fio.surname:=surname;
  new_stud.fio.name:=name;
  new_stud.fio.patronymic:=patronymic;
  new_stud.group_num:=group_num;
  new_stud.marks:=marks;
  student_init:=new_stud;
end;


var
stud_arr : array of student;
stud : student;

begin
// Создание экземпляра и его вывод
writeln('Создание экземпляра и его вывод:');
writeln;
var marks: array of integer := (3,5,4,5,4);
stud := student_init('Балабасов', 'Илья', 'Олегович', 5, marks);
print_student(stud);
writeln;

// Создание массива экземпляров и вывод только тех, средний балл которых составляет 4 и более
writeln('Создание массива экземпляров и вывод только тех, средний балл которых составляет 4 и более:');
writeln;
var len := 5;// Количество экземпляров
setlength(stud_arr, len);
for i:integer:=0 to len-1 do stud_arr[i]:=generate_stud; // генерация массива студентов
for i:integer:=0 to len-1 do
  begin
    writeln('Средний балл: ', avg(stud_arr[i].marks));
    if avg(stud_arr[i].marks)>=4 then
      print_student(stud_arr[i]);
    writeln;
  end;
end.