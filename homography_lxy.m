% calculate Homography Matrix through RANSIC provided by matlab
%IN:
%  pointloc1 --- the matched interest points of reference image
%  pointloc2 --- the matched interest points of transformation image
%  descriptor1 --- the descriptors of the matched interest points in reference image
%  descriptor2 --- the descriptors of the matched interest points in transformation image
%  threshold --- the threshold of  RANSIC
%OUT��
%  result --- the ending of the Program
function [] = homography_lxy( descriptor1,descriptor2, threshold,pointloc1,pointloc2)
[matches, scores] = vl_ubcmatch(descriptor1,descriptor2,1.5);%%% match based on ratio
[scores index]=sort(scores);
total=size(scores,2);
mystart=scores(ceil(total/2));
matches=[];
scores=[];

[matches, scores] = vl_ubcmatch(descriptor1,descriptor2,threshold);%%% match based on ratio
matches=[matches;scores];
[row col]=find(matches(3,:)>mystart);%%% remove the pairs which euclidean distance is out of the threshold
matches(:,col)=[];
scores(col)=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
matches=[matches;zeros(1,size(matches,2))];
matchpair=size(matches,2);
for i=1:matchpair
    matchloc1(i,:)=pointloc1(1:2,matches(1,i));
    matchloc2(i,:)=pointloc2(1:2,matches(2,i));
end

matchloc1=single(matchloc1);
matchloc2=single(matchloc2);
gte = vision.GeometricTransformEstimator;
gte.Transform = 'Projective';
[H inlierIdx] = step(gte, matchloc1, matchloc2);

% H=[1,0,0;0,1,0;0,0,1];
homog=strcat('./Homography/H.mat');
H=H';
save(homog,'H');
result='Get the Homography Matrix.';
disp(result);

end

