#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <vector>
#include <string>

class Dictionary {
public:
    // Function to convert ASCII string to decimal array
    static std::vector<int> asctodec(const std::string& str);

    // Function to convert decimal array back to ASCII string
    static std::string dectoasc(const std::vector<int>& decarr);
};

#endif
