#ifndef NSKALGO_H
#define NSKALGO_H

#include <vector>
#include <string>

class NSKalgo {
public:
    // Secret key generation
    static long long int secretkey(long long int p);

    // Public key generation
    static std::vector<long long int> publickey(long long int p, long long int s);

    // Encryption
    static std::vector<long long int> encrypt(const std::vector<long long int>& mess, const std::vector<long long int>& pubk, long long int p);

    // Decryption
    static std::vector<long long int> decrypt(const std::vector<long long int>& cipher, long long int p, long long int s);

    // Utility to dump contents of a vector (to replace the table dump)
    static std::string dump(const std::vector<long long int>& vec);
};

#endif
