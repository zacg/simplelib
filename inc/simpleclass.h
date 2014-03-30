#ifndef SIMPLECLASS_H
#define SIMPLECLASS_H

#include <iostream>
#include <vector>

class SimpleClass
{
public:
    SimpleClass();
    std::string hello();
    void hello(std::vector<std::string> *results);
    void hello(std::vector<char> *results);
};

#endif
