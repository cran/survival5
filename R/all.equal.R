all.equal<-function(x,y,tol=1e-8){
  if (length(x)!=length(y)) return(F)
  if (is.list(x)){
    if (!is.list(y)) return(F)
    return(all(sapply(1:length(x),function(i) all.equal(x[[i]],y[[i]]))))
  }
  nax<-is.na(x)
  if (any(nax!=is.na(y))) return(F)
  r<-max(abs(x-y)[!nax])
  rval<-r<tol
  attr(rval,"tol")<-r
  rval
}
