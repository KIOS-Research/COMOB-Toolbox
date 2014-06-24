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

function dx = myode23(t, x, A01, L1, H1, A02, L2, H2, A03, L3, H3, zn1, izn1, zn2, izn2, zn3, izn3, xt, time)

    g = interp1(time,xt',t);
    
    dx = zeros(14,1); 
    
    dx(1:5) = A01*x(1:5) + L1*g(zn1)' + H1*g(izn1)';
        
    dx(6:10) = A02*x(6:10) + L2*g(zn2)' + H2*g(izn2)';
        
    dx(11:14) = A03*x(11:14) + L3*g(zn3)' + H3*g(izn3)';
    
    
    
    
        

