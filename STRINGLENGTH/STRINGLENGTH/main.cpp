//Author: PeaceBeUponYou
//Consider supporting me: https://www.patreon.com/peaceCheats

#include<iostream>

using namespace std;
extern "C" int stringLength(void*, int*, bool);
int main() {
	//string.length()
	char normal[20];
	wchar_t unic[20];

	std::cout << "Enter a Normal string: ";
	std::cin.getline(normal, 20); //read user input
	std::wcout << "Enter a Unicode string: ";
	std::wcin.getline(unic, 20); //read user input

	int count = 0;
	std::cout << "Normal String Length: " << stringLength(normal, &count, false) << std::endl;
	count = 0;
	std::cout << "Unicode String Length: " << stringLength(unic, &count, true) << std::endl;//*/
	return 0;
}
