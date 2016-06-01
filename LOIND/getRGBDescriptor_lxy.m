%%%INPUT:
%%% patchsize --- the size of the patch to be described
%%% patch --- the patch of RGBimage
%%% mask --- represent  a circle whose radius is 20
%%% pieindex --- the spatial blocks map 
%%%npies---the spatial blocks
%%%nbins---the grayscale blocks
%%%dnbins---the dotproduct blocks
%%% normal --- the normal corresponding to the depth image
%%%OUTPUT
%%%desD---the 192v descriptor
%%%indictor--- the flag whether the descriptor is successfully to be built


function [desD, indictor] = getRGBDescriptor_lxy(patchsize, patch,mask, pieindex, npies, nbins,dnbins,normal)

radius=int32((patchsize-1)/2);
center_x=patchsize-radius;
center_y=patchsize-radius;

% rgbpatch=zeros(size(patch));
% depthpatch=zeros(size(patch)); it is just for showing the result of the
% label

number_piex=sum(sum(mask));    %%%calculate the total number of the pixels
mask_normal=normal(:,:,1)|normal(:,:,2)|normal(:,:,3);%%%get the mask map corresponding to the normal
if mask_normal(center_x,center_y) == 0 %%%if the keypoint's normal is lost
    desD=0;
    indictor=0;
    return;
end;
number_normal=sum(sum(mask_normal));  %%calculate the total number of the pixels whose normal is not lost

if number_normal<number_piex*0.7 
    desD=0;
    indictor=0;
    return;
end
indictor=1;
center_normalx=normal(center_x,center_y,1);
center_normaly=normal(center_x,center_y,2);
center_normalz=normal(center_x,center_y,3);

dotproduct=zeros(size(patch));


for i = -radius : radius
    for j = -radius :radius   
        
        nx=normal(center_x+i,center_y+j,1);  
        ny=normal(center_x+i,center_y+j,2);
        nz=normal(center_x+i,center_y+j,3);
        
        
        dotproduct(center_x+i,center_y+j)=abs(nx*center_normalx+ny*center_normaly+nz*center_normalz);  %%calculate the dotproduct
        if isnan(dotproduct(center_x+i,center_y+j))   
            dotproduct(center_x+i,center_y+j)=0;
        end
    end;
end;

uniq_patch = unique(patch(:));   %%calculate the gray levels of the patch to be described
uniq_dotproduct = unique(dotproduct(dotproduct<0.9));   %%calculate the dotproduct levels of the patch to be described

number_nbins = ceil(size(uniq_patch,1)/nbins);   %%%the number of gray levels in each grayscale block
upper_bound_gray=ones(1,nbins);
for i=1:1:nbins
    index=i*number_nbins;
    if index>size(uniq_patch,1)
        index=size(uniq_patch,1);
    end
    upper_bound_gray(i)=uniq_patch(index);%%%get the upper bound of each grayscale block
end
number_dnbins = ceil(size(uniq_dotproduct,1)/dnbins);  %%%the number of dotproduct levels in each dotproduct block
upper_bound_dotproduct=ones(1,dnbins);
if number_dnbins~=0
    for i=1:1:dnbins
        index=i*number_dnbins;
        if index>size(uniq_dotproduct,1)
            index=size(uniq_dotproduct,1);
        end
        upper_bound_dotproduct(i)=uniq_dotproduct(index);%%%get the upper bound of each dotproduct block
    end
else
    for i=1:1:dnbins
        upper_bound_dotproduct(i)=0;
    end
end
histogram= zeros(nbins, npies,dnbins+1);  %%3d statistical histogram

for i = -radius : radius
    for j = -radius : radius   
        if mask(center_x+i,center_y+j) == 0  
            continue;
        end;
        for index=1:1:nbins
            if patch(center_x+i,center_y+j)<=upper_bound_gray(index)
                nbin_id=index;%%%the id of grayscale block
                break;
            end
        end;
        
        if dotproduct(center_x+i,center_y+j)>=0.9  %%if the dotproduct is greater than 0.9 ,the id of dotproduct block is 3
            dnbin_id=3;
        else
            for index=1:1:dnbins
                if dotproduct(center_x+i,center_y+j)<=upper_bound_dotproduct(index)
                    dnbin_id=index;%%%the id of dotproduct block
                    break;
                end
            end;
        end;
        npie_id = pieindex(center_x+i,center_y+j);   %%the id of the spatial block
        histogram(nbin_id,npie_id,dnbin_id) =  histogram(nbin_id,npie_id,dnbin_id) + 1;  
    
end;
desD = histogram(:);  

end