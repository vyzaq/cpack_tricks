include(GenerateExportHeader)

find_package(Qt5Core)
find_package(Qt5Concurrent)
find_package(Qt5Quick)

file(GLOB_RECURSE lib_includes "include/*.h")
file(GLOB_RECURSE lib_sources "src/*.cpp")

include_directories("include" "src" "${CMAKE_BINARY_DIR}/exports")
add_library(datamodels SHARED ${lib_includes} ${lib_sources})
generate_export_header(datamodels EXPORT_FILE_NAME "${CMAKE_BINARY_DIR}/exports/datamodels_export.h")
target_link_libraries(datamodels Qt5::Core Qt5::Concurrent Qt5::Quick common)
target_include_directories(datamodels PUBLIC "include")

meetup_install_3rd_party(ThirdPartyLibs Qt5::Core Qt5::Concurrent Qt5::Quick)

#add_subdirectory(test)
