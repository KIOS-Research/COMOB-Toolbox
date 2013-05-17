function dy = myode(t, y, A, L, C, xt, time, GAMMA, B, Fj)

    g = interp1(time,xt,t);
    Zones = length(B);
    dy = zeros(2*Zones+1,1); 

    if (y(2*Zones+1)<0.0001)        
        y(2*Zones+1)=0;
        dy(2*Zones+1)=0;
    else
        dy(2*Zones+1) =  GAMMA*(C*y(Zones+1:2*Zones))' * (g' - C*y(1:Zones));
    end

    dy(1:Zones) = (A - L*C)*y(1:Zones) + L*g' + y(Zones+1:2*Zones)*dy(2*Zones+1) + B*Fj*y(2*Zones+1) ;

    dy(Zones+1:2*Zones) = (A - L*C)*y(Zones+1:2*Zones) + B*Fj;

