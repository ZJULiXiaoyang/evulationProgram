function corrpnum= correspondencenum( keypoint1,keypoint2,R,T,depthImage1,depthImage2 )
CX=320;
CY=240;
focal=570.5;

numa=size(keypoint1,2);
numb=size(keypoint2,2);

corrpnum=0;
for i=1:numa
    
    u1=ceil(keypoint1(1,i));
    v1=ceil(keypoint1(2,i));
    z1=double(depthImage1(v1,u1))/1000;
    if z1==0
        continue;
    end
    x1=(u1-CX)*z1/focal;
    y1=(v1-CY)*z1/focal;
    
    for j=1:numb
        u2=ceil(keypoint2(1,j));
        v2=ceil(keypoint2(2,j));
        z2=double(depthImage2(v2,u2))/1000;
        if z2==0
            continue;
        end
        x2=(u2-CX)*z2/focal;
        y2=(v2-CY)*z2/focal;
        x21=R(1,1)*x2+R(1,2)*y2+R(1,3)*z2+T(1);
        y21=R(2,1)*x2+R(2,2)*y2+R(2,3)*z2+T(2);
        z21=R(3,1)*x2+R(3,2)*y2+R(3,3)*z2+T(3);
        
        distance=[x1-x21,y1-y21,z1-z21];
        
        if norm(distance)<0.3
            corrpnum=corrpnum+1;
            break;
        end
    end    
end

