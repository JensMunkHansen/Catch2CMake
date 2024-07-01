#include <catch2/catch_test_macros.hpp>
#include <cstring>
#include <fstream>

TEST_CASE("TestMe")
{
  const std::string filepath = "/input.txt";
  std::ifstream ifs(filepath, std::ios::binary | std::ios::ate);  

  if(!ifs)
    throw std::runtime_error(filepath + ": " + std::strerror(errno));
#if 0

  auto end = ifs.tellg();
  ifs.seekg(0, std::ios::beg);
  
  auto size = std::size_t(end - ifs.tellg());

  if(size == 0) // avoid undefined behavior 
    REQUIRE(0 == 1);
  
  std::vector<std::byte> buffer(size);

  if(!ifs.read((char*)buffer.data(), buffer.size()))
    throw std::runtime_error(filepath + ": " + std::strerror(errno));
#endif
  REQUIRE(1 == 1);
}
