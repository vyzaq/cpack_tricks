cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(cmake/3rdparty.cmake)
include(${THIRD_PARTY_AUX_CMAKE_FILES}/cpack_helpers.cmake)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

project(CPackAndGo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

meetup_install_system_runtime_dependencies(ThirdPartyLibs)

enable_testing()
add_subdirectory(src)

meetup_qt_conf_generator( QT_CONF_FILE PLUGINS_LOCATION ".")
install(FILES "${QT_CONF_FILE}" DESTINATION . COMPONENT Core)
install(TARGETS datamodels launcher RUNTIME DESTINATION . COMPONENT Core)


include(CPackComponent)

cpack_add_component_group(CoreGroup DISPLAY_NAME "Core")
cpack_add_component(ThirdPartyLibs HIDDEN)
cpack_add_component(Core
  REQUIRED
  DISABLED
  DEPENDS ThirdPartyLibs
  DESCRIPTION "Core module to make things work"
  GROUP CoreGroup
  )

cpack_add_component_group(ProductSpecific DISPLAY_NAME "Product specific")
cpack_add_component(HomeProduct REQUIRED DISABLED DEPENDS Core GROUP ProductSpecific)
cpack_add_component(EnterpriseProduct REQUIRED DISABLED DEPENDS Core GROUP ProductSpecific)

meetup_generate_package_configuration(
  PACKAGE "MeetupCPackAndGoHome"
  VENDOR "WeirdCompany"
  MAJOR 1
  MINOR 2
  BUGFIX 1
  OUTNAME "CPackDemoAppHome.cmake"
  GENERATORS NSIS WIX
  UPGRADE_GUID "132e0277-e5d3-49c5-a07f-0f076dfad798"
  COMPONENTS Core ThirdPartyLibs HomeProduct)

meetup_generate_package_configuration(
  PACKAGE_FILENAME "MeetupCPackAndGoEnterprise"
  PACKAGE "Meetup CPackAndGo Enterprise"
  VENDOR "WeirdCompany"
  MAJOR 1
  MINOR 2
  BUGFIX 1
  OUTNAME "CPackDemoAppEnterprise.cmake"
  GENERATORS WIX IFW
  UPGRADE_GUID "9c8e60a6-4423-4ec0-99cb-b630eef0884e"
  COMPONENTS Core ThirdPartyLibs EnterpriseProduct)
