#include <iostream>
#include <string>
#include <vector>
#include "NSKalgo.h"
#include "dictionary.h"

int main() {
    int p = 74207281;  // Select some Mersennes Prime/Perfect Prime Value

    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout<< "Generate the Secret Key" << std::endl;
    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    int s = NSKalgo::secretkey(p);
    std::cout << "Generated SECRET KEY: " << s << std::endl;

    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout<< "Generate the Public Key" << std::endl;
    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::vector<int> pubk = NSKalgo::publickey(p, s);
    std::cout << "Public Key Table: " << NSKalgo::dump(pubk) << std::endl << std::endl;

    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout<< "Encrypting the Message" << std::endl;
    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout << "Enter message to encrypt: ";
    std::string input;
    std::getline(std::cin, input);

    // Translate message to decimal form
    std::vector<int> mess = Dictionary::asctodec(input);

    // Create the Encrypted Message (Cipher)
    std::vector<int> cipher = NSKalgo::encrypt(mess, pubk, p);

    // Cipher difficult to solve by knapsack problem
    std::cout << "Cipher Message: " << NSKalgo::dump(cipher) << std::endl << std::endl;

    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout<< "Decrypting the Mesage" << std::endl;
    std::cout<< "--------------------------------------------------------------------------------------------------------" << std::endl;
    std::cout << "Enter Secret Key to decrypt: ";
    int seckey;
    std::cin >> seckey;

    std::vector<int> decryptedMessage = NSKalgo::decrypt(cipher, p, seckey);
    std::string decryptedAsciiMessage = Dictionary::dectoasc(decryptedMessage);

    std::cout << "Decrypted Message: " << decryptedAsciiMessage << std::endl << std::endl;

    return 0;
}
