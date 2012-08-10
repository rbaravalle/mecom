
% blue: non bread
% red: baguette
% yellow : salvado
% black: sandwich
% green: lactal

train2sameSize = csvread('train2sameSize.csv');
test2sameSize = csvread('test2sameSize.csv');
baguetteCS = csvread('baguetteCS.csv');

hold on;

init = 4;

p = plot(mean(train2sameSize(1:20,init:2:41)),'--mo');
p2 = plot(mean(train2sameSize(21:40,init:2:41)),'--mo');
p3 = plot(mean(train2sameSize(41:60,init:2:41)),'--mo');
p4 = plot(mean(train2sameSize(61:80,init:2:41)),'--mo');
p5 = plot(mean(train2sameSize(81:100,init:2:41)),'--mo');
p6 = plot(mean(test2sameSize(1:20,init:2:41)),'--mo');
p7 = plot(mean(test2sameSize(21:40,init:2:41)),'--mo');
p8 = plot(mean(test2sameSize(41:60,init:2:41)),'--mo');
p9 = plot(mean(test2sameSize(61:80,init:2:41)),'--mo');
p10 = plot(mean(test2sameSize(81:100,init:2:41)),'--mo');

p11 = plot(mean(baguetteCS(:,init:2:41)),'--mo');
set(p11,'Color','magenta')


set(p,'Color','red')
set(p2,'Color','green')
set(p3,'Color','yellow','LineStyle','none')
set(p4,'Color','black','LineStyle','none')


set(p6,'Color','red','LineStyle','none')
set(p7,'Color','green','LineStyle','none')
set(p8,'Color','yellow','LineStyle','none')
set(p9,'Color','black','LineStyle','none')

set(p5,'Color','blue','LineStyle','none')
set(p10,'Color','blue','LineStyle','none')

hold off;