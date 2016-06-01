function [unprecision,recall]=PRvalue(matchKP1,matchKP2,R,T,num,correspNum,depthImage1,depthImage2,flag)
mystart=1;
alpha=1;
myend=num*alpha;
mygap=(myend-mystart)/50;
correctNums=[];
totalNums=[];
index=1;
for t=mystart:mygap:myend
    correctNum=0;
    totalNum=floor(t);
    if flag
        for i=1:t
            point1(1)=matchKP1(i,1);
            point1(2)=matchKP1(i,2);
            point2(1)=matchKP2(i,1);
            point2(2)=matchKP2(i,2);
            result=isCorrect(point1,point2,depthImage1,depthImage2,R,T);
            if    result==1
                correctNum=correctNum+1;
            else if result ==2
                    totalNum=totalNum-1;
                end
            end
        end
    else
        for i=1:t
            point1(1)=matchKP1(i,1);
            point1(2)=matchKP1(i,2);
            point2(1)=matchKP2(i,1);
            point2(2)=matchKP2(i,2);
            if isCorrectHomo(point1,point2)
                correctNum=correctNum+1;
            end
        end
    end
    correctNums(index)=correctNum;
    totalNums(index)=totalNum;
    index=index+1;
end

unprecision=1-correctNums./totalNums;
unprecision=sort(unprecision);
correspNum=correspNum*alpha;
recall=correctNums/correspNum;

end