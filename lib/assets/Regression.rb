Zi = {0,1} denote the assignment variable for individual i (0 = control, 1 = treatment).
Xi = {0,1} denote the observed action
let Yi denote the outcome
Let Z, X, and Y denote corresponding column vectors with all of the observations.  

X = Matrix()
Y = Matrix()
Z = Matrix()

CSV.foreach("C:/Users/Anon/Desktop/testdata.csv") do |row|
  x = row(1)
  y = row(1)
  z = row(1)
end

beta = inv(Z.t*X)*Z.t*Y
Omega = Matrix.diagonal(Y - X*beta)
P_z = Z*inv(Z.t*Z)*Z.t
Variance = inv(X.t*P_z*X)*(X.t*Z*inv(Z.t*Z)*(Z.t*Omega*Z)*inv(Z.t*Z)*Z.t*X)*inv(X.t*P_z*X)
SE = sqrt(Variance)
CI = [beta - 1.96*se, beta + 1.96*se]