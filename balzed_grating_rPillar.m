clear all
n_aSi=3.5;
n_air=1;
lambda=4;%um
f=100;%um
k0=2*pi/lambda;
height=2;%height of silicon pillar 
% load('retardation vs radius for 1um pitch.mat')
%% boundry of zero order
%basic equation: phi(0)=phi(x)+x*sin(theta)*k0
% p=phase_delay_height;

% p=p-p(1);

angle=pi*30/180;%diffraction angle

% R0=max(p)/(k0*sin(angle));
grating_pitch=2*pi/(k0*sin(angle));

%% calculate rPillar
phi=[];
rPillar=[];
cutoff=lambda/n_aSi;%struture cutoff
pillar_pitch=2;%periodity

grating_length=300;%um
grating_width=300;
k=1;

grid_x=0:pillar_pitch:grating_width;
grid_y=0:pillar_pitch:grating_length;
phi=zeros(length(grid_x),length(grid_y));
% phase=x*k0*sin(angle);
% phase=mod(phase,2*pi);
for i=1:1:length(grid_x)
    for j=1:1:length(grid_y)
        x=i*pillar_pitch;
        y=j*pillar_pitch;
        phi(i,:)=mod(x*k0*sin(angle),2*pi)/pi;
%         if phi(i,j)<=0
%             phi(i,j)=0.001;
%         end
        rPillar(i,j)=phi2radius(phi(i,j));
        E(k)=Raith_element('circle',0,[x y],rPillar(i,j),[],60,1);k=k+1;
    end
end

% x_grid=linspace(0,R0,i);
% y_grid=linspace(0,grating_length,j);
% mesh(x,y,phi)
% figure
% mesh(y_grid,x_grid,rPillar)
        
%% GDS generation

name=['RCWA_' 'grating_pitch' num2str(round(grating_pitch))  'angle' num2str(angle*180/pi) '_width' num2str(grating_width) 'length' num2str(grating_length) ];
% cell=size(rPillar);
% k=1;
% 
% for i=1:cell(1)
%     for j=1:cell(2)
%         if rPillar(i,j)~=0
%         E(k)=Raith_element('circle',0,[(i-0.5)*pitch (j-0.5)*pitch],rPillar(i,j),[],60,1.3);k=k+1;
%        end
% axis equal;
% end
% end
% 
E(k)=Raith_element('text',0,[0 -30],5,0,[1 1],name,1.5);
S=Raith_structure(name,E);
clf;
axis equal;
S.plot;
span=Raith_library(name,S);
span.writegds;