#include "dictionary.h"
#include <vector>
#include <string>

// Convert ASCII string to decimal array
std::vector<int> Dictionary::asctodec(const std::string& str) {
    std::vector<int> decarr;
    for (char c : str) {
        decarr.push_back(static_cast<int>(c));
    }
    return decarr;
}

// Convert decimal array back to ASCII string
std::string Dictionary::dectoasc(const std::vector<int>& decarr) {
    std::string result;
    for (int value : decarr) {
        result += static_cast<char>(value);
    }
    return result;
}
