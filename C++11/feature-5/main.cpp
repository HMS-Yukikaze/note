#include <iostream>
#include <string>
using namespace std;

int main(){
    string A{"hello"};
    string B{"world"};
    auto foo=[A,&B](){
        cout<<A<<" "<<B<<endl;
    };
    foo();
    return 0;
}