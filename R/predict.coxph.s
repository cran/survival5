#SCCS 02/15/99 @(#)predict.coxph.s	4.11
#What do I need to do predictions --
#
#linear predictor:  exists
#        +se     :  X matrix
#        +newdata:  means of old X matrix, new X matrix, new offset
#
#risk -- same as lp
#
#expected --    cumulative hazard for subject= baseline haz + time + risk
#        +se :  sqrt(expected)
#      +new  :  baseline hazard function, new time, new x, means of old X,
#                        new offset, new strata
#
#terms -- : X matrix and the means
#    +se  :  ""  + I matrix
#   +new  : new X matrix and the old means + I matrix
predict.coxph <-
function(object, newdata, type=c("lp", "risk", "expected", "terms"),
		se.fit=F,
		terms=names(object$assign), collapse, safe=F, ...)

    {
    type <-match.arg(type)
    n <- object$n
    Terms <- object$terms
    strata <- attr(Terms, 'specials')$strata
    dropx <- NULL
    if (length(strata)) {
	   temp <- untangle.specials(Terms, 'strata', 1)
	   dropx <- temp$terms
	   }
    if (length(attr(Terms, 'specials')$cluster)) {
	temp <- untangle.specials(Terms, 'cluster', 1)
	dropx <- c(dropx, temp$terms)
	}
    if (length(dropx)) Terms2 <- Terms[-dropx]
    else  Terms2 <- Terms

    offset <- attr(Terms, "offset")
    resp <- attr(Terms, "variables")[attr(Terms, "response")]

    if (missing(newdata)) {
	if (type=='terms' || (se.fit && (type=='lp' || type=='risk'))) {
	    x <- object$x
	    if (is.null(x)) {
		x <- model.matrix(Terms2, model.frame(object))[,-1,drop=F]
		}
	    x <- sweep(x, 2, object$means)
	    }
	else if (type=='expected') {
	    y <- object$y
	    if (is.null(y)) {
		m <- model.frame(object)
		y <- model.extract(m, 'response')
		}
	    }
	}
    else {
	if (type=='expected')
	     m <- model.newframe(Terms, newdata, response=T)
	else m <- model.newframe(Terms2, newdata)

	x <- model.matrix(Terms2, m)[,-1,drop=F]
	x <- sweep(x, 2, object$means)
	if (length(offset)) {
	    if (type=='expected') offset <- as.numeric(m[[offset]])
	    else {
		offset <- attr(Terms2, 'offset')
		offset <- as.numeric(m[[offset]])
		}
	    }
	else offset <- 0
	}

    #
    # Now, lay out the code one case at a time.
    #  There is some repetition this way, but otherwise the code just gets
    #    too complicated.
    coef <- ifelse(is.na(object$coef), 0, object$coef)
    if (type=='lp' || type=='risk') {
	if (missing(newdata)) {
	    pred <- object$linear.predictors
	    names(pred) <- names(object$residuals)
	    }
	else                  pred <- x %*% coef  + offset
	if (se.fit) se <- sqrt(diag(x %*% object$var %*% t(x)))

	if (type=='risk') {
	    pred <- exp(pred)
	    if (se.fit) se <- se * sqrt(pred)
	    }
	}

    else if (type=='expected') {
	if (missing(newdata)) pred <- y[,ncol(y)] - object$residual
	else  stop("Method not yet finished")
	se   <- sqrt(pred)
	}

    else {  #terms is different for R <TSL>
        asgn <- object$assign
        nterms<-length(terms)
        pred<-matrix(ncol=nterms,nrow=NROW(x))
        dimnames(pred)<-list(rownames(x),terms)
        if (se.fit){
            se<-matrix(ncol=nterms,nrow=NROW(x))
            dimnames(se)<-list(rownames(x),terms)
            R<-object$var
            ip <- real(NROW(x))
        }
        for (i in 1:nterms){
            ii<-asgn[[terms[i] ]]
            pred[,i]<-x[,ii,drop=FALSE]%*%(coef[ii])
            if (se.fit){
                for(j in (1:NROW(x))){
                    xi<-x[j,ii,drop=FALSE]*(coef[ii])
                    vci<-R[ii,ii]
                    se[j,i]<-sqrt(sum(xi%*% vci %*%t( xi)))
                }
            }
        }
    }

    if (se.fit) se <- drop(se)
    pred <- drop(pred)
    ##Expand out the missing values in the result
    # But only if operating on the original dataset
    if (missing(newdata) && !is.null(object$na.action)) {
	pred <- naresid(object$na.action, pred)
	if (is.matrix(pred)) n <- nrow(pred)
	else               n <- length(pred)
	if(se.fit) se <- naresid(object$na.action, se)
	}

    # Collapse over subjects, if requested
    if (!missing(collapse)) {
	if (length(collapse) != n) stop("Collapse vector is the wrong length")
	pred <- rowsum(pred, collapse)
	if (se.fit) se <- sqrt(rowsum(se^2, collapse))
	}

    if (se.fit) list(fit=pred, se.fit=se)
    else pred
    }
