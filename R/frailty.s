# SCCS @(#)frailty.s	1.2 01/14/99
# 
# Parent function for frailty, calls the actual working functions
#
frailty <- function(x, distribution = 'gamma', ...) {
    dlist <- c("gamma", "gaussian", "t")
    i <- pmatch(distribution, dlist)
    if (!is.na(i)) distribution <- dlist[i]

    temp <- paste("frailty", distribution, sep='.')
    if (!exists(temp))
            stop(paste("Function '", temp, "' not found", sep=""))
    ##- provokes bug in new save() code
    ##(get(temp))(x, ...) 
    m<-match.call()
    m$distribution<-NULL
    m[[1]]<-as.name(temp)
    eval(m,sys.frame(sys.parent()))
    }

        		  
			   
			   
