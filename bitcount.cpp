#include <iostream>
#include <cstdio>

constexpr int onecount(unsigned int i) {
    int c = 0;
    while(i != 0) {
        if(i & 1) {
            c++; 
        }
        i = i >> 1;
    }
    return c;
}
constexpr int zerocount(unsigned int i) {
    int c = 0;
    while(i != 0) {
        if (~i & 1) {
            c++;
        }
        i = i >> 1;
    }   
    return c;
}
constexpr int whole_amount(unsigned int i) {
    int c = 0;
    while(i != 0) {
        if(i | 0) { 
            c++; 
        }
        i = i >> 1;
    }   
    return c;
}

int main() {
    int num {};
    std::cout << "Enter number: ";
    std::cin >> num;
    if (!std::cin) {
        std::cerr << "Not a number \n";
        std::cerr.flush();
        return -1;
    }
    printf("%b", num);
    std::cout << " returns " << onecount(num) << " units, " << zerocount(num) << " zeros, and whole amount of bits " << whole_amount(num) <<  std::endl;  
}
