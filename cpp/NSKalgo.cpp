#include "NSKalgo.h"
#include "mathfunc.h"
#include <vector>
#include <string>
#include <cstdlib> // for rand() and srand()

// Primes used in key generation
static const std::vector<long long int> pval = {2, 3, 5, 7, 11, 13, 17, 19};

// Secret key generation (finds secret key 's' such that GCD(s, p-1) = 1)
long long int NSKalgo::secretkey(long long int p) {
    long long int s = std::rand() % (p - 1);  // Random between 0 and p-1
    while (MathFunc::itemgcd(p - 1, s) != 1) {
        s = (s + 1) % p;
    }
    return s;
}

// Public key generation using modular exponentiation
std::vector<long long int> NSKalgo::publickey(long long int p, long long int s) {
    std::vector<long long int> temp(pval.size());
    long long int x, y;
    MathFunc::ext_gcd(s, p - 1, x, y);

    for (size_t i = 0; i < pval.size(); ++i) {
        if (x < 0) {
            x += p - 1;  // Make x positive if necessary
        }
        temp[i] = MathFunc::mod_exp(pval[i], x, p);  // Generate the public key
    }

    return temp;
}

// Encryption process
std::vector<long long int> NSKalgo::encrypt(const std::vector<long long int>& mess, const std::vector<long long int>& pubk, long long int p) {
    std::vector<long long int> cipher(mess.size());
    
    for (size_t i = 0; i < mess.size(); ++i) {
        std::vector<long long int> binaryArray = MathFunc::intToBinArr(mess[i]);  // Get binary representation
        long long int c = 1;
        for (size_t j = 0; j < pubk.size(); ++j) {
            c = (c * MathFunc::mod_exp(pubk[j], binaryArray[j], p)) % p;  // Multiply with public key
        }
        cipher[i] = c;
    }

    return cipher;
}

// Decryption process
std::vector<long long int> NSKalgo::decrypt(const std::vector<long long int>& cipher, long long int p, long long int s) {
    std::vector<long long int> decipher(cipher.size());

    for (size_t i = 0; i < cipher.size(); ++i) {
        long long int val = 0;
        for (size_t j = 0; j < pval.size(); ++j) {
            long long int term1 = MathFunc::mod_exp(2, j, p);
            long long int term2 = MathFunc::invmod(pval[j] - 1, p);
            long long int term3 = MathFunc::itemgcd(pval[j], MathFunc::mod_exp(cipher[i], s, p)) - 1;
            val = (val + ((term1 * term2) % p) * term3) % p;
        }
        decipher[i] = val;
    }

    return decipher;
}

// Dump function for utility (for printing vectors in C++)
std::string NSKalgo::dump(const std::vector<long long int>& vec) {
    std::string result = "{ ";
    for (const auto& val : vec) {
        result += std::to_string(val) + ", ";
    }
    result += "}";
    return result;
}
