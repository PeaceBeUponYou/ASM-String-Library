//Author : PeaceBeUponYou
//Consider supporting me: https://www.patreon.com/peaceCheats
#include <iostream>
extern "C" void normalToUnicode(char*, wchar_t*);
extern "C" void unicodeToNormal(wchar_t*, char*);

using std::cout;
using std::endl;

int main()
{
	char normalString[100];
	wchar_t unicodeString[100];

	cout << "Enter a normal String: ";
	std::cin.getline(normalString,100);
	normalToUnicode(normalString, unicodeString);
	std::wcout << unicodeString << std::endl;

	cout << "Enter a unicode String: ";
	std::wcin.getline(unicodeString, 100);
	unicodeToNormal( unicodeString, normalString);
	std::cout << normalString << endl;
}
