# Tests using the rats data
#
#  (Female rats, from Mantel et al, Cancer Research 37,
#    3863-3868, November 77)

rats <- read.table('data.rats', col.names=c('litter', 'rx', 'time',
				  'status'))

rfit <- coxph(Surv(time,status) ~ rx + frailty(litter), rats,
	     method='breslow')
names(rfit)
rfit

rfit$iter
rfit$df
rfit$history[[1]]

rfit1 <- coxph(Surv(time,status) ~ rx + frailty(litter, theta=1), rats,
	     method='breslow')
rfit1

rfit2 <- coxph(Surv(time,status) ~ frailty(litter), rats)
rfit2
