enable_testing()
find_package(GTest REQUIRED)

file(GLOB_RECURSE lib_tests_include "test" "*.h")
file(GLOB_RECURSE lib_tests_sources "test" "*.cpp")

include_directories(${GTEST_INCLUDE_DIRS})
add_executable(common_test ${lib_tests_include} ${lib_tests_sources})
target_link_libraries(common_test GTest::GTest GTest::Main)
add_test(CommonTests common_test)
