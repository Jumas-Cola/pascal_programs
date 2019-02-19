var
    X, Y, Z, T: real;
    PX, PY, PZ, PT: ^real;

begin
    PX := @X;
    PY := @Y;
    PZ := @Z;
    PT := @T;
    
    Write('X=');
    Readln(PX^);
    Write('Y=');
    Readln(PY^);
    Write('Z=');
    Readln(PZ^);
    
    if (Min(Min(PX^, PY^), PZ^) < PX^) and (Max(Max(PX^, PY^), PZ^) > PX^) then
        PT^ := PX^
    else if (Min(Min(PX^, PY^), PZ^) < PY^) and (Max(Max(PX^, PY^), PZ^) > PY^) then
        PT^ := PY^
    else if (Min(Min(PX^, PY^), PZ^) < PZ^) and (Max(Max(PX^, PY^), PZ^) > PZ^) then
        PT^ := PZ^
    else
    begin
        writeln('Значения, не являющегося ни минимальным, ни максимальным не существует.');
        exit;
    end;
    
    writeln('Ни минимальным, ни максимальным значением является: ', PT^);
end.