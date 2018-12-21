uses GraphABC;

var a:real; // глобальная переменная текущего угла

// отрисовка прямой заданной длины и заданного наклона
procedure go_forward(len:real; angle:real);
  var cur_pos:array[1..2] of integer;
  begin
    cur_pos[1]:=penx();
    cur_pos[2]:=peny();
    lineto(cur_pos[1]+round(len*cos(angle)), cur_pos[2]+round(len*sin(angle)));
  end;

// отрисовка кривой Коха
procedure koch(order:integer; size:real);
  begin
  if order=0 then
    go_forward(size, a)
  else
    begin
      koch(order-1, size/3);
      a-=Pi/3;
      koch(order-1, size/3);
      a+=2*Pi/3;
      koch(order-1, size/3);
      a-=Pi/3;
      koch(order-1, size/3);
    end;
  end;

// отрисовка кривой Минковского
procedure mink(order:integer; size:real);
  begin
  if order=0 then
    go_forward(size, a)
  else
    begin
      mink(order-1, size/8);
      a-=Pi/2;
      mink(order-1, size/8);
      a+=Pi/2;
      mink(order-1, size/8);
      a+=Pi/2;
      mink(order-1, size/8);
      mink(order-1, size/8);
      a-=Pi/2;
      mink(order-1, size/8);
      a-=Pi/2;
      mink(order-1, size/8);
      a+=Pi/2;
      mink(order-1, size/8);
    end;
  end;

// отрисовка кривой Леви
procedure levi(order:integer; size:real);
  begin
  if order=0 then
    go_forward(size, a)
  else
    begin
      a-=Pi/4;
      levi(order-1, size);
      a+=Pi/2;
      levi(order-1, size);
      a-=Pi/4;
    end;
  end;
  
// отрисовка кривой дракона
procedure dragon(order:integer; size:real; dir:char:='r');
  begin
  if order=0 then
    go_forward(size, a)
  else
    begin
      if dir='r' then
        begin
          a+=Pi/4;
          dragon(order-1, size/sqrt(2), 'r');
          a-=Pi/2;
          dragon(order-1, size/sqrt(2), 'l');
          a+=Pi/4;
        end
      else
        begin
          a-=Pi/4;
          dragon(order-1, size/sqrt(2), 'r');
          a+=Pi/2;
          dragon(order-1, size/sqrt(2), 'l');
          a-=Pi/4;
        end;
    end;
  end;

// отрисовка треугольника Серпинского
procedure serp(order:integer; size:real; dir:char:='f');
  begin
  if order=0 then
    go_forward(size, a)
  else
    begin
      if dir='f' then
        begin
          if order mod 2<>0 then
            a-=Pi/3;
          dir:='r';
        end;
      if dir='r' then
        begin
          serp(order-1, size/3, 'l');
          a+=Pi/3;
          serp(order-1, size/3, 'r');
          a+=Pi/3;
          serp(order-1, size/3, 'l');
        end
      else if dir='l' then
        begin
          serp(order-1, size/3, 'r');
          a-=Pi/3;
          serp(order-1, size/3, 'l');
          a-=Pi/3;
          serp(order-1, size/3, 'r');
        end;
    end;
  end;

//процедура отрисовки ковра Серпинского методом хаоса
procedure chaos_serp(a:array of integer);
var x:integer;
begin
var center := window.center;
moveto(center.x, center.y);
randomize;
for i:integer:=0 to 100000 do
  begin
    x:=(random(round(length(a)/2))+1)*2-1;
    PutPixel(round((a[x-1]+penx())/2), round((a[x]+peny())/2), RGB(0,0,0));
    MoveTo(round((a[x-1]+penx())/2), round((a[x]+peny())/2));
  end;
end;

//процедура отрисовки папортника Барнсли
procedure chaos_barns(size,padding_left,padding_bottom:integer);
begin
randomize;
var i:integer;
var x:real;
var y:real;
for j:integer:=0 to 100000 do
  begin
    i:=random(100);
    if i in [0] then
      begin
        x := 0;
        y := 0.16*peny();
      end
    else if i in [1..85] then
      begin
        x := 0.85*penx() + 0.04*peny();
        y := -0.04*penx() + 0.85*peny() + 1.6;
      end
    else if i in [86..92] then
      begin
        x := 0.2*penx() - 0.26*peny();
        y := 0.23*penx() + 0.22*peny() + 1.6;
      end
    else if i in [93..99] then
      begin
        x := -0.15*penx() + 0.28*peny();
        y := 0.26*penx() + 0.24*peny() + 0.44;
      end;
    PutPixel(round(x+padding_left), window.height-round(y+padding_bottom), RGB(0,100,0));
    MoveTo(round(x), round(y+size));
  end;
end;

begin
  var center:=window.center;
  var size:=300; // длина сегмента
  var order:=5; // порядок рекурсии
  moveto(center.x-200, center.y-100); // установка указателя на 100 пикселей выше и на 200 левее центра
  
  a:=0; // начальное значение угла
  // отрисовка трёх кривых Коха под углом в 120 градусов (снежинка Коха)
  koch(order,size);
  a+=2*Pi/3;
  koch(order,size);
  a+=2*Pi/3;
  koch(order,size);
  
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
  
  a:=0; // начальное значение угла
  // отрисовка кривой Минковского
  mink(3,size*10);
  a+=Pi/2;
  mink(3,size*10);
  a+=Pi/2;
  mink(3,size*10);
  a+=Pi/2;
  mink(3,size*10);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    moveto(center.x+100, center.y); // установка указателя
  
  a:=Pi; // начальное значение угла
  // отрисовка кривой Леви
  levi(9,size/30);
  
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
  
  a:=0; // начальное значение угла
  // отрисовка кривой дракона
  dragon(15,size);
  
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    moveto(center.x-250, center.y+200); // установка указателя
  
  a:=0; // начальное значение угла
  // отрисовка треугольника Серпинского
  serp(8,size*37);
  
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
  
  //отрисовка ковра Серпинского методом хаоса
  var arr: array of integer := (center.x, 10, center.x-200, 400, center.x+200, 400);
  chaos_serp(arr);
  
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    
  //процедура отрисовки папортника Барнсли
  chaos_barns(80,300,20);
end.