#include <iostream>

class Sample
{
private:
    /* data */
    int s;
public:
    Sample(/* args */);
    ~Sample();
    Sample(Sample&&) = delete;
};


int main(){
    Sample s1; //success default
    //Sample s2(s1); error delete
    
    return 0;
}

Sample::Sample(/* args */)
{
    std::cout<<"default constructor"<<std::endl;
}

Sample::~Sample()
{
    std::cout<<"default destructor"<<std::endl;
}