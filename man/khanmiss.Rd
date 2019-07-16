\name{khanmiss}
\docType{data}
\alias{khanmiss}
\title{Khan microarray data with random missing values}
\description{ A text file containing the Khan micorarray data with
  random missing values introduced for illustrative purposes}
\usage{
   data(khanmiss)
}
\format{
  The data set \code{khanmiss} consists of 2310 rows and 65
  columns. Row 1 has the
  sample labels, Row 2 has the class labels.
  The remaining rows are gene expression. Column 1 is a dummy gene number.
  Column 2 is the gene name. Remaining columns are gene expression.
  
  Please note that this dataset was derived from the original by
  introducing some random missing values purely for the purpose of
  illustration.
    
}

\source{
  Khan, J.  and  Wei, J.S.  and
Ringner, M. and  Saal, L. and  Ladanyi, M. and
Westermann, F.  and  Berthold, F. and Schwab, M. and  Antonescu, C. and
Peterson, C. and and Meltzer, P. (2001) Classification and diagnostic prediction of cancers using gene expression
profiling and artificial neural network. Nature Medicine 7, 673-679.
}
\references{
  Robert Tibshirani, Trevor Hastie, Balasubramanian Narasimhan, and Gilbert Chu  (2002).
  Diagnosis of multiple cancer types by shrunken centroids of gene expression
  PNAS 99: 6567-6572.   Available at www.pnas.org
}
\examples{
  data(khanmiss)
}
 
\keyword{datasets}
