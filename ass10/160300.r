#1
num_elements <- 50000
data <- rexp(num_elements, 0.2)
x <- data.frame(X = seq(1, num_elements , 1), Y = sort(data))
plot(x)

#2
mat_d <- matrix(data, 500, 100)

#3
xcols <- c(0:99)

for(i in 1:5){
  pdata <- rep(0, 100)
  cdata <- rep(0, 100)
  for(j in 1:100){
    val=round(mat_d[i,j], 0);
    if(val <= 100){
       pdata[val] = pdata[val] + 1/500;
    }
  }

  cdata[1] <- pdata[1]

  for(j in 2:100){
      cdata[j] = cdata[j-1] + pdata[j]
  }

  plot(xcols, pdata, "l", xlab="X", ylab=paste("PDF of vector-",i))

  plot(xcols, cdata, "l", col="blue", xlab="X", ylab=paste("CDF of vector-",i))

}

#mean and std
r.mean <- apply(mat_d, 1, mean)
r.std <- apply(mat_d, 1, sd)

print(r.mean[1:5])
print(r.std[1:5])

#4

#Frequency
tab <- table(round(r.mean))

plot(tab, "h", xlab="Mean value", ylab="Frequency")

pdata <- rep(0, 10);

for(i in 1:500){
    val=round(r.mean[i], 0);
    if(val <= 10){
       pdata[val] = pdata[val] + 1/500;
    }
}

xcols <- c(0:9)
plot(xcols, pdata, "l", xlab="Mean(X)", ylab="PDF of Mean")

cdata <- rep(0, 10)

cdata[1] <- pdata[1]

for(i in 2:10){
    cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="Mean(X)", ylab="CDF of Mean");

#5
r.mean.mean <- mean(r.mean)
r.mean.std <- sd(r.mean)

#6
print("Theoratical value of Mean(1/lambda) = ")
print(1/0.2)

print("Actual value of Mean = ")
print(r.mean.mean)


print("Actual value of SD = ")
print(r.mean.std)
