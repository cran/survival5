# SCCS @(#)coxph.control.s	5.1 10/27/98
#
# Gather all of the control parameters for coxph into one spot
#
coxph.control <- function(eps=1e-7, toler.chol =eps/1000, iter.max=10,
			  toler.inf= sqrt(eps) ) {
    if (iter.max <0) stop("Invalid value for iterations")
    if (eps <=0) stop ("Invalid convergence criteria")
    if (eps <= tol.chol) 
	    warning("For numerical accuracy, tolerance should be < eps")
    if (toler.inf <=0) stop ("The inf.warn setting must be >0")
    list(eps=eps, toler.chol=toler.chol, iter.max=iter.max, 
	 toler.inf=toler.inf)
    }
