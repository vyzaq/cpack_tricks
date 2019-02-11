set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
find_package(Qt5Gui)
find_package(Qt5Widgets)
find_package(Qt5Quick)
find_package(Qt5QuickControls2)
find_package(Qt5QuickTemplates2)

file(GLOB_RECURSE lib_includes "include/*.h")
file(GLOB_RECURSE lib_sources "src/*.cpp")

add_definitions(-DQT_DECLARATIVE_DEBUG=1 -DQT_QML_DEBUG=1)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/ui/modules" CACHE STRING "path to force Qt Creator to detect modules in Resources" FORCE)

include_directories("src" "${CMAKE_BINARY_DIR}/exports")
qt5_add_resources(RESOURCES "ui/launcher.qrc")
add_executable(launcher WIN32 ${lib_includes} ${lib_sources} ${RESOURCES})
target_link_libraries(launcher Qt5::Gui Qt5::Widgets Qt5::Quick Qt5::QuickControls2 common datamodels)

meetup_install_3rd_party(ThirdPartyLibs Qt5::Gui Qt5::Widgets Qt5::Quick Qt5::QuickControls2 Qt5::QuickTemplates2 Qt5::Qml)
meetup_install_3rd_party(ThirdPartyLibs ${Qt5Gui_PLUGINS} DESTINATION "./plugins")
