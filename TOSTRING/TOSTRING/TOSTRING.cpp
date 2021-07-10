#include <iostream>
extern "C" void tostringMain(long long int*,char*,int);
int main()
{
    long long int thenumber; 
    std::cout << "Enter a number to convert to string: ";
    std::cin >> thenumber;
    char stringArr[100];
    tostringMain(&thenumber, stringArr, sizeof(stringArr));
    std::cout << stringArr << std::endl;
}
