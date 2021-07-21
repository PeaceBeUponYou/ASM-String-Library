#include <iostream>
extern "C" void stringMatchMain(char*, char*, long long int*, long long int*);
int main()
{
	char theStr[400];
	char theMatchStr[200];
	long long int startFrom = 0;
	long long int result = 0;

	std::cout << "Enter a string to look form: ";
	std::cin.getline(theStr, 100);
	std::cout << "Enter a string to match: ";
	std::cin.getline(theMatchStr, 100);
	std::cout << "Enter starting position: ";
	std::cin >> startFrom;

	stringMatchMain(theStr, theMatchStr, &startFrom, &result);
	for (int c = 0; c < result; c++) {
		std::cout << theMatchStr << std::endl;
	}
}

