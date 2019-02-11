find_package(Qt5Core)
find_package(Qt5Network)

file(GLOB_RECURSE lib_includes "include/*.h")
file(GLOB_RECURSE lib_sources "src/*.cpp")

include_directories("include" "src" "${CMAKE_BINARY_DIR}/exports")
add_library(common STATIC ${lib_includes} ${lib_sources})
target_link_libraries(common Qt5::Core Qt5::Network)
target_include_directories(common PUBLIC "include")

meetup_install_3rd_party(ThirdPartyLibs Qt5::Core Qt5::Network)

#add_subdirectory(test)
