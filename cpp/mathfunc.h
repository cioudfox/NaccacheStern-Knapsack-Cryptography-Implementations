#ifndef MATHFUNC_H
#define MATHFUNC_H

#include <vector>

class MathFunc {
public:
    // Function to calculate GCD using Euclid's algorithm
    static int itemgcd(int a, int b);

    // Function to calculate modular inverse
    static int invmod(int a, int m);

    // Extended GCD algorithm
    static int ext_gcd(int a, int b, int& x, int& y);

    // Function for modular exponentiation
    static int mod_exp(int a, int exp, int mod);

    // Function to convert an integer to a binary array
    static std::vector<int> intToBinArr(int num);
};

#endif
