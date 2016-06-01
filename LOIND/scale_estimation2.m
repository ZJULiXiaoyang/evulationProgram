%%%This function is mainly to estimate the radius of the patch to be described
%%%INPUT
%%%pointcloud---the pointcloud of the patch to be described
%%%interestpoint---the keypoint
%%%exradius---the empirical equation result
%%%OUTPUT
%%%radius---the estimated radius
function [radius ] = scale_estimation2(pointcloud,interestpoint,exradius)
average=mean(pointcloud);
dz=pointcloud(:,3)-average(1,3);
[row]=find(abs(dz)>0.1);%%%get rid of the points which are far away from the interesting point
pointcloud(row,:)=[];


if size(pointcloud)<20%%%if the pointcloud is vary sparse, we keep on the empirical equation result
    radius=exradius;
    return
end
normal = fitNormal(pointcloud, interestpoint,false);
%%%fit a plane P :Ax+By+Cz+D=0
A=normal(1,1);
B=normal(2,1);
C=normal(3,1);
D=-(interestpoint*normal);
%  [x,y]=meshgrid((average(1,1)-0.2):0.01:(average(1,1)+0.2),(average(1,2)-0.2):0.01:(average(1,2)+0.2));
%  z=-(A*x+B*y+D)/C;
%  mesh(x,y,z);
%  xlabel('{\itx}/m')
%  ylabel('{\ity}/m')
%  zlabel('{\itz}/m')
pointcloud=[pointcloud,ones(size(pointcloud,1),1)];
P=pointcloud*[A,B,C,D]';
Q=A^2+B^2+C^2;
distance=abs(P)/sqrt(Q);
b=max(distance);%%%select the max distance to the plane P  as b

%%%%%project all the points to the plane P
K=-P/Q;
point(:,1)=pointcloud(:,1)+K*A;
point(:,2)=pointcloud(:,2)+K*B;
point(:,3)=pointcloud(:,3)+K*C;

%%%%build a 2-d coordinate system in the plane P
p1=[0,0,-D/C];
p1p0=p1-interestpoint;
p1p0=p1p0/norm(p1p0);%%%x axis
p2p0=cross(p1p0,normal);%%% y axis
% plot3([interestpoint(1,1),interestpoint(1,1)+p1p0(1,1)],[interestpoint(1,2),interestpoint(1,2)+p1p0(1,2)],[interestpoint(1,3),interestpoint(1,3)+p1p0(1,3)],'r-','LineWidth',3);
% hold on;
% plot3([interestpoint(1,1),interestpoint(1,1)+p2p0(1,1)],[interestpoint(1,2),interestpoint(1,2)+p2p0(1,2)],[interestpoint(1,3),interestpoint(1,3)+p2p0(1,3)],'r-','LineWidth',3);

point(:,1)=point(:,1)-interestpoint(1,1);
point(:,2)=point(:,2)-interestpoint(1,2);
point(:,3)=point(:,3)-interestpoint(1,3);
px=point*p1p0';
py=point*p2p0';
% figure(22)
% plot(px,py,'*');
% hold on;
ellipse_t = fit_ellipse( px,py );


focal=570.3;
if isempty(ellipse_t)|| isempty(ellipse_t.a)%%%if ellipse fitting failed
    a=0;
    c=0;
else
    a=ellipse_t.a;
    c=ellipse_t.b;
end
tmp=max(max(a,b),c);%%%select the max value as the radius of the pointcloud
radius=ceil(tmp*focal/interestpoint(1,3));%%%project the radius  to the image plane
if radius>50%%%if the result is too awful,we keep on the empirical equation result
    radius=exradius;
end
end

