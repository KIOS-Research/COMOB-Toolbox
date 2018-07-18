%{
 Copyright (c) 2018 KIOS Research and Innovation Centre of Excellence
 (KIOS CoE), University of Cyprus (www.kios.org.cy)
 
 Licensed under the EUPL, Version 1.1 or – as soon they will be approved 
 by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 
 You may obtain a copy of the Licence at: https://joinup.ec.europa.eu/collection/eupl/eupl-text-11-12
 
 Unless required by applicable law or agreed to in writing, software distributed
 under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
 
 Author(s)     : Marinos Christoloulou, Marios Kyriakou and Alexis Kyriacou
 
 Work address  : KIOS Research Center, University of Cyprus
 email         : akyria09@ucy.ac.cy (Alexis Kyriacou)
 Website       : http://www.kios.ucy.ac.cy
 
 Last revision : June 2018
%}
function dx = IsolationObserver(t, x, A, L, C, nZones, ysen, time, GAMMA, B, Fj, nsources)


% y = interp1(time',ysen',t);
y = interp1q(time',ysen',t);
% y = pchip(time',ysen',t);

dx = zeros(nZones + nsources*nZones+nsources,1); 

for i=1:nsources
    if (0<x(nZones + nsources*nZones+i))||((x(nZones + nsources*nZones+i)==0)&&((GAMMA*(C*x((i*nZones+1):(i*nZones+nZones)))' * (y' - C*x(1:nZones)))>=0))
        dx(nZones + nsources*nZones+i) =  GAMMA*(C*x((i*nZones+1):(i*nZones+nZones)))' * (y' - C*x(1:nZones));
    else
        dx(nZones + nsources*nZones+i)=0;
    end
    W(1:nZones, i) = x((i*nZones+1):(i*nZones+nZones));
end

dx(1:nZones) = (A - L*C)*x(1:nZones) + L*y' + W*dx((nZones + nsources*nZones+1):(nZones + nsources*nZones+nsources)) + B*Fj*x((nZones + nsources*nZones+1):(nZones + nsources*nZones+nsources));
    
for i=1:nsources
    dx((i*nZones+1):(i*nZones+nZones)) = (A - L*C)*x((i*nZones+1):(i*nZones+nZones)) + B*Fj(1:nZones,i);
end


