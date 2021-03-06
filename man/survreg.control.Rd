\name{survreg.control}
\alias{survreg.control}
\alias{coxph.control}
%- Also NEED an `\alias' for EACH other topic documented here.
\title{Package options for survreg and coxph}
\description{
These functions check and package the fitting options for \code{\link{survreg}} and \code{\link{coxph}}
}
\usage{
survreg.control(maxiter=30, rel.tolerance=1e-05, 
toler.chol=1e-10, iter.max, debug=0, outer.max=10)
coxph.control (eps = 1e-04, toler.chol = .Machine$double.eps^0.75, 
    iter.max = 10, toler.inf = sqrt(eps), outer.max = 10) 

}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{maxiter}{maximum number of iterations }
  \item{rel.tolerance}{relative tolerance to declare convergence }
  \item{toler.chol}{Tolerance to declare Cholesky decomposition singular}
  \item{iter.max}{same as \code{maxiter}}
  \item{debug}{print debugging information}
  \item{outer.max}{maximum number of outer iterations for choosing
    penalty parameters}
  \item{eps}{Tolerance to declare convergence for Cox model}
}
\value{
 A list with the same elements as the input
}

\seealso{ \code{\link{survreg}}, \code{\link{coxph}  }

\examples{

}
\keyword{survival5 }