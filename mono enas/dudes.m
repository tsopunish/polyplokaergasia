function [ Npef, Npec,room ] = dudes(room,x,y)
State=zeros(9,15);
RI=5.558;
RE=5.853;

Npef=zeros(1,3);
Npec=zeros(1,3);


State=5+rand(9,15);
for i=1:x-2
    for j=1:15
        if State(i,j)<RI && room(i,j)~=4 && room(i,j)~=3
            room(i,j)=2;
            Npef(1)=Npef(1)+1;
        elseif State(i,j)<RE && room(i,j)~=4
            room(i,j)=3;
            Npef(2)=Npef(2)+1;
        else
            room(i,j)=4;
            Npef(3)=Npef(3)+1;
        end
    end
end

if x~=1
i=x-1;
for j=[1:y-2 y+2:15]
        if State(i,j)<RI && room(i,j)~=4 && room(i,j)~=3
            room(i,j)=2;
            Npef(1)=Npef(1)+1;
        elseif State(i,j)<RE && room(i,j)~=4
            room(i,j)=3;
            Npef(2)=Npef(2)+1;
        else
            room(i,j)=4;
            Npef(3)=Npef(3)+1;
        end
end
end
if y==1
    for j=y:y+1
        if State(x-1,j)<RI && room(x-1,j)~=4 && room(x-1,j)~=3
            room(x-1,j)=2;
            Npec(1)=Npec(1)+1;
        elseif State(x-1,j)<RE && room(x-1,j)~=4
            room(x-1,j)=3;
            Npec(2)=Npec(2)+1;
        else
            room(x-1,j)=4;
            Npec(3)=Npec(3)+1;
        end
    end 
    if State(x,y+1)<RI && room(x,y+1)~=4 && room(x,y+1)~=3
        room(x,y+1)=2;
        Npef(1)=Npef(1)+1;
    elseif State(x,y+1)<RE && room(x,y+1)~=4
        room(x,y+1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y+1)=4;
        Npef(3)=Npef(3)+1;
    end
    
elseif y==15 
    for j=y-1:y
        State=5+rand(9,15);
        if State(x-1,j)<RI && room(x-1,j)~=4 && room(x-1,j)~=3
            room(x-1,j)=2;
            Npec(1)=Npec(1)+1;
        elseif State(x-1,j)<RE && room(x-1,j)~=4
            room(x-1,j)=3;
            Npec(2)=Npec(2)+1;
        else
            room(x-1,j)=4;
            Npec(3)=Npec(3)+1;
        end
    end
    if State(x,y-1)<RI && room(x,y-1)~=4 && room(x,y-1)~=3
        room(x,y-1)=2;
        Npef(1)=Npef(1)+1;
    elseif State(x,y-1)<RE && room(x,y-1)~=4
        room(x,y-1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y-1)=4;
        Npef(3)=Npef(3)+1;
    end
    
elseif x==1 
    if State(x,y+1)<RI && room(x,y+1)~=4 && room(x,y+1)~=4
        room(x,y+1)=2;
        Npef(1)=Npef(1)+1;
    elseif State(x,y+1)<RE && room(x,y+1)~=4
        room(x,y+1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y+1)=4;
        Npef(3)=Npef(3)+1;
    end
    if State(x,y-1)<RI && room(x,y-1)~=4 && room(x,y-1)~=3
        room(x,y-1)=2; 
        Npef(1)=Npef(1)+1;
    elseif State(x,y-1)<RE && room(x,y-1)~=4
        room(x,y-1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y-1)=4;
        Npef(3)=Npef(3)+1;
    end
else
    for j=y-1:y+1
        if State(x-1,j)<RI && room(x-1,j)~=4 && room(x-1,j)~=3
            room(x-1,j)=2;
            Npec(1)=Npec(1)+1;
        elseif State(x-1,j)<RE && room(x-1,j)~=4
            room(x-1,j)=3;
            Npec(2)=Npec(2)+1;
        else
            room(x-1,j)=4;
            Npec(3)=Npec(3)+1;
        end
    end
    if State(x,y+1)<RI && room(x,y+1)~=4 && room(x,y+1)~=4
        room(x,y+1)=2;
        Npef(1)=Npef(1)+1;
    elseif State(x,y+1)<RE && room(x,y+1)~=4
        room(x,y+1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y+1)=4;
        Npef(3)=Npef(3)+1;
    end 
    if State(x,y-1)<RI && room(x,y-1)~=4 && room(x,y-1)~=3
        room(x,y-1)=2;
        Npef(1)=Npef(1)+1;
    elseif State(x,y-1)<RE && room(x,y-1)~=4
        room(x,y-1)=3;
        Npef(2)=Npef(2)+1;
    else
        room(x,y-1)=4;
        Npef(3)=Npef(3)+1;
    end
end



