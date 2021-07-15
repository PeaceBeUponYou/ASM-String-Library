#include <iostream>
extern "C" void substrMain(char*,  long long int,  long long int,char*);
using std::cout;
using std::endl;
using std::cin;

int main()
{
	char orString[50];
	cout << "Enter a string to sub from: ";
	cin.getline(orString, 50);
	char result[100];
	 long long int a, b;
	cout << "Enter start point: ";
	cin >> a;
	cout << "Enter end point: ";
	cin >> b;
	substrMain(orString, a, b, result);
	cout << result << endl;
}

