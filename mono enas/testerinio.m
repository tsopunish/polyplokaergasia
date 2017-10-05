clear;
clc;

RI    = 5.558;
RE    = 5.953;
room = 2*ones(9,15);  
printroom(room);
pause(0.1);
x=randi([1 9]);
y=randi([1 15]);
room(x,y)=5;
printroom(room);
pause(0.1);
D=135;
temp = room(1:x-1,:);
if (y==1)||(y==15) 
    far=sum(temp(temp==2))*0.5-2;
elseif x==1
    far=0;
else 
    far=sum(temp(temp==2))*0.5 -3;
end

if (y==1)||(y==15)
    close=3;
elseif x==1 
    close=2;
else
    close=5;
end




R=0;  

for t=0:0.1:10 
    [Npef, Npec,room] = dudes(room,x,y);
    R = Risk(Npef,Npec,t);
    if R<RI
       room(x,y)=5;
    elseif R<RE
       room(x,y)=6;
       fprintf(' katalave oti tha ton piei %fs \n', t);
    else
       room(x,y)=7;
       printroom(room);
       pause(0.1);
       fprintf(' pa na fygei %fs \n', t);
       break;
    end
    printroom(room);
    pause(0.1);
    
end;
    





