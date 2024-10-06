#include "dictionary.h"
#include <vector>
#include <string>

// Convert ASCII string to decimal array
std::vector<long long int> Dictionary::asctodec(const std::string& str) {
    std::vector<long long int> decarr;
    for (char c : str) {
        decarr.push_back(static_cast<long long int>(c));
    }
    return decarr;
}

// Convert decimal array back to ASCII string
std::string Dictionary::dectoasc(const std::vector<long long int>& decarr) {
    std::string result;
    for (long long int value : decarr) {
        result += static_cast<char>(value);
    }
    return result;
}
