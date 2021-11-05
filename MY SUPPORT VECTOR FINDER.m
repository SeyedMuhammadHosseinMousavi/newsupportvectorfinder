%% DEFINITION
clc;clear;
%%%simple dataset
% x1=[2,3,5,7,1,2,3];
% x2=[3,4,4,6,3,9,8];
% y1=[2,5,8,7,4,6,8];
% y2=[1,2,1,2,3,4,4];
%%% iris dataset for class 1and 2 with first two features from four
% x1=[5.1;4.9;4.7;4.6;5;5.4;4.6;5;4.4;4.9;5.4;4.8;4.8;4.3;5.8;5.7;5.4;5.1;5.7;5.1;5.4;5.1;4.6;5.1;4.8;5;5;5.2;5.2;4.7;4.8;5.4;5.2;5.5;4.9;5;5.5;4.9;4.4;5.1;5;4.5;4.4;5;5.1;4.8;5.1;4.6;5.3;5]';
% x2=[3.5;3;3.2;3.1;3.6;3.9;3.4;3.4;2.9;3.1;3.7;3.4;3;3;4;4.4;3.9;3.5;3.8;3.8;3.4;3.7;3.6;3.3;3.4;3;3.4;3.5;3.4;3.2;3.1;3.4;4.1;4.2;3.1;3.2;3.5;3.6;3;3.4;3.5;2.3;3.2;3.5;3.8;3;3.8;3.2;3.7;3.3]';
% y1=[7;6.4;6.9;5.5;6.5;5.7;6.3;4.9;6.6;5.2;5;5.9;6;6.1;5.6;6.7;5.6;5.8;6.2;5.6;5.9;6.1;6.3;6.1;6.4;6.6;6.8;6.7;6;5.7;5.5;5.5;5.8;6;5.4;6;6.7;6.3;5.6;5.5;5.5;6.1;5.8;5;5.6;5.7;5.7;6.2;5.1;5.7]';
% y2=[3.2;3.2;3.1;2.3;2.8;2.8;3.3;2.4;2.9;2.7;2;3;2.2;2.9;2.9;3.1;3;2.7;2.2;2.5;3.2;2.8;2.5;2.8;2.9;3;2.8;3;2.9;2.6;2.4;2.4;2.7;2.7;3;3.4;3.1;2.3;3;2.5;2.6;3;2.6;2.3;2.7;3;2.9;2.9;2.5;2.8]';
%%% random dataset
%rng(0,'twister');   there is no need to this line except frist run
a = 0;b = 12;c=10;d=20;dd=5;
x1 = ((b-a).*rand(50,1))' + a;   
x2 = ((b-a).*rand(50,1))' + a;   
y1 = ((b-a).*rand(50,1))' + a; 
y2 = ((d-c).*rand(50,1))' + c;   
% scatter(x1,x2);hold on;scatter(y1,y2)
%% PROCESS STEP 1
thresholdup= 0.05;  thresholddown=0.005;
x2half=b/2; y2half=(c+d)/2;
wholecounter=0; conditioncounter=0;  w=1;  index=0;  indexvalue=0;  indexnumber=0; value=0;
sizex=size(x1); sizey=size(y1);
for i=1 : sizex(1,2)
    for j=1 : sizey(1,2)-1
        for z=j+1 : sizey(1,2)
            testx=[x1(i),y1(j),y1(z)];
            testy=[x2(i),y2(j),y2(z)];
         A(i,j,z) = polyarea(testx,testy);
 if x2(i)>=x2half && y2(j)<=y2half && y2(z)<=y2half
 if A(i,j,z) <=thresholdup && A(i,j,j+1)>thresholddown         
        value(w)=A(i,j,z);      conditioncounter=conditioncounter+1; index(i,j,z)=1; indexvalue(i,j,z)=A(i,j,z);
        indexnumber(w,1)=i; indexnumber(w,2)=j; indexnumber(w,3)=z;
        w=w+1;
 end;end;
 wholecounter=wholecounter+1;
 end; end;end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%FOR THE OTHER SIDE
indexnumber2=0;  w1=1; sizex=size(x1); sizey=size(y1);
for i=1 : sizex(1,2)
    for j=1 : sizey(1,2)-1
            for z=j+1 : sizey(1,2)
         testx1=[y1(i),x1(j),x1(z)];
         testy1=[y2(i),x2(j),x2(z)];
        B(i,j,z) = polyarea(testx1,testy1);
 if x2(i)>=x2half && y2(j)<=y2half && y2(z)<=y2half
 if B(i,j,z) <=thresholdup && B(i,j,z)>thresholddown                 
     indexnumber2(w1,1)=i; indexnumber2(w1,2)=j; indexnumber2(w1,3)=z;
     w1=w1+1;  
 end;end;
 end; end; end;
%% PROCESS STEP 2
indexnumber=sort(indexnumber);sizeindexnumber=size(indexnumber);
for i=1:sizeindexnumber(1,1)-1
    if indexnumber(i,1)==indexnumber(i+1,1)
        newindex(i,1)=0;
    else         newindex(i,1)=indexnumber(i,1);
    end;end;         
for i=1:sizeindexnumber(1,1)-1
    if indexnumber(i,2)==indexnumber(i+1,2)
        newindex(i,2)=0;
    else         newindex(i,2)=indexnumber(i,2);
    end;end;
for i=1:sizeindexnumber(1,1)-1
    if indexnumber(i,3)==indexnumber(i+1,3)
        newindex(i,3)=0;
    else         newindex(i,3)=indexnumber(i,3);
    end;end

newindex(end+1,1)=indexnumber(end,1);
newindex(end,2)=indexnumber(end,2);
newindex(end,3)=indexnumber(end,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FOR THE OTHER SIDE
indexnumber2=sort(indexnumber2);sizeindexnumber2=size(indexnumber2);
for i=1:sizeindexnumber2(1,1)-1
    if indexnumber2(i,1)==indexnumber2(i+1,1)
        newindex2(i,1)=0;
    else         newindex2(i,1)=indexnumber2(i,1);
    end;end;        
for i=1:sizeindexnumber2(1,1)-1
    if indexnumber2(i,2)==indexnumber2(i+1,2)
        newindex2(i,2)=0;
    else         newindex2(i,2)=indexnumber2(i,2);
    end;end;
for i=1:sizeindexnumber2(1,1)-1
    if indexnumber2(i,3)==indexnumber2(i+1,3)
        newindex2(i,3)=0;
    else         newindex2(i,3)=indexnumber2(i,3);
    end;end

newindex2(end+1,1)=indexnumber2(end,1);
newindex2(end,2)=indexnumber2(end,2);
newindex2(end,3)=indexnumber2(end,3);
%% PROCESS STEP 3
aa=newindex(:,1);bb=newindex(:,2);cc=newindex(:,3);
class1 = aa(aa~=0);class21 = bb(bb~=0);class22 = cc(cc~=0);
sizeclass1=size(class1);sizeclass21=size(class21);sizeclass22=size(class22);
sz1 = 140;  sz2=100;
 %%%FOR THE OTHER SIDE
aa2=newindex2(:,1);bb2=newindex2(:,2);cc2=newindex2(:,3);
class12 = aa2(aa2~=0);class212 = bb2(bb2~=0);class222 = cc2(cc2~=0);
sizeclass12=size(class12);sizeclass212=size(class212);sizeclass222=size(class222);
sz1 = 140;  sz2=100;
%% DISPLAY
clear myminx; clear myminy; clear min;
myminx=[min(x1),min(y1)];  minx=min(myminx);
myminy=[min(x2),min(y2)];  miny=min(myminy);
clear mymaxx; clear mymaxy; clear max;
mymaxx=[max(x1),max(y1)];  maxx=max(mymaxx);
mymaxy=[max(x2),max(y2)];  maxy=max(mymaxy);
%the data for plot is extracted from {class1 and class212 and class 222}
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
for i=1:sizeclass1(1,1)
    scatter(x1(class1(i,1)),x2(class1(i,1)),sz1,'filled','b');
    hold on;   xlim([minx maxx]);      ylim([miny maxy]);
end

for i=1:sizeclass212(1,1)
    scatter(y1(class212(i,1)),y2(class212(i,1)),sz1,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
    hold on;  xlim([minx maxx]);      ylim([miny maxy]);  title('Result'); xlabel('X axis'); ylabel('Y axis');  
end   
for i=1:sizeclass222(1,1)
     scatter(y1(class222(i,1)),y2(class222(i,1)),sz1,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
     hold on; xlim([minx maxx]);      ylim([miny maxy]);  title('Result'); xlabel('X axis'); ylabel('Y axis');   
end
%%%Compare with result
subplot(1,2,2)
scatter(x1,x2,sz1,'filled','b'); hold on; 
scatter(y1,y2,sz1,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
xlim([minx maxx]);      ylim([miny maxy]);  title('Original'); xlabel('X axis'); ylabel('Y axis');

%% SVM BINARY CLASSIFIER
xdata=0;s=0;ss=0;
xdata(1:sizeclass1(1,1),1)=class1(1:sizeclass1(1,1),1);
s=sizeclass1(1,1)+sizeclass212(1,1);
xdata(end+1:s,1)=class212(1:end,1);
ss=sizeclass1(1,1)+sizeclass212(1,1)+sizeclass222(1,1);
xdata(end+1:ss,1)=class222(1:end,1);

for i=1:sizeclass1(1,1)
    mydata(i,1)=x1(class1(i));
    mydata(i,2)=x2(class1(i));
end
f=sizeclass1(1,1)+1; rr=1;
for i= f : s
    mydata(i,1)=y1(class212(rr));
    mydata(i,2)=y2(class212(rr));
    rr=rr+1;
end
ff=sizeclass1(1,1)+sizeclass212(1,1)+1; rr=1;
for i= ff : ss
    mydata(i,1)=y1(class222(rr));
    mydata(i,2)=y2(class222(rr));
    rr=rr+1;
end

group(1:sizeclass1(1,1),1)={'class1'};
group(end+1:ss,1)={'class2'};

%%% all iris data(frist two dimention and frist two class
% figure;
load fisheriris
data2 = meas(1:100,1:2);
group2 = species(1:100);
svmStruct2 = fitcsvm(data2,group2);
% xlim([minx maxx]);      ylim([miny maxy]);
% title('svm on all data'); xlabel('X axis'); ylabel('Y axis');
sv = svmStruct2.SupportVectors;
figure
gscatter(data2(:,1),data2(:,2),group2)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
 title('svm on all data'); xlabel('X axis'); ylabel('Y axis');
hold off
%%% on all of my data without any process
% figure;
data3(1:sizex(1,2),1)=x1;
data3(1:sizex(1,2),2)=x2;
data3(sizex(1,2)+1:sizex(1,2)+sizey(1,2),1)=y1;
data3(sizex(1,2)+1:sizex(1,2)+sizey(1,2),2)=y2;
group3(1:sizex(1,2),1)={'c1'};
group3(sizex(1,2)+1:sizex(1,2)+sizey(1,2),1)={'c2'};
svmStruct4 = fitcsvm(data3,group3);
% xlim([minx maxx]);      ylim([miny maxy]);   
% title('on all of my data without any process');
% xlabel('X axis'); ylabel('Y axis');
%%% new data
sv1 = svmStruct4.SupportVectors;
figure
gscatter(data3(:,1),data3(:,2),group3)
hold on
plot(sv1(:,1),sv1(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
title('on all of my data without any process');
hold off
%
% figure;
svmStruct = fitcsvm(mydata,group);
% xlim([minx maxx]);      ylim([miny maxy]); 
% 
sv2 = svmStruct.SupportVectors;
figure
gscatter(mydata(:,1),mydata(:,2),group)
hold on
plot(sv2(:,1),sv2(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
title('svm on new data');
hold off

%% Using least squares for linear classification for all
x=0;b=0;y=0;z=0;
x(1:50,1)=x1;
x(51:100,1)=y1;
x(1:50,2)=x2;
x(51:100,2)=y2;
x(:,3)=1;
b(1:50,1)=1;
b(51:100)=-1;
z = lsqlin(x, b);
% Plot data points and linear separator found above
figure;
y = -z(3)/z(2) - (z(1)/z(2))*x;
hold on; 
scatter(x(1:50, 1), x(1:50, 2), 'bx');
hold on; 
scatter(x(51:100, 1), x(51:100, 2), 'd');
xlim([minx maxx]);      ylim([miny maxy]);
plot(x, y, 'r');

%% using k-means before and after process
%%%this is before process
sizex=size(x1); sizey=size(y1);
data4(1:sizex(1,2),1)=x1;
data4(1:sizex(1,2),2)=x2;
data4(sizex(1,2)+1:sizex(1,2)+sizey(1,2),1)=y1;
data4(sizex(1,2)+1:sizex(1,2)+sizey(1,2),2)=y2;
X=data4(1:sizex(1,2),1:2);
Y=data4(sizex(1,2)+1:end,1:2);
figure;plot(X(:,1),X(:,2),'k*','MarkerSize',5); hold on; plot(Y(:,1),Y(:,2),'go','MarkerSize',5);
title ' dataset';xlabel 'x axis';ylabel 'y axis';hold on;
rng(1); [idx1,C1] = kmeans(X,10);
plot(C1(:,1),C1(:,2),'go','LineWidth',2,'MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor',[0.9,0.1,0.1]);hold on;
rng(1); [idx2,C2] = kmeans(Y,10);
plot(C2(:,1),C2(:,2),'go', 'LineWidth',2,'MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor',[0.1,0.1,0.9]);

%% this is after process
xdata=0;s=0;ss=0;
xdata(1:sizeclass1(1,1),1)=class1(1:sizeclass1(1,1),1);
s=sizeclass1(1,1)+sizeclass212(1,1);
xdata(end+1:s,1)=class212(1:end,1);
ss=sizeclass1(1,1)+sizeclass212(1,1)+sizeclass222(1,1);
xdata(end+1:ss,1)=class222(1:end,1);
for i=1:sizeclass1(1,1)
    mydata(i,1)=x1(class1(i));
    mydata(i,2)=x2(class1(i));end;
f=sizeclass1(1,1)+1; rr=1;
for i= f : s
    mydata(i,1)=y1(class212(rr));
    mydata(i,2)=y2(class212(rr));
    rr=rr+1;end;
ff=sizeclass1(1,1)+sizeclass212(1,1)+1; rr=1;
for i= ff : ss
    mydata(i,1)=y1(class222(rr));
    mydata(i,2)=y2(class222(rr));
    rr=rr+1;end;
XX(1:sizeclass1(1,1),1:2)=mydata(1:sizeclass1(1,1),1:2);
YY(1:sizeclass212(1,1),1:2)=mydata(sizeclass1(1,1)+1:sizeclass212(1,1)+sizeclass1(1,1),1:2);
s=sizeclass1(1,1)+sizeclass212(1,1);
YY(end+1:sizeclass212(1,1)+sizeclass222(1,1),1:2)=mydata(s+1:end,1:2);
figure;plot(XX(:,1),XX(:,2),'k*','MarkerSize',5); hold on; plot(YY(:,1),YY(:,2),'go','MarkerSize',5);
title ' dataset';xlabel 'x axis';ylabel 'y axis';hold on;
rng(1); [idx3,C3] = kmeans(XX,5);
plot(C3(:,1),C3(:,2),'go','LineWidth',2,'MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor',[0.9,0.1,0.1]);hold on;
rng(1); [idx4,C4] = kmeans(YY,5);
plot(C4(:,1),C4(:,2),'go', 'LineWidth',2,'MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor',[0.1,0.1,0.9]);

