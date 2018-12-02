#include <iostream>
#include <fstream>
#include <set>
using namespace std;

int main(int argc, char* argv[]) {
	int freq=0;
	set<int> seen = {0};
	bool quit=false;
	while (!quit) {
		ifstream f;
		f.open("input", fstream::in);
		for (int delta=0; !quit && f >> delta && !f.eof(); ) {
			freq += delta;
			if (!seen.insert(freq).second) { quit=true; }
		}
	}
	cout << freq << endl;
	return 0;
}
