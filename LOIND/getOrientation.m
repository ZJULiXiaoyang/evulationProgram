%%%This function is mainly to estimated the 3D orientation based on the PCA
%%%INPUT
%%%pointcloud---the pointcloud of the patch to be described
%%%OUTPUT
%%%mainVector---the the orientation
function [ mainVector ] = getOrientation( pointcloud )
average=mean(pointcloud);
dx=pointcloud(:,1)-average(1);
dy=pointcloud(:,2)-average(2);
dz=pointcloud(:,3)-average(3);

kesi=[dx,dy,dz];
%%%estimated covariance matrix
cov_pointcloud= cov(kesi);
%%%estimated the eigenvalue and eigenvector
[eigenvector,eigenvalue]=eig(cov_pointcloud);
eigvalues=diag(eigenvalue);
[~,index]=sort(eigvalues);

if eigvalues(2)>0.8*eigvalues(3)&&eigvalues(1)>0.8*eigvalues(3)
%     mainVector=eigenvector(:,1)+eigenvector(:,2)+eigenvector(:,3);
    mainVector=cross(eigenvector(:,2),eigenvector(:,3));%%%modified in 20160530 by LXY
    mainVector=mainVector/norm(mainVector);
else if eigvalues(2)>0.8*eigvalues(3)
%         mainVector=eigenvector(:,2)+eigenvector(:,3);
        mainVector=cross(eigenvector(:,2),eigenvector(:,3));
        mainVector=mainVector/norm(mainVector);
    else
        mainVector=eigenvector(:,3);
    end
end


end

