using  Plots, Random, Distributions

nPoints = 3;

μ1 = [3.2, 4.8];
μ2 = [4.8, 3.2];

P1 = .5;
P2 = .5;

Σ1 = [1.0 0.7;0.7 1.0];
Σ2 = [1.0 0.7;0.7 1.0];

d1 = MvNormal(μ1,Σ1);
d2 = MvNormal(μ2,Σ2);

s1 = rand(d1::MultivariateDistribution,nPoints::Int);
s2 = rand(d2::MultivariateDistribution,nPoints::Int);






########################################################################

# calculate estimated values for sample 1
μ1E = [mean(s1[1,:]); mean(s1[2,:])];
cv11 = var(s1[1,:]);
cv22 = var(s1[2,:]);
cv21 = sum((s1[1,:] .- μ1E[1]) .* (s1[2,:] .- μ1E[2]))/(nPoints-1);
Σ1E = [cv11 cv21; cv21 cv22];

# calculate estimated values for sample 2
μ2E = [mean(s2[1,:]); mean(s2[2,:])];
cv11 = var(s2[1,:]);
cv22 = var(s2[2,:]);
cv21 = sum((s2[1,:] .- μ2E[1]) .* (s2[2,:] .- μ2E[2]))/(nPoints-1);
Σ2E = [cv11 cv21; cv21 cv22];


#Plot some relevant things
discrimInfo = discrimLine(μ1,μ2,Σ1,Σ2,P1,P2);
discrimInfoE = discrimLine(μ1E,μ2E,Σ1E,Σ2E,P1,P2);

x = [s1[1,:] s2[1,:]];
dLine = linFuncForPlot(discrimInfo[1],discrimInfo[2],minimum(x),maximum(x),nPoints);
eLine = linFuncForPlot(discrimInfoE[1],discrimInfoE[2],minimum(x),maximum(x),nPoints);

x = [s1[1,:] s2[1,:] dLine[1] eLine[1]];
y = [s1[2,:] s2[2,:] dLine[2] eLine[2]];




c1 = classifyCorrect(s1[1,:],s1[2,:],discrimInfo[1],discrimInfo[2],1);
c2 = classifyCorrect(s2[1,:],s2[2,:],discrimInfo[1],discrimInfo[2],2);

c1E = classifyCorrect(s1[1,:],s1[2,:],discrimInfoE[1],discrimInfoE[2],1);
c2E = classifyCorrect(s2[1,:],s2[2,:],discrimInfoE[1],discrimInfoE[2],2);
(2 * nPoints - sum(c1) - sum(c2))/(2*nPoints)
errorBayesClassifier = (2 * nPoints - sum(c1) - sum(c2))/(2*nPoints)

errorEstimated = (2 * nPoints - sum(c1E) - sum(c2E))/(2*nPoints)

errorEstimated - errorBayesClassifier

plot(x,y,seriestype=:scatter)
