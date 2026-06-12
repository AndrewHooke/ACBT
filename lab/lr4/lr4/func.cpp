#include <cmath>

extern "C" double __cdecl CalcFunc(double x)
{
    double value = fabs(cos(x) - sin(x));

    return log10(value);
}