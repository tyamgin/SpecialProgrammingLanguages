library(kernlab)
library(MASS);
library(datasets)

TR = function(a) {
  print(a)
}

StochasticGradient = function(xl, eta = 0.2, lambda = -1, eps = 1e-5, L, dL) {
  n = dim(xl)[1]
  m = dim(xl)[2] - 1
  if (lambda == -1)
    lambda = 1.0 / n
  w = runif(m)
  Q = 0.0
  for (i in 1:n)
    Q = Q + L(sum(xl[i,1:m]*w)*xl[i,m+1])
  iters = 1
  wPrev = w
  while(TRUE) {
    xy = xl[sample(1:n, 1),]
    x = xy[1:m]
    y = xy[m + 1]
    Eps = L(sum(w*x)*y)
    w = w - eta * dL(sum(w*x)*y)*x*y
    Q = (1 - lambda)*Q + lambda * Eps
    if (abs(sum(w^2) - sum(wPrev^2)) < eps)
        break
    wPrev = w
    iters = iters + 1
  }
  TR(c("StochasticGradient iters", iters))
  return( w )
}

# Генерация выборки
n = 350 # число объектов
p = 2   # размерность
sigma = 1
meanpos = -2
meanneg = 2
npos = round(n / 2)
nneg = n - npos
xpos = matrix(rnorm(npos*p, mean=meanpos, sd=sigma), npos, p)
xneg = matrix(rnorm(nneg*p, mean=meanneg, sd=sigma), nneg, p)
x = rbind(xpos, xneg)
x[,1] = x[,1] / max(abs(x[,1]))
x[,2] = x[,2] / max(abs(x[,2]))
y = matrix(c(rep(1, npos), rep(-1, nneg)))
xl = cbind(x, y)

# Стохастический градиент
colors = c(3, 0, 2);

plot(c(min(x[,1]), max(x[,1])), c(min(x[,2]), max(x[,2])), type="n", xlab="x1", ylab="x2", asp=1)
points(xl[,1], xl[,2], pch=20, col=colors[xl[,3]+2]);
w = StochasticGradient(xl, 
                       L = function(x) { (1-x)^2 }, 
                       dL = function(x) { 2*(x-1) },
                       eps = 1e-4
)
abline(0, -w[1] / w[2])

plot(c(min(x[,1]), max(x[,1])), c(min(x[,2]), max(x[,2])), type="n", xlab="x1", ylab="x2", asp=1)
points(xl[,1], xl[,2], pch=20, col=colors[xl[,3]+2], asp=1);
w = StochasticGradient(xl, 
                       L = function(x) { log2(1+exp(-x)) }, 
                       dL = function(x) { -1/(exp(x)*log(2)+log(2)) },
                       eps = 1e-4
)
abline(0, -w[1] / w[2])


# Метод опорных векторов

svp = ksvm(x, y, type="C-svc", kernel="vanilladot", C=100, scaled=c())
w = colSums(coef(svp)[[1]] * x[SVindex(svp),])
w0 = b(svp)

plot(c(min(x[,1]), max(x[,1])), c(min(x[,2]), max(x[,2])), type="n", xlab="x1", ylab="x2", asp=1)
svplot = function(idx, col, pch) {
    points(x[idx, 1], x[idx, 2], col=ifelse(y[idx] < 0, col[1], col[2]), pch=pch)  
}
svplot(-SVindex(svp), c(3, 2), 20)
svplot(SVindex(svp), c(3, 2), 21)

abline(w0 / w[2], -w[1] / w[2], lwd=3)
abline((w0+1) / w[2], -w[1] / w[2], lwd=1)
abline((w0-1) / w[2], -w[1] / w[2], lwd=1)
