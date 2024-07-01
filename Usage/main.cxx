#include <catch2/catch_test_macros.hpp>
#include <cstring>
#include <fstream>
#include <iostream>

TEST_CASE("TestMe")
{
  const std::string filepath = "/assets/input.txt";
  std::ifstream ifs(filepath, std::ios::binary | std::ios::ate);  

  if(!ifs)
    throw std::runtime_error(filepath + ": " + std::strerror(errno));

  auto end = ifs.tellg();
  ifs.seekg(0, std::ios::beg);
  
  auto size = std::size_t(end - ifs.tellg());

  std::cout << size << std::endl;
  if(size == 0) // avoid undefined behavior 
    REQUIRE(0 == 1);
  
  const std::string filepath2 = "/assets/input2.txt";
  std::ifstream ifs2(filepath2, std::ios::binary | std::ios::ate);  

  if(!ifs2)
    throw std::runtime_error(filepath2 + ": " + std::strerror(errno));

  end = ifs2.tellg();
  ifs2.seekg(0, std::ios::beg);
  
  size = std::size_t(end - ifs2.tellg());

  std::cout << size << std::endl;
  
  REQUIRE(1 == 1);

  
}
