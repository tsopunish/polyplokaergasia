function M = printroom( room )
    cm = [1,1,1; 0,0,0; 0,1,0; 1,0,0; 0,0,1];
        
    M=zeros(21,33);
    k=3;
    l=3;
    for i=1:9
        for j=1:15     
            M(k,l)=room(i,j);
            l=l+2;
        end
        l=3;
        k=k+2;
    end
    
    imshow(M,cm,'InitialMagnification','fit');
    pause(0.2);

end

