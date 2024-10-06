#include "mathfunc.h"
#include <vector>
#include <cmath>  // For std::floor

// Function to calculate GCD using the Euclid algorithm
int MathFunc::itemgcd(int a, int b) {
    if (b == 0) {
        return a;
    } else {
        return itemgcd(b, a % b);
    }
}
// Function to calculate the modular inverse
int MathFunc::invmod(int a, int m) {
    int m0 = m, x0 = 0, x1 = 1;
    if (m == 1) return 0;

    while (a > 1) {
        int q = a / m;
        int t = m;

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
int MathFunc::ext_gcd(int a, int b, int& x, int& y) {
    if (b == 0) {
        x = 1;
        y = 0;
        return a;
    } else {
        int x1, y1;
        int gcd = ext_gcd(b, a % b, x1, y1);
        x = y1;
        y = x1 - (a / b) * y1;
        return gcd;
    }
}

// Modular exponentiation
int MathFunc::mod_exp(int a, int exp, int mod) {
    if (mod == 1) return 0;

    int result = 1;
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
std::vector<int> MathFunc::intToBinArr(int num) {
    std::vector<int> binaryArray(8, 0);
    for (int i = 0; i < 8; ++i) {
        binaryArray[i] = num % 2;
        num = num / 2;
    }
    return binaryArray;
}
