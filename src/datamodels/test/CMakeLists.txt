enable_testing()
find_package(GTest REQUIRED)

file(GLOB_RECURSE lib_tests_include "test" "*.h")
file(GLOB_RECURSE lib_tests_sources "test" "*.cpp")
include_directories(${GTEST_INCLUDE_DIRS})
add_executable(datamodels_test ${lib_tests_include} ${lib_tests_sources})
target_link_libraries(datamodels_test GTest::GTest GTest::Main )
add_test(DataModelsTests datamodels_test)
