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
function [Ey Ex] = DetectionThreshold(DA, L, d, Cofcls, x_hat, t, ns, Ex0)

%% Find the threshold of state estimation error Ex.
inp = ones(1,length(t));

E1 = Cofcls.rho*exp(-Cofcls.ksi*t)*Ex0;
x_hat_norm = sqrt(sum(x_hat.^2,2));    

A = [-Cofcls.ksi 0; 0 -Cofcls.ksi];
C = [Cofcls.rho*DA 0; 0 Cofcls.rho*d*norm(L)];

E = lsim(A, eye(2), C, zeros(2,2), [x_hat_norm'; inp], t);
E1_t = sum([E'; E1])';

sys = tf(Cofcls.rho*DA, [1 Cofcls.ksi-Cofcls.rho*DA]);

E2_t = lsim(sys, E1_t, t);

Ex = E1_t + E2_t;

%% Find the threshold of ouput estimation error Ey.
for j=1:ns        
    Ey1(:,j) = Cofcls.alpha(j)*exp(-Cofcls.zita(j)*t)*Ex0;
    A2 = [-Cofcls.zita(j) 0 0; 0 -Cofcls.zita(j) 0; 0 0 -Cofcls.zita(j)];
    C2 = [Cofcls.alpha(j)*DA 0 0; 0 Cofcls.alpha(j)*DA 0; 0 0 Cofcls.alpha(j)*d*norm(L)];
    Ey(:,j)= sum([Ey1(:,j)'; lsim(A2, eye(3), C2, zeros(3,3), [x_hat_norm'; Ex'; inp], t)'; inp.*d])';
end


