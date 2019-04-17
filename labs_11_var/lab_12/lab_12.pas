uses Arrays;

// Создание типа данных - "студент"
type
    student = record
        fio: record
            surname: string;
            name: string;
            patronymic: string;
        end;
        group_num: integer;
        marks: array of integer;
    end;

// Вывод записи студента на экран
procedure print_student(stud: student);
begin
    writeln('Фамилия: ', stud.fio.surname);
    writeln('Имя: ', stud.fio.name);
    writeln('Отчество: ', stud.fio.patronymic);
    writeln('Группа № ', stud.group_num);
    writeln('Оценки: ', stud.marks);
end;

// Генерация записи студента
function generate_stud: student;
var
    new_stud: student;
    names: array of string := ('Василий', 'Пётр', 'Илья', 'Глеб', 'Влад', 
                              'Елена', 'Антонина', 'Алевтина', 'Анна');
    surnames: array of string := ('Иванов', 'Петров', 'Сидоров');
    patronymics: array of string := ('Олегов', 'Иванов', 'Семёнов', 'Александров', 'Юрьев');
begin
    new_stud.fio.name := names[random(names.length)];
    if (new_stud.fio.name[new_stud.fio.name.length] = 'а') then
    begin
        new_stud.fio.surname := surnames[random(surnames.length)] + 'а';
        new_stud.fio.patronymic := patronymics[random(patronymics.length)] + 'на';
    end
    else
    begin
        new_stud.fio.surname := surnames[random(surnames.length)];
        new_stud.fio.patronymic := patronymics[random(patronymics.length)] + 'ич';
    end;
    new_stud.group_num := random(1, 7);
    new_stud.marks := CreateRandomIntegerArray(5, 3, 5);
    generate_stud := new_stud;
end;

// Конструктор записи студента
function student_init(surname, name, patronymic: string; group_num: integer; marks: array of integer): student;
var
    new_stud: student;
begin
    foreach i: char in surname do
        if not i.IsLetter then
            raise new Exception('Фамилия может состоять только из букв!');
    new_stud.fio.surname := surname;
    foreach i: char in name do
        if not i.IsLetter then
            raise new Exception('Имя может состоять только из букв!');
    new_stud.fio.name := name;
    foreach i: char in patronymic do
        if not i.IsLetter then
            raise new Exception('Отчество может состоять только из букв!');
    new_stud.fio.patronymic := patronymic;
    new_stud.group_num := group_num;
    foreach i: integer in marks do
        if not (i in [1..5]) then
            raise new Exception('Оценка может быть только в диапазоне от 1 до 5!');
    new_stud.marks := marks;
    student_init := new_stud;
end;


var
    stud: student;
    aver: real;

begin
    // Создание экземпляра и его вывод
    writeln('Создание экземпляра и его вывод:');
    writeln;
    var marks := Arr(3, 5, 4, 5, 4);
    stud := student_init('Бабасов', 'Илья', 'Олегович', 5, marks);
    print_student(stud);
    writeln;
    
    // Создание массива экземпляров и вывод только тех, средний балл которых составляет 4 и более
    var len := 5;// Количество экземпляров
    var min_avrg := 4;// Минимальный средний балл
    writeln('Создание массива экземпляров и вывод только тех, средний балл которых составляет ', min_avrg, ' и более:');
    writeln;
    var stud_arr := SeqGen(len, x -> generate_stud).ToArray; // генерация массива студентов
    for i: integer := 0 to len - 1 do
    begin
        aver := stud_arr[i].marks.Average;
        println('Средний балл:', aver);
        if aver >= min_avrg then
            print_student(stud_arr[i])
        else
            println('Средний балл ниже минимального.');
        writeln;
    end;
end.