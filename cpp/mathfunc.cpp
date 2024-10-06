#include "mathfunc.h"
#include <vector>
#include <cmath>  // For std::floor

// Function to calculate GCD using the Euclid algorithm
long long int MathFunc::itemgcd(long long int a, long long int b) {
    if (b == 0) {
        return a;
    } else {
        return itemgcd(b, a % b);
    }
}
// Function to calculate the modular inverse
long long int MathFunc::invmod(long long int a, long long int m) {
    long long int m0 = m, x0 = 0, x1 = 1;
    if (m == 1) return 0;

    while (a > 1) {
        long long int q = a / m;
        long long int t = m;

        m = a % m;
        a = t;
        t = x0;

        x0 = x1 - q * x0;
        x1 = t;
    }

    if (x1 < 0) {
        x1 += m0;
    }

    return x1;
}

// Extended GCD algorithm
long long int MathFunc::ext_gcd(long long int a, long long int b, long long int& x, long long int& y) {
    if (b == 0) {
        x = 1;
        y = 0;
        return a;
    } else {
        long long int x1, y1;
        long long int gcd = ext_gcd(b, a % b, x1, y1);
        x = y1;
        y = x1 - (a / b) * y1;
        return gcd;
    }
}

// Modular exponentiation
long long int MathFunc::mod_exp(long long int a, long long int exp, long long int mod) {
    if (mod == 1) return 0;

    long long int result = 1;
    a = a % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * a) % mod;
        }
        exp = exp >> 1;   // Right shift by 1 (divides exp by 2)
        a = (a * a) % mod;
    }
    return result;
}

// Convert integer to binary array (8 bits)
std::vector<long long int> MathFunc::intToBinArr(long long int num) {
    std::vector<long long int> binaryArray(8, 0);
    for (int i = 0; i < 8; ++i) {
        binaryArray[i] = num % 2;
        num = num / 2;
    }
    return binaryArray;
}
