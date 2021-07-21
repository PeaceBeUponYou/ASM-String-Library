#include <iostream>
extern "C" void thegsubfunction(char*,char*,char*,char*);

using namespace std;

int main()
{
	char mainString[50];
	char toFindStr[20];
	char ReplaceWithStr[20];
	char finalOutput[100];
	
	cout << "Enter MAIN string:-";
	cin.getline(mainString, 50);
	cout << "Enter TO_FIND string:-";
	cin.getline(toFindStr, 20);
	cout << "Enter REPLACING string:-";
	cin.getline(ReplaceWithStr, 20);

	thegsubfunction(mainString, toFindStr, ReplaceWithStr, finalOutput);
	cout << "Result:-" << finalOutput << endl;

}
