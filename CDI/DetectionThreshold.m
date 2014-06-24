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

function [Ey Initial]= DetectionThreshold(DA, d, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, t, Dt, ns, Ex0, Initial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCTION
%Ey = Detection_Threshold(DA, d, ksi, rho, ksi_d, rho_d, alpha, zita, alpha_d, zita_d, x_hat, t, ns, Ex0)
%Gives the adaptive threshold for Contaminant Detection
%
%INPUT ARGUMENTS:
%   DA:             A real number that gives the bound for Uncertainties.
%   d:              A real number that gives the bound for noise.
%   ksi,rho:        Choosen real numbers parameters which give the bound for
%                   ||expm(A0*t)|| <= rho*exp(-ksi*t).
%   ksi_d,rho_d:    Choosen real numbers parameters which give the bound
%                   for ||expm(A0*t)*L|| <= rho_d*exp(-ksi_d*t).
%   alpha,zita:     1xns vector with choosen parameters for every zone with
%                   sensor which give the bound for ||Ci*expm(A0*t)|| <= 
%                   alpha(j)*exp(-zita(j)*t) (j corresponds to jth zone 
%                   with sensor). 
%   alpha_d,zita_d: 1xns vector with choosen parameters for every zone with
%                   sensor which give the bound for ||Ci*expm(A0*t)*L|| <=    
%                   alpha_d(j)*exp(-zita_d(j)*t) (j corresponding to jth zone
%                   with sensor).
%   x_hat:          TxN matrix which gives the state of the observer whose 
%                   columns are the number of zones and rows correspond to 
%                   the time. 
%   t:              1xT vector correspond to the time step. 
%   ns:             An integer number for the number of sensors.
%
%OUTPUT ARGUMENTS:
%   Ey:             Txns matrix which gives the adaptive threshold for
%                   Detection for each zone that have sensor. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Find the state estimation error threshold Ex.

    warning off all

%     tm = [i-1 i]*stp;    
    parfor j=1:length(t)
        E1(j) = rho*exp(-ksi*t(j))*Ex0;
%         x_hat_norm(j)= norm(x_hat(i+j-1,:)');
    end

    [ass1 bss1 css1 dss1] = tf2ss(rho*DA, [1 ksi]);
    sys1 = ss(ass1, bss1, css1, dss1);

    parfor j=1:ns 
        E1_DA(j,:) = lsim(sys1, abs(x_hat(:,j)), Dt, Initial.E1_DA0(j));        
    end
    Initial.E1_DA0 = E1_DA(:,2)/(rho*DA);
    Initial.E1_DA0(isnan(Initial.E1_DA0)) = 0;
    
    
    [ass2 bss2 css2 dss2] = tf2ss(rho_d*d, [1 ksi_d]);
    sys2 = ss(ass2, bss2, css2, dss2);

    inp = ones(1,2);

    E1_d = lsim(sys2, inp, Dt, Initial.E1_d0);
    Initial.E1_d0 = E1_d(2)/(rho_d*d);
    Initial.E1_d0(isnan(Initial.E1_d0)) = 0;
    
    
    parfor j=1:ns
        E1_t(j,:) = E1 + E1_DA(j,:) + E1_d';
    end

    [ass3 bss3 css3 dss3] = tf2ss(rho*DA, [1 ksi-rho*DA]);
    sys3 = ss(ass3, bss3, css3, dss3);
    
    parfor j=1:ns
        E2_t(j,:) = lsim(sys3, E1_t(j,:), Dt, Initial.E2_t0(j));         
    end
    
    Initial.E2_t0 = E2_t(:,2)/(rho*DA);
    Initial.E2_t0(isnan(Initial.E2_t0)) = 0;    
    
    Ex = E1_t + E2_t;
%% Find the output estimation error threshold Ey.

    parfor k=1:ns
%         for j=1:length(t)
            Ey1(k,:) = alpha(k)*exp(-zita(k).*t)*Ex0;
%         end
    end
    
    parfor j = 1:ns
        [ass4 bss4 css4 dss4] = tf2ss(alpha(j)*DA, [1 zita(j)]);
        sys4 = ss(ass4, bss4, css4, dss4);
        [ass5 bss5 css5 dss5] = tf2ss(alpha_d(j)*d, [1 zita_d(j)]);
        sys5 = ss(ass5, bss5, css5, dss5);
        Ey1DA(j,:) = lsim(sys4, abs(x_hat(:,j)), Dt, Initial.Ey1DA0(j));        
        Ey2DA(j,:) = lsim(sys4, abs(Ex(j,:)), Dt, Initial.Ey2DA0(j));        
        Ey1d(j,:) = lsim(sys5, inp, Dt, Initial.Ey1d0(j));        
    end
    
        Initial.Ey1DA0 = Ey1DA(:,2)./(alpha.*DA)';
        Initial.Ey1DA0(isnan(Initial.Ey1DA0)) = 0;
        Initial.Ey2DA0 = Ey2DA(:,2)./(alpha.*DA)';
        Initial.Ey2DA0(isnan(Initial.Ey2DA0)) = 0;
        Initial.Ey1d0 = Ey1d(:,2)./(alpha_d.*d)';
        Initial.Ey1d0(isnan(Initial.Ey1d0)) = 0;
        
    parfor j = 1:ns
        Ey(j,:) = Ey1(j,:) + Ey1DA(j,:) + Ey2DA(j,:) + Ey1d(j,:) + ones(1,2)*d; 
    end
    
    warning on all