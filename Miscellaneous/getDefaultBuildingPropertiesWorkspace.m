function [DefaultBuildingProperties]=getDefaultBuildingPropertiesWorkspace()
        
        try            
            DefaultBuildingProperties = evalin('base', 'DefaultBuildingProperties');
        catch
            DefaultBuildingProperties=[];
        end
end
