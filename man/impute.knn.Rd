\name{impute.knn}
\alias{impute.knn}
\title{A function to impute missing expression data}
\description{A function to impute missing expression data, using
  nearest neighbor averaging.}


\usage{
impute.knn(data ,k = 10, rowmax = 0.5, colmax = 0.8, maxp = 1500, rng.seed=362436069)
}

\arguments{
  \item{data}{An expression matrix with genes in the rows, samples in the columns}
  \item{k}{Number of neighbors to be used in the
    imputation (default=10)}
  \item{rowmax}{The maximum percent missing data allowed in any row
    (default 50\%). For any rows with more than \code{rowmax}\% missing
    are imputed using the overall mean per sample.}
  \item{colmax}{The maximum percent missing data allowed in any column
    (default 80\%). If any column has more than \code{colmax}\% missing data,
    the program halts and reports an error.}
  \item{maxp}{The largest block of genes imputed using the knn
    algorithm inside \code{impute.knn} (default
    1500); larger blocks are divided by two-means clustering
    (recursively) prior to imputation. If \code{maxp=p}, only knn
    imputation is done.}
  \item{rng.seed}{The seed used for the random number generator (default
    362436069) for reproducibility.}
}

\details{
  \code{impute.knn} 
  uses \eqn{k}{k}-nearest neighbors in the space of genes to impute missing
  expression values.
  
  For each gene with missing values, we find the \eqn{k}{k} nearest neighbors using
  a Euclidean metric, confined to the columns for which that gene is NOT
  missing. Each candidate neighbor might be missing some of the
  coordinates used to calculate the distance. In this case we average the
  distance from the non-missing coordinates. Having found the k nearest
  neighbors for a gene, we impute the missing elements by averaging those
  (non-missing) elements of its neighbors. This can fail if ALL the
  neighbors are missing in a particular element. In this case we use the
  overall column mean for that block of genes.
  
  Since nearest neighbor imputation costs
  \eqn{O(p\log(p))}{O(p*log(p))} operations per gene, where \eqn{p}{p} is the
  number of rows, the computational time can be excessive for large p and
  a large number of missing rows. Our strategy is to break blocks with
  more than \code{maxp} genes into two smaller blocks using two-mean
  clustering. This is done recursively till all blocks have less than
  \code{maxp} genes. For each block, \eqn{k}{k}-nearest neighbor
  imputation is done separately.
  We have set the default value of \code{maxp} to 1500. Depending on the
  speed of the machine, and number of samples, this number might be
  increased. Making it too small is counter-productive, because the
  number of two-mean clustering algorithms will increase.

  For reproducibility, this function reseeds the random number
  generator using the seed provided or the default seed (362436069). 
}

\value{
  \item{data}{the new imputed data matrix}
  \item{rng.seed}{the rng.seed that can be used to
    reproduce the imputation. This should be saved by any prudent user
    if different from the default.}
  \item{rng.state}{the state of the random number generator, if
    available, prior to the call to \code{set.seed}. Otherwise, it is
    \code{NULL}. If necessary, this can be used in the calling code to
    undo the side-effect of changing the random number generator
    sequence.} 
}

\note{
     A bug in the function \code{knnimp.split} was fixed in version 1.18.0. 
     This means that results from earlier versions may not be exactly reproducible. 
     We apologize for this inconvenience.}
\examples{
data(khanmiss)
khan.expr <- khanmiss[-1, -(1:2)]
##
## First example
##
if(exists(".Random.seed")) rm(.Random.seed)
khan.imputed <- impute.knn(as.matrix(khan.expr))
##
## khan.imputed$data should now contain the imputed data matrix
## khan.imputed$rng.seed should contain the random number seed used
## in imputation. In the above invocation, it is the default seed.
##
khan.imputed$rng.seed # should be 362436069
khan.imputed$rng.state # should be NULL
##
## Second example
##
set.seed(12345)
saved.state <- .Random.seed
khan.imputed <- impute.knn(as.matrix(khan.expr))
# Assuming all goes well with no guarantees in case of error...
.Random.seed <- khan.imputed$rng.state
sum(saved.state - khan.imputed$rng.state) # should be zero!
save(khan.imputed, file="khanimputation.Rda")
}

\seealso{set.seed, save}

\references{
  Hastie, T., Tibshirani, R., Sherlock, G., Eisen, M., Brown, P. and
  Botstein, D., Imputing Missing Data for Gene Expression Arrays,
  Stanford University Statistics Department Technical report (1999),
  http://www-stat.stanford.edu/~hastie/Papers/missing.pdf 
  
  Olga Troyanskaya, Michael Cantor, Gavin Sherlock, Pat Brown,
  Trevor Hastie, Robert Tibshirani, David Botstein and Russ B. Altman, Missing
  value estimation methods for DNA microarrays BIOINFORMATICS Vol. 17
  no. 6, 2001 Pages 520-525 }

\author{ Trevor Hastie, Robert Tibshirani, Balasubramanian Narasimhan, and Gilbert Chu}

\keyword{data}
\concept{impute, k-nearest neighbor, two-means clustering}
