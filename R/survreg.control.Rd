\name{survreg.control}
\alias{survreg.control}
%- Also NEED an `\alias' for EACH other topic documented here.
\title{ ~~function to do ... ~~ }
\description{
  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
survreg.control(maxiter=30, rel.tolerance=1e-05, failure=1, toler.chol=1e-10, iter.max, debug=0, outer.max=10)
}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{maxiter}{ ~~Describe \code{maxiter} here~~ }
  \item{rel.tolerance}{ ~~Describe \code{rel.tolerance} here~~ }
  \item{failure}{ ~~Describe \code{failure} here~~ }
  \item{toler.chol}{ ~~Describe \code{toler.chol} here~~ }
  \item{iter.max}{ ~~Describe \code{iter.max} here~~ }
  \item{debug}{ ~~Describe \code{debug} here~~ }
  \item{outer.max}{ ~~Describe \code{outer.max} here~~ }
}
\details{
  ~~ If necessary, more details than the __description__  above ~~
}
\value{
  ~Describe the value returned
  If it is a LIST, use
  \item{comp1 }{Description of `comp1'}
  \item{comp2 }{Description of `comp2'}
  ...
}
\references{ ~put references to the literature/web site here ~ }
\author{ ~~who you are~~ }
\note{ ~~further notes~~ }

 ~Make other sections like WARNING with \section{WARNING }{....} ~

\seealso{ ~~objects to SEE ALSO as \code{\link{~~fun~~}}, ~~~ }

\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	     or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (maxiter = 30, rel.tolerance = 1e-05, failure = 1, toler.chol = 1e-10, 
    iter.max, debug = 0, outer.max = 10) 
{
    if (missing(iter.max)) {
        iter.max <- maxiter
    }
    else maxiter <- iter.max
    list(iter.max = iter.max, rel.tolerance = rel.tolerance, 
        failure = failure, toler.chol = toler.chol, debug = debug, 
        maxiter = maxiter, outer.max = outer.max)
  }
}
\keyword{ ~keyword }%-- one or more ...
