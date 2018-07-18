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

function setDefaultBuildingPropertiesWorkspace(DefaultBuildingProperties_ini)

    DefaultBuildingProperties.AmbientTemperature=DefaultBuildingProperties_ini.AmbientTemperature;
    DefaultBuildingProperties.WindSpeed=DefaultBuildingProperties_ini.WindSpeed;
    DefaultBuildingProperties.WindDirection=DefaultBuildingProperties_ini.WindDirection;
    DefaultBuildingProperties.Temp=DefaultBuildingProperties_ini.Temp;
    DefaultBuildingProperties.ZoneName=DefaultBuildingProperties_ini.ZoneName;
    DefaultBuildingProperties.v=DefaultBuildingProperties_ini.v;
    DefaultBuildingProperties.nZones=DefaultBuildingProperties_ini.nZones;
    DefaultBuildingProperties.Zones=DefaultBuildingProperties_ini.Zones;
    DefaultBuildingProperties.nS=DefaultBuildingProperties_ini.nS;
    DefaultBuildingProperties.Sensors=DefaultBuildingProperties_ini.Sensors;
    DefaultBuildingProperties.nLevel=DefaultBuildingProperties_ini.nLevel;
    DefaultBuildingProperties.nPaths=DefaultBuildingProperties_ini.nPaths;
    DefaultBuildingProperties.Openings=DefaultBuildingProperties_ini.Openings;

    assignin('base','DefaultBuildingProperties',DefaultBuildingProperties)

end
