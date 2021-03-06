#include <stdio.h>

typedef unsigned long long ull;

const ull BASE = 10000;

ull lookup[BASE];

#define NUM_DIGITS 10000
ull digits = 1;
ull idx = 1;

static inline void print_n()
{
    printf("a[%lld] = %lld\n", idx, digits);
    fflush(stdout);
}

int main()
{
    // Initialize the lookup.
    for (int i = 0 ; i < BASE; i++)
    {
        int sum = 0;
        int ii = i;
        while (ii)
        {
            sum += ii % 10;
            ii /= 10;
        }
        lookup[i] = sum;
    }

#if 0
    const long long LIM = 1000000;
#else
    const long long LIM = 1000000000000000;
#endif
    const long long STEP = 1000000000;
    long long checkpoint = STEP;

    for (;idx < LIM;idx++)
    {
        if (idx == checkpoint)
        {
            print_n();
            checkpoint += STEP;
        }
        ull copy = digits;
        while (copy)
        {
            digits += lookup[ copy % BASE];
            copy /= BASE;
        }
    }

    print_n();

    return 0;
}
