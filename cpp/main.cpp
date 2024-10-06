#include <iostream>
#include <string>
#include <vector>
#include "NSKalgo.h"
#include "dictionary.h"

int main() {
    long long int p = 9999971;  // Select some Mersennes Prime/Perfect Prime Value

    std::cout << "\nGenerating the Secret Key" << std::endl;
    int s = NSKalgo::secretkey(p);
    std::cout << "\nGenerated SECRET KEY: " << s << std::endl;

    std::cout << "\nGenerate the Public Key" << std::endl;
    std::vector<long long int> pubk = NSKalgo::publickey(p, s);
    std::cout << "\nPublic Key Table: " << NSKalgo::dump(pubk) << std::endl << std::endl;

    std::cout << "\nEnter message to encrypt: ";
    std::string input;
    std::getline(std::cin, input);
    
    std::cout << "\nEncrypting the Message" << std::endl;

    // Translate message to decimal form
    std::vector<long long int> mess = Dictionary::asctodec(input);

    // Create the Encrypted Message (Cipher)
    std::vector<long long int> cipher = NSKalgo::encrypt(mess, pubk, p);

    // Cipher difficult to solve by knapsack problem
    std::cout << "\nCipher Message: " << NSKalgo::dump(cipher) << std::endl << std::endl;

    std::cout << "\nDecrypting the Mesage" << std::endl;
    std::cout << "\nEnter Secret Key to decrypt: ";
    long long int seckey;
    std::cin >> seckey;

    std::vector<long long int> decryptedMessage = NSKalgo::decrypt(cipher, p, seckey);
    std::string decryptedAsciiMessage = Dictionary::dectoasc(decryptedMessage);

    std::cout << "\nDecrypted Message: " << decryptedAsciiMessage << std::endl << std::endl;

    return 0;
}
