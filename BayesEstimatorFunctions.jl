# returns info about discrimination line
function discrimLine(μ1,μ2,Σ1,Σ2,P1,P2)

μd = μ2-μ1;

μdInvΣ = μd' * inv(Σ1);

secondTerm = .5(μ1'*inv(Σ1)*μ1 - μ2'*inv(Σ2)*μ2);

priorLog = log(P1/P2);

m = -μdInvΣ[1]/μdInvΣ[2];
b = (priorLog - secondTerm)/μdInvΣ[2];
[m b];
end

#applies function to all points in vector
function linearFunction(x,m,b)
    m * x .+ b;
end

# Returns a linear discrim function for plotting
function linFuncForPlot(m,b,minVal,maxVal,numPoints)
stepsize = (maxVal - minVal)/(numPoints-1);
x = collect(minVal:stepsize:maxVal);
[x,linearFunction(x,m,b)];
end

# returns a list containing correct and incorrect classifications
function classifyCorrect(x,y,m,b,class)

for i in eachindex(x)
ysamp = y[i];
ytest = linearFunction(x[i],m,b);

#ysamp = 1;
#ytest = 2;
#class = 1;
if ((ysamp > ytest && class == 1) || (ysamp < ytest && class == 2))
 y[i] = 1;
else
 y[i] = 0;
end

end
y;
end
