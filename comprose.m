function ho=comprose(x,y,n,w,az,varargin)
%COMPROSE Compass rose plot
%
%       COMPROSE(X,Y,N,W,AZ) adds a compass rose on current axis located at
%       position X,Y with N points (N is 1, 4, 8 or 16), width W (radius)
%       and North pointing to azimuth AZ (in degree, AZ = 0 means an arrow
%       pointing to positive Y-axis direction, rotating clockwise).
%
%       COMPROSE(...,FS) adds Cardinal directions with font size FS.
%
%       COMPROSE(...,'param1',value1,'param2',value2,...) specifies any
%       additionnal properties of the Patch using standard parameter/value
%       pairs. Note that 'FaceColor' concerns only the default black-filled
%       parts of the drawing.
%
%	H=COMPROSE(...) returns a Nx3 matrix of object handles: first column
%	addresses solid filled patches, second column for white patches, third
%	column for Cardinal direction text.
%
%       Examples:
%		comprose(0,0,8,.5,10)
%
%		comprose(2,-1,1,2,0,20,'LineWidth',2,'FaceColor',.5*[1,1,1])
%		
%		h = comprose(1,2.5,16,1,-10);
%		set(h(:,1),'FaceColor',[0,.5,.5],'EdgeColor',.5*[1,1,1])
%		set(h(:,2),'FaceColor',.9*[1,1,1])
%
%       See also PATCH.
%
%	Author: Francois Beauducel <beauducel@ipgp.fr>
%	Created: 2012-06-24

%	Copyright (c) 2012, François Beauducel, covered by BSD License.
%	All rights reserved.
%
%	Redistribution and use in source and binary forms, with or without 
%	modification, are permitted provided that the following conditions are 
%	met:
%
%	   * Redistributions of source code must retain the above copyright 
%	     notice, this list of conditions and the following disclaimer.
%	   * Redistributions in binary form must reproduce the above copyright 
%	     notice, this list of conditions and the following disclaimer in 
%	     the documentation and/or other materials provided with the distribution
%	                           
%	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%	POSSIBILITY OF SUCH DAMAGE.

if nargin < 5
	error('Not enough input arguments.')
end

if nargin > 5 & isnumeric(varargin{1})
	fs = varargin{1};
	varargin = varargin(2:end);
else
	fs = 0;
end

if ~isnumeric(x) | ~isnumeric(y) | ~isnumeric(n) | ~isnumeric(w) | ~isnumeric(az)
	error('X,Y,N,W, and AZ must be numeric.')
end

if all(n ~= [1,4,8,16])
	error('N must be equal to 1, 4, 8 or 16.')
end

hh = [];

for k = n:-1:1
	h = branch(x,y,k,w,az,fs,varargin{:});
	hh = [hh;h];
end

  xr = [x x x];  
  yr =[y+2.5, y, y-2.5];   
%  [THETA,R] = cart2pol(xp,yp); %Convert to polar coordinates
%  THETA=THETA+a_rad; %Add a_rad to theta
%  [xr,yr] = pol2cart(THETA,R); %Convert back to Cartesian coordinates
%  h(4) = plot(xr,yr,'Color','r','LineWidth',2.5);
%Vertices matrix
V=[xr(:) yr(:) zeros(size(yr(:)))];
V_centre=mean(V,1); %Centre, of line
Vc=V-ones(size(V,1),1)*V_centre; %Centering coordinates

 %Angle in degrees
a_rad=((az*pi)./180); %Angle in radians
E=[0  0 a_rad]; %Euler angles for X,Y,Z-axis rotations

%Direction Cosines (rotation matrix) construction
Rx=[1        0        0;...
    0        cos(E(1))  -sin(E(1));...
    0        sin(E(1))  cos(E(1))]; %X-Axis rotation

Ry=[cos(E(2))  0        sin(E(2));...
    0        1        0;...
    -sin(E(2)) 0        cos(E(2))]; %Y-axis rotation

Rz=[cos(E(3))  -sin(E(3)) 0;...
    sin(E(3))  cos(E(3))  0;...
    0        0        1]; %Z-axis rotation

R=Rx*Ry*Rz; %Rotation matrix

Vrc=[R*Vc']'; %Rotating centred coordinates
% Vruc=[R*V']'; %Rotating un-centred coordinates
Vr=Vrc+ones(size(V,1),1)*V_centre; %Shifting back to original location
h1 = plot(Vr(:,1), Vr(:,2),'Color',[255/255, 153/255, 51/255],'LineWidth',2.5);
h2 = plot(Vr(1,1), Vr(1,2), 'o', 'LineWidth',2.5,'MarkerSize',2.5,'MarkerEdgeColor',[255/255, 153/255, 51/255]);
hh = [hh;[h1 h2 h2]];
    


if nargout > 0    
	ho = hh;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function h = branch(x,y,k,w,az,fs,varargin)

cpt = {'S','E','N','W','NE','SE','SW','NW', ...
	'NNE','ENE','ESE','SSE','SSW','WSW','WNW','NNW'};
cph = {'center','left','center','right','left','left','right','right', ...
	'left','left','left','left','right','right','right','right'};
cpv = {'top','middle','bottom','middle','bottom','top','top','bottom', ...
	'bottom','bottom','top','top','top','top','bottom','bottom'};

if k <= 4
	a = (k-1)*90 - 0;
else
	if k <= 8
		a = (k-8)*90 - 45 - az;
		w = w*.8;
		fs = fs*.8;
	else
		a = (k-16)*45 - 22.5 - az;
		w = w*.6;
		fs = fs*.6;
	end
end

r = .15;
xx = w*[0 0 r];
yy = w*[0 1 r];
x1 =  xx*cosd(a) + yy*sind(a);
y1 = -xx*sind(a) + yy*cosd(a);
x2 = -xx*cosd(a) + yy*sind(a);
y2 =  xx*sind(a) + yy*cosd(a);

% r2 = 2;
% x3 =  r2*cosd(-az) + r2*sind(-az);
% y3 = -r2*sind(az) + r2*cosd(az);
% x4 = -r2*cosd(-az) + r2*sind(-az);
% y4 =  r2*sind(az) + r2*cosd(az);

% r2 = 2;
% x3 =  x*cosd(az) - (y+2)*sind(az);
% y3 =  x*sind(az) + (y+2)*cosd(az);
% x4 =  x*cosd(az+90) - (y-2)*sind(az+90);
% y4 =  x*sind(az+90) + (y-2)*cosd(az+90);
  



h(1) = patch(x1 + x,y1 + y,'k',varargin{:});
h(2) = patch(x2 + x,y2 + y,'k',varargin{:},'FaceColor','w');
% h(4) = line([x , x ],[y+2 ,y-2],'Color','r','LineWidth',2.5);
% Cardinal points
xp = 1.03*x1(2) + x;
yp = 1.03*y1(2) + y;
h(3) = text(xp,yp,cpt{k}, ...
	'HorizontalAlignment',cph{k},'VerticalAlignment',cpv{k},'Rotation',0);
if fs > 0
	set(h(3),'FontSize',fs','FontWeight','bold')
else
	set(h(3),'Visible','off')
end

