function template=template_lxy(pathsize,slice,number_rotate,delttheta,angs_mask,mask)
template=zeros(pathsize);
radius=(pathsize-1)/2;
center_x=pathsize-radius;
center_y=pathsize-radius;
upper_bound=2*pi+(number_rotate-1)*delttheta+slice;
lower_bound=2*pi+(number_rotate-1)*delttheta;
for i = -radius : radius
    for j = -radius:radius
        if mask(center_x+i,center_y+j)==0
           continue;
        end
        if upper_bound<=4*pi
            if (angs_mask(center_x+i,center_y+j)>=lower_bound)&&(angs_mask(center_x+i,center_y+j)<=upper_bound)
                template(center_x+i,center_y+j)=1;
            end
        else
             if (angs_mask(center_x+i,center_y+j)>=lower_bound)||(angs_mask(center_x+i,center_y+j)<=(upper_bound-2*pi))
                template(center_x+i,center_y+j)=1;
            end
        end
    end;
end;
%  figure;imagesc(template); colormap(gray);
end