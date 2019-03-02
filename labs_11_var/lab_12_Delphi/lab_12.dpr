program lab_12;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

// �������� ���� ������ - "�������"
type student=record
  fio: record
    surname: string;
    name: string;
    patronymic: string;
  end;
  group_num: integer;
  marks: array of integer;
end;

// ����� ������ �������� �� �����
procedure print_student(stud:student);
var i: integer;
begin
  writeln('�������: ',stud.fio.surname);
  writeln('���: ',stud.fio.name);
  writeln('��������: ',stud.fio.patronymic);
  writeln('������ � ',stud.group_num);
  writeln('������: ');
  for i:=0 to length(stud.marks)-1 do
  begin
    if i<>0 then
      write(', ');
    write(stud.marks[i]);
  end;
end;

// ������� �������� �������
function avg(arr:array of integer):real;
var sum,i:integer;
begin
  sum:=0;
  for i:=0 to length(arr)-1 do
    sum := sum + arr[i];
  avg:=sum/length(arr);
end;

// ����������� ������ ��������
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

// ��������� ������ ��������
function generate_stud:student;
var i: integer;
    new_stud: student;
    names: array of string;
    surnames: array of string;
    patronymics: array of string;
begin
  names := ['�������', 'ϸ��', '����', '����', '����',
                              '�����', '��������', '��������', '����'];
  surnames := ['������', '������', '�������'];
  patronymics := ['������', '������', '������', '�����������', '�����'];
  new_stud.fio.name := names[random(length(names))];
  if (new_stud.fio.name[new_stud.fio.name.length] = '�') then
    begin
      new_stud.fio.surname := surnames[random(length(surnames))]+'�';
      new_stud.fio.patronymic := patronymics[random(length(patronymics))]+'��';
    end
  else
    begin
      new_stud.fio.surname := surnames[random(length(surnames))];
      new_stud.fio.patronymic := patronymics[random(length(patronymics))]+'��';
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
    // �������� ���������� � ��� �����
    writeln('�������� ���������� � ��� �����:');
    writeln;
    setlength(marks, 5);
    for i := 0 to 4 do
      marks[i] := random(3) + 3;
    stud := student_init('���������', '����', '��������', 5, marks);
    print_student(stud);
    writeln;

    // �������� ������� ����������� � ����� ������ ���, ������� ���� ������� ���������� 4 � �����
    writeln('�������� ������� ����������� � ����� ������ ���, ������� ���� ������� ���������� 4 � �����:');
    writeln;
    len := 5;// ���������� �����������
    setlength(stud_arr, len);
    for i:=0 to len-1 do stud_arr[i]:=generate_stud; // ��������� ������� ���������
    for i:=0 to len-1 do
    begin
      writeln('������� ����: ', avg(stud_arr[i].marks));
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
