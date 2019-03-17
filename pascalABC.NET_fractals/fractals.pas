unit fractals;

interface

uses GraphABC;

var
    a: real;// глобальная переменная текущего угла

procedure go_forward(len: real; angle: real);// отрисовка прямой заданной длины и заданного наклона
procedure koch(order: integer; size: real);// отрисовка кривой Коха
procedure mink(order: integer; size: real);// отрисовка кривой Минковского
procedure levi(order: integer; size: real);// отрисовка кривой Леви
procedure dragon(order: integer; size: real; dir: char := 'r');// отрисовка кривой дракона
procedure serp(order: integer; size: real; dir: char := 'f');//приближённая отрисовка треугольника Серпинского
procedure chaos_serp(arr: array of integer);//процедура отрисовки ковра Серпинского методом хаоса
procedure chaos_barns(size, padding_left, padding_bottom: integer);//процедура отрисовки папортника Барнсли

implementation

// отрисовка прямой заданной длины и заданного наклона
procedure go_forward;
var
    cur_pos: array[1..2] of integer;
begin
    cur_pos[1] := penx();
    cur_pos[2] := peny();
    lineto(cur_pos[1] + round(len * cos(angle)), cur_pos[2] + round(len * sin(angle)));
end;

// отрисовка кривой Коха
procedure koch;
begin
    if order = 0 then
        go_forward(size, a)
    else
    begin
        koch(order - 1, size / 3);
        a -= Pi / 3;
        koch(order - 1, size / 3);
        a += 2 * Pi / 3;
        koch(order - 1, size / 3);
        a -= Pi / 3;
        koch(order - 1, size / 3);
    end;
end;

// отрисовка кривой Минковского
procedure mink;
begin
    if order = 0 then
        go_forward(size, a)
    else
    begin
        mink(order - 1, size / 8);
        a -= Pi / 2;
        mink(order - 1, size / 8);
        a += Pi / 2;
        mink(order - 1, size / 8);
        a += Pi / 2;
        mink(order - 1, size / 8);
        mink(order - 1, size / 8);
        a -= Pi / 2;
        mink(order - 1, size / 8);
        a -= Pi / 2;
        mink(order - 1, size / 8);
        a += Pi / 2;
        mink(order - 1, size / 8);
    end;
end;

// отрисовка кривой Леви
procedure levi;
begin
    if order = 0 then
        go_forward(size, a)
    else
    begin
        a -= Pi / 4;
        levi(order - 1, size);
        a += Pi / 2;
        levi(order - 1, size);
        a -= Pi / 4;
    end;
end;

// отрисовка кривой дракона
procedure dragon;
begin
    if order = 0 then
        go_forward(size, a)
    else
    begin
        if dir = 'r' then
        begin
            a += Pi / 4;
            dragon(order - 1, size / sqrt(2), 'r');
            a -= Pi / 2;
            dragon(order - 1, size / sqrt(2), 'l');
            a += Pi / 4;
        end
        else
        begin
            a -= Pi / 4;
            dragon(order - 1, size / sqrt(2), 'r');
            a += Pi / 2;
            dragon(order - 1, size / sqrt(2), 'l');
            a -= Pi / 4;
        end;
    end;
end;

//приближённая отрисовка треугольника Серпинского
procedure serp;
begin
    if order = 0 then
        go_forward(size, a)
    else
    begin
        if dir = 'f' then
        begin
            if order mod 2 <> 0 then
                a -= Pi / 3;
            dir := 'r';
        end;
        if dir = 'r' then
        begin
            serp(order - 1, size / 3, 'l');
            a += Pi / 3;
            serp(order - 1, size / 3, 'r');
            a += Pi / 3;
            serp(order - 1, size / 3, 'l');
        end
        else if dir = 'l' then
        begin
            serp(order - 1, size / 3, 'r');
            a -= Pi / 3;
            serp(order - 1, size / 3, 'l');
            a -= Pi / 3;
            serp(order - 1, size / 3, 'r');
        end;
    end;
end;

//процедура отрисовки ковра Серпинского методом хаоса
procedure chaos_serp;
var
    x: integer;
begin
    var center := window.center;
    moveto(center.x, center.y);
    randomize;
    for i: integer := 0 to 100000 do
    begin
        x := (random(round(length(arr) / 2)) + 1) * 2 - 1;
        PutPixel(round((arr[x - 1] + penx()) / 2), round((arr[x] + peny()) / 2), RGB(0, 0, 0));
        MoveTo(round((arr[x - 1] + penx()) / 2), round((arr[x] + peny()) / 2));
    end;
end;

//процедура отрисовки папортника Барнсли
procedure chaos_barns;
begin
    randomize;
    var i: integer;
    var x: real;
    var y: real;
    for j: integer := 0 to 100000 do
    begin
        i := random(100);
        if i in [0] then
        begin
            x := 0;
            y := 0.16 * peny();
        end
        else if i in [1..85] then
        begin
            x := 0.85 * penx() + 0.04 * peny();
            y := -0.04 * penx() + 0.85 * peny() + 1.6;
        end
        else if i in [86..92] then
        begin
            x := 0.2 * penx() - 0.26 * peny();
            y := 0.23 * penx() + 0.22 * peny() + 1.6;
        end
        else if i in [93..99] then
        begin
            x := -0.15 * penx() + 0.28 * peny();
            y := 0.26 * penx() + 0.24 * peny() + 0.44;
        end;
        PutPixel(round(x + padding_left), window.height - round(y + padding_bottom), RGB(0, 100, 0));
        MoveTo(round(x), round(y + size));
    end;
end;

end.
