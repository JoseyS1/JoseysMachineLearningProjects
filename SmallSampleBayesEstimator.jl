using  Plots, Random, Distributions

nPoints = 2;

μ1 = [3.2, 4.8];
μ2 = [4.8, 3.2];

P1 = .5;
P2 = .5;

Σ = [1.0 0.7;0.7 1.0];

d1 = MvNormal(μ1,Σ);
d2 = MvNormal(μ2,Σ);

s1 = rand(d1::MultivariateDistribution,nPoints::Int);
s2 = rand(d2::MultivariateDistribution,nPoints::Int);

p1=plot(s1[1,:],s1[2,:],seriestype=:scatter);
p2=plot(s1[1,:],s2[2,:],seriestype=:scatter);

plot(p1,p2)
