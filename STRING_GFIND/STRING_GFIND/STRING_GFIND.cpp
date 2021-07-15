#include <iostream>
using namespace std;
extern "C" void stringFindMain(char*, char*, unsigned long long int*, int*);
int main()
{
	char mainString[100], toFindString[30];
	unsigned long long int startFrom = 0; //8byte int (must)
	int container[100]; //100 dwords
	cout << "Enter the string to find from: ";
	cin.getline(mainString, 100);
	cout << "Enter the string to find: ";
	cin.getline(toFindString, 30);
	cout << "Enter the starting point(leave 0 for the beginning): ";
	cin >> startFrom;

	stringFindMain(mainString, toFindString, &startFrom, container);
	for (int c = 1; c <= container[0] * 2 ; c +=2 ) {
		cout << container[c] <<"-" << container[c+1] << endl;
	}
}
