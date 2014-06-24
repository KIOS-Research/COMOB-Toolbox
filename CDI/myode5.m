%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or – as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function dy = myode5(t, y, A, L, C, H, xt, gr, time, GAMMA, B, Fj, nsources)

    g = interp1(time,xt,t);
    g2 = interp1(time,gr,t);
    Zones = length(B);  

    dy = zeros(Zones + nsources*Zones+nsources,1); 
    
    for i=1:nsources
        if (0.0001<y(Zones + nsources*Zones+i))||((y(Zones + nsources*Zones+i)==0.0001)&&((-GAMMA*(C*y((i*Zones+1):(i*Zones+Zones)))' * (g' - C*y(1:Zones)))<=0))
            dy(Zones + nsources*Zones+i) =  GAMMA*(C*y((i*Zones+1):(i*Zones+Zones)))' * (g' - C*y(1:Zones));
        else
            dy(Zones + nsources*Zones+i)=0;
        end
        W(1:Zones, i) = y((i*Zones+1):(i*Zones+Zones)) ;
    end
    
    dy(1:Zones) = (A - L*C)*y(1:Zones) + L*g' + W*dy((Zones + nsources*Zones+1):(Zones + nsources*Zones+nsources)) + B*Fj*y((Zones + nsources*Zones+1):(Zones + nsources*Zones+nsources)) + H*g2';

    
    for i=1:nsources
        dy((i*Zones+1):(i*Zones+Zones)) = (A - L*C)*y((i*Zones+1):(i*Zones+Zones)) + B*Fj(1:Zones,i);
    end