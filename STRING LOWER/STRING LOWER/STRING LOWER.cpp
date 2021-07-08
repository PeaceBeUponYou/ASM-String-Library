#include <iostream>

extern "C" void lowermainFun(char* sourceString, char* destinationString, int sizeOfDestination);

int main()
{
	char source[100];
	char dest[100];
	std::cout << "Enter a string: ";
	std::cin.getline(source, 100);
	lowermainFun(source, dest, 100);
	std::cout << dest << std::endl;

}