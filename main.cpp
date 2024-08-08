#include <iostream>
#include "singleton/1.hpp"

struct Rect{
    int x;
    int y;
    int w;
    int h;
};

int main() {
    auto& mrect = Singleton<Rect>::getInstance();
    mrect.x = 10;
    mrect.y = 20;
    mrect.w = 30;
    mrect.h = 40;
    std::cout << "x: " << mrect.x << std::endl;
    std::cout << "y: " << mrect.y << std::endl;
    std::cout << "w: " << mrect.w << std::endl;
    std::cout << "h: " << mrect.h << std::endl;
    return 0;
}