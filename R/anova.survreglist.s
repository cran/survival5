# SCCS @(#)anova.survreglist.s	1.1 01/18/99
#  The StatSci function, updated for the new survreg code
anova.survreglist <- function(object, ..., test = c("Chisq", "none")) {
    diff.term <- function(term.labels, i)
	    {
		t1 <- term.labels[[1]]
		t2 <- term.labels[[2]]
		m1 <- match(t1, t2, F)
		m2 <- match(t2, t1, F)
		if(all(m1)) {
		    if(all(m2)) return("=")
		    else return(paste(c("", t2[ - m1]), collapse = "+"))
		    }
		else {
		    if(all(m2))
			 return(paste(c("", t1[ - m2]), collapse = "-"))
		    else return(paste(i - 1, i, sep = " vs. "))
		    }
		}
    test <- match.arg(test)
    rt <- length(object)
    if(rt == 1) {
	object <- object[[1]]
	UseMethod("anova")
	}
    forms <- sapply(object, function(x) as.character(formula(x)))
    subs <- as.logical(match(forms[2,  ], forms[2, 1], F))
    if(!all(subs))
	    warning("Some fit objects deleted because response differs from the first model")
    if(sum(subs) == 1)
	    stop("The first model has a different response from the rest")
    forms <- forms[, subs]
    object <- object[subs]
    dfres <- sapply(object, "[[", "df.resid")
    m2loglik <- -2 * sapply(object, "[[", "loglik")[2,  ]
    tl <- lapply(object, labels)
    rt <- length(m2loglik)
    effects <- character(rt)
    for(i in 2:rt)
	    effects[i] <- diff.term(tl[c(i - 1, i)], i)
    dm2loglik <-  - diff(m2loglik)
    ddf <-  - diff(dfres)
    heading <- c("Analysis of Deviance Table", 
		 paste("\nResponse: ", forms[2, 1], "\n", sep = ""))
    aod <- data.frame(Terms = forms[3,  ], 
		      "Resid. Df" = dfres, 
		      "-2*LL" = m2loglik, 
		      Test = effects, 
		      Df = c(NA, ddf), 
		      Deviance = c(NA, dm2loglik), check.names = F)
    ##aod <- as.anova(aod, heading)
    aod<-structure(aod,heading=heading,class=c("anova","data.frame"))
    if(test != "none") {
	n <- length(object[[1]]$residuals)
	o <- order(dfres)
        ## R uses scale argument even for "Chisq"
        if (test=="Chisq")
            scale<-1
        else
            scale<-deviance.lm(object[[o[1]]])/dfres[o[1]]
	stat.anova(aod, test, scale, dfres[o[1]], n)
	}
    else aod
    }






