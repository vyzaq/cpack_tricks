if($ENV{THIRD_PARTY_LIBS_ROOT})
  set(THIRD_PARTY_LIBS_ROOT $ENV{THIRD_PARTY_LIBS_ROOT})
else()
  set(THIRD_PARTY_LIBS_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../3rdparty")
endif()

set(THIRD_PARTY_AUX_CMAKE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/cmake/helpers")

set(GTEST_ROOT "${THIRD_PARTY_LIBS_ROOT}/googletest")
set(GMock_ROOT "${THIRD_PARTY_LIBS_ROOT}/googletest")

set(BOOST_ROOT "${THIRD_PARTY_LIBS_ROOT}/boost")

define_property(TARGET PROPERTY RUNTIME_SHARED_HINTS
  BRIEF_DOCS "Target dll/etc location to add to PATH for example"
  FULL_DOCS "Target dll/etc location to add to PATH for example")

define_property(TARGET PROPERTY RUNTIME_SHARED_HINTS_DEBUG
  BRIEF_DOCS "Target dll/etc location to add to PATH for example"
  FULL_DOCS "Target dll/etc location to add to PATH for example")

define_property(TARGET PROPERTY RUNTIME_SHARED_HINTS_RELEASE
  BRIEF_DOCS "Target dll/etc location to add to PATH for example"
  FULL_DOCS "Target dll/etc location to add to PATH for example")
