function index=getpieindex(mask,r,npies,angs,point)   %%计算一定角度的分块标记
%     diffangs=angs-point.orientation;
%     diffangs=mod(diffangs,2*pi);
    
    slice=2*pi/npies;
    nthpie=floor(point.orientation/slice);  %%计算一定角度的分块标记
    diffangs=angs-nthpie*slice;  %%减去主方向角度
     diffangs=mod(diffangs,2*pi);  %%除以2pi,求余
%      diffangs=mod(diffangs,pi);
    index = zeros(2*r+1, 2*r+1);
    tmp = ceil(diffangs/slice);
    index = zeros(2*r+1, 2*r+1);%%然后根据旋转后的角度获取标记
    for i=-r:r
        for j=-r:r
        if mask(i+r+1,j+r+1)==0
            continue;
        end
        if tmp(i+r+1,j+r+1)==0
            index(i+r+1,j+r+1)=1;
        else
            index(i+r+1,j+r+1)=tmp(i+r+1,j+r+1);
        end
        
        end
    end

