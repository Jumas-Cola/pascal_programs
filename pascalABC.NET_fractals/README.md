fractals PascalABC.NET
======
**fractals PascalABC.NET** – процедуры для отрисовки фрактальных кривых  

  
Кривая Коха
------------
![Кривая Коха](https://pp.userapi.com/c830401/v830401701/18d15f/0vJ5O3PDuIY.jpg)

```pascal
...
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
...

```
  
Кривая Минковского
------------
![Кривая Минковского](https://pp.userapi.com/c830401/v830401701/18d16f/a6OGScnigcE.jpg)

```pascal
...
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
...

```
  
Кривая Леви
------------
![Кривая Леви](https://pp.userapi.com/c830401/v830401701/18d167/NU_qfOInYUo.jpg)

```pascal
...
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
...

```
  
Кривая дракона
------------
![Кривая дракона](https://pp.userapi.com/c830401/v830401701/18d177/tw1RlI4g_sM.jpg)

```pascal
...
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
...

```
  
Треугольник Серпинского
------------
![Треугольник Серпинского](https://pp.userapi.com/c851520/v851520456/1a159/vsGzJbA6VjU.jpg)

```pascal
...
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
...

```
  
Треугольник Серпинского методом хаоса
------------
![Треугольник Серпинского](https://pp.userapi.com/c845124/v845124698/110157/A3UmPD6f7Og.jpg)

```pascal
...
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
...

```
  
Папоротник Барнсли методом хаоса
------------
![Папоротник Барнсли](https://pp.userapi.com/c845124/v845124698/11015f/7HUGxpKrANc.jpg)

```pascal
...
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
...

```