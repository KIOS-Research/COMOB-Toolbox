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
function [Eyj Exj] = IsolationThreshold(DA, d, Cofcls, t, DetectionTime, ns, nZones, nsour, C, L, Theta, Ez0, x_hat)

warning off all
inp = ones(1,length(t));

ZITA = x_hat(:,1:nZones)';
if nsour == 1
    Omega = x_hat(:,(nZones+1):(2*nZones))';
    
    Omega_norm = zeros(1,length(t));
    for i=1:length(t)
        Omega_norm(i) = norm(Omega(:,i));
    end
    
else
    for i=1:nsour
        Omega(:,i,:) = x_hat(:,(i*nZones+1):(i*2*nZones))';
    end
    
    Omega_norm = zeros(1,length(t));
    for i=1:length(t)
        Omega_norm(i) = norm(Omega(:,:,i));
    end
    
end

ZITA_norm = sqrt(sum(ZITA'.^2,2));

E1 = Cofcls.rho*exp(-Cofcls.ksi*(t-DetectionTime))*Ez0;

A = [-Cofcls.ksi 0 ; 0 -Cofcls.ksi];
C2 = [Cofcls.rho*DA 0; 0 Cofcls.rho*d*norm(L)];
E = lsim(A, eye(2), C2, zeros(2,2), [ZITA_norm'; inp], t);

Ejt = sum([E'; E1; Omega_norm*Theta])';

sys = tf(Cofcls.rho*DA, [1 Cofcls.ksi-Cofcls.rho*DA]);

Ejda = lsim(sys, Ejt, t);

Exj = Ejt + Ejda;

for j=1:ns
    Ey1(:,j) = Cofcls.alpha(j)*exp(-Cofcls.zita(j)*(t-DetectionTime))*Ez0;
    
    if nsour == 1
        COmega_norm = zeros(1,length(t));
        for i=1:length(t)
            COmega_norm(i) = norm(C(j,:)*Omega(:,i));
        end
    else
        COmega_norm = zeros(1,length(t));
        for i=1:length(t)
            COmega_norm(i) = norm(C(j,:)*Omega(:,:,i));
        end
    end    
    A2 = [-Cofcls.zita(j) 0 0; 0 -Cofcls.zita(j) 0; 0 0 -Cofcls.zita(j)];
    C3 = [Cofcls.alpha(j)*DA 0 0; 0 Cofcls.alpha(j)*DA 0; 0 0 Cofcls.alpha(j)*d*norm(L)];
    Eyj(:,j)= sum([COmega_norm*Theta; Ey1(:,j)'; lsim(A2, eye(3), C3, zeros(3,3), [Exj'; ZITA_norm'; inp], t)'; inp.*d])';    
end
warning on all