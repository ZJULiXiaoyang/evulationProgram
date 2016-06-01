function corrpnum= correspondencenum2D( keypoint1,keypoint2 )
load('H.mat');

numa=size(keypoint1,2);
numb=size(keypoint2,2);

corrpnum=0;
for i=1:numa
    
    u1=ceil(keypoint1(1,i));
    v1=ceil(keypoint1(2,i));
    
    y1=H(1,1)*u1+H(1,2)*v1+H(1,3);
    y2=H(2,1)*u1+H(2,2)*v1+H(2,3);
    y3=H(3,1)*u1+H(3,2)*v1+H(3,3);
    
    u12=y1/y3;
    v12=y2/y3;
    
    for j=1:numb
        u2=ceil(keypoint2(1,j));
        v2=ceil(keypoint2(2,j));       
        
        distance=[u2-u12,v2-v12];
        
        if norm(distance)<10
            corrpnum=corrpnum+1;
            break;
        end
    end
end

