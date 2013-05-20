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

