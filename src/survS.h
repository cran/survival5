#include "R.h"
#include "R_ext/Memory.h"
#define ALLOC(a,b) S_alloc(a,b)

#ifdef WIN32
#include <R_ext/Mathlib.h>
#define erf(x) 2*pnorm5(x*M_SQRT2,0,1,1,0)-1
#define erfc(x) 2*pnorm5(-x*M_SQRT2,0,1,1,0)
#endif

