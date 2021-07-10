#include <iostream>
extern "C" void tonumbermain(char*,long long int*);
int main()
{
	char stringA[100];
	long long int num = 0;
	std::cout << "Enter a string number: ";
	std::cin >> stringA;
	
	tonumbermain(stringA, &num);
	std::cout << num << std::endl;	
}
