%%%This function is mainly to map the normal to the CCD to get the dominant orientation
function [ u,v,orentition] = generate_uv( normal,interestpoint,x,y,height,width)

normal_world=normal'+interestpoint;
focal=575;
u=normal_world(1,1)*focal/normal_world(1,3)+width/2;
v=normal_world(1,2)*focal/normal_world(1,3)+height/2;
du=u-x;
dv=y-v;
if du>0
    orentition=mod(atan(dv/du),2*pi);
else
    orentition=atan(dv/du)+pi;
end
end
