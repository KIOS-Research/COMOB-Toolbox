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
function [Ey Ex] = DetectionThresholdD(CDI, Lcls, Hcls, Cofcls, Subsystems, sensors, IntCon, x_hat, t, nSub, ns, y)

inp = ones(1,length(t));

for i = 1:nSub
    E1{i} = Cofcls{i}.rho*exp(-Cofcls{i}.ksi*t)*CDI{i}.Ex0;
    x_hat_norm{i} = sqrt(sum(x_hat(:,Subsystems{1,i}).^2,2));    
    [r b] = ismember(IntCon{i},sensors);
    [r c v]=find(b);
    y_IntCon{i} = sqrt(sum(y(v,:)'.^2,2)); 
    
    A = [-Cofcls{i}.ksi 0 0 0; 
         0 -Cofcls{i}.ksi 0 0; 
         0 0  -Cofcls{i}.ksi 0; 
         0 0 0 -Cofcls{i}.ksi];
     
    C = [Cofcls{i}.rho*CDI{i}.UncertaintiesBound 0 0 0; 
         0 Cofcls{i}.rho*CDI{i}.NoiseBound*norm(Lcls{i}.L) 0 0; 
         0 0 Cofcls{i}.rho*norm(Hcls{i}.H) 0; 
         0 0 0 Cofcls{i}.rho*CDI{i}.UncertaintiesBound2];
     
    E{i} = lsim(A, eye(4), C, zeros(4,4), ...
               [x_hat_norm{i}'; inp; ones(1,length(t)).*CDI{i}.NoiseBound; y_IntCon{i}'], t);
           
    E1_t{i} = sum([E{i}'; E1{i}])';
    
    sys{i} = tf(Cofcls{i}.rho*CDI{i}.UncertaintiesBound, ...
               [1 Cofcls{i}.ksi-Cofcls{i}.rho*CDI{i}.UncertaintiesBound]);
           
           
    E2_t{i} = lsim(sys{i}, E1_t{i}, t);
    Ex{i} = E1_t{i} + E2_t{i};
    
    for j=1:ns(i)        
        Ey1{i}(:,j) = Cofcls{i}.alpha(j)*exp(-Cofcls{i}.zita(j)*t)*CDI{i}.Ex0;
        A2 = [-Cofcls{i}.zita(j) 0 0 0 0; 
               0 -Cofcls{i}.zita(j) 0 0 0; 
               0 0 -Cofcls{i}.zita(j) 0 0; 
               0 0 0 -Cofcls{i}.zita(j) 0; 
               0 0 0 0 -Cofcls{i}.zita(j)];
           
        C2 = [Cofcls{i}.alpha(j)*CDI{i}.UncertaintiesBound 0 0 0 0; 
              0 Cofcls{i}.alpha(j)*CDI{i}.UncertaintiesBound 0 0 0; 
              0 0 Cofcls{i}.alpha(j)*CDI{i}.NoiseBound*norm(Lcls{i}.L) 0 0; 
              0 0 0 Cofcls{i}.alpha(j)*norm(Hcls{i}.H) 0; 
              0 0 0 0 Cofcls{i}.alpha(j)*CDI{i}.UncertaintiesBound2];
          
        Ey{i}(:,j)= sum([Ey1{i}(:,j)'; ...
                        lsim(A2, eye(5), C2, zeros(5,5), ...
                        [x_hat_norm{i}'; Ex{i}'; inp; ones(1,length(t)).*CDI{i}.NoiseBound; y_IntCon{i}'], t)'; ones(1,length(t)).*CDI{i}.NoiseBound])';
    end
end