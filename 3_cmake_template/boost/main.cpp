#include <boost/regex.hpp>
#include <iostream>
#include <string>
int main()
{
    std::string   str = "2024-03-15";

    boost::regex  rex("(?<year>[0-9]{4}).*(?<month>[0-9]{2}).*(?<day>[0-9]{2})");

    boost::smatch res;

    std::string::const_iterator begin = str.begin();

    std::string::const_iterator end   = str.end();

    if (boost::regex_search(begin, end, res, rex))

    {
     	  std::cout << "Day:   " << res ["day"] << std::endl
        << "Month: " << res ["month"] << std::endl
        << "Year:  " << res ["year"] << std::endl;
    }
    return 0;    
}