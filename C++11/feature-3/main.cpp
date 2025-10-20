#include <iostream>
#include <chrono>
using namespace std;
using namespace std::chrono_literals;

/*UDL*/

unsigned long long operator""_MB(unsigned long long _sz);

int main(){
    std::cout<<20_MB<<"\n";
    auto tm=10s;
    return 0;
}

unsigned long long operator""_MB(unsigned long long _sz){
    return _sz*1024*1024;
}
