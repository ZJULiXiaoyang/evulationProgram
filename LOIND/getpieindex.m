function index=getpieindex(mask,r,npies,angs,point)   %%����һ���Ƕȵķֿ���
%     diffangs=angs-point.orientation;
%     diffangs=mod(diffangs,2*pi);
    
    slice=2*pi/npies;
    nthpie=floor(point.orientation/slice);  %%����һ���Ƕȵķֿ���
    diffangs=angs-nthpie*slice;  %%��ȥ������Ƕ�
     diffangs=mod(diffangs,2*pi);  %%����2pi,����
%      diffangs=mod(diffangs,pi);
    index = zeros(2*r+1, 2*r+1);
    tmp = ceil(diffangs/slice);
    index = zeros(2*r+1, 2*r+1);%%Ȼ�������ת��ĽǶȻ�ȡ���
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

