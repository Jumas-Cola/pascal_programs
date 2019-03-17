uses GraphABC;
uses fractals;

begin
    var center := window.center;
    var size := 300; // длина сегмента
    var order := 5; // порядок рекурсии
    moveto(center.x - 200, center.y - 100); // установка указателя на 100 пикселей выше и на 200 левее центра
    
    a := 0; // начальное значение угла
    // отрисовка трёх кривых Коха под углом в 120 градусов (снежинка Коха)
    koch(order, size);
    a += 2 * Pi / 3;
    koch(order, size);
    a += 2 * Pi / 3;
    koch(order, size);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    
    a := 0; // начальное значение угла
    // отрисовка кривой Минковского
    mink(3, size * 10);
    a += Pi / 2;
    mink(3, size * 10);
    a += Pi / 2;
    mink(3, size * 10);
    a += Pi / 2;
    mink(3, size * 10);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    moveto(center.x + 100, center.y); // установка указателя
    
    a := Pi; // начальное значение угла
    // отрисовка кривой Леви
    levi(9, size / 30);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    
    a := 0; // начальное значение угла
    // отрисовка кривой дракона
    dragon(15, size);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    moveto(center.x - 250, center.y + 200); // установка указателя
    
    a := 0; // начальное значение угла
    // отрисовка треугольника Серпинского
    serp(8, size * 37);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    
    //отрисовка ковра Серпинского методом хаоса
    var arr: array of integer := (center.x, 10, center.x - 200, 400, center.x + 200, 400);
    chaos_serp(arr);
    
    Sleep(1000); // пауза
    ClearWindow(); // очистка окна
    
    //процедура отрисовки папортника Барнсли
    chaos_barns(80, 300, 20);
    CloseWindow(); // закрытие окна
end.