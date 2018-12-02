#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char* argv[]) {
	ifstream f;
	f.open("input", fstream::in);
	int freq=0;
	for (int delta=0; f >> delta && !f.eof(); ) {
		freq += delta;
	}
	cout << freq << endl;
	return 0;
}
