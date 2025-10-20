#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main(){
    vector<string> vec={"h","e","l","l","o"};
    for (auto str : vec) {
        std::cout<<str<<std::endl;
    }
    return 0;
}