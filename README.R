This is an R port of survival5.1; the author, Terry Therneau, provided the
same code to MathSoft for version 6 of S-PLUS(tm) so it should be
compatible.

It requires version 1.0 or later of R (you are strongly encouraged to be
using 1.1.1) and you will probably want to install the date package.

The main new feature since survival4 is penalised (partial) likelihood.
Both survreg() and coxph() can now fit frailty models, smoothing splines,
ridge regressions and other penalised estimation methods.  This is also
the largest change in porting, since the S-PLUS implementation uses S
frames directly. The R implementation uses functions and environments.

The parametric survival models are more numerically stable. They will now
fit some nasty examples where the the loglikelihood is nowhere near
quadratic. There is, of course, no guarantee that the asymptotic
distribution for the parameter estimates will be even remotely relevant.

The ratetables have been updated since survival4. They still are not
loaded as part of the library, since they take up 22000 heap elements and
3000 cons cells. They are now available as data(ratetables) rather than in
a separate package. They no longer autoload -- you must explicitly do
data(ratetables).





