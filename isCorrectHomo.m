function [result]=isCorrectHomo(point1,point2)

load('H.mat');
u1=ceil(point1(1));
v1=ceil(point1(2));

u2=ceil(point2(1));
v2=ceil(point2(2));

y1=H(1,1)*u1+H(1,2)*v1+H(1,3);
y2=H(2,1)*u1+H(2,2)*v1+H(2,3);
y3=H(3,1)*u1+H(3,2)*v1+H(3,3);

u12=y1/y3;
v12=y2/y3;

distance =[u2-u12,v2-v12];

if norm(distance)<3
    result=true;
else
    result=false;
end
end

