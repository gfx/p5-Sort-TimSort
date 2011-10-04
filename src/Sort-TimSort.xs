#include "timsort.hpp"

#define NEED_newSVpvn_flags
#include "xshelper.h"

class PerlCompare {
    SV* compare_;

    public:
    PerlCompare(SV* compare) : compare_(compare) {

    }

    int operator()(SV* const x, SV* const y) const {
        dTHX;
        dSP;

        ENTER;
        SAVETMPS;

        PUSHMARK(SP);
        EXTEND(SP, 2);
        PUSHs(x);
        PUSHs(y);
        PUTBACK;

        call_sv(compare_, G_SCALAR);
        SPAGAIN;
        int const ret = POPi;
        PUTBACK;

        FREETMPS;
        LEAVE;

        return ret;
    }
};

MODULE = Sort::TimSort    PACKAGE = Sort::TimSort

PROTOTYPES: DISABLE

void
timsort(SV* compare, ...)
PROTOTYPE: &@
PPCODE:
{
    I32 const len = items - 1;
    AV* const tmp = av_make(len, &ST(1));
    SV** const ary = AvARRAY(tmp);
    sv_2mortal((SV*)tmp);
    timsort( ary, ary + len, PerlCompare(compare) );

    EXTEND(SP, len - 1);
    for(int i = 0; i < len; ++i) {
        PUSHs( ary[i] );
    }
    XSRETURN(len);
}
