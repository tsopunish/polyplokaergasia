function [ R ] = Risk( Npef, Npec, t )

%Table 2 values
RI    = 5.558;
RE    = 5.953;
Cca   = 0.343;
Cspef = 0.245;
Cspec = 1.02;
Cspg  = 0.177;
A     = 0.1;


R = exp(Cca*t) + Cspef*((Npef(3)+Npef(2))/(Npef(1)+Npef(3)+Npef(2)))^A + Cspec*((Npec(3)+Npec(2))/(Npec(1)+Npec(3)+Npec(2)))^A ;

end

