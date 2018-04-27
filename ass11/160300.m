#! /usr/local/bin/octave -q

train = "train.csv";
test_ = "test.csv";

#Loading training data
train_data = csvread(train);

x_train = train_data(2:end,1);
y_train = train_data(2:end,2);

x_train = [ones(rows(x_train),1), x_train];

#Random intialization of weights
w = rand(2,1);

hold off;
plot(x_train(:,2), y_train, "r" , x_train(:,2), x_train*w, "b");
title("Plot after random intialization of weights");
pause(4);
print -dpdf "fig1.pdf";
close;

#Direct Method
w_direct = inv(x_train'*x_train)*(x_train'*y_train);

#Plotting result of direct method
hold off;
plot(x_train(:,2), y_train, "r" , x_train(:,2), x_train*w_direct, "b");
title("Result of direct method");
pause(4);
print -dpdf "fig2.pdf";
close;

#hyperparameters
etaa = 1e-8;
epoch = 1;

#SGD
hold on;
for i = 1:epoch
  for j = 1:rows(y_train)
    temp = ((x_train(j,:)*w) - y_train(j,:))*(x_train(j,:)');
    w = w - etaa*temp;
    if(mod(j,1000)==0)
      plot(x_train(:,2), y_train, "r" , x_train(:,2), x_train*w, "b");
      title("Training .....");
      pause(1);
    endif
  endfor
endfor
print -dpdf "fig3.pdf";
close;

#Plotting result of SGD
hold off;
plot(x_train(:,2), y_train, "r" , x_train(:,2), x_train*w, "b");
title("Result of SGD");
pause(4);
print -dpdf "fig4.pdf";
close;

#Loading test data
test_data = csvread(test_);

x_test = test_data(2:end,1);
y_test = test_data(2:end,2);

x_test = [ones(rows(x_test),1), x_test];

#Testing
y1_pred = x_test*w;
printf("RMSE error between y1_pred and y_test:%f\n",norm(y1_pred-y_test)/sqrt(rows(y_test)));

y2_pred = x_test*w_direct;
printf("RMSE error between y2_pred and y_test:%f\n",norm(y2_pred-y_test)/sqrt(rows(y_test)));
