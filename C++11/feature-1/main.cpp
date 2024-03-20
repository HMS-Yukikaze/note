#include <iostream>

int main(){
    auto i=10;
    std::cout<<typeid(i).name()<<"\n";
    auto j=2l;
    std::cout<<typeid(j).name()<<"\n";
    auto k=3lu;
    std::cout<<typeid(k).name()<<"\n";
    auto l=3.1415;
    std::cout<<typeid(l).name()<<"\n";

    decltype(i) res = i * 2;
    //static_assert(std::is_same_v<decltype(i), decltype(res)>); c++17 feature
    //static_assert(std::is_same_v<decltype(i), decltype(j)>); error
    std::cout<<typeid(res).name()<<"\n";
   
    

    
    return 0;
}