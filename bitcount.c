#include <stdio.h>

int onecount(unsigned int i) {
    int c = 0;
    while(i != 0) {
        if(i & 1) {
            c++; 
        }
        i = i >> 1;
    }
    return c;
}
int zerocount(unsigned int i) {
    int c = 0;
    while(i != 0) {
        if (~i & 1) {
            c++;
        }
        i = i >> 1;
    }   
    return c;
}
int whole_amount(unsigned int i) {
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
    int num = 0;
    printf("Enter number: ");
    scanf("%d", &num);
    printf("%b", num);
    printf(" returns %d units, %d zeros, and whole amount of bits %d \n", onecount(num), zerocount(num), whole_amount(num));  
}

