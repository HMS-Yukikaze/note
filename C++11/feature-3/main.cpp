#include <iostream>
#include <chrono>
using namespace std::chrono_literals;

/*UDL*/

size_t operator""_MB(size_t _sz);

int main(){
    std::cout<<20_MB<<"\n";
    auto tm=10s;
    return 0;
}

size_t operator""_MB(size_t _sz){
    return _sz*1024*1024;
}
