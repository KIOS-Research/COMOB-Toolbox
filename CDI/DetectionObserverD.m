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
function dx = DetectionObserverD(t, x, Acls, Lcls, Hcls, Ccls, Subsystems, sensors, IntCon, nSub, nZones, ysen, time)

y = interp1q(time',ysen',t);

dx = zeros(nZones,1); 

for i=1:nSub
    [r b] = ismember(Subsystems{1,i},sensors);
    [r c v ]=find(b);
    [r b] = ismember(IntCon{i},sensors);
    [r c v1]=find(b);
    dx(Subsystems{1,i}) = Acls{i}.A*x(Subsystems{1,i}) + Lcls{i}.L*(y(v)'-Ccls{i}.C*x(Subsystems{1,i})) + Hcls{i}.H*y(v1)';
end