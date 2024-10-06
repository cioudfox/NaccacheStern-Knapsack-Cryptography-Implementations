#ifndef NSKALGO_H
#define NSKALGO_H

#include <vector>
#include <string>

class NSKalgo {
public:
    // Secret key generation
    static int secretkey(int p);

    // Public key generation
    static std::vector<int> publickey(int p, int s);

    // Encryption
    static std::vector<int> encrypt(const std::vector<int>& mess, const std::vector<int>& pubk, int p);

    // Decryption
    static std::vector<int> decrypt(const std::vector<int>& cipher, int p, int s);

    // Utility to dump contents of a vector (to replace the table dump)
    static std::string dump(const std::vector<int>& vec);
};

#endif
