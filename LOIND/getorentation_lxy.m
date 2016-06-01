function [angles,resultnum]=getorentation_lxy(path_normal,npies,mask,number_rotate)  %%������ڷ�������������ͳ�Ʒ���������ֱ��ͼͳ��
pathsize=size(mask,1);
radius=((pathsize-1)/2);
center_x=pathsize-radius;
center_y=pathsize-radius;
number_piex=sum(sum(mask));    %%�ܹ����صĸ���
mask_normal=path_normal(:,:,1)&path_normal(:,:,2)&path_normal(:,:,3);
if mask_normal(center_x,center_y) == 0 %%%�ж�������ķ������Ƿ����
    angles=0;
    resultnum=1;
    return;
end;
number_normal=sum(sum(mask_normal));  %%�ܹ��ķ���������

if number_normal<number_piex*0.7 %%%�жϷ�����ȱʧ�̶�
    angles=0;
    resultnum=1;
    return;
end

center_normalx=path_normal(center_x,center_y,1);%%%���������ķ�����
center_normaly=path_normal(center_x,center_y,2);
center_normalz=path_normal(center_x,center_y,3);
[~, angs_mask] = getLookupTablePie(radius,0);
delttheta=2*pi/number_rotate;
slice=2*pi/npies;
path_dotproduct=zeros(pathsize);
sum_dotproduct=zeros(1,number_rotate);
for num=1:1:number_rotate
    for i = -radius : radius
        for j = -radius :radius   %%ѭ���������е�ĵ��ֵ
            nx=path_normal(center_x+i,center_y+j,1);   %%��ȡ������,x,y,z��ֵ
            ny=path_normal(center_x+i,center_y+j,2);
            nz=path_normal(center_x+i,center_y+j,3);
            path_dotproduct(center_x+i,center_y+j)=nx*center_normalx+ny*center_normaly+nz*center_normalz;  %%����ֵ
            if isnan(path_dotproduct(center_x+i,center_y+j))   %%�ų���Ϊ�������
                path_dotproduct(center_x+i,center_y+j)=0;
            end
        end;
    end;

        template=template_lxy(pathsize,slice,num,delttheta,angs_mask,mask);
        sum_dotproduct(num)=sum(sum(path_dotproduct.*template));
end
[result,index]=sort(sum_dotproduct);
angles=(index(number_rotate)-1)*delttheta;
resultnum=index(number_rotate);
end