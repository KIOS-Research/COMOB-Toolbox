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
function  CDI0=DefaultParametersCDI

CDI0.choice = 1;
CDI0.Ex0 = 0.1;
CDI0.Ez0 = 0.3;
CDI0.LearningRate = 10e7;
CDI0.Theta = 20;
CDI0.InitialSourceEstimation = 0.05;
CDI0.UncertaintiesBound = 0;
CDI0.NoiseBound = 0;
CDI0.Tolerances.Wd = 0;
CDI0.Tolerances.Ws = 0;
CDI0.Tolerances.Ztemp = 0;
CDI0.Tolerances.PathsOpenings = 0;
CDI0.Tolerances.Iterations = 100;
CDI0.NominalChoice = 1;
CDI0.NominalFile = '';
CDI0.MatricesFile = '';
CDI0.ActiveDistributed = 0;
CDI0.nSub = [];

CDI0.Subsystems{1} = [];
CDI0.SubsystemsData{1}.Ex0 = 0.1;
CDI0.SubsystemsData{1}.Ez0 = 0.3;
CDI0.SubsystemsData{1}.LearningRate = 10e7;
CDI0.SubsystemsData{1}.Theta = 20;
CDI0.SubsystemsData{1}.InitialSourceEstimation = 0.05;
CDI0.SubsystemsData{1}.UncertaintiesBound = 0;
CDI0.SubsystemsData{1}.UncertaintiesBound2 = 0;
CDI0.SubsystemsData{1}.NoiseBound = 0;


