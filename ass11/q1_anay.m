data = csvread("train.csv");
data([1],:) = [];

x=data(:,[1]);
y=data(:,[2]);

x=[ones(length(x),1),x];

wd=inv(x'*x)*x'*y;
disp(sprintf("w_direct is: %i , %i", wd(1),wd(2)));

hold on;
title("Regression Learning")
plot(x(:,[2]),y,'y');
pause(2);
plot(x(:,[2]),x*wd,'r');
pause(2);


#train
w=rand(2,1);
n=1;eta=1e-8;
for i = 1:n,
   for j = 1:length(x),
        cx=x(j,:)';
        w-=eta*(w'*cx-y(j,:))*cx;
        if(mod(j,1000)==0),
          plot(x,x*w,'c');
          pause(0.1);
        end,
   end,
end,

print -dpdf "q1_.pdf";
close;

disp(sprintf("w_train is: %i , %i", w(1),w(2)));

test=csvread("test.csv");
test([1],:) = [];

xt=data(:,[1]);
yt=data(:,[2]);

xt=[ones(length(xt),1),xt];

cs1=sqrt(mean((xt*wd-yt).^2))
cs2=sqrt(mean((xt*w-yt).^2));

disp(sprintf("error: direct %i, iteration %i",cs1,cs2));
