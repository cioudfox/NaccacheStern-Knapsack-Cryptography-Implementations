#ifndef MATHFUNC_H
#define MATHFUNC_H

#include <vector>

class MathFunc {
public:
    // Function to calculate GCD using Euclid's algorithm
    static long long int itemgcd(long long int a, long long int b);

    // Function to calculate modular inverse
    static long long int invmod(long long int a, long long int m);

    // Extended GCD algorithm
    static long long int ext_gcd(long long int a, long long int b, long long int& x, long long int& y);

    // Function for modular exponentiation
    static long long int mod_exp(long long int a, long long int exp, long long int mod);

    // Function to convert an integer to a binary array
    static std::vector<long long int> intToBinArr(long long int num);
};

#endif
